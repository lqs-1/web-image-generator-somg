import json

import requests
from flask import g

from chat.models import models


def doSaveSysLogRequest(action: str):
    # 封装请求数据
    sys_log = g.sys_log
    user_id = models.User.query.filter_by(username=sys_log.userName).first().id
    sys_log.userId = user_id
    sys_log.action = action

    # 获取请求地址
    third_sys_log_request_path = models.SysDict.query.filter_by(dictCode="THIRD_SYS_LOG_DEFAULT_REQUEST_PATH").first().dictValue

    # 处理数据
    data = sys_log.__dict__
    data.pop("_sa_instance_state", None)

    headers = {'content-type': "application/json"}
    # 发送请求
    requests.post(third_sys_log_request_path, data=json.dumps(data), headers=headers)
