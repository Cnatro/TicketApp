from django.template.defaulttags import querystring
from django.views.generic import detail
from rest_framework.response import Response
from rest_framework import viewsets, permissions, filters, generics, parsers
from rest_framework.decorators import action
from rest_framework.permissions import IsAuthenticated

from .models import  User, Category, Venue, Event, Performance, Ticket_Type, Ticket, Receipt, Comment, Review,Messages, Notification
from tickets import serializers
from tickets.serializers import UserSerializer, CategorySerializer


class UserViewSet(viewsets.ViewSet, generics.CreateAPIView):
    queryset = User.objects.all()
    serializer_class = serializers.UserSerializer
    parser_classes = [parsers.MultiPartParser]

    @action(detail=False, methods=['get'], url_path='current-user', permission_classes = [IsAuthenticated])
    def get_current_user(self, request):
        u = request.user
        if request.method.__eq__('PATCH'):
            for k, v in request.data.items():
                if k in ['first_name','last_name']:
                    setattr(u,k,v)
                elif k.__eq__('password'):
                    u.set_password(v)
            u.save()
        return Response(serializers.UserSerializer(u).data)


class CategoryViewSet(viewsets.ViewSet, generics.ListAPIView):
    queryset = Category.objects.filter(active=True)
    serializer_class = serializers.CategorySerializer

    def list(self, request):
        queryset = self.get_queryset()
        serializer = self.get_serializer(queryset, many = True)
        return Response(serializer.data)

    @action(methods=['get'], detail=True, url_path="events")
    def get_event_by_category(self, request, pk = None):
        try:
            category = Category.objects.get(pk=pk, active=True)
        except Category.DoesNotExist:
            return Response({'error': 'Category not found'}, status=404)
        events = category.events.filter(active=True) #events là foreinket
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
    queryset = Event.objects.filter(active=True).order_by('started_date')
    serializer_class = serializers.EventListSerializer

    def retrieve(self, request, pk=None):
        try:
            event = self.get_queryset().get(pk=pk)
        except Event.DoesNotExist:
            return Response({'error': 'Event not found'}, status=404)
        serializer = serializers.EventDetailSerializer(event,context={'request':request})
        return Response(serializer.data)

class PerformanceViewSet(viewsets.ViewSet, generics.ListAPIView):
    queryset = Performance.objects.filter(active=True)
    serializer_class = serializers.PerformanceSerializer

class TicketViewSet(viewsets.ViewSet, generics.ListAPIView):
    queryset = Ticket.objects.filter(active=True)
    serializer_class = serializers.TicketSerializer









    


