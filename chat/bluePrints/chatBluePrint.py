import datetime
import openai
from flask import Blueprint, request, jsonify, current_app
from flask_cors import cross_origin


# chatGPT模块路由
chat_view = Blueprint("chat_view", __name__, url_prefix="/chat")


# 自己的cecretKey
openai.api_key = "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"

# 这个路由用来处理会话
@chat_view.route("/session", methods=["POST"])
@cross_origin(supports_credentials=True)
def index():
    # 获取会话的问题数据
    data = request.get_json()

    current_app.logger.info(str(datetime.datetime.now()) + "======> 提问 =====> " + data.get("request"))

    # 请求chartGPT
    try:

        chartResponse = openai.ChatCompletion.create(
          model="gpt-3.5-turbo",  # 使用第几代GPT
          messages=[
                {"role": "system", "content": "一个60年工作经验的程序员"},  # 设置chartGPT的角色
                {"role": "user", "content": data.get("request")}  # 设置提问的消息
            ],
        )
    except Exception as e:
        return jsonify({"code": 500, "msg": "会话失败"})

    return jsonify({"code": 200, "msg": "会话成功", "responseText": chartResponse.get("choices")[0].get('message').get('content')})




