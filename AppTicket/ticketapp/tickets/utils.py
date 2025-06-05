import qrcode
import base64
from io import BytesIO


def generate_qr_base64(qr_data):
    qr_img = qrcode.make(qr_data)
    buffer = BytesIO()
    qr_img.save(buffer, format='PNG')
    img_str = base64.b64encode(buffer.getvalue()).decode('utf-8')
    return img_str


def generate_qr_bytes(qr_data):
    qr_img = qrcode.make(qr_data)
    buffer = BytesIO()
    qr_img.save(buffer, format='PNG')

    return buffer.getvalue()