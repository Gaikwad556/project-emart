FROM openjdk:11 as build_java
WORKDIR /usr/src/app
COPY . ./java
RUN apt update && apt install maven -y
RUN cd /usr/src/app/java && mvn install

FROM openjdk:11 
WORKDIR /usr/src/app
COPY --from=build_java /usr/src/app/java/target/*.jar ./java-app.jar
EXPOSE 9000
CMD ["java","-jar","java-app.jar"]