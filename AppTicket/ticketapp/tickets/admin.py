from idlelib.rpc import request_queue

from django.contrib import admin
from django.contrib.auth.models import Group, Permission
from django.utils.html import format_html
from django.urls import reverse
from .models import *
import qrcode
import base64
from io import BytesIO
from django.db.models import Avg
from ticketapp.settings import ALLOWED_GROUPS
from django.contrib.auth.hashers import make_password


class TicketAppAdminSite(admin.AdminSite):
    site_header = "TICKETMALL - NN"

    def has_permission(self, request):
        if not request.user.is_active or not request.user.is_authenticated:
            return False

        return request.user.groups.filter(name__in=ALLOWED_GROUPS).exists()


class BaseModelAdmin(admin.ModelAdmin):

    def __init__(self, model, admin_site):
        self.app_label = model._meta.app_label
        self.model_name = model._meta.model_name
        super().__init__(model, admin_site)

    def has_permission(self, request, action, obj=None):
        if not request.user.is_superuser and isinstance(obj, User):
            return obj is not None and obj == request.user

        perm = f"{self.app_label}.{action}_{self.model_name}"
        return request.user.has_perm(perm)

    def has_view_permission(self, request, obj=None):
        return self.has_permission(request, "view", obj)

    def has_add_permission(self, request):
        return self.has_permission(request, "add")

    def has_delete_permission(self, request, obj=None):
        return self.has_permission(request, "delete", obj)

    def has_change_permission(self, request, obj=None):
        return self.has_permission(request, "change", obj)

    def actions_link(self, obj):
        edit_url = reverse(f'admin:{obj._meta.app_label}_{obj._meta.model_name}_change', args=[obj.pk])
        delete_url = reverse(f'admin:{obj._meta.app_label}_{obj._meta.model_name}_delete', args=[obj.pk])
        return format_html(
            '<a href="{}" style="color:blue; margin-right:10px;">Cập nhật</a>'
            '<a href="{}" style="color:red;">Xóa</a>',
            edit_url,
            delete_url
        )

    actions_link.short_description = 'Action'
    actions_link.allow_tags = True


class CategoryModelAdmin(BaseModelAdmin):
    list_display = ['id', 'name', 'active', 'created_date', 'actions_link']
    search_fields = ['name']
    list_display_links = ['name']
    list_per_page = 5
    list_filter = ['created_date', 'active']


class UserModelAdmin(BaseModelAdmin):
    list_display = ['id', 'username', 'email', 'is_active', 'get_groups', 'actions_link']
    search_fields = ['username', 'email']
    list_display_links = ['username']
    list_per_page = 5
    list_filter = ['is_active']

    def get_groups(self, obj):
        return ", ".join([g.name for g in obj.groups.all()])

    get_groups.short_description = 'Groups'

    def has_module_permission(self, request):
        return request.user.is_superuser

    def changelist_view(self, request, extra_context=None):
        request._exclude_self = True
        return super().changelist_view(request, extra_context=extra_context)

    # lấy ds user
    def get_queryset(self, request):
        qs = super().get_queryset(request)
        if getattr(request, "_exclude_self", False):
            qs = qs.exclude(pk=request.user.pk)

        if not request.user.is_superuser:
            qs = qs.filter(pk=request.user.pk)
        return qs

    def save_model(self, request, obj, form, change):
        if not change:
            obj.password = make_password(obj.password)
        else:
            db_user = User.objects.get(pk=obj.pk)
            if db_user.password != obj.password:
                obj.password = make_password(obj.password)
        super().save_model(request, obj, form, change)


class VenueModelAdmin(BaseModelAdmin):
    list_display = ['id', 'name', 'capacity', 'active', 'actions_link']
    list_display_links = ['name']
    search_fields = ['name']
    list_filter = ['active', 'created_date']
    list_per_page = 5


class EventModelAdmin(BaseModelAdmin):
    list_display = ['id', 'name', 'time_event', 'status', 'category', 'user', 'venue', 'attendee_count', 'active',
                    'avg_reviews',
                    'actions_link']
    search_fields = ['name']
    list_display_links = ['name']
    list_filter = ['status']
    list_per_page = 5
    list_select_related = ['category', 'user', 'venue']
    exclude = ['status', 'user']

    def time_event(self, obj):
        return format_html('{}<br>--<br>{}', obj.started_date.strftime('%d/%m/%Y %H:%M'),
                           obj.ended_date.strftime('%d/%m/%Y %H:%M'))

    time_event.short_description = "Event time"

    def save_model(self, request, obj, form, change):
        if not change:
            obj.user = request.user
        obj.save()

    def avg_reviews(self, obj):
        result = obj.review_set.aggregate(avg=Avg('count'))
        return round(result['avg'], 2) if result['avg'] else "Chưa có"

    avg_reviews.short_description = "reviews"


class TicketTypeModelAdmin(BaseModelAdmin):
    list_display = ['id', 'event', 'name', 'quantity', 'format_price', 'active', 'actions_link']
    list_filter = ['event']
    search_fields = ['name']
    list_display_links = ['name']
    list_per_page = 5

    def format_price(self, obj):
        return f"{obj.price:,.0f} VNĐ".replace(",", ".")

    format_price.short_description = "price"


class TicketModelAdmin(BaseModelAdmin):
    list_display = ['id', 'event_name', 'ticket_type', 'qr_code', 'receipt', 'actions_link']
    list_filter = ['ticket_type', 'receipt__id']
    list_select_related = ['receipt']
    list_per_page = 5
    exclude = ['is_check_in', 'code_qr']

    def event_name(self, obj):
        return obj.ticket_type.event.name

    def qr_code(self, obj):
        qr_data = obj.code_qr

        qr_img = qrcode.make(qr_data)
        buffer = BytesIO()
        qr_img.save(buffer, format='PNG')
        img_str = base64.b64encode(buffer.getvalue()).decode()

        modal_id = f"qrModal{obj.id}"

        return format_html(f"""
                <button class="btn btn-sm btn-primary" onclick="event.preventDefault(); document.getElementById('{modal_id}').style.display='block'">
                    Xem QR
                </button>
                <div id="{modal_id}" style="display:none; position:fixed; z-index:9999; left:0; top:0; width:100%; height:100%;
                     background-color:rgba(0,0,0,0.5);" onclick="this.style.display='none'">
                    <div style="position:relative; margin:10% auto; padding:20px; background:white; width:fit-content; border-radius:8px;"
                         onclick="event.stopPropagation()">
                        <button style="position:absolute; top:10px; right:10px; background:transparent; border:none; font-size:20px; cursor:pointer;"
                                onclick="document.getElementById('{modal_id}').style.display='none'">
                            &times;
                        </button>
                        <img src="data:image/png;base64,{img_str}" style="width:250px; height:250px;" />
                    </div>
                </div>
            """)

    qr_code.short_description = "QR Code"
    event_name.short_description = "event name"
    qr_code.short_description = "QR"


class PerformanceModelAdmin(BaseModelAdmin):
    list_display = ['id', 'name', 'time_performance', 'event', 'actions_link']
    list_filter = ['event']
    search_fields = ['name']
    list_per_page = 5

    def time_performance(self, obj):
        return f"{obj.started_date.strftime('%d/%m/%Y %H:%M')} -- {obj.ended_date.strftime('%d/%m/%Y %H:%M')}"

    time_performance.short_description = "performance time"


class ReceiptModelAdmin(BaseModelAdmin):
    list_display = ['id', 'user', 'payment_method', 'is_paid', 'total_quantity', 'format_total_price', 'actions_link']
    list_per_page = 5
    search_fields = ['user']
    list_filter = ['is_paid']

    def format_total_price(self, obj):
        return f"{obj.total_price:,.0f} VNĐ".replace(",", ".")

    format_total_price.short_description = "total price"


class PermissionModelAdmin(BaseModelAdmin):
    list_display = ['id', 'codename', 'name', 'actions_link']
    list_filter = ['content_type__model']
    list_per_page = 10
    ordering = ['-id']
    list_display_links = ['codename']


class GroupModelAdmin(BaseModelAdmin):
    list_display = ['id', 'name', 'actions_link']
    search_fields = ['name']
    list_per_page = 5
    list_display_links = ['name']


admin_site = TicketAppAdminSite(name="myAdminSite")
admin_site.register(User, UserModelAdmin)
admin_site.register(Category, CategoryModelAdmin)
admin_site.register(Venue, VenueModelAdmin)
admin_site.register(Event, EventModelAdmin)
admin_site.register(Ticket_Type, TicketTypeModelAdmin)
admin_site.register(Ticket, TicketModelAdmin)
admin_site.register(Performance, PerformanceModelAdmin)
admin_site.register(Receipt, ReceiptModelAdmin)
admin_site.register(Group, GroupModelAdmin)
admin_site.register(Permission, PermissionModelAdmin)
# admin_site.register(Comment)
admin_site.register(Review)
# admin_site.register(Messages)
