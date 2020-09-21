# datax-web-docker
此项目只用于使用容器化部署docker-web，且不够完善，正常使用没有问题。
源项目地址：https://github.com/WeiYe-Jing/datax-web
希望大家多多支持原作者

# 编译datax
```
自行下载datax代码 编译
编译前pom 文件中的 <modules> 注释不需要的数据源
编译命令
mvn clean package assembly:assembly -Dmaven.test.skip=true
等待编译完成 生成/target/datax.tar.gz
将文件拷贝至此项目下/datax.tar.gz
```
# 编译datax-web
```
自行下载datax-web代码 编译
替换datax-admin/pom.xml 替换文件在项目各自对应的文件夹中
新增datax-executor/src/main/resources/bootstrap.properties 文件，新增文件内容在项目各自对应的文件夹中
编译命令
mvn clean package install -Dmaven.test.skip=true
编译成功后会datax-executor datax-admin 文件夹下会生成target各自运行的jar
将jar文件拷贝到本项目
```

# 生成dockerfile
```
dockerfile在项目根目录下
```

## docker内部网络访问
```
创建虚拟网络命令如下：
network create --subnet=172.10.0.0/24 datax-network
```

#datax-admin启动命令
```
运行生成的images  使用/bin/bash 切勿使用/bin/sh
```
####参数解释
```
PORT 代表admin端口 启动时需要和映射端口保持一致
MYSQL_SERVICE_HOST 代表数据库host，可直接填写地址
MYSQL_SERVICE_PORT 代表访问端口，基本都是3306 填写
MYSQL_USER 代表数据库 用户名
MYSQL_PASSWORD 代表数据库 密码
DB_DATABASE  初始化数据库 名称
```
####docker运行命令参考
```
docker run -i -d -p 2020:2020 \
--name datax-admin \
--net datax-network \
--ip 172.10.0.2 zanderchao/datax-admin:v2  \
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

## datax-executor启动命令

####参数解释
```
PORT 代表executor端口 
ADDRESSES 代表admin服务器地址 eg：http://172.10.0.2:2020
```
#### docker运行命令参考
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
admin只需要启动一次就可以
多个executor启动，可将命令中的指定--ip 及 --name 更换为不同即可
```
## 访问

```
    浏览器访问datax-admin 运行时配置的映射端口
    http://127.0.0.1:port/index.html 初始化密码123456
```

## FAQ
```
数据库初始化，可在https://github.com/WeiYe-Jing/datax-web项目中https://github.com/WeiYe-Jing/datax-web/tree/master/bin/db 中找到sql文件，手动进行初始化
```
