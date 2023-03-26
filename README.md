## 网络文件存储网站

> 每次写博客都要想办法传网络图片，自己写一个简单的能获取链接

> 并且这些生成的图片会上传到云上,本地数据库也会对文件链接做一个持久化存储

> 网站添加了多用户功能,用户可以注册自己的账号登录自己的私有空间

> 用户上传文件最好不要大于300MB,因为目前没有做分片上传

> 网站对用户上传的文件进行了分类,具体有 `文件列表`、`图片列表`、`视频列表`、`音频列表`,其中`文件列表`包含了其他三个分类的所有数据以及没有分类的数据

> 网站`系统首页`中将会展示整站的文件的统计数据,如果用户登陆了,还会在`系统首页`展示当前用户的文件统计数据

> 上传到网站上的`图片`和`视频`都有缩略图展示,方便用户寻找视频,配合查询可以更方便的查找资源


### web-image-generator-somg

> 后端采用SpringBoot + SpringSecurity + Jwt做的前后端分离认证

> 采用redis做权限存储,采用mysql做数据持久化存储

> 项目整合MybatisPlus,文件删除使用逻辑删除,用于记录用户使用过网站

> 后端api接口的请求权限通过SpringSecurity提供的权限认证来做,保证用户有每种权限或者角色才能请求到响应的api接口

> 后端api接口权限存放在Role和Permission数据表以及关联表中

### web-image-generator-vue

> 本地图片上传生成网络图片的前端，需要和后端一起使用，前后端分离的，后端也有一个简单的页面，可以选择不使用这个前端页面

> 使用vue编写的可视化前台页面

> 前端的菜单访问权限也是从后端获取过来的

### 在线工具使用
> [网络文件上传地址 账号guest 密码guest](http://nobibibi.top)

> [匿名上传地址](http://nobibibi.top:8888)

> 登录

![login](https://pub-pce.oss-cn-chengdu.aliyuncs.com/public/2023-03-26/518d3e3c173f4f7c96bd649ce1cac758.PNG)

> 主页

![index](https://pub-pce.oss-cn-chengdu.aliyuncs.com/public/2023-03-26/656d8bbca49348d2b648b116369c443f.PNG)

> 上传

![upload](https://pub-pce.oss-cn-chengdu.aliyuncs.com/public/2023-03-26/b9b52e4fff11437586d73d76ea75e653.PNG)


