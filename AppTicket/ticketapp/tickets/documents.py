from django_elasticsearch_dsl import Document, fields
from django_elasticsearch_dsl.registries import registry
from .models import Event

@registry.register_document
class EventDocument(Document):
    venue = fields.ObjectField(properties={
        'name': fields.TextField(),
    })

    class Index:
        name = 'events'

    class Django:
        model = Event
        fields = ['name']
