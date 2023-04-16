from flask import Flask
import logging
from logging.handlers import RotatingFileHandler
import time
from chat.bluePrints import register_all_views



# 配置日志信息
# 设置日志记录等级
logger = logging.getLogger()
logger.setLevel(logging.DEBUG)
# 配置日志记录器,指明日志保存的路径,每个日志文件的最大大小,保存的日志文件的个数上限
file_log_error_handler = RotatingFileHandler(f"logs/chat/error_{time.strftime('%Y-%m-%d')}.log", maxBytes=1024*1024*100, backupCount=10)
# file_log_all_handler = RotatingFileHandler(f"logs/all_{time.strftime('%Y-%m-%d')}.log", maxBytes=1024*1024*100, backupCount=10)
# 配置写入等级
file_log_error_handler.setLevel(logging.ERROR)
# file_log_all_handler.setLevel(logging.INFO)
# 创建日志记录格式
formatter = logging.Formatter('%(levelname)s %(filename)s:%(lineno)d %(message)s')
# 为刚创建的日志记录器设置日志记录格式
file_log_error_handler.setFormatter(formatter)
# file_log_all_handler.setFormatter(formatter)
logger.addHandler(file_log_error_handler)
# logger.addHandler(file_log_all_handler)




# 创建app 并注册路由
def create_app():
    app = Flask(__name__)
    register_all_views(app)
    return app