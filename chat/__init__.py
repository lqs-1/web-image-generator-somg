from flask import Flask
import logging
from logging.handlers import RotatingFileHandler
import time

import config
from chat.bluePrints import register_all_views
from chat.models import register_db
from chat.utils import register_redis, register_converter

# 配置
# 获取日志记录对象
logger = logging.getLogger()

# 控制台日志配置
# 获取控制台日志处理器
console_handler = logging.StreamHandler()
# 设置控制台日志的输出等级
console_handler.setLevel(logging.DEBUG)
# 给控制台日志设置输出格式
console_log_formatter = logging.Formatter(
    fmt="%(asctime)s [%(levelname)s] - file_name:%(filename)s - func_name:%(funcName)s - [%(lineno)s] --- %(message)s",
    datefmt="%Y-%m-%d %H:%M:%S")
# 将这个格式设置到到控制台日志处理器
console_handler.setFormatter(console_log_formatter)
# 将控制台日志处理器添加到日志记录对象
logger.addHandler(console_handler)


# 文件日志配置
# 获取文件日志处理器 输出到的文件位置 最大100MB 保存的日志文件的个数上限为10个
file_log_error_handler = RotatingFileHandler(f"/home/logs/chat/error_{time.strftime('%Y-%m-%d')}.log", maxBytes=1024*1024*100, backupCount=10)
# 设置输出到文件的日志的等级
file_log_error_handler.setLevel(logging.INFO)
# 给文件日志设置输出格式
file_log_formatter = logging.Formatter(
    fmt="%(asctime)s [%(levelname)s] - file_name:%(filename)s - func_name:%(funcName)s - [%(lineno)s] --- %(message)s",
    datefmt="%Y-%m-%d %H:%M:%S")
# 将这个格式设置到文件日志处理器
file_log_error_handler.setFormatter(file_log_formatter)
# 将文件日志处理器添加到日志记录对象
logger.addHandler(file_log_error_handler)

'''
    %(asctime)s：日志记录时间（默认格式：YYYY-MM-DD HH:MM:SS）。
    %(levelname)s：日志级别（如：DEBUG、INFO、WARNING、ERROR、CRITICAL）。
    %(message)s：日志信息。
    %(name)s：记录器的名称。
    %(pathname)s：源文件的完整路径。
    %(filename)s：源文件名。
    %(module)s：模块名。
    %(lineno)d：源文件中日志记录的行号。
    %(funcName)s：函数名。
    %(process)s：进程ID。
    %(thread)s：线程ID。

    datefmt：自定义%(asctime)s输出的日期格式

'''



# 创建app 并注册路由
def create_app(env):
    app = Flask(__name__, )

    # 加载配置
    config_class = config.config_selector.get(env)
    app.config.from_object(config_class)

    # 注册视图
    register_all_views(app)

    # 初始化redis
    register_redis(config_class.REDIS_HOST, config_class.REDIS_PORT, config_class.REDIS_DB)

    # 为flask添加自定义的转换器
    register_converter(app)

    # 初始化数据库
    manage = register_db(app)

    # 全局配置跨域
    # supports_credentials允许跨域带cookie, resources={r"/spider/*": {r"origins": "*"}这个spider路径下的所有资源都可以被所有主机访问
    # CORS(app=app, supports_credentials=True, resources={r"/spider/*": {r"origins": "*"}})

    return manage
