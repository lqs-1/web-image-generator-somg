import openai
from flask import Flask, request, jsonify
from flask_cors import cross_origin

app = Flask(__name__)
# 自己的cecretKey
openai.api_key = "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"

# 这个路由用来处理会话
@app.route("/session", methods=["POST"])
@cross_origin(supports_credentials=True)
def index():
    # 获取会话的问题数据
    data = request.get_json()
    # 请求chartGPT
    print("eeee")
    try:

        chartResponse = openai.ChatCompletion.create(
          model="gpt-3.5-turbo",  # 使用第几代GPT
          messages=[
                {"role": "system", "content": "一个60年工作经验的程序员"},  # 设置chartGPT的角色
                {"role": "user", "content": data.get("request")}  # 设置提问的消息
            ]
        )
    except Exception as e:
        return jsonify({"code": 500, "msg": "会话失败"})

    return jsonify({"code": 200, "msg": "会话成功", "responseText": chartResponse.get("choices")[0].get('message').get('content')})


if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000, debug=True)

