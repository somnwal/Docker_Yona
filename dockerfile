FROM mariadb:10.3

ENV TZ Asia/Seoul
ENV MYSQL_ROOT_PASSWORD=root
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update && apt -y install git vim wget openjdk-8-jdk unzip

RUN mkdir /yona-data
COPY my.cnf /etc/mysql/my.cnf

RUN wget https://github.com/yona-projects/yona/releases/download/v1.16.0/yona-v1.16.0-bin.zip
RUN unzip yona-v1.16.0-bin.zip
RUN mv yona-1.16.0 yona

ADD db_user.sql /docker-entrypoint-initdb.d/db_user.sql

WORKDIR /yona

EXPOSE 9000