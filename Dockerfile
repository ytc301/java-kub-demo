FROM tomcat:8.5.34-jre8
RUN rm -rf /usr/local/tomcat/webapps/ROOT/*
ADD . /usr/local/tomcat/webapps/ROOT
EXPOSE 8080
CMD ["catalina.sh", "run"]
