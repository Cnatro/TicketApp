from django_elasticsearch_dsl import Document, Index, fields
from django_elasticsearch_dsl.registries import registry
from .models import Event

# ✅ Khai báo Index với custom analyzer settings
event_index = Index('events')
event_index.settings(
    number_of_shards=1,
    number_of_replicas=0,
    analysis={
        "filter": {
            "edge_ngram_filter": {
                "type": "edge_ngram",
                "min_gram": 1,
                "max_gram": 20
            }
        },
        "analyzer": {
            "autocomplete": {
                "type": "custom",
                "tokenizer": "standard",
                "filter": ["lowercase", "edge_ngram_filter"]
            },
            "autocomplete_search": {
                "type": "custom",
                "tokenizer": "standard",
                "filter": ["lowercase"]
            }
        }
    }
)

@registry.register_document
class EventDocument(Document):
    name = fields.TextField(
        analyzer="autocomplete",              # ✅ Dùng đúng tên analyzer
        search_analyzer="autocomplete_search"
    )

    venue = fields.ObjectField(properties={
        'name': fields.TextField(
            analyzer="autocomplete",
            search_analyzer="autocomplete_search"
        ),
        'address': fields.TextField()
    })

    class Index:
        name = 'events'
        settings = event_index._settings

    class Django:
        model = Event
        fields = [
            'description',
            'attendee_count',
            'started_date',
            'ended_date',
            'active',
            'status',
            'view_count',
        ]
