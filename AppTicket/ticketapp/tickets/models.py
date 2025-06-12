from django.contrib.auth.models import AbstractUser
from django.db import models
from cloudinary.models import CloudinaryField
from django.core.exceptions import ValidationError
from django.core.validators import MinValueValidator, MaxValueValidator
from django.utils import timezone
from datetime import timedelta


class User(AbstractUser):
    gender = models.BooleanField(null=True, default=True)
    birthday = models.DateField(null=True)
    avatar = CloudinaryField("avatar", null=True)
    phone = models.CharField(max_length=15, null=True)
    address = models.CharField(max_length=255, null=True)


class BasicModel(models.Model):
    created_date = models.DateTimeField(auto_now_add=True)
    updated_date = models.DateTimeField(auto_now=True)
    active = models.BooleanField(default=True)

    class Meta:
        abstract = True
        ordering = ["-id"]


class Category(BasicModel):
    name = models.CharField(max_length=50)
    img_name = CloudinaryField("img_name", null=True, blank=True)
    def __str__(self):
        return self.name


class Venue(BasicModel):
    name = models.CharField(max_length=100)
    capacity = models.IntegerField(default=0)
    img_seat = CloudinaryField("img_seat")
    address = models.CharField(max_length=255)
    latitude = models.FloatField(blank=True, null=True)
    longitude = models.FloatField(blank=True, null=True)

    def __str__(self):
        return f"{self.name} - {self.capacity}"


class Event(BasicModel):
    class Status(models.TextChoices):
        PUBLISHED = 'published', 'Published'
        ONGOING = 'ongoing', 'Ongoing'
        ENDED = 'ended', 'Ended'
        CANCELLED = 'cancelled', 'Cancelled'

    name = models.CharField(max_length=100)
    image = CloudinaryField("img_event")
    attendee_count = models.IntegerField(default=0)
    started_date = models.DateTimeField()
    ended_date = models.DateTimeField()
    description = models.CharField(max_length=255, null=True)
    status = models.CharField(max_length=20, choices=Status.choices, default=Status.PUBLISHED)
    view_count = models.IntegerField(default=0)

    category = models.ForeignKey(Category, on_delete=models.RESTRICT, related_name="events")
    user = models.ForeignKey(User, on_delete=models.RESTRICT, related_name="events")
    venue = models.ForeignKey(Venue, on_delete=models.RESTRICT, related_name="events")

    def validate_event(self):
        if self.started_date and self.started_date < (timezone.now() + timedelta(days=2)):
            raise ValidationError("Thời gian bắt đầu phải lớn hơn hiện tại 2 ngày")
        if self.ended_date and self.ended_date <= self.started_date:
            raise ValidationError("Thời gian kết thúc phải lớn hơn thời gian hiện tại")

        event_exist = Event.objects.filter(started_date__lt=self.ended_date,
                                           ended_date__gt=self.started_date,
                                           venue=self.venue)
        # bỏ qua chính nó khi update
        if self.pk:
            event_exist = event_exist.exclude(pk=self.pk)

        if event_exist.exists():
            event = event_exist.first()
            raise ValidationError(
                f"Đã có sự kiện '{event.name}' diễn ra tại '{event.venue.name}' "
                f"từ {event.started_date.strftime('%d/%m/%Y %H:%M')} đến {event.ended_date.strftime('%d/%m/%Y %H:%M')}"
            )
        if self.attendee_count > self.venue.capacity:
            raise ValidationError("Số người tham gia phải nhỏ hơn sức chứa của địa điểm")

    def clean(self):
        super().clean()
        self.validate_event()

    def __str__(self):
        return f"Su kien : {self.name} - Thoi gian : {self.started_date} -- {self.ended_date}"


class Performance(BasicModel):
    name = models.CharField(max_length=50)
    started_date = models.DateTimeField()
    ended_date = models.DateTimeField()

    event = models.ForeignKey(Event, on_delete=models.CASCADE, related_name="performances")

    def validation_time(self):
        if (self.started_date < self.event.started_date or
                self.started_date > self.event.ended_date):
            raise ValidationError("Thời gian bắt đầu phải trong khoảng thời bắt đầu và kết thúc sự kiện")

        if (self.ended_date < self.event.started_date or
                self.ended_date > self.event.ended_date):
            raise ValidationError("Thời gian kết thúc phải trong khoảng thời bắt đầu và kết thúc sự kiện")

        performance_exists = Performance.objects.filter(started_date__lt=self.ended_date,
                                           ended_date__gt=self.started_date,
                                           event=self.event)
        # bỏ qua chính nó khi update
        if self.pk:
            performance_exists = performance_exists.exclude(pk=self.pk)

        if performance_exists.exists():
            performance = performance_exists.first()
            raise ValidationError(
                f"Đã có chương trình '{performance.name}' diễn ra tại '{performance.event.name}' "
                f"từ {performance.started_date.strftime('%d/%m/%Y %H:%M')} đến {performance.ended_date.strftime('%d/%m/%Y %H:%M')}"
            )

    def clean(self):
        super().clean()
        self.validation_time()

    def __str__(self):
        return self.name


class Ticket_Type(BasicModel):
    name = models.CharField(max_length=50)

    quantity = models.IntegerField(default=0)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    event = models.ForeignKey(Event, on_delete=models.CASCADE, related_name="ticket_types")

    def validate_ticket_type(self):
        existing_quantity_event = Ticket_Type.objects.filter(event=self.event).exclude(pk=self.pk).aggregate(
            total=models.Sum('quantity')
        )['total'] or 0
        total_quantity = existing_quantity_event + self.quantity
        if total_quantity > self.event.attendee_count:
            raise ValidationError(
                f"Tổng số lượng vé ({total_quantity}) vượt quá số người tham gia cho phép ({self.event.attendee_count})"
            )

    def clean(self):
        super().clean()
        self.validate_ticket_type()

    def __str__(self):
        return f"{self.name} - {format(self.price, ',.0f').replace(',', '.')} VNĐ"


class Receipt(BasicModel):
    class PaymentMethod(models.TextChoices):
        MOMO = 'MoMo', 'MoMo'
        VNPAY = 'VNPay', 'VNPay'

    payment_method = models.CharField(max_length=20, choices=PaymentMethod.choices)
    is_paid = models.BooleanField(default=False)
    total_price = models.DecimalField(max_digits=10, decimal_places=2)
    total_quantity = models.IntegerField(default=0)

    user = models.ForeignKey(User, on_delete=models.PROTECT, related_name="receipts")

    def __str__(self):
        return f"Receipt #{self.pk} - {self.user.username}"


class Ticket(BasicModel):
    code_qr = models.CharField(max_length=255, unique=True)
    is_checked_in = models.BooleanField(default=False)
    quantity = models.IntegerField(default=0)

    ticket_type = models.ForeignKey(Ticket_Type, on_delete=models.RESTRICT, related_name="tickets")
    receipt = models.ForeignKey(Receipt, on_delete=models.RESTRICT, related_name="tickets")

    def generate_qr_code(self):
        return (
            f"ID: RC:{self.receipt.id}||TT:{self.ticket_type.id}\n"
            f"USER: {self.receipt.user.username}\n"
            f"EVENT: {self.ticket_type.event.name}\n"
            f"TIME: {self.ticket_type.event.started_date} - {self.ticket_type.event.ended_date}\n"
            f"ADDRESS: {self.ticket_type.event.venue.name} - {self.ticket_type.event.venue.address}\n"
            f"EVENT TYPE - PRICE: {self.ticket_type.name} - {format(self.quantity * self.ticket_type.price, ',.0f').replace(',', '.')} VNĐ"
        )

    def save(self, *args, **kwargs):
        if not self.code_qr:
            self.code_qr = self.generate_qr_code()
        super().save(*args, **kwargs)

    def __str__(self):
        return self.ticket_type.name


class Interaction(BasicModel):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    event = models.ForeignKey(Event, on_delete=models.CASCADE)

    class Meta:
        abstract = True


class Comment(Interaction):
    content = models.CharField(max_length=255)
    parent = models.ForeignKey("self", null=True, blank=True, on_delete=models.CASCADE, related_name="replies")

    def __str__(self):
        return self.content


class Review(Interaction):
    count = models.IntegerField(validators=[
        MinValueValidator(1),
        MaxValueValidator(5)
    ])

    class Meta:
        unique_together = ('event', 'user')


class ChatRoom(BasicModel):
    name = models.CharField(max_length=255, unique=True)
    customer = models.ForeignKey(User, on_delete=models.CASCADE, related_name='customer_rooms')
    staff = models.ForeignKey(User, on_delete=models.CASCADE, related_name='staff_rooms')
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Room {self.name} (Customer: {self.customer.username}, Staff: {self.staff.username})"


class Messages(BasicModel):
    content = models.TextField()
    sent_at = models.DateTimeField(auto_now_add=True)

    room = models.ForeignKey(ChatRoom, on_delete=models.CASCADE, related_name="messages",null=True)
    sender = models.ForeignKey(User, on_delete=models.CASCADE, related_name="sent_messages")

    def __str__(self):
        return f"Message from {self.sender.username} at {self.sent_at}"


class Notification(BasicModel):
    title = models.CharField(max_length=100)
    content = models.CharField(max_length=255, default="Thông báo")
    is_read = models.BooleanField(default=False)

    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name="notifications")
    event = models.ForeignKey(Event, null=True, blank=True, on_delete=models.SET_NULL, related_name="notifications")

    def __str__(self):
        return f"Notify: {self.title} -> {self.user.username}"
