import requests
from flask import Blueprint, request, jsonify
from flask_cors import cross_origin
from bs4 import BeautifulSoup

# 娱乐模块路由
play_view = Blueprint("play_view", __name__, url_prefix="/play")


# 根据关键字搜索影视 TODO 还没做 这个网站行不通
@play_view.route("/searchMovies", methods=["post"])
@cross_origin(supports_credentials=True)
def searchMovies():
    json_data = request.get_json()
    search_key = json_data.get("searchKey")

    if search_key is None:
        return jsonify({"code": 500, "msg": "请传递搜索参数"})

    # 拼接搜索路径
    search_url = f"https://cupfox.app/s/{search_key}"


    response = requests.get(search_url)


    if response.status_code == 200:
        print("ok")
        # 解析HTML数据
        soup = BeautifulSoup(response.content, 'html.parser')
        # 找到新闻列表的容器
        it_new_list = soup.find('div', {'class': 'search-result-list'})

        # 收集结果
        resultList = list()





