import re

import requests
from flask import Blueprint, request, jsonify, current_app, g
from flask_cors import cross_origin
from bs4 import BeautifulSoup

from chat.models import models
from chat.utils.respon_result import ResponseResult
from chat.utils.respon_enum import REnum
from chat.utils.sys_log_save_request import doSaveSysLogRequest

# 娱乐模块路由
play_view = Blueprint("play_view", __name__, url_prefix="/play")

@play_view.before_request
def requestPlayBefore():

    # 在钩子函数中配置g对象
    if request.method != 'OPTIONS':
        sys_log = models.SysLog(serverName="影视服务", userName=request.headers.get('username'))
        g.sys_log = sys_log

# 根据关键字搜索影视
@play_view.route("/searchMovies", methods=["get"])
@cross_origin(supports_credentials=True)
def searchMovies():

    search_key = request.args.get("searchKey")

    action = f"搜索影视=={search_key}"
    doSaveSysLogRequest(action)

    if search_key is None:
        return jsonify({"code": 500, "msg": "请传递搜索参数"})

    # 拼接搜索路径
    search_url = f"https://www.bhxoxo.com/s/-------------.html?wd=%{search_key}"


    try:
        # 请求获取有几页结果
        response = requests.get(search_url)
    except Exception as e:
        current_app.logger.info('Failed to retrieve data from ' + search_url)
        return jsonify(ResponseResult.error(REnum.NET_CONNECTION_ERROR.code, REnum.NET_CONNECTION_ERROR.msg))

    if response.status_code == 200:
        # 解析HTML数据
        soup = BeautifulSoup(response.content, 'html.parser')
        page_result_list = soup.findAll('a', {'class': 'page-link page-next'})

        result_list = list()

        if len(page_result_list) == 0:
            current_page = 1
            page_search_url = f'https://www.bhxoxo.com/s/{search_key}----------{current_page}---.html'
            result_list = doRquest(page_search_url)

        else:
            last_page_url = page_result_list[len(page_result_list)-1]

            last_page_url_all_num = re.findall(r'\d+', last_page_url.attrs.get('href'))

            page_size = last_page_url_all_num[len(last_page_url_all_num) - 1]

            for current_page in range(int(page_size)):
                page_search_url = f'https://www.bhxoxo.com/s/{search_key}----------{current_page + 1}---.html'
                page_result = doRquest(page_search_url)
                result_list += page_result

        return jsonify(ResponseResult.success_has_args_diff_key(REnum.SPIDER_PLAY_BY_KEYWORD_SUCCESS.code,
                                                                        REnum.SPIDER_PLAY_BY_KEYWORD_SUCCESS.msg,
                                                                        "result_list",
                                                                        result_list))
    else:
        return jsonify(ResponseResult.error(REnum.NET_CONNECTION_ERROR.code, REnum.NET_CONNECTION_ERROR.msg))


def doRquest(page_search_url):

    base_play_url = "https://www.bhxoxo.com"

    result_list = list()

    try:
        # 请求获取有几页结果
        response = requests.get(page_search_url)
    except Exception as e:
        current_app.logger.info('Failed to retrieve data from ' + page_search_url)
        return jsonify(ResponseResult.error(REnum.NET_CONNECTION_ERROR.code, REnum.NET_CONNECTION_ERROR.msg))

    if response.status_code == 200:
        # 解析HTML数据
        soup = BeautifulSoup(response.content, 'html.parser')

        play_div_list = soup.findAll('div', {'class': 'module-card-item module-item'})

        for play_div in play_div_list:
            img_link = play_div.find('img', {'class', 'lazy lazyload'}).attrs.get('data-original')
            play_link = base_play_url + play_div.find('a', {'class': 'play-btn-o'}).attrs.get('href')
            title = play_div.find('strong').text
            result = {'title': title, 'img_link': img_link, 'play_link': play_link}
            result_list.append(result)

    return result_list

