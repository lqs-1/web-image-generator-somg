import openai
from flask import Flask, request, jsonify
from flask_cors import cross_origin

import datetime

import requests
from bs4 import BeautifulSoup


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
            ],
        )
    except Exception as e:
        return jsonify({"code": 500, "msg": "会话失败"})

    return jsonify({"code": 200, "msg": "会话成功", "responseText": chartResponse.get("choices")[0].get('message').get('content')})






@app.route("/cnJingJiItNews", methods=["GET"])
@cross_origin(supports_credentials=True)
# 获取中国经济网的it要闻
def cnJingJiItNews():
    url = 'http://www.ce.cn/cysc/tech/'  # 中国经济网中产经下IT页面的URL
    response = requests.get(url)

    if response.status_code == 200:
        # 解析HTML数据
        soup = BeautifulSoup(response.content, 'html.parser')
        # 找到新闻列表的容器
        it_new_list = soup.findAll('div', {'class': 'txt fr badom', 'class': 'txt fr', 'class': 'picboxa clearfix'})

        # 收集结果
        resultList = list()

        # 打印新闻标题和链接
        for news in it_new_list:
            title = news.find('a').text
            link = url + news.find('a')['href']

            result = {"title": title, "link": link}
            resultList.append(result)
    else:
        print('Failed to retrieve data from ' + url)
        return jsonify({"code": 500, "msg": "爬取新闻失败"})


    return jsonify({"code": 200, "msg": "爬取新闻成功", "resultList": resultList})



@app.route("/cnPeopleNews", methods=["get"])
@cross_origin(supports_credentials=True)
# 获取人民网的滚动要闻
def cnPeopleNews():

    # 用于动态拼接爬取的地址
    flag = 1

    # 用户爬取循环的终结标志
    flagTime = str(datetime.date.today())

    # 收集数据
    resultList = list()

    # 新闻地址
    linkBase = 'http://finance.people.com.cn/'

    while True:

        if flagTime != str(datetime.date.today()): break

        url = f'http://finance.people.com.cn/GB/70846/index{flag}.html'  # 人民网的滚动要闻的URL
        response = requests.get(url)


        if response.status_code == 200:
            # 解析HTML数据
            soup = BeautifulSoup(response.content, 'html.parser')
            # 找到新闻列表的容器
            new_list = soup.findAll('li')


            # 打印新闻标题和链接
            for news in new_list:
                time = news.find('em').text # 获取当前新闻的时间
                flagTime = time

                if time != str(datetime.date.today()): break # 如果不是今天的新闻就退出

                title = news.find('a').text # 获取新闻标题
                link = linkBase + news.find('a')['href'] # 获取新闻链接
                result = {"title": title, "link": link, "time": time}
                resultList.append(result)
        else:
            return jsonify({"code": 500, "msg": "爬取新闻失败"})

        flag += 1
    return jsonify({"code": 200, "msg": "爬取新闻成功", "resultList": resultList})



@app.route("/cnTouTiaoNews", methods=["get"])
@cross_origin(supports_credentials=True)
# 获取今日头条上面的热榜新闻
def cnTouTiaoNews():

    url = 'https://www.toutiao.com/hot-event/hot-board/?origin=toutiao_pc'  # 人民网的滚动要闻的URL
    response = requests.get(url)

    if response.status_code == 200:

        data = response.json()

        # 封装结果
        resultList = list()

        # 封装指定热点
        top_hot_news_list = data.get("fixed_top_data")

        for top_hot_news in top_hot_news_list:
            top_result = {"title": top_hot_news.get("Title"), "link": top_hot_news.get("Url")}
            resultList.append(top_result)

        # 封装普通头条热点
        common_hot_news_list = data.get("data")

        for common_hot_news in common_hot_news_list:
            common_host_result = {"title": common_hot_news.get("Title"), "link": common_hot_news.get("Url")}
            resultList.append(common_host_result)
    else:
        return jsonify({"code": 500, "msg": "爬取新闻失败"})

    return jsonify({"code": 200, "msg": "爬取新闻成功", "resultList": resultList})



if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000, debug=True)

