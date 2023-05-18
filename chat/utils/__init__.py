from flask import Flask
from chat.utils.common_converter import ReConverter
from chat.utils.redis_store import constrict_redis


def register_converter(app: Flask):
    app.url_map.converters["re"] = ReConverter


def register_redis(host: str, port: int, db: int):
    constrict_redis(host, port, db)