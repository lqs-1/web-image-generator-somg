from chat import create_app


# 创建app
application = create_app("develop")


if __name__ == '__main__':
    application.run()
