from email.mime.image import MIMEImage

from django.core.mail import EmailMultiAlternatives
from django.template.loader import render_to_string
from django.utils import timezone

from rest_framework.response import Response
from rest_framework import viewsets, generics, parsers, status
from rest_framework.decorators import action
from rest_framework.permissions import IsAuthenticated

from django.db.models import Case, When, IntegerField
from .models import User, Category, Venue, Event, Performance, Ticket, Receipt, Messages, ChatRoom
from .paypal_configs import paypalrestsdk
from .utils import  generate_qr_bytes
from . import serializers, paginators
from .serializers import UserSerializer, CategorySerializer, TicketTypeSerializer,ReceiptCreateSerializer,ReceiptSerializer,\
    ReceiptHistorySerializer,MessagesSerializer
from .search import search_events


class UserViewSet(viewsets.ViewSet, generics.CreateAPIView):
    queryset = User.objects.all()
    serializer_class = serializers.UserSerializer
    parser_classes = [parsers.MultiPartParser]

    @action(detail=False, methods=['get', 'patch'], url_path='current-user', permission_classes = [IsAuthenticated])
    def get_current_user(self, request):
        u = request.user
        if request.method.__eq__('PATCH'):
            for k, v in request.data.items():
                if k in ['first_name', 'last_name']:
                    setattr(u, k, v)
                elif k.__eq__('password'):
                    u.set_password(v)
            u.save()
        return Response(serializers.UserSerializer(u).data)


class CategoryViewSet(viewsets.ViewSet, generics.ListAPIView):
    queryset = Category.objects.filter(active=True)
    serializer_class = serializers.CategorySerializer

    def list(self, request):
        queryset = self.get_queryset()
        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)

    @action(methods=['get'], detail=True, url_path="events")
    def get_event_by_category(self, request, pk=None):
        try:
            category = Category.objects.get(pk=pk, active=True)
        except Category.DoesNotExist:
            return Response({'error': 'Category not found'}, status=404)
        events = category.events.filter(active=True)  # events là foreinket
        serializer = serializers.EventListSerializer(events, many=True, context={'request': request})
        return Response(serializer.data)


class VenueViewSet(viewsets.ViewSet, generics.ListAPIView):
    queryset = Venue.objects.filter(active=True)
    serializer_class = serializers.VenueSerializer

    @action(methods=['get'], detail=True, url_path="events")
    def get_event_by_venue(self, request, pk=None):
        try:
            venue = Venue.objects.get(pk=pk, active=True)
        except Venue.DoesNotExist:
            return Response({'error': 'Venue not found'}, status=404)
        events = venue.events.filter(active=True)
        serializer = serializers.EventListSerializer(events, many=True, context={'request': request})
        return Response(serializer.data)



class EventViewSet(viewsets.ViewSet, generics.ListAPIView):
    serializer_class = serializers.EventListSerializer
    pagination_class = paginators.EventPagination

    def get_queryset(self):
        current_day = timezone.now()
        q = self.request.query_params.get('q')

        if q:
            results = search_events(q)
            ids = [int(hit.meta.id) for hit in results]
            if ids:
                preserved_order = Case(
                    *[When(id=pk, then=pos) for pos, pk in enumerate(ids)],
                    output_field=IntegerField()
                )
                return Event.objects.filter(
                    id__in=ids,
                    active=True,
                    ended_date__gt=current_day
                ).order_by(preserved_order)
            else:
                return Event.objects.none()

        return Event.objects.filter(
            active=True,
            ended_date__gt=current_day
        ).order_by('started_date')

    def list(self, request, *args, **kwargs):
        queryset = self.get_queryset()
        # Kiểm tra nếu queryset rỗng
        if not queryset.exists():
            return Response({
                'next': None,
                'previous': None,
                'count': 0,
                'results': []
            }, status=status.HTTP_200_OK)

        # Tiến hành phân trang nếu có dữ liệu
        page = self.paginate_queryset(queryset)
        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return self.get_paginated_response(serializer.data)

        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)

    def retrieve(self, request, pk=None):
        try:
            event = self.get_queryset().get(pk=pk)
        except Event.DoesNotExist:
            return Response({'error': 'Event not found'}, status=404)
        serializer = serializers.EventDetailSerializer(event, context={'request': request})
        return Response(serializer.data)

    @action(methods=['get'], detail=True, url_name="ticket-type", url_path="event_types")
    def get_event_types(self, request, pk):
        event_types = self.get_object().ticket_types.filter(active=True)
        serializer = serializers.TicketTypeSerializer(event_types, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)


class PerformanceViewSet(viewsets.ViewSet, generics.ListAPIView):
    queryset = Performance.objects.filter(active=True)
    serializer_class = serializers.PerformanceSerializer


class TicketViewSet(viewsets.ViewSet, generics.ListAPIView):
    queryset = Ticket.objects.filter(active=True)
    serializer_class = serializers.TicketSerializer

    def list(self, request):
        user = request.user
        tickets = Ticket.objects.filter(receipt__user=user)
        serializer = self.get_serializer(tickets, many=True)
        return Response(serializer.data)


class ReceiptViewSet(viewsets.ViewSet, generics.CreateAPIView):
    queryset = Receipt.objects.filter(active=True)
    serializer_class = serializers.ReceiptCreateSerializer
    permission_classes = [IsAuthenticated]

    @action(methods=['get'], detail=False, url_path='latest')
    def get_latest_receipt(self, request):
        user = request.user
        now = timezone.now()
        latest_receipt = Receipt.objects.filter(
            user=user,
            tickets__ticket_type__event__ended_date__gt=now).order_by('-created_date').first()
        if not latest_receipt:
            return Response({'message': 'Chưa có hóa đơn nào'}, status=status.HTTP_404_NOT_FOUND)

    @action(methods=['get'], detail=False, url_path="receipt-history")
    def get_history_receipt(self, request):
        user = request.user
        history_receipt = Receipt.objects.filter(user=user).order_by('-created_date')
        if not history_receipt:
            return Response({'message': 'Chưa có hóa đơn nào'}, status=status.HTTP_404_NOT_FOUND)
        serializer = serializers.ReceiptHistorySerializer(history_receipt, many=True)
        return Response(serializer.data)





class PayPalViewSet(viewsets.ViewSet):
    permission_classes = [IsAuthenticated]

    @action(methods=["post"], detail=False, url_path="create-payment")
    def create_payment(self, request):

        total = request.data.get("total", "10.00")
        currency = "USD"
        return_url = request.data.get("return_url")
        cancel_url = request.data.get("cancel_url")

        payment = paypalrestsdk.Payment({
            "intent": "sale",  # trả ngay khi bấm đồng ý
            "payer": {"payment_method": "paypal"},
            "redirect_urls": {
                "return_url": return_url,
                "cancel_url": cancel_url,
            },
            "transactions": [{
                "amount": {
                    "total": total,
                    "currency": currency,
                },
                "description": "ZiveGO Ticket Payment"
            }]
        })

        if payment.create():
            for link in payment.links:
                if link.rel == "approval_url":
                    return Response({
                        "approval_url": link.href,
                        "payment_id": payment.id,
                    })
        else:
            return Response({"error": payment.error}, status=400)

    @action(detail=False, methods=["post"], url_path="execute-payment")
    def execute(self, request):
        payment_id = request.data.get("payment_id")
        payer_id = request.data.get("payer_id")

        payment = paypalrestsdk.Payment.find(payment_id)
        if payment.execute({"payer_id": payer_id}):
            return Response({"status": "success", "payment": payment.to_dict()})
        else:
            return Response({"error": payment.error}, status=400)



class ChatRoomViewSet(viewsets.ViewSet, generics.ListAPIView):
    permission_classes = [IsAuthenticated]

    @action(methods=['get'], detail=False, url_path="room-messages")
    def get_my_room_messages(self, request):
        user = request.user
        try:
            room = ChatRoom.objects.get(customer=user)
        except ChatRoom.DoesNotExist:
            return Response({"detail": "User chưa có phòng chat"}, status=status.HTTP_404_NOT_FOUND)

        messages = Messages.objects.filter(room=room).order_by('created_date')
        serializer = MessagesSerializer(messages, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)


class EmailViewSet(viewsets.ViewSet):
    permission_classes = [IsAuthenticated]

    @action(methods=["post"], detail=False, url_path="send")
    def send_email(self, request):
        user = request.user

        email_to = request.data.get("email",user.email)
        message = request.data.get("message", "Nội dung trống")
        subject = request.data.get("subject", "Thông báo từ hệ thống")

        if not email_to:
            Response({"error": "Tài khoản không có Email"}, status=status.HTTP_400_BAD_REQUEST)

        try:

            tickets = message.get("tickets", [])
            attachments = []

            for i, ticket in enumerate(tickets):
                qr_data = ticket.get("code_qr", "")
                qr_bytes = generate_qr_bytes(qr_data)
                cid = f"qr{i}"
                ticket["qr_cid"] = cid

                attachments.append({
                    "cid": cid,
                    "bytes": qr_bytes
                })

            message["tickets"] = tickets


            html_content_email = render_to_string("email_template.html",message)

            email  = EmailMultiAlternatives(
                subject=subject,
                body="Đây là xác nhận đặt vé của bạn.",
                from_email=None,
                to=[email_to]
            )
            email.attach_alternative(html_content_email,"text/html")
            # Gắn QR code ảnh theo cid
            for att in attachments:
                image = MIMEImage(att["bytes"])
                image.add_header("Content-ID", f"<{att['cid']}>")
                image.add_header("Content-Disposition", "inline", filename=f"{att['cid']}.png")
                email.attach(image)

            email.send()
            return Response({"message": f"Đã gửi email tới {email_to}"}, status=status.HTTP_200_OK)

        except Exception as e:
            return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


