FROM adoptopenjdk/openjdk8

RUN apt-get update && \
apt-get install -y vim && \
apt-get install -y python3 && \
apt-get install -y python3-pip && \
apt-get install -y libpq-dev python-dev && \
apt-get install -y freetds-dev freetds-bin && \
pip3 install --upgrade pip && \
pip3 install -i https://pypi.tuna.tsinghua.edu.cn/simple --upgrade pip && \
pip3 install -i https://pypi.tuna.tsinghua.edu.cn/simple pymysql && \
pip3 install -i https://pypi.tuna.tsinghua.edu.cn/simple pymssql && \
pip3 install -i https://pypi.tuna.tsinghua.edu.cn/simple psycopg2 && \
rm /usr/bin/python && \
ln -s /usr/bin/python3.6 /usr/bin/python

WORKDIR /opt/

ADD ./datax.tar.gz /opt/
ADD ./datax-admin-2.1.2.jar /opt/
ADD ./datax-executor-2.1.2.jar /opt/

