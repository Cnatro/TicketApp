from django.urls import path, include

from . import statistical
from .views import UserViewSet, CategoryViewSet, EventViewSet, ReceiptViewSet, \
    PayPalViewSet, ChatRoomViewSet, EmailViewSet
from rest_framework.routers import DefaultRouter

router = DefaultRouter()
router.register('users', UserViewSet, basename='user')
router.register('categories', CategoryViewSet, basename='category')
router.register('events', EventViewSet, basename='event')
router.register('receipts', ReceiptViewSet, basename='receipt')
router.register("paypal", PayPalViewSet, basename="paypal")
router.register("chatroom",ChatRoomViewSet,basename="chatroom")
router.register("email",EmailViewSet, basename="email")

urlpatterns = [
    path('', include(router.urls)),
    path("stats/tickets/<int:event_id>/", statistical.get_ticket_stats_by_event_id, name="ticket-stats"),
]