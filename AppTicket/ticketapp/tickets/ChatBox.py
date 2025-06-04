from channels.db import database_sync_to_async
from channels.generic.websocket import AsyncWebsocketConsumer


class ChatConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        from .models import ChatRoom, Messages, User
        self.room_name = self.scope['url_route']['kwargs']['room_name']
        self.room_group_name = f'chat_{self.room_name}'

        await self.create_room_if_not_exists(self.room_name)

        await self.channel_layer.group_add(self.room_group_name, self.channel_name)
        await self.accept()

    async def disconnect(self, code):
        await self.channel_layer.group_discard(self.room_group_name, self.channel_name)

    async def receive(self, text_data=None, bytes_data=None):
        import json
        from .models import Messages, User
        data = json.loads(text_data)
        message = data['message']
        sender = data['sender']

        msg = await self.save_message(
            room_name=self.room_name,
            sender_username=sender,
            message=message
        )

        # await self.channel_layer.group_send(self.room_group_name, {
        #     "type": "chat_messages",
        #     "message": message,
        #     "sender": sender
        # })
        await self.channel_layer.group_send(self.room_group_name, {
            "type": "chat_messages",
            "id": msg.id,
            "message": msg.content,
            "sender": msg.sender.username,
            "time": msg.sent_at.isoformat()
        })

    async def chat_messages(self, event):
        import json
        await self.send(text_data=json.dumps({
            "id": event['id'],
            "message": event['message'],
            "sender": event['sender'],
            "time": event['time']
        }))

    @database_sync_to_async
    def create_room_if_not_exists(self, room_name):

        from .models import ChatRoom, User
        parts = room_name.split('_')
        if len(parts) == 2 and parts[0] == "room":
            try:
                id1 = int(parts[1])
                id2 = 2  # id nhân viên cố định
                customer = User.objects.get(id=id1)
                staff = User.objects.get(id=id2)

                room, created = ChatRoom.objects.get_or_create(
                    name=room_name,
                    defaults={
                        'customer': customer,
                        'staff': staff,
                    }
                )
                # print(f"[Chat] Room created or found: {room.name}")
                return room
            except Exception as e:
                # print(f"[Chat] Error in create_room_if_not_exists: {e}")
                return None
        return None

    @database_sync_to_async
    def save_message(self, room_name, sender_username, message):
        from .models import ChatRoom, Messages, User
        sender = User.objects.get(username=sender_username)
        room = ChatRoom.objects.filter(name=room_name).first()
        return Messages.objects.create(room=room, sender=sender, content=message)
