# web-image-generator-somg

> 每次写博客都要想办法传网络图片，自己写一个简单的能获取链接

> 下载src下面的`web-image-generator-0.0.1-SNAPSHOT.jar`文件

> 通过`java -jar web-image-generator-0.0.1-SNAPSHOT.jar`运行程序

> 打开浏览器输入`http://localhost:8888/` 就可以将本地图片上传为网络图片并返回链接地址

# 项目使用说明
## 在线工具使用
> [网络图片链接生成地址](http://nobibibi.top)

## 离线工具使用(下载代码自定义)
### 后端
> 地址 [`https://github.com/lqs-1/web-image-generator-somg/tree/main´](https://github.com/lqs-1/web-image-generator-somg/tree/main)，除了项目代码以外还有一个做好的jar包可以直接使用

> 可以使用源代码自己来改

> 也可以下载src下面的`web-image-generator-0.0.1-SNAPSHOT.jar`文件

> 通过`java -jar web-image-generator-0.0.1-SNAPSHOT.jar`运行程序

> 打开浏览器输入`http://localhost:8888/` 就可以将本地图片上传为网络图片并返回链接地址

### 前端
> 这是`网络图片生成`的后端，也就是这个jar包，这个后端自带一个简单的上传页面，只能一张一张的上传，如图

![](https://pub-pce.oss-cn-chengdu.aliyuncs.com/somgWebImageSingleGenerate/2023-01-17/92dd8c30d8d2444b9402f9cebabcc8ac.png)

> 文件上传之后返回的链接是在json中，如图

![](https://pub-pce.oss-cn-chengdu.aliyuncs.com/somgWebImageSingleGenerate/2023-01-17/dd87425d9a6f42c39588ff7b573dd701.png)

#### 分离页面
> 前后端分离页面，使用vue编写项目地址[`https://github.com/lqs-1/web-image-generator-somg/tree/vue`](https://github.com/lqs-1/web-image-generator-somg/tree/vue)

> vue前端文件上传页面如下

![](https://pub-pce.oss-cn-chengdu.aliyuncs.com/somgWebImageSingleGenerate/2023-01-17/f559ca57f4814a0a9fa13511337987fb.png)
![](https://pub-pce.oss-cn-chengdu.aliyuncs.com/somgWebImageSingleGenerate/2023-01-17/427731a47b194a21b7dd956c8bda69e8.png)
![](https://pub-pce.oss-cn-chengdu.aliyuncs.com/somgWebImageSingleGenerate/2023-01-17/d2af691fb8014f78b0f7bfee097ce7fc.png)

> 只要将这个项目下载下来运行好，再把这个后端jar包运行起来，就可以通过vue前端页面来上传本地图片生成网络图片
