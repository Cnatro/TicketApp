from django_elasticsearch_dsl import Document, Index, fields
from django_elasticsearch_dsl.registries import registry
from elasticsearch_dsl import analyzer
from .models import Event

# Khai báo analyzer
my_analyzer = analyzer(
    'my_analyzer',
    tokenizer="standard",
    filter=["lowercase", "stop", "snowball"]
)

# Cấu hình Index
event_index = Index('events')
event_index.settings(
    number_of_shards=1,
    number_of_replicas=0,
)

# Đăng ký Document
@registry.register_document
class EventDocument(Document):
    # Áp dụng analyzer cho trường name
    name = fields.TextField(analyzer=my_analyzer)

    venue = fields.ObjectField(properties={
        'name': fields.TextField(analyzer=my_analyzer),
        'address': fields.TextField()  # Không dùng để tìm, nhưng có thể để hiển thị
    })

    class Index:
        name = 'events'

    class Django:
        model = Event
        fields = [
            'description',         # Không cần tìm, chỉ hiển thị
            'attendee_count',      # Hiển thị
            'started_date',
            'ended_date',
            'active',
            'status',
            'view_count',
        ]
