from django.contrib import admin
from django.contrib.admin.views.decorators import staff_member_required
from django.contrib.auth.models import Group, Permission
from django.http import HttpResponseRedirect
from django.shortcuts import render
from django.template.response import TemplateResponse
from django.utils.html import format_html
from django.urls import reverse, path
from rest_framework.decorators import api_view, permission_classes
from rest_framework.generics import get_object_or_404
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response

from .models import *
import qrcode
import base64
from io import BytesIO
from django.db.models import Avg
from ticketapp.settings import ALLOWED_GROUPS
from django.contrib.auth.hashers import make_password
import requests

from .statistical import get_revenue_ticket, get_interest_event


class TicketAppAdminSite(admin.AdminSite):
    site_header = "TICKETMALL - NN"

    def has_permission(self, request):
        if not request.user.is_active or not request.user.is_authenticated:
            return False

        return request.user.groups.filter(name__in=ALLOWED_GROUPS).exists()

    def get_urls(self):
        urls = super().get_urls()
        custom_urls = [
            path('chat/', self.admin_view(admin_chat_view), name='admin_chat'),
            path('verify-ticket/', self.admin_view(verify_ticket_page), name="admin_check_ticket"),
            path('api/verify-ticket/', verify_ticket, name='verify_ticket'),
        ]
        return custom_urls + urls

    def index(self, request, extra_context=None):
        event_ends = Event.objects.filter(
            ended_date__lt=timezone.now(),
            ticket_types__tickets__receipt__is_paid=True
        ).distinct()

        revenue_data = get_revenue_ticket(request)
        interest_data = get_interest_event(request)
        context = {
            **self.each_context(request),
            "event_ends":event_ends,
            "revenue_data":revenue_data,
            "interest_data":interest_data
        }
        return TemplateResponse(request, "admin/custom_index.html", context)


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
    list_display = ['id', 'name', 'address', 'latitude', 'longitude', 'capacity', 'active', 'actions_link']
    list_display_links = ['name']
    search_fields = ['name', 'address']
    list_filter = ['active', 'created_date']
    list_per_page = 5

    def save_model(self, request, obj, form, change):
        if obj.address and not (obj.latitude and obj.longitude):
            try:
                url = "https://nominatim.openstreetmap.org/search"
                params = {
                    'q': obj.address,
                    'format': 'json',
                    'limit': 1,
                    'countrycodes': 'vn'
                }
                headers = {
                    'User-Agent': 'ticketmobileapp/1.0 (nhantran.011004@gmail.com)'
                }
                response = requests.get(url, params=params, headers=headers)
                data = response.json()
                if data:
                    obj.latitude = float(data[0]['lat'])
                    obj.longitude = float(data[0]['lon'])
                else:
                    print(f"Không tìm thấy tọa độ cho địa chỉ: {obj.address}")
            except Exception as e:
                print(f"Lỗi khi lấy tọa độ: {e}")
        super().save_model(request, obj, form, change)


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

    def formfield_for_foreignkey(self, db_field, request, **kwargs):
        if db_field.name == "event":
            now = timezone.now()
            kwargs["queryset"] = Event.objects.filter(started_date__gt=now)
        return super().formfield_for_foreignkey(db_field, request, **kwargs)


    def format_price(self, obj):
        return f"{obj.price:,.0f} VNĐ".replace(",", ".")

    format_price.short_description = "price"


class TicketModelAdmin(BaseModelAdmin):
    list_display = ['id', 'event_name', 'ticket_type', 'qr_code', 'receipt','quantity', 'actions_link']
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
    list_display = ['id', 'user', 'payment_method', 'is_paid', 'total_quantity', 'format_total_price','created_date', 'actions_link']
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


@staff_member_required
def admin_chat_view(request):
    chat_users = User.objects.filter(groups__name="ROLE_CUSTOMER")

    selected_user_id = request.GET.get('user_id')
    selected_user = None
    room_name = None
    messages = []

    if selected_user_id:
        selected_user = get_object_or_404(User, id=selected_user_id)
        room_name = f"room_{selected_user.id}"

        if request.method == "POST":
            content = request.POST.get('message')
            if content:
                Messages.objects.create(sender=selected_user, content=content, from_admin=True)
            return HttpResponseRedirect(f"?user_id={selected_user_id}")

        messages = Messages.objects.filter(room__name=room_name).order_by('created_date')
    context = {
        'chat_users': chat_users,
        'selected_user': selected_user,
        'messages': messages,
        'room_name': room_name
    }
    return render(request, 'admin/chat_view.html', context)


@staff_member_required
@permission_classes([IsAuthenticated])
def verify_ticket_page(request):
    return render(request, 'admin/verify_ticket.html')


@api_view(['GET'])
def verify_ticket(request):
    receipt_id = request.GET.get('receipt_id')
    ticket_type_id = request.GET.get('ticket_type_id')

    try:
        ticket = Ticket.objects.get(receipt_id=receipt_id, ticket_type_id=ticket_type_id)

        if ticket.is_checked_in:
            return Response({'message': 'Vé đã được sử dụng!'}, status=400)
        # elif ticket.ticket_type.event.ended_date < timezone.now():
        #     return Response({'message': 'Sự kiện đã kết thúc!'}, status=400)
        else:
            ticket.is_checked_in = True
            ticket.save()
            return Response({'message': 'Vé hợp lệ. Cho phép vào!'})
    except Ticket.DoesNotExist:
        return Response({'message': 'Không tìm thấy vé!'}, status=404)


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
admin_site.register(Messages)
admin_site.register(ChatRoom)
