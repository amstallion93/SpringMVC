FROM alpine/git as clone 
WORKDIR /app
RUN git clone https://github.com/amstallion93/SpringMVC.git


FROM maven:3.5-jdk-8-alpine as build 
WORKDIR /app


COPY --from=clone /app/SpringMVC /app 
RUN mvn install
FROM openjdk:8-jre-alpine
WORKDIR /app
COPY --from=build /app/target/SpringMVC.war /app

FROM tomcat:8.0.20-jre8
COPY --from=build /app/target/SpringMVC.war /usr/local/tomcat/webapps/ 

CMD ["catalina.sh", "run"]
