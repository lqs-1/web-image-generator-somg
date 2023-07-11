import smtplib
from email.mime.base import MIMEBase
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
import os
import logging
import pymysql
from apscheduler.schedulers.blocking import BlockingScheduler
import shutil
from apscheduler.triggers.interval import IntervalTrigger

# Set log format
logging.basicConfig(format='%(asctime)s - %(pathname)s[line:%(lineno)d] - %(levelname)s:%(message)s',
                    level=logging.INFO)

# MySQL database details to which backup to be done. Make sure below user having enough privileges to take databases backup.
# 数据库主机地址
MYSQL_HOST = '47.108.229.150'
# MySQL数据库用户名
MYSQL_USERNAME = 'somg'
# 数据库端口
MYSQL_PORT = 3306
# 数据库密码
MYQSL_PASSWORD = 'somg'
# 需要备份的数据库名称
# DB_NAME = 'main'
# 排除，不进行备份操作的数据库名称集合
DISABLED_DATABASES = {'information_schema', 'mysql', 'performance_schema', 'sys'}
# 备份文件存放路径
BACKUP_PATH = '/home/'




class DatabaseBR:

    def send_email(self, back_path, database):
        """发送邮件的方法"""
        # 设置发件人和收件人邮箱以及邮件内容
        sender_email = '749062870@qq.com'
        sender_password = 'idyvzneokcpjbgah'
        receiver_email = '749062870@qq.com'
        subject = '备份文件'

        # 创建一个带附件的邮件对象
        msg = MIMEMultipart()
        msg['From'] = sender_email
        msg['To'] = receiver_email
        msg['Subject'] = subject
        smtp_server = 'smtp.qq.com'
        smtp_port = 465

        # 添加邮件正文
        msg.attach(MIMEText(f'备份数据库{database}', 'plain', 'utf-8'))

        # 添加附件
          # 替换为实际文件路径
        with open(back_path, 'rb') as attachment:
            part = MIMEBase('application', 'octet-stream')
            part.set_payload(attachment.read().decode('utf-8'))
            part.add_header('Content-Disposition', f'attachment; filename={database}')

            msg.attach(part)

        # 连接到SMTP服务器并发送邮件
        with smtplib.SMTP_SSL(smtp_server, smtp_port) as server:
            server.login(sender_email, sender_password)
            server.sendmail(sender_email, receiver_email, msg.as_string().encode('utf8'))
            server.quit()
        logging.info(f'邮件发送成功{database}')

    def backing(self):
        """备份数据库"""
        """
        读取全部数据库名称，并对这些数据库的数据和结构进行备份
        """
        # 检查备份路径是否存在，不存在则进行创建
        self.mkdir_if_not_exists(BACKUP_PATH)
        # 读取全部待备份数据库名称
        databases = self.read_all_databases()
        # 逐个对数据库进行备份
        for database in databases:
            self.backup_database(database)
            # 阻塞10秒

        # 删除旧备份
        self.del_old_backup(BACKUP_PATH)

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
        databases = list(databases - DISABLED_DATABASES)
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
        command = f'mysqldump -u {MYSQL_USERNAME}  {database} > {BACKUP_PATH}{database}.sql'
        os.system(command)
        # 判断命令是否正常执行，异常则直接抛出
        logging.info(f'数据库 {database} 备份完毕！')
        logging.info(f'数据库备份位置 {BACKUP_PATH}{database}.sql')
        self.send_email(f'{BACKUP_PATH}{database}.sql', f'{database}.sql')

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
        conn = pymysql.connect(host=MYSQL_HOST, port=MYSQL_PORT, user=MYSQL_USERNAME, password=MYQSL_PASSWORD,
                               db='mysql')
        return conn



    def con_task(self):
        """执行定时任务的方法"""
        blocking = BlockingScheduler()  # 实例化父类
        trigger_min = IntervalTrigger(minutes=30)
        blocking.add_job(self.backing, trigger=trigger_min)
        blocking.start()


if __name__ == '__main__':
    dbBack = DatabaseBR()
    dbBack.con_task()