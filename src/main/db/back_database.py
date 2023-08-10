import getpass
import platform
import smtplib
from email.mime.base import MIMEBase
from email.mime.multipart import MIMEMultipart
import os
import logging
from email.mime.text import MIMEText

import pymysql
from apscheduler.schedulers.blocking import BlockingScheduler
import shutil
from apscheduler.triggers.interval import IntervalTrigger

# 设置日志
logging.basicConfig(format='%(asctime)s - %(pathname)s[line:%(lineno)d] - %(levelname)s:%(message)s',
                    level=logging.INFO)

# 字典值配置 读取字典
MYSQL_DICT_HOST = '172.245.10.200'
MYSQL_DICT_PORT = 3306
MYSQL_DICT_USERNAME = 'somg'
MYSQL_DICT_PASSWORD = 'somg'
MYSQL_DICT_DB = 'storage'


class DatabaseBR:
    # 通用配置 要备份的配置 先从配置的字典数据库中获取 没有在按这里的默认配置
    # 数据库主机地址
    MYSQL_HOST = None

    # MySQL数据库用户名
    MYSQL_USERNAME = None

    # 数据库密码
    MYQSL_PASSWORD = None

    # 数据库端口
    MYSQL_PORT = None

    # 排除，不进行备份操作的数据库名称集合
    IGNORE_DATABASES = set()

    # 备份文件存放路径
    BACKUP_PATH = None

    # 需要备份的数据库
    DATABASES = list()

    # 设置发件人和收件人邮箱以及邮件内容
    # 发送备份文件邮箱地址
    SENDER_EMAIL = None
    # 发送备份文件邮箱授权码
    SENDER_PASSWORD = None
    # SENDER_PASSWORD = 'idyvzneokcpjbgah'
    # 接收备份文件邮箱
    RECEIVER_EMAIL = None
    # 发送备份文件邮箱服务商
    SMTP_SERVER = None
    # 发送备份文件邮箱端口
    SMTP_PORT = None

    # 实例化父类 创建定时任务调度器
    blocking = BlockingScheduler()

    def send_email(self):
        """发送邮件的方法"""

        subject = '备份文件'

        # 创建一个带附件的邮件对象
        msg = MIMEMultipart()
        msg['From'] = self.SENDER_EMAIL
        msg['To'] = self.RECEIVER_EMAIL
        msg['Subject'] = subject

        # 添加邮件正文
        msg_text = '备份数据库 ==>  '

        # 添加附件
        for sql_file in os.listdir(self.BACKUP_PATH):
            with open(os.path.join(self.BACKUP_PATH, sql_file), 'rb') as attachment:
                part = MIMEBase('application', 'octet-stream')
                part.set_payload(attachment.read().decode('utf-8'))
                part.add_header('Content-Disposition', f'attachment; filename={sql_file}')

                msg.attach(part)
                msg_text = msg_text + " [" + sql_file.split('.')[0] + "] "

        msg.attach(MIMEText(msg_text, 'plain', 'utf-8'))

        # 连接到SMTP服务器并发送邮件
        with smtplib.SMTP_SSL(self.SMTP_SERVER, self.SMTP_PORT) as server:
            server.login(self.SENDER_EMAIL, self.SENDER_PASSWORD)
            server.sendmail(self.SENDER_EMAIL, self.RECEIVER_EMAIL, msg.as_string().encode('utf8'))
            server.quit()
        logging.info(f'邮件发送成功')

    def backing(self):
        """备份数据库"""
        """
        读取全部数据库名称，并对这些数据库的数据和结构进行备份
        """

        # 根据系统生成默认sql保存目录
        if platform.system().lower() == "windows":
            self.BACKUP_PATH = os.path.join(f"C:\\Users\\{getpass.getuser()}", "db_file\\")
        else:
            # 如果是mac或者linux就在这里创建默认得保存文件夹  /home/用户/db_file
            self.BACKUP_PATH = os.path.join(f"/home/{getpass.getuser()}", "db_file/")

        logging.info(f'当前系统为 {platform.system().lower()}')
        logging.info(f'当前系统登录用户为 {getpass.getuser()}')

        databases = list()

        # 配置了字典数据库就必须走字典配置 只有忽略/备份/存储位置不是必须配置到字典 其它值必须走字典
        if all([MYSQL_DICT_PORT, MYSQL_DICT_DB, MYSQL_DICT_PASSWORD, MYSQL_DICT_USERNAME, MYSQL_DICT_HOST]):
            logging.info(f'读取字典配置开始')
            # 填充数据库配置
            self.fill_db_field()
            # 填充邮箱配置
            self.fill_mail_field()
            logging.info(f'读取字典配置结束')
            # 读取全部待备份数据库名称
            if (len(self.DATABASES) > 0):
                databases = self.DATABASES
            elif (len(self.IGNORE_DATABASES) > 0):
                databases = self.read_all_databases()
            else:
                databases = self.read_all_databases()

        # 没有配置字典就全部走硬编码 不然代码报错
        else:

            # 读取全部待备份数据库名称
            logging.info(f"备份文件路径使用默认生成路径 : {self.BACKUP_PATH}")
            databases = self.read_all_databases()

        # 检查备份路径是否存在，不存在则进行创建
        self.mkdir_if_not_exists(self.BACKUP_PATH)

        # 逐个对数据库进行备份
        for database in databases:
            self.backup_database(database)

        # 发送邮件
        self.send_email()

        # 删除旧备份
        self.del_old_backup(self.BACKUP_PATH)

    def mkdir_if_not_exists(self, path):
        """
        判断备份目录是否存在，不存在则创建
        Args:
            path:带创建目录名称
        """
        if not os.path.exists(path):
            os.makedirs(path)
        logging.info(f"创建备份目录{path}")

    def read_all_databases(self):
        """
        从数据库中读取全部数据库名称
        :return:
        数据库名称list
        """
        logging.info('读取全部数据库名称')
        conn = self.create_mysql_conn()
        cursor = conn.cursor()
        # 查询服务器上有哪些数据库
        cursor.execute('show databases')
        res = cursor.fetchall()
        databases = {item[0] for item in res}
        # 排除掉指定不备份的数据库
        databases = list(databases - self.IGNORE_DATABASES)
        cursor.close()
        conn.close()
        logging.info(f'读取数据库完毕，数据库列表如下：{databases}')
        return databases

    def backup_database(self, database):
        """
        备份指定数据库的数据和结构
        Args:
            database: 待备份的数据库名称
        """
        logging.info(f'开始备份数据库{database}...')
        # 通过调用mysqldump完成指定数据库的备份
        command = f'mysqldump -h {self.MYSQL_HOST} -P {self.MYSQL_PORT} -u {self.MYSQL_USERNAME} -p{self.MYQSL_PASSWORD}  {database} > {self.BACKUP_PATH}{database}.sql'
        os.system(command)
        # 判断命令是否正常执行，异常则直接抛出
        logging.info(f'数据库 {database} 备份完毕！')
        logging.info(f'数据库备份位置 {self.BACKUP_PATH}{database}.sql')

    def del_old_backup(self, path):
        """
        删除备份好的文件
        """
        shutil.rmtree(path)
        logging.info(f'删除{path}下所有备份文件成功')

    def create_mysql_conn(self):
        """
        创建并返回一个MySQL数据库连接
        Args:
            db:要连接的数据库名称
        """
        conn = pymysql.connect(host=self.MYSQL_HOST, port=self.MYSQL_PORT, user=self.MYSQL_USERNAME,
                               password=self.MYQSL_PASSWORD,
                               db='mysql')
        return conn

    def create_dict_mysql_conn(self):
        """
        创建并返回一个MySQL数据库连接
        Args:
            db:要连接的数据库名称
        """
        conn = pymysql.connect(host=MYSQL_DICT_HOST, port=MYSQL_DICT_PORT, user=MYSQL_DICT_USERNAME,
                               password=MYSQL_DICT_PASSWORD,
                               db=MYSQL_DICT_DB)
        return conn

    def fill_mail_field(self):
        """
       根据字典编号查出对应的值 并且赋值
       :return:
       """
        try:
            conn_dict = self.create_dict_mysql_conn()
            cursor = conn_dict.cursor()
            # 查询各字段的值
            cursor.execute("select dictValue from sys_dict where dictCode = 'MYSQL_BACK_UP_DB_SEND_EMAIL'")
            res = cursor.fetchall()
            self.SENDER_EMAIL = list({item[0] for item in res})[0]
            logging.info(f'发送邮件邮箱 {self.SENDER_EMAIL}')

            cursor.execute("select dictValue from sys_dict where dictCode = 'MYSQL_BACK_UP_DB_RECEIVE_EMAIL'")
            res = cursor.fetchall()
            self.RECEIVER_EMAIL = list({item[0] for item in res})[0]
            logging.info(f'接收邮件邮箱 {self.RECEIVER_EMAIL}')

            cursor.execute("select dictValue from sys_dict where dictCode = 'MYSQL_BACK_UP_DB_SEND_EMAIL_AUTHORIZED'")
            res = cursor.fetchall()
            self.SENDER_PASSWORD = list({item[0] for item in res})[0]
            logging.info(f'发送邮件邮箱的授权码 {self.SENDER_PASSWORD}')

            cursor.execute("select dictValue from sys_dict where dictCode = 'MYSQL_BACK_UP_DB_SEND_EMAIL_PORT'")
            res = cursor.fetchall()
            self.SMTP_PORT = int(list({item[0] for item in res})[0])
            logging.info(f'发送邮件邮箱的端口 {self.SMTP_PORT}')

            cursor.execute("select dictValue from sys_dict where dictCode = 'MYSQL_BACK_UP_DB_SEND_EMAIL_SERVER'")
            res = cursor.fetchall()
            self.SMTP_SERVER = list({item[0] for item in res})[0]
            logging.info(f'发送邮件邮箱的服务商 {self.SMTP_SERVER}')

            cursor.close()
            conn_dict.close()

        except Exception as e:
            logging.error(f'读取字典配置不全或者网络错误')


    def fill_db_field(self):
        """
        根据字典编号查出对应的值 并且赋值
        :return:
        """
        try:
            conn_dict = self.create_dict_mysql_conn()
            cursor = conn_dict.cursor()

            # 查询各字段的值
            cursor.execute("select dictValue from sys_dict where dictCode = 'MYSQL_BACK_UP_DB_IGNORE_NAMES'")
            res = cursor.fetchall()
            IGNORE_DATABASES_STRING = list({item[0] for item in res})[0]
            self.IGNORE_DATABASES = set(IGNORE_DATABASES_STRING.split(':')) if len(
                IGNORE_DATABASES_STRING) > 0 else self.IGNORE_DATABASES
            # information_schema: mysql:performance_schema: sys
            logging.info(f'读取忽略数据库 {self.IGNORE_DATABASES}')

            cursor.execute("select dictValue from sys_dict where dictCode = 'MYSQL_BACK_UP_DB_NAMES'")
            res = cursor.fetchall()
            DATABASES_STRING = list({item[0] for item in res})[0]
            self.DATABASES = DATABASES_STRING.split(':') if len(DATABASES_STRING) > 0 else self.DATABASES
            logging.info(f'读取备份数据库 {self.DATABASES}')

            cursor.execute("select dictValue from sys_dict where dictCode = 'MYSQL_BACK_UP_DB_PASSWORD'")
            res = cursor.fetchall()
            self.MYQSL_PASSWORD = list({item[0] for item in res})[0]
            logging.info(f'读取数据库密码 {self.MYQSL_PASSWORD}')

            cursor.execute("select dictValue from sys_dict where dictCode = 'MYSQL_BACK_UP_DB_USERNAME'")
            res = cursor.fetchall()
            self.MYSQL_USERNAME = list({item[0] for item in res})[0]
            logging.info(f'读取数据库用户名 {self.MYSQL_USERNAME}')

            cursor.execute("select dictValue from sys_dict where dictCode = 'MYSQL_BACK_UP_DB_HOST'")
            res = cursor.fetchall()
            self.MYSQL_HOST = list({item[0] for item in res})[0]
            logging.info(f'读取数据库地址 {self.MYSQL_HOST}')

            cursor.execute("select dictValue from sys_dict where dictCode = 'MYSQL_BACK_UP_DB_PORT'")
            res = cursor.fetchall()
            self.MYSQL_PORT = int(list({item[0] for item in res})[0])
            logging.info(f'读取数据库端口 {self.MYSQL_PORT}')

            cursor.execute("select dictValue from sys_dict where dictCode = 'MYSQL_BACK_UP_DB_PATH'")
            res = cursor.fetchall()
            self.BACKUP_PATH = list({item[0] for item in res})[0] if len(
                list({item[0] for item in res})[0]) > 0 else self.BACKUP_PATH
            logging.info(f'读取备份文件存储目录 {self.BACKUP_PATH}')

            cursor.close()
            conn_dict.close()

        except Exception as e:
            logging.error(f'读取字典配置不全或者网络错误')

    def con_task(self):
        """执行定时任务的方法"""
        trigger_min = IntervalTrigger(seconds=6)
        self.blocking.add_job(self.backing, trigger=trigger_min, id="backing-task")
        self.blocking.start()
        # self.blocking.pause_job(job_id="backing-task")  # 暂停任务
        # self.blocking.resume_job(job_id="backing-task")  # 恢复任务


if __name__ == '__main__':
    dbBack = DatabaseBR()
    dbBack.con_task()
