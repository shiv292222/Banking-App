#-----------------Stage-1------------------------
FROM maven:3.8.3-openjdk-17 AS builder


WORKDIR /app

COPY . /app
RUN mvn dependency:go-offline -B


RUN mvn clean install -DskipTests=True



################# Stage-2 ######################


FROM openjdk:17-alpine


WORKDIR /app


COPY --from=builder /app/target/*.jar /app/target/bankapp.jar


EXPOSE 8080


CMD ["java","-jar","/app/target/bankapp.jar"]


