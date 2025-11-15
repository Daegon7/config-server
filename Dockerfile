FROM eclipse-temurin:24-jdk
COPY build/libs/*.jar app.jar
EXPOSE 8888
ENTRYPOINT ["java", "-jar", "app.jar"]