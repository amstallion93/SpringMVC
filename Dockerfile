FROM alpine/git as clone (1)
WORKDIR /app
RUN git clone https://github.com/amstallion93/SpringMVC.git
echo "Clone success"

FROM maven:3.5-jdk-8-alpine as build (2)
WORKDIR /app
echo "Build Done"

COPY --from=clone /app/SpringMVC /app (3)
RUN mvn install
FROM openjdk:8-jre-alpine
WORKDIR /app
COPY --from=build /app/target/SpringMVC.war /app

FROM tomcat:8.0.20-jre8
COPY --from=build /app/target/SpringMVC.war /usr/local/tomcat/webapps/ 



