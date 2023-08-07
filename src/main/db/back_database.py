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
    MYSQL_HOST = '192.168.153.128'

    # MySQL数据库用户名
    MYSQL_USERNAME = 'root'

    # 数据库密码
    MYQSL_PASSWORD = '123456'

    # 数据库端口
    MYSQL_PORT = 3306

    # 排除，不进行备份操作的数据库名称集合
    IGNORE_DATABASES = set()

    # 备份文件存放路径
    BACKUP_PATH = ''

    # 需要备份的数据库
    DATABASES = list()

    def send_email(self):
        """发送邮件的方法"""
        # 设置发件人和收件人邮箱以及邮件内容
        sender_email = '749062870@qq.com'
        sender_password = 'idyvzneokcpjbgah'
        receiver_email = 'liqisong2002@gmail.com'
        subject = '备份文件'

        # 创建一个带附件的邮件对象
        msg = MIMEMultipart()
        msg['From'] = sender_email
        msg['To'] = receiver_email
        msg['Subject'] = subject
        smtp_server = 'smtp.qq.com'
        smtp_port = 465

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
        with smtplib.SMTP_SSL(smtp_server, smtp_port) as server:
            server.login(sender_email, sender_password)
            server.sendmail(sender_email, receiver_email, msg.as_string().encode('utf8'))
            server.quit()
        logging.info(f'邮件发送成功')

    def backing(self):
        """备份数据库"""
        """
        读取全部数据库名称，并对这些数据库的数据和结构进行备份
        """

        # 根据系统生成默认sql保存目录
        if platform.system().lower() == "windows" :
            self.BACKUP_PATH = "C:/.db/db_file/"
        else:
            # 如果是mac或者linux就在这里创建默认得保存文件夹  /home/用户/db_file
            self.BACKUP_PATH = os.path.join(f"/home/{getpass.getuser()}", "db_file/")

        databases = list()

        if all([MYSQL_DICT_PORT, MYSQL_DICT_DB, MYSQL_DICT_PASSWORD, MYSQL_DICT_USERNAME, MYSQL_DICT_HOST]):
            # 填充数据库配置
            self.fill_db_field()
            # 读取全部待备份数据库名称
            if (len(self.DATABASES) > 0):
                databases = self.DATABASES
            elif (len(self.IGNORE_DATABASES) > 0):
                databases = self.read_all_databases()
        else:
            # 读取全部待备份数据库名称
            databases = self.read_all_databases()

        # 检查备份路径是否存在，不存在则进行创建
        self.mkdir_if_not_exists(self.BACKUP_PATH)

        # 逐个对数据库进行备份eee
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
        conn = pymysql.connect(host=self.MYSQL_HOST, port=self.MYSQL_PORT, user=self.MYSQL_USERNAME, password=self.MYQSL_PASSWORD,
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

    def fill_db_field(self):
        """
        根据字典编号查出对应的值 并且赋值
        :return:
        """
        logging.info(f'读取字典配置开始')

        conn_dict = self.create_dict_mysql_conn()
        cursor = conn_dict.cursor()

        # 查询各字段的值
        cursor.execute("select dictValue from sys_dict where dictCode = 'MYSQL_BACK_UP_DB_IGNORE_NAMES'")
        res = cursor.fetchall()
        IGNORE_DATABASES_STRING = list({item[0] for item in res})[0]
        self.IGNORE_DATABASES = set(IGNORE_DATABASES_STRING.split(':'))



        cursor.execute("select dictValue from sys_dict where dictCode = 'MYSQL_BACK_UP_DB_NAMES'")
        res = cursor.fetchall()
        DATABASES_STRING = list({item[0] for item in res})[0]
        self.DATABASES = DATABASES_STRING.split(':')


        cursor.execute("select dictValue from sys_dict where dictCode = 'MYSQL_BACK_UP_DB_PASSWORD'")
        res = cursor.fetchall()
        self.MYQSL_PASSWORD = list({item[0] for item in res})[0]

        cursor.execute("select dictValue from sys_dict where dictCode = 'MYSQL_BACK_UP_DB_USERNAME'")
        res = cursor.fetchall()
        self.MYSQL_USERNAME = list({item[0] for item in res})[0]

        cursor.execute("select dictValue from sys_dict where dictCode = 'MYSQL_BACK_UP_DB_HOST'")
        res = cursor.fetchall()
        self.MYSQL_HOST = list({item[0] for item in res})[0]

        cursor.execute("select dictValue from sys_dict where dictCode = 'MYSQL_BACK_UP_DB_PORT'")
        res = cursor.fetchall()
        self.MYSQL_PORT = list({item[0] for item in res})[0]


        cursor.execute("select dictValue from sys_dict where dictCode = 'MYSQL_BACK_UP_DB_PATH'")
        res = cursor.fetchall()
        self.BACKUP_PATH = list({item[0] for item in res})[0]

        logging.info(f'读取字典配置结束')

    def con_task(self):
        """执行定时任务的方法"""
        blocking = BlockingScheduler()  # 实例化父类
        trigger_min = IntervalTrigger(hours=1)
        blocking.add_job(self.backing, trigger=trigger_min)
        blocking.start()


if __name__ == '__main__':

    dbBack = DatabaseBR()
    dbBack.con_task()
