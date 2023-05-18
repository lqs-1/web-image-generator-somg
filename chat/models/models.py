from datetime import datetime

from . import db



# 用户
class User(db.Model):
    """用户"""

    __tablename__ = "user"

    id = db.Column(db.Integer, primary_key=True)  # 用户编号
    username = db.Column(db.String(255), unique=True, nullable=False)  # 用户名
    password = db.Column(db.String(255), nullable=False)  # 加密的密码
    sex = db.Column(db.String(255), unique=False, nullable=False)  # 性别
    createTime = db.Column(db.DateTime, default=datetime.now)  # 创建时间
    loginTime = db.Column(db.DateTime, default=datetime.now, onupdate=datetime.now)  # 登录时间
    email = db.Column(db.String(255))  # 邮箱


# 系统日志
class SysLog(db.Model):
    """系统日志"""

    __tablename__ = "sys_log"

    id = db.Column(db.Integer, primary_key=True)  # 日志编号
    userId = db.Column(db.Integer, unique=False, nullable=False)  # 用户id
    userName = db.Column(db.String(255), nullable=False)  # 用户名
    time = db.Column(db.DateTime, default=datetime.now)  # 操作时间
    serverName = db.Column(db.String(255), nullable=False)  # 服务名称
    action = db.Column(db.String(255), nullable=False)  # 操作行为

    def __str__(self):
        return f"userId: {self.userId}, userName: {self.userName}, time: {self.time}, serverName: {self.serverName}, action: {self.action}"


# 系统字典
class SysDict(db.Model):
    """系统字典"""

    __tablename__ = "sys_dict"

    id = db.Column(db.Integer, primary_key=True)  # 字典id
    dictCode = db.Column(db.String(255), nullable=False)  # 字典编码
    parentId = db.Column(db.Integer)  # 父字典id
    dictDesc = db.Column(db.String(255), nullable=False)  # 字典描述
    dictValue = db.Column(db.String(255), nullable=False)  # 字典值