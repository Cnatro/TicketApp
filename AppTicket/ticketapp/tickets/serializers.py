from django.contrib.auth.models import Group
from rest_framework import serializers
from .models import User, Category, Venue, Event, Performance, Ticket_Type, Ticket, Receipt, Comment, Review, Messages, \
    Notification


class UserSerializer(serializers.ModelSerializer):
    role = serializers.CharField(write_only=True, required=True)

    def to_representation(self, instance):
        data = super().to_representation(instance)
        data['avatar'] = instance.avatar.url if instance.avatar else ''
        data['role'] = instance.groups.first().name if instance.groups.exists() else ''
        return data

    def create(self, validated_data):
        role = validated_data.pop('role', None)
        data = validated_data.copy()
        u = User(**data)
        u.set_password(u.password)
        u.save()
        if role:
            try:
                group = Group.objects.get(name=role)
                u.groups.add(group)
            except Group.DoesNotExist:
                raise serializers.ValidationError({'role': 'Role không tồn tại trong hệ thống'})

        return u

    class Meta:
        model = User
        fields = ['id', 'username', 'email', 'first_name', 'last_name',
                  'gender', 'birthday', 'avatar', 'phone', 'address', 'role', 'password']
        extra_kwargs = {
            'password': {'write_only': True}
        }


class CategorySerializer(serializers.ModelSerializer):
    def to_representation(self, instance):
        data = super().to_representation(instance)
        data['img_name'] = instance.img_name.url if instance.img_name else ''
        return data

    class Meta:
        model = Category
        fields = ['id', 'name', 'img_name']


class VenueSerializer(serializers.ModelSerializer):
    def to_representation(self, instance):
        data = super().to_representation(instance)
        data['img_seat'] = instance.img_seat.url if instance.img_seat else ''
        return data

    class Meta:
        model = Venue
        fields = ['id', 'name', 'address', 'latitude', 'longitude', 'img_seat', 'address']


class PerformanceSerializer(serializers.ModelSerializer):
    class Meta:
        model = Performance
        fields = ['id', 'name', 'started_date', 'ended_date', 'event', 'active']

    def validate(self, data):
        # Validation sẽ được gọi từ clean() trong model
        performance = Performance(**data)
        performance.validation_time()
        return data


class TicketTypeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Ticket_Type
        fields = ['id', 'name', 'quantity', 'price', 'event', 'active']


class TicketSerializer(serializers.ModelSerializer):
    event_name = serializers.CharField(source='ticket_type.event.name', read_only=True)
    ticket_types = TicketTypeSerializer(many=True, read_only=True)

    class Meta:
        model = Ticket
        fields = ['id', 'code_qr', 'is_checked_in', 'quantity', 'ticket_types', 'event_name']


class TicketCreateSerializer(serializers.Serializer):
    ticket_type_id = serializers.IntegerField()
    quantity = serializers.IntegerField(min_value=1)

    def validate_ticket_type_id(self, value):
        if not Ticket_Type.objects.filter(pk=value, active=True).exists():
            raise serializers.ValidationError("Ticket type không tồn tại hoặc đã bị khoá.")
        return value


class EventListSerializer(serializers.ModelSerializer):
    venue_name = serializers.CharField(source='venue.name', read_only=True)
    is_reviewed = serializers.SerializerMethodField()

    def to_representation(self, instance):
        data = super().to_representation(instance)
        data['image'] = instance.image.url if instance.image else ''
        return data

    def get_is_reviewed(self, event):
        user = self.context['request'].user
        if user and user.is_authenticated:
            return Review.objects.filter(event=event, user=user).exists()
        return False

    class Meta:
        model = Event
        fields = ['id', 'name', 'image', 'started_date', 'venue_name', 'is_reviewed']


class EventDetailSerializer(serializers.ModelSerializer):
    category = CategorySerializer(read_only=True)
    venue = VenueSerializer(read_only=True)
    performances = PerformanceSerializer(many=True, read_only=True)
    ticket_types = TicketTypeSerializer(many=True, read_only=True)

    def to_representation(self, instance):
        data = super().to_representation(instance)
        data['image'] = instance.image.url if instance.image else ''
        return data

    class Meta:
        model = Event
        fields = ['id', 'name', 'image', 'attendee_count', 'started_date',
                  'ended_date', 'description', 'status', 'category',
                  'venue', 'performances', 'ticket_types']


class ReceiptCreateSerializer(serializers.ModelSerializer):
    tickets = TicketCreateSerializer(many=True, write_only=True)
    user = serializers.PrimaryKeyRelatedField(read_only=True)
    tickets_output = serializers.SerializerMethodField()
    user_name = serializers.SerializerMethodField()

    def get_tickets_output(self, objs):
        tickets_output = objs.tickets.all()
        return TicketSerializer(tickets_output, many=True).data

    def get_user_name(self, obj):
        return obj.user.username if obj.user else None

    def validate(self, data):
        user = self.context['request'].user
        tickets_data = data.get('tickets', [])

        for ticket in tickets_data:
            try:
                ticket_type = Ticket_Type.objects.get(pk=ticket['ticket_type_id'], active=True)
            except Ticket_Type.DoesNotExist:
                raise serializers.ValidationError("Loại vé không tồn tại.")

            new_event = ticket_type.event
            exist_tickets = Ticket.objects.filter(receipt__user=user,is_checked_in=False)

            for existing_ticket in exist_tickets:
                existing_event = existing_ticket.ticket_type.event

                is_time = (
                        new_event.started_date <= existing_event.ended_date and
                        new_event.ended_date >= existing_event.started_date
                )

                is_same_venue = new_event.venue == existing_event.venue

                if is_time and is_same_venue:
                    raise serializers.ValidationError({
                        'tickets': f"Sự kiện '{new_event.name}' trùng thời gian và địa điểm với sự kiện '{existing_event.name}' bạn đã đặt trước đó."
                    })

        return data

    def create(self, validated_data):
        tickets = validated_data.pop("tickets")
        data = validated_data.copy()

        user = self.context['request'].user
        receipt = Receipt(user=user, is_paid=True, **data)
        receipt.save()

        for ticket_data in tickets:
            ticket_type = Ticket_Type.objects.get(pk=ticket_data['ticket_type_id'])
            ticket_type.quantity -= ticket_data['quantity']
            ticket_type.save()

            Ticket.objects.create(
                receipt=receipt,
                ticket_type=ticket_type,
                quantity=ticket_data['quantity']
            )
        return receipt

    class Meta:
        model = Receipt
        fields = ["id", "payment_method", "total_quantity", "total_price", "tickets", "user", "user_name",
                  "tickets_output"]
        extra_kwargs = {
            'user': {'write_only': True},
            'tickets': {'write_only': True}
        }


class ReceiptSerializer(serializers.ModelSerializer):
    tickets = TicketSerializer(many=True, read_only=True)

    class Meta:
        model = Receipt
        fields = ["id", "payment_method", "total_quantity", "total_price", "tickets"]


class ReceiptHistorySerializer(serializers.ModelSerializer):
    event_name = serializers.SerializerMethodField()
    venue_name = serializers.SerializerMethodField()
    venue_address = serializers.SerializerMethodField()

    class Meta:
        model = Receipt
        fields = ["id", "event_name", "venue_name", "venue_address", "total_price"]

    def get_event_name(self, receipt):
        first_ticket = receipt.tickets.first()
        if first_ticket:
            return first_ticket.ticket_type.event.name
        return None

    def get_venue_name(self, receipt):
        first_ticket = receipt.tickets.first()
        if first_ticket:
            return first_ticket.ticket_type.event.venue.name
        return None

    def get_venue_address(self, receipt):
        first_ticket = receipt.tickets.first()
        if first_ticket:
            return first_ticket.ticket_type.event.venue.address
        return None


class MessagesSerializer(serializers.ModelSerializer):
    sender = serializers.CharField(source="sender.username", read_only=True)
    room_id = serializers.IntegerField(source="room.id", read_only=True)
    message = serializers.CharField(source="content",read_only=True)
    time = serializers.DateTimeField(source="sent_at",read_only=True)

    class Meta:
        model = Messages
        fields = ["id", "message", "time", "room_id", "sender"]


class CommentSerializer(serializers.ModelSerializer):
    def to_representation(self, instance):
        data = super().to_representation(instance)
        data['user'] = UserSerializer(instance.user).data
        return data

    class Meta:
        model = Comment
        fields = ["id", "content", 'created_date', 'updated_date', "user", "event"]
        extra_kwargs={
            'event':{
                'write_only' : True
            }
        }


class ReviewSerializer(serializers.ModelSerializer):
    def to_representation(self, instance):
        data = super().to_representation(instance)
        data['user'] = UserSerializer(instance.user).data
        return data

    class Meta:
        model = Review
        fields = ["id", "count", 'created_date', 'updated_date', "user", "event"]
        extra_kwargs={
            'event':{
                'write_only' : True
            }
        }
