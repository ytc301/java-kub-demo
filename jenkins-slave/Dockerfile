FROM jenkinsci/jnlp-slave:3.26-1-alpine
MAINTAINER Lisen <lisen_@hotmail.com>

USER root

RUN echo -e "https://mirror.tuna.tsinghua.edu.cn/alpine/latest-stable/main\n\
https://mirror.tuna.tsinghua.edu.cn/alpine/latest-stable/community" > /etc/apk/repositories

RUN apk update && apk --no-cache add tzdata ca-certificates wget docker maven \
    && cp -r -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

COPY kubectl /usr/local/bin/kubectl

RUN apk --update add docker

COPY k8s/* /opt/k8s/
