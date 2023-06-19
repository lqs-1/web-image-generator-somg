from flask import Blueprint, jsonify, current_app, request, g
from flask_cors import cross_origin
import datetime
import requests
from bs4 import BeautifulSoup
from chat.models import models
from chat.utils.respon_result import ResponseResult
from chat.utils.respon_enum import REnum
from chat.utils.sys_log_save_request import doSaveSysLogRequest

# 新闻模块路由
news_view = Blueprint("news_view", __name__, url_prefix="/news")


@news_view.before_request
def requestNewsBefore():

    # 在钩子函数中配置g对象
    if request.method != 'OPTIONS':
        sys_log = models.SysLog(serverName="新闻服务", userName=request.headers.get('username'))
        g.sys_log = sys_log


@news_view.route("/cnJingJiItNews", methods=["GET"])
@cross_origin(supports_credentials=True)
# 获取中国经济网的it要闻
def cnJingJiItNews():


    action = "查看中国经济网IT要闻"
    doSaveSysLogRequest(action)


    url = 'http://www.ce.cn/cysc/tech/'  # 中国经济网中产经下IT页面的URL + 新闻前缀
    try:
        response = requests.get(url)
    except Exception as e:
        current_app.logger.error('网络连接失败 =====> ' + url)
        return jsonify(ResponseResult.error(REnum.NET_CONNECTION_ERROR.code, REnum.NET_CONNECTION_ERROR.msg))

    if response.status_code == 200:
        # 解析HTML数据
        soup = BeautifulSoup(response.content, 'html.parser')
        # 找到新闻列表的容器
        it_new_list = soup.findAll('div', {'class': 'txt fr badom', 'class': 'txt fr', 'class': 'picboxa clearfix'})

        # 收集结果
        result_list = list()

        # 打印新闻标题和链接
        for news in it_new_list:
            title = news.find('a').text
            link = url + news.find('a')['href']

            result = {"title": title, "link": link}
            result_list.append(result)
    else:
        return jsonify(
            ResponseResult.error(REnum.SPIDER_CN_JINGJI_IT_NEWS_FAIL.code, REnum.SPIDER_CN_JINGJI_IT_NEWS_FAIL.msg))
    
    current_app.logger.info(f"{g.sys_log.userName} ======> f{action}")

    return jsonify(ResponseResult.success_has_args_diff_key(REnum.SPIDER_CN_JINGJI_IT_NEWS_SUCCESS.code,
                                                            REnum.SPIDER_CN_JINGJI_IT_NEWS_SUCCESS.msg, "result_list",
                                                            result_list))


@news_view.route("/cnPeopleNews", methods=["get"])
@cross_origin(supports_credentials=True)
# 获取人民网的滚动要闻
def cnPeopleNews():

    action = "查看人民日报滚动要闻"
    doSaveSysLogRequest(action)

    # 用于动态拼接爬取的地址
    flag = 1

    # 用户爬取循环的终结标志
    flagTime = str(datetime.date.today())

    # 收集数据
    result_list = list()

    # 新闻地址前缀
    link_base = 'http://finance.people.com.cn/'

    while True:

        if flagTime != str(datetime.date.today()): break

        url = f'http://finance.people.com.cn/GB/70846/index{flag}.html'  # 人民网的滚动要闻的URL
        try:
            response = requests.get(url)
        except Exception as e:
            current_app.logger.error('网络连接失败 =====> ' + url)
            return jsonify(ResponseResult.error(REnum.NET_CONNECTION_ERROR.code, REnum.NET_CONNECTION_ERROR.msg))

        if response.status_code == 200:
            # 解析HTML数据
            soup = BeautifulSoup(response.content, 'html.parser')
            # 找到新闻列表的容器
            new_list = soup.findAll('li')

            # 打印新闻标题和链接
            for news in new_list:
                time = news.find('em').text  # 获取当前新闻的时间
                flagTime = time

                if time != str(datetime.date.today()): break  # 如果不是今天的新闻就退出

                title = news.find('a').text  # 获取新闻标题
                link = link_base + news.find('a')['href']  # 获取新闻链接
                result = {"title": title, "link": link, "time": time}
                result_list.append(result)
        else:
            return jsonify(
                ResponseResult.error(REnum.SPIDER_CN_PEOPLE_NEWS_FAIL.code, REnum.SPIDER_CN_PEOPLE_NEWS_FAIL.msg))

        flag += 1

    current_app.logger.info(f"{g.sys_log.userName} ======> f{action}")

    return jsonify(ResponseResult.success_has_args_diff_key(REnum.SPIDER_CN_PEOPLE_NEWS_SUCCESS.code,
                                                            REnum.SPIDER_CN_PEOPLE_NEWS_SUCCESS.msg,
                                                            "result_list", result_list))


@news_view.route("/cnTouTiaoNews", methods=["get"])
@cross_origin(supports_credentials=True)
# 获取今日头条上面的热榜新闻
def cnTouTiaoNews():

    action = "查看今日头条热搜新闻"
    doSaveSysLogRequest(action)

    url = 'https://www.toutiao.com/hot-event/hot-board/?origin=toutiao_pc'  # 人民网的滚动要闻的URL
    try:
        response = requests.get(url)
    except Exception as e:
        current_app.logger.error('网络连接失败 =====> ' + url)
        return jsonify(ResponseResult.error(REnum.NET_CONNECTION_ERROR.code, REnum.NET_CONNECTION_ERROR.msg))

    if response.status_code == 200:

        data = response.json()

        # 封装结果
        result_list = list()

        # 封装指定热点
        top_hot_news_list = data.get("fixed_top_data")

        for top_hot_news in top_hot_news_list:
            top_result = {"title": top_hot_news.get("Title"), "link": top_hot_news.get("Url")}
            result_list.append(top_result)

        # 封装普通头条热点
        common_hot_news_list = data.get("data")

        for common_hot_news in common_hot_news_list:
            common_host_result = {"title": common_hot_news.get("Title"), "link": common_hot_news.get("Url")}
            result_list.append(common_host_result)
    else:
        return jsonify(
            ResponseResult.error(REnum.SPIDER_CN_TOUTIAO_NEWS_FAIL.code, REnum.SPIDER_CN_TOUTIAO_NEWS_FAIL.msg))
    
    current_app.logger.info(f"{g.sys_log.userName} ======> f{action}")

    return jsonify(ResponseResult.success_has_args_diff_key(REnum.SPIDER_CN_TOUTIAO_NEWS_SUCCESS.code,
                                                            REnum.SPIDER_CN_TOUTIAO_NEWS_SUCCESS.msg,
                                                            "result_list", result_list))


@news_view.route("/cnWeiBoHotSearch", methods=["GET"])
@cross_origin(supports_credentials=True)
# 获取微博热搜榜单
def cnWeiBoHotNews():

    action = "查看微博热搜新闻"
    doSaveSysLogRequest(action)

    url = 'https://weibo.com/ajax/statuses/hot_band'  # 获取微博热搜数据的url

    link_base = 'https://s.weibo.com/weibo?q='

    try:
        response = requests.get(url)
    except Exception as e:
        current_app.logger.error('网络连接失败 =====> ' + url)
        return jsonify(ResponseResult.error(REnum.NET_CONNECTION_ERROR.code, REnum.NET_CONNECTION_ERROR.msg))

    if response.status_code == 200:

        json_data = response.json()

        # 封装结果
        result_list = list()

        # 获取置顶热搜
        hot_top = json_data.get("data").get("hotgov")
        # 封装置顶热搜数据
        hot_top_result = {"title": str(hot_top.get("name")).replace("#", ""),
                          "link": link_base + "%23" + str(hot_top.get("name")).replace("#", "") + "%23"}
        # 装在置顶热点数据
        result_list.append(hot_top_result)

        # 获取普通热搜数据
        common_hot_news_list = json_data.get("data").get("band_list")

        # 打印新闻标题和链接
        for common_hot_news in common_hot_news_list:
            hot_top_result = {"title": common_hot_news.get("word"),
                              "link": link_base + "%23" + str(common_hot_news.get("word")) + "%23"}

            result_list.append(hot_top_result)
    else:
        print('网络连接失败 =====> ' + url)
        return jsonify(
            ResponseResult.error(REnum.SPIDER_CN_WEIBO_NEWS_FAIL.code, REnum.SPIDER_CN_WEIBO_NEWS_FAIL.msg))
    
    current_app.logger.info(f"{g.sys_log.userName} ======> f{action}")

    return jsonify(ResponseResult.success_has_args_diff_key(REnum.SPIDER_CN_WEIBO_NEWS_SUCCESS.code,
                                                            REnum.SPIDER_CN_WEIBO_NEWS_SUCCESS.msg,
                                                            "result_list", result_list))
