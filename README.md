## 对接一个openAi的chatGPT聊天机器人Python版本

### 创建虚拟环境


```bash
python -m venv venv
venv/bin/activate # linux
venv/Script/activate # windows
```

### 安装依赖:

```bash
pip install -r requirements.txt
```

### 获取chatGPT的SecretKey

7. [`点击获取SecretKey`](https://beta.openai.com/account/api-keys)

### 运行

> 不推荐(不会开启自己配置的方式)
```bash
flask run
```

> 推荐
```bash
python app.py
```

> 非常推荐
```bash
python app.py runserver
```