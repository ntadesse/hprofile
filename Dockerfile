FROM openjdk:11 AS BUILD_IMAGE
RUN apt update && apt install maven -y
COPY ./ hprofile
RUN cd hprofile &&  mvn install 

FROM tomcat:9-jre11
LABEL "Project"="Vprofile"
LABEL "Author"="Imran"
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=BUILD_IMAGE hprofile/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
