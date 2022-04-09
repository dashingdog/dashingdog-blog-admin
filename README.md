# dashingdog-blog-admin
[![Build Status](https://travis-ci.com/dashingdog/dashingdog-blog-admin.svg?branch=master)](https://travis-ci.com/dashingdog/dashingdog-blog-admin)

## 项目介绍
blog管理系统基于[lin-cms](https://doc.cms.talelin.com/start/koa/)/vue框架开发

dashingdog-blog需要安装以下三个系统配合使用：
### dashingdog-blog-nuxt（客户端）
代码仓库：[https://github.com/dashingdog/dashingdog-blog-nuxt](https://github.com/dashingdog/dashingdog-blog-nuxt)
### dashingdog-blog-admin（管理系统）
代码仓库：[https://github.com/dashingdog/dashingdog-blog-admin](https://github.com/dashingdog/dashingdog-blog-admin)
### dashingdog-blog-server（服务端）
 代码仓库：[https://github.com/dashingdog/dashingdog-blog-server](https://github.com/dashingdog/dashingdog-blog-server)
## 项目启动
1. `npm install`安装依赖包 
2. `npm run serve`启动项目
3. 项目初次启动需要在服务端跑sql脚本生成超级管理员账号

## 项目部署
1. 安装依赖 `npm install`
2. 构建代码 `npm run build`

如果需要使用持续集成可以参考[Travis CI部署实践](https://www.dashingdog.cn/article/2)，根据需要修改`.travis.yml`和`script/deploy.sh`来配置自己的持续集成