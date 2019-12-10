FROM maven:3.5-jdk-8 AS build  
COPY . /LodView
WORKDIR /LodView
RUN mvn compile war:war
RUN mvn -f pom.xml clean package

FROM tomcat
LABEL MAINTAINER leon@vwissen.nl

RUN rm -rf /usr/local/tomcat/webapps/ROOT
COPY --from=build LodView/target/lodview.war /usr/local/tomcat/webapps/ROOT.war
#COPY --from=build LodView/target/lodview /usr/local/tomcat/webapps/ROOT

CMD ["catalina.sh", "run"]
