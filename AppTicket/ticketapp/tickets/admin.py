from django.contrib import admin
from .models import*


class TicketAppAdminSite(admin.AdminSite):
    site_header = "TICKETMALL - NN"


admin_site = TicketAppAdminSite(name="myAdminSite")
admin_site.register(User)
admin_site.register(Category)
admin_site.register(Venue)
admin_site.register(Event)
admin_site.register(Ticket)
admin_site.register(Ticket_Type)
admin_site.register(Registration)
admin_site.register(Performance)
admin_site.register(Receipt)
admin_site.register(Comment)
admin_site.register(Review)
admin_site.register(Messages)