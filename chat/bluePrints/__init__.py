from flask import Flask

from chat.bluePrints.chatBluePrint import chat_view
from chat.bluePrints.newsBluePrint import news_view
from chat.bluePrints.playBluePrint import play_view


# 注册各种路由
def register_all_views(app: Flask):
    app.register_blueprint(chat_view)
    app.register_blueprint(news_view)
    app.register_blueprint(play_view)
