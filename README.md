# datax-web-docker
此项目只用于使用容器化部署docker-web，且不够完善，正常使用没有问题。
源项目地址：https://github.com/WeiYe-Jing/datax-web
希望大家多多支持原作者

## docker内部网络访问
```
创建虚拟网络命令如下：
network create --subnet=172.10.0.0/24 datax-network
```

## 获取datax-admin镜像 目前版本2.1.2
```
tag v1 基础环境
tag v2 自带datax-admin + 基础环境 
docker pull zanderchao/datax-admin:v2  建议使用
```

##datax-admin启动命令

PORT 代表admin端口 启动时需要和映射端口保持一致
MYSQL_SERVICE_HOST 代表数据库host，可直接填写地址
MYSQL_SERVICE_PORT 代表访问端口，基本都是3306 填写
MYSQL_USER 代表数据库 用户名
MYSQL_PASSWORD 代表数据库 密码
DB_DATABASE  代码同步数据存储库名

```
docker run -i -d -p 2020:2020 \
--name datax-admin \
--net datax-network \
--ip 172.10.0.2  zanderchao/datax-admin:v2  \
java -jar datax-admin-2.1.2.jar \
--PORT=$(PORT) \
--MYSQL_SERVICE_HOST=$(MYSQL_SERVICE_HOST) \
--MYSQL_SERVICE_PORT=$(MYSQL_SERVICE_PORT) \
--MYSQL_USER=$(MYSQL_USER) \
--MYSQL_PASSWORD=$(MYSQL_PASSWORD) \
--DB_DATABASE=$(DB_DATABASE)
```
## datax-admin 日志路径
```
/tmp/datax-admin.log
```

## 获取datax-executor镜像 目前版本2.1.2
```
tag v1 基础环境+python3环境
tag v2 自带datax-executor + 基础环境 + datax
docker pull zanderchao/datax-executor:v2  建议使用
```

## datax-executor启动命令

PORT 代表executor端口 
ADDRESSES 代表admin服务器地址 eg：http://172.10.0.2:2020

```
docker run -i -d -p 2020:2020 \
--name datax-admin \
--net datax-network \
--ip 172.10.0.2  zanderchao/datax-executor:v2  \
java -jar datax-admin-2.1.2.jar \
--PORT=$(PORT) \
--ADDRESSES=$(ADDRESSES)
```
## datax-executor 日志路径
```
/home/applogs/executor/jobhandler
```

## 集群部署暂未测试。
```
集群正在在测试。
```
