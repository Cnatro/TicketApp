from django.utils import timezone

from django.db.models import Sum, OuterRef, Subquery, DecimalField, Value, F
from django.db.models.functions import Coalesce
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .models import Ticket_Type, Event, Receipt


@api_view(["GET"])
def get_ticket_stats_by_event_id(request,event_id):
    # loai ve - so luong
    ticket_types_stats = (Ticket_Type.objects.filter(event__id=event_id)
                          .annotate(total=Sum("tickets__quantity")).values("id","name","total"))
    return Response(ticket_types_stats)


def get_revenue_ticket(request):
    decimal_type = DecimalField(max_digits=10, decimal_places=2)
    receipts = Receipt.objects.filter(tickets__ticket_type__event=OuterRef('pk'))\
                   .values('tickets__ticket_type__event') \
                   .annotate(total=Sum('total_price')) \
                   .values('total')[:1]


    events = (Event.objects.filter(
        ended_date__lt=timezone.now(),
        ticket_types__tickets__receipt__is_paid=True)
              .annotate(revenue=Coalesce(
                Subquery(receipts, output_field=decimal_type),
                         Value(0, output_field=decimal_type))
                        ).values('id', 'name', 'revenue')).distinct()

    return events


def get_interest_event(request):
    # su kien - so luong mua
    events_with_ticket_quantity = (Event.objects.filter(
        ended_date__lt=timezone.now(),
        ticket_types__tickets__receipt__is_paid=True)
                                   .annotate(total_quantity=Sum("ticket_types__tickets__quantity"))
                                   .values("id","name","total_quantity")).distinct()

    return events_with_ticket_quantity