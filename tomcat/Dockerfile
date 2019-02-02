FROM tomcat:latest
MAINTAINER Lisen <lisen_@hotmail.com>
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo 'Asia/Shanghai' >/etc/timezone && \
    echo "export LC_ALL=en_US.UTF-8" >> /etc/profile && \
    . /etc/profile
