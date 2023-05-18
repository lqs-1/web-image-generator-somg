from flask import Flask
from flask_script import Manager
from flask_migrate import Migrate, MigrateCommand
from flask_sqlalchemy import SQLAlchemy

# 数据库
db = SQLAlchemy()


def register_db(app: Flask) -> Manager:
    db.init_app(app)
    # 控制台
    manage = Manager(app)

    # 迁移文件命令
    Migrate(app=app, db=db)

    # 生成迁移命令
    manage.add_command('db', MigrateCommand)

    return manage