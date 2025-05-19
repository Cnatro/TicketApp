from rest_framework import serializers
from .models import User, Category, Venue, Event, Performance, Ticket_Type, Ticket, Receipt, Comment, Review,Messages, Notification

class UserSerializer(serializers.ModelSerializer):
    def to_representation(self, instance):
        data = super().to_representation(instance)
        data['avatar'] = instance.avatar.url if instance.avatar else ''
        return data

    def create(self, validated_data):
        data = validated_data.copy()
        u = User(**data)
        u.set_password(u.password)
        u.save()

        return u

    class Meta:
        model = User
        fields = ['id', 'username', 'email', 'first_name', 'last_name',
                 'gender', 'birthday', 'avatar', 'phone', 'address']
        extra_kwargs = {
            'password': {'write_only': True}
        }

class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Category
        fields = ['id','name']

class VenueSerializer(serializers.ModelSerializer):
    def to_representation(self, instance):
        data = super().to_representation(instance)
        data['img_seat'] = instance.img_seat.url if instance.img_seat else ''
        return data

    class Meta:
        model = Venue
        fields = ['id', 'name', 'capacity', 'img_seat', 'address', 'active']


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
        fields = ['id', 'code_qr', 'is_checked_in', 'quantity', 'user','ticket_types','event_name']



class EventListSerializer(serializers.ModelSerializer):
    category_name = serializers.CharField(source='category.name', read_only=True)
    venue_name = serializers.CharField(source='venue.name', read_only=True)
    def to_representation(self, instance):
        data = super().to_representation(instance)
        data['image'] = instance.image.url if instance.image else ''
        return data

    class Meta:
        model = Event
        fields = ['id', 'name', 'image', 'attendee_count', 'started_date',
                 'ended_date', 'status', 'category_name', 'venue_name']


class EventDetailSerializer(serializers.ModelSerializer):
    category = CategorySerializer(read_only=True)
    venue = VenueSerializer(read_only=True)
    performances = PerformanceSerializer(many=True, read_only=True)
    ticket_types = TicketTypeSerializer(many=True, read_only=True)

    class Meta:
        model = Event
        fields = ['id', 'name', 'image', 'attendee_count', 'started_date',
                  'ended_date', 'description', 'status', 'category',
                  'venue', 'performances', 'ticket_types']


class EventCreateUpdateSerializer(serializers.ModelSerializer):
    class Meta:
        model = Event
        fields = ['id', 'name', 'image', 'attendee_count', 'started_date',
                  'ended_date', 'description', 'category', 'venue', 'active']

    def validate(self, data):
        # Validation sẽ được gọi từ clean() trong model
        event = Event(**data)
        if self.instance:  # Update case
            for attr, value in data.items():
                setattr(event, attr, value)
            event.pk = self.instance.pk

        event.validate_event()
        return data


class MessageSerializer(serializers.ModelSerializer):
    user_name = serializers.CharField(source='user.username', read_only=True)

    class Meta:
        model = Messages
        fields = ['id', 'content', 'sent_at', 'event', 'user', 'user_name']


class NotificationSerializer(serializers.ModelSerializer):
    event_name = serializers.CharField(source='event.name', read_only=True, allow_null=True)

    class Meta:
        model = Notification
        fields = ['id', 'title', 'content', 'is_read', 'user', 'event', 'event_name']

