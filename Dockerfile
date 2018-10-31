FROM tomcat:8.5.34-jre8
ADD . /usr/local/tomcat/work
EXPOSE 8080
CMD ["catalina.sh", "run"]
