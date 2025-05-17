from django.contrib import admin
from django.utils.html import format_html
from django.urls import reverse
from .models import *
import qrcode
import base64
from io import BytesIO
from django.db.models import Avg


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

    actions_link.short_description = 'Action'
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
    list_display = ['id', 'name', 'time_event', 'status', 'category', 'user', 'venue', 'attendee_count', 'active','avg_reviews',
                    'actions_link']
    search_fields = ['name']
    list_display_links = ['name']
    list_filter = ['status']
    list_per_page = 5
    list_select_related = ['category', 'user', 'venue']
    exclude = ['status', 'user']

    def time_event(self, obj):
        return f"{obj.started_date.strftime('%d/%m/%Y %H:%M')} -- {obj.ended_date.strftime('%d/%m/%Y %H:%M')}"

    time_event.short_description = "Event time"

    def save_model(self, request, obj, form, change):
        if not change:
            obj.user = request.user
        obj.save()

    def avg_reviews(self, obj):
        result = obj.review_set.aggregate(avg=Avg('count'))
        return round(result['avg'], 2) if result['avg'] else "Chưa có"

    avg_reviews.short_description = "reviews"

class TicketTypeAdminSite(BaseAdminSite):
    list_display = ['id', 'event', 'name', 'quantity', 'format_price', 'active', 'actions_link']
    list_filter = ['event']
    search_fields = ['name']
    list_display_links = ['name']
    list_per_page = 5

    def format_price(self, obj):
        return f"{obj.price:,.0f} VNĐ".replace(",", ".")

    format_price.short_description = "price"


class TicketAdminSite(BaseAdminSite):
    list_display = ['id', 'event_name', 'ticket_type', 'qr_code','receipt', 'actions_link']
    list_filter = ['ticket_type','receipt__id']
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


class PerformanceAdminSite(BaseAdminSite):
    list_display = ['id','name','time_performance','event','actions_link']
    list_filter = ['event']
    search_fields = ['name']
    list_per_page = 5

    def time_performance(self, obj):
        return f"{obj.started_date.strftime('%d/%m/%Y %H:%M')} -- {obj.ended_date.strftime('%d/%m/%Y %H:%M')}"


    time_performance.short_description = "performance time"


class ReceiptAdminSite(BaseAdminSite):
    list_display = ['id','user','payment_method','is_paid','total_quantity','format_total_price','actions_link']
    list_per_page = 5
    search_fields = ['user']
    list_filter = ['is_paid']

    def format_total_price(self, obj):
        return f"{obj.total_price:,.0f} VNĐ".replace(",", ".")

    format_total_price.short_description = "total price"




admin_site = TicketAppAdminSite(name="myAdminSite")
admin_site.register(User, UserAdminSite)
admin_site.register(Category, CategoryAdminSite)
admin_site.register(Venue, VenueAdminSite)
admin_site.register(Event, EventAdminSite)
admin_site.register(Ticket_Type, TicketTypeAdminSite)
admin_site.register(Ticket, TicketAdminSite)
admin_site.register(Performance,PerformanceAdminSite)
admin_site.register(Receipt,ReceiptAdminSite)
# admin_site.register(Comment)
admin_site.register(Review)
# admin_site.register(Messages)
