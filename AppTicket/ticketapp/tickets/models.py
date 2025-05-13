from django.contrib.auth.models import AbstractUser
from django.db import models
from cloudinary.models import CloudinaryField
from django.core.exceptions import ValidationError
from django.core.validators import MinValueValidator, MaxValueValidator

class User(AbstractUser):
    gender = models.BooleanField(null=True,default=True)
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

    def __str__(self):
        return self.name


class Venue(BasicModel):
    name = models.CharField(max_length=100)
    capacity = models.IntegerField(default=0)
    img_seat = CloudinaryField("img_seat")
    address = models.CharField(max_length=255)


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
    description = models.CharField(max_length=255,null=True)
    status = models.CharField(max_length=20, choices=Status.choices, default=Status.PUBLISHED)

    category = models.ForeignKey(Category,on_delete=models.RESTRICT,related_name="events")
    user = models.ForeignKey(User,on_delete=models.RESTRICT,related_name="events")
    venue = models.ForeignKey(Venue,on_delete=models.RESTRICT,related_name="events")

    def __str__(self):
        return self.name


class Performance(BasicModel):
    name = models.CharField(max_length=50)
    started_date = models.DateTimeField()
    ended_date = models.DateTimeField()

    event = models.ForeignKey(Event,on_delete=models.CASCADE,related_name="performances")

    def validation_time(self):
        if (self.started_date < self.event.started_date or
                self.started_date > self.event.ended_date):
            raise ValidationError("Thời gian bắt đầu phải trong khoảng thời bắt đầu và kết thúc sự kiện")

        if (self.ended_date < self.event.started_date or
                self.ended_date > self.event.ended_date):
            raise ValidationError("Thời gian kết thúc phải trong khoảng thời bắt đầu và kết thúc sự kiện")

    def __str__(self):
        return self.name


class Ticket_Type(BasicModel):
    name = models.CharField(max_length=50)

    event = models.ForeignKey(Event, on_delete=models.CASCADE,related_name="ticket_types")

    def __str__(self):
        return self.name


class Ticket(BasicModel):
    quantity = models.IntegerField(default=0)
    price = models.DecimalField(max_digits=10, decimal_places=2)

    event = models.ForeignKey(Event,on_delete=models.CASCADE,related_name="tickets")
    ticket_type = models.ForeignKey(Ticket_Type,on_delete=models.RESTRICT,related_name="tickets")

    def __str__(self):
        return f"{self.ticket_type.name} - {self.event.name} - {self.price}"


class Registration(BasicModel):
    code_qr = models.CharField(max_length=255)
    is_checked_in = models.BooleanField(default=False)

    user = models.ForeignKey(User,on_delete=models.PROTECT,related_name="registrations")
    ticket = models.ForeignKey(Ticket, on_delete=models.CASCADE,related_name="registrations")

    def __str__(self):
        pass


class Receipt(BasicModel):
    class PaymentMethod(models.TextChoices):
        MOMO = 'MoMo', 'MoMo'
        VNPAY = 'VNPay', 'VNPay'

    payment_method = models.CharField(max_length=20, choices=PaymentMethod.choices)
    is_paid = models.BooleanField(default=False)

    registration = models.OneToOneField(Registration,on_delete=models.CASCADE,related_name="receipt")

    def __str__(self):
        return f"Reg #{self.id} - {self.user.username} - {self.ticket.event.name}"


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
    count = models.IntegerField( validators=[
            MinValueValidator(1),
            MaxValueValidator(5)
        ])
    class Meta:
        unique_together = ('event', 'user')


class Messages(BasicModel):
    content = models.TextField()
    sent_at = models.DateTimeField(auto_now_add=True)

    event = models.ForeignKey(Event, on_delete=models.CASCADE, related_name="messages")
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name="sent_messages")

    def __str__(self):
        return f"Message from {self.user.username} at {self.sent_at}"



class Notification(BasicModel):
    pass
