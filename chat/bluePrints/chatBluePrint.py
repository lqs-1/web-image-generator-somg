import openai
from flask import Blueprint, request, jsonify, current_app, g
from flask_cors import cross_origin

from chat.models import models
from chat.utils.respon_enum import REnum
from chat.utils.respon_result import ResponseResult
from chat.utils.sys_log_save_request import doSaveSysLogRequest

# chatGPT模块路由
chat_view = Blueprint("chat_view", __name__, url_prefix="/chat")

# 自己的cecretKey
# openai.api_key = ""

@chat_view.before_request
def requestPlayBefore():
    # 在钩子函数中配置g对象
    if request.method != 'OPTIONS':
        sys_log = models.SysLog(serverName="ChatGPT", userName=request.headers.get('username'))
        g.sys_log = sys_log
        
        # 获取自己的secretKey
        chat_gpt_secret_key = models.SysDict.query.filter_by(
            dictCode="CHAT_GPT_SECRET_KEY").first().dictValue
        
        current_app.logger.info(f"chat_gpt_secret_key ======> {chat_gpt_secret_key}")
        openai.api_key = chat_gpt_secret_key


# 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
# 这个路由用来处理会话
@chat_view.route("/session", methods=["POST"])
@cross_origin(supports_credentials=True)
def index():
    # 获取会话的问题数据
    data = request.get_json()

    current_app.logger.info(f"{g.sys_log.userName} ======> 提问 =====> " + data.get("request"))

    action_text = data.get('request')
    if len(action_text) > 10:
        action_text = action_text[: 10]

    # 请求chartGPT
    try:

        chartResponse = openai.ChatCompletion.create(

            model="gpt-3.5-turbo",  # 使用第几代GPT

            messages=[

                {"role": "system", "content": "一个60年工作经验的程序员"},  # 设置chartGPT的角色

                {"role": "user", "content": data.get("request")}  # 设置提问的消息

            ],

        )

        action = f"提问=={action_text}...  花费token=={chartResponse.get('usage').get('total_tokens')}个"
        doSaveSysLogRequest(action)
        current_app.logger.info(f"{g.sys_log.userName}======> 回复 =====> " + data.get("request") + f" ====> {chartResponse.get('choices')[0].get('message').get('content')}")

    except Exception as e:
        current_app.logger.error(f"{g.sys_log.userName} ======> 问答失败 ChatGPT通信失败")
        return jsonify(ResponseResult.error(REnum.CHATGPT_SESSION_FAIL.code, REnum.CHATGPT_SESSION_FAIL.msg))

    return jsonify(
        ResponseResult.success_has_args_diff_key(REnum.CHATGPT_SESSION_SUCCESS.code, REnum.CHATGPT_SESSION_SUCCESS.msg,
                                                 'responseText',
                                                 chartResponse.get("choices")[0].get('message').get('content')))
