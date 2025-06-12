from .documents import EventDocument
from django.utils import timezone
from elasticsearch_dsl import Q

def search_events(query):
    q = Q(
        "multi_match",
        query=query,
        fields=["name", "venue.name"],
        fuzziness="auto"  # Cho phép tìm gần đúng
    )
    return EventDocument.search().query(q).extra(size=20).execute()

def get_top_events(limit=4):
    now = timezone.now()
    q = Q("bool", filter=[
        Q("term", active=True),#truy vấn chính xác
        Q("range", ended_date={"gt": now}) # khoảng thời gian
    ])
    search = EventDocument.search().query(q).sort("-view_count")[:limit]
    hits = search.execute()
    ids = [int(hit.meta.id) for hit in hits]
    return ids