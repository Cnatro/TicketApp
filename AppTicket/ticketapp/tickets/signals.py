from django.db.models.signals import post_save, post_delete
from django.dispatch import receiver
from .models import Event
from .documents import EventDocument

@receiver(post_save, sender=Event)
def update_event_document(sender, instance, **kwargs):
    instance.refresh_from_db()
    EventDocument().update(instance, refresh=True)

@receiver(post_delete, sender=Event)
def delete_event_document(sender, instance, **kwargs):
    EventDocument().delete(instance, refresh=True)