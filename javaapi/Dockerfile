FROM openjdk:8 AS build_java
WORKDIR /usr/src/app/
COPY . /usr/src/app/
RUN apt update && apt install maven -y
RUN mvn install

FROM openjdk:8 
WORKDIR /usr/src/app
COPY --from=build_java /usr/src/app/java/target/*.jar ./java-app.jar
EXPOSE 9000
CMD ["java","-jar","java-app.jar"]