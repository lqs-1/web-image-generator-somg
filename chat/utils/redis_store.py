import redis

redis_store: redis = None
def constrict_redis(host: str, port: int, db: int):
    global redis_store
    redis_store = redis.StrictRedis(host=host, port=port, db=db)