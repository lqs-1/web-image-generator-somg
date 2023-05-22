# coding:utf-8


# 配置
class Config(object):
    '''基本配置'''
    SECRET_KEY = '1232MJJOIfewf'

    # mysql    root:123456@127.0.0.1:3306
    SQLALCHEMY_DATABASE_URI = "mysql+pymysql://root:123456@localhost:3306/storage"
    SQLALCHEMY_TRACK_MODIFICATIONS = True

    # redis
    REDIS_HOST = "11.1.101.142"
    REDIS_PORT = 6379
    REDIS_DB = 1



    # flask-session配置
    # SESSION_TYPE = "redis"
    # SESSION_REDIS = redis.StrictRedis(host=REDIS_HOST, port=REDIS_PORT)
    # SESSION_USE_SIGNER = True  # 对cookie中的session_id进行隐藏
    # PERMANENT_SESSION_LIFETIME = 60 * 60 * 24  # session数据的有效期


class DevelopmentConfig(Config):
    '''开发模式配置信息'''
    DEBUG = True



class ProductConfig(Config):
    '''生产环境配置信息'''
    pass


config_selector = {
    "develop": DevelopmentConfig,
    "product": ProductConfig
}