from django.contrib import admin
from django.utils.html import format_html
from django.urls import reverse
from .models import *


class BaseAdminSite(admin.ModelAdmin):

    def actions_link(self, obj):
        edit_url = reverse(f'admin:{obj._meta.app_label}_{obj._meta.model_name}_change', args=[obj.pk])
        delete_url = reverse(f'admin:{obj._meta.app_label}_{obj._meta.model_name}_delete', args=[obj.pk])
        return format_html(
            '<a href="{}" style="color:blue; margin-right:10px;">Cập nhật</a>'
            '<a href="{}" style="color:red;">Xóa</a>',
            edit_url,
            delete_url
        )

    actions_link.short_description = 'Thao tác'
    actions_link.allow_tags = True


class TicketAppAdminSite(admin.AdminSite):
    site_header = "TICKETMALL - NN"


class CategoryAdminSite(BaseAdminSite):
    list_display = ['id', 'name', 'active', 'created_date', 'actions_link']
    search_fields = ['name']
    list_display_links = ['name']
    list_per_page = 5
    list_filter = ['created_date', 'active']


class UserAdminSite(BaseAdminSite):
    list_display = ['id', 'username', 'email', 'is_active', 'actions_link']
    search_fields = ['username', 'email']
    list_display_links = ['username']
    list_per_page = 5
    list_filter = ['is_active']
    # làm phân quyền r hiện thị thêm role


class VenueAdminSite(BaseAdminSite):
    list_display = ['id', 'name', 'capacity', 'active', 'actions_link']
    list_display_links = ['name']
    search_fields = ['name']
    list_filter = ['active', 'created_date']
    list_per_page = 5


class EventAdminSite(BaseAdminSite):
    list_display = ['id', 'name', 'time_event', 'status', 'category', 'user', 'venue', 'attendee_count', 'active',
                    'actions_link']
    search_fields = ['name']
    list_display_links = ['name']
    list_filter = ['status']
    list_per_page = 5
    list_select_related = ['category', 'user', 'venue']
    exclude = ['status','user']

    def time_event(self, obj):
        return f"{obj.started_date.strftime('%d/%m/%Y %H:%M')} -- {obj.ended_date.strftime('%d/%m/%Y %H:%M')}"

    time_event.short_description = "Event time"


    def save_model(self, request, obj, form, change):
        if not change:
            obj.user = request.user
        obj.save()


class TicketTypeAdminSite(BaseAdminSite):
    # list_display = ['id','event','']
    pass

admin_site = TicketAppAdminSite(name="myAdminSite")
admin_site.register(User, UserAdminSite)
admin_site.register(Category, CategoryAdminSite)
admin_site.register(Venue, VenueAdminSite)
admin_site.register(Event, EventAdminSite)
admin_site.register(Ticket_Type)
admin_site.register(Ticket)
admin_site.register(Performance)
admin_site.register(Receipt)
admin_site.register(Comment)
admin_site.register(Review)
admin_site.register(Messages)
