FROM harbor.hicustom.com/pub/tomcat
MAINTAINER Lisen <lisen_@hotmail.com>
RUN rm -rf /usr/local/tomcat/webapps/*
ADD <APP_NAME>.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
