from .documents import EventDocument
from elasticsearch_dsl import Q

def search_events(query):
    q = Q("multi_match", query=query, fields=["name", "venue.name"])
    return EventDocument.search().query(q).extra(size=20).execute()