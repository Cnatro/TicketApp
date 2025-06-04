from django.urls import path, include

from .views import UserViewSet, CategoryViewSet, VenueViewSet, EventViewSet, TicketViewSet, ReceiptViewSet
from rest_framework.routers import DefaultRouter

router = DefaultRouter()
router.register('users', UserViewSet, basename='user')
router.register('categories', CategoryViewSet, basename='category')
router.register('venues', VenueViewSet, basename='venue')
router.register('events', EventViewSet, basename='event')
router.register('tickets', TicketViewSet, basename='ticket')
router.register('receipts', ReceiptViewSet, basename='receipt')

urlpatterns = [
    path('', include(router.urls)),

]