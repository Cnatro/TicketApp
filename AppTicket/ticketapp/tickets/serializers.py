from rest_framework import serializers
from tickets.models import  User, Category, Venue, Event, Performance, Ticket_Type, Ticket, Registration, Receipt,Comment, Review, Messages, Notification

class UserSerializer(serializers.ModelSerializer):
    def to_representation(self, instance):
        data = super().to_representation(instance)
        data['avatar'] = instance.avatar.url if instance.avatar else ''
        return data;

    def creat(self, validated_data):



