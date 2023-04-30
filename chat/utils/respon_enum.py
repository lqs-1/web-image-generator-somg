from enum import Enum



class REnum(Enum):
    """状态码枚举类"""

    OK = (200, '操作成功')
    ERROR = (0, '操作失败')
    SERVER_ERR = (500, '服务器异常')
    SPIDER_CN_JINGJI_IT_NEWS_SUCCESS = (10000, '爬取中国经济网IT信息新闻成功')
    SPIDER_CN_JINGJI_IT_NEWS_FAIL = (20000, '爬取中国经济网IT信息新闻失败')
    CHATGPT_SESSION_SUCCESS = (10001, '会话成功')
    CHATGPT_SESSION_FAIL = (20001, '会话失败')
    NET_CONNECTION_ERROR = (20002, '网络链接失败')
    SPIDER_CN_PEOPLE_NEWS_SUCCESS = (10003, '爬取人民网滚动新闻成功')
    SPIDER_CN_PEOPLE_NEWS_FAIL = (20003, '爬取人民网滚动新闻失败')
    SPIDER_CN_TOUTIAO_NEWS_SUCCESS = (10004, '爬取今日头条热搜成功')
    SPIDER_CN_TOUTIAO_NEWS_FAIL = (20004, '爬取今日头条热搜失败')
    SPIDER_CN_WEIBO_NEWS_SUCCESS = (10005, '爬取微博热搜成功')
    SPIDER_CN_WEIBO_NEWS_FAIL = (20005, '爬取微博热搜失败')
    SPIDER_PLAY_BY_KEYWORD_SUCCESS = (10006, '根据关键字爬取影视成功')


    @property
    def code(self) -> int:
        return self.value[0]

    @property
    def msg(self) -> str:
        return self.value[1]
