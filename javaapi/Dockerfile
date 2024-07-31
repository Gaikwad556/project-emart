FROM openjdk:11 AS build_java
WORKDIR /usr/src/app
COPY . ./
RUN apt update && apt install maven -y
RUN mvn install

FROM openjdk:11 
WORKDIR /usr/src/app
COPY --from=build_java /usr/src/app/java/target/*.jar ./java-app.jar
EXPOSE 9000
CMD ["java","-jar","java-app.jar"]