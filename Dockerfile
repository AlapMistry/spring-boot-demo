FROM eclipse-temurin:17-jdk AS build
WORKDIR /app

# Copy maven executable and pom.xml
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

# Make the maven wrapper executable
RUN chmod +x ./mvnw

# Download all required dependencies into one layer
RUN ./mvnw dependency:go-offline -B

# Copy source code
COPY src src

# Build the application
RUN ./mvnw package -DskipTests

# Use a smaller base image for the runtime
FROM eclipse-temurin:17-jre
WORKDIR /app

# Copy the built artifact from the build stage
COPY --from=build /app/target/spring-boot-demo-0.0.1-SNAPSHOT.war /app/app.war

# Copy entry point script
COPY entry-point.sh /app/entry-point.sh
RUN chmod +x /app/entry-point.sh && ls -la /app/app.war

# Set the startup command
ENTRYPOINT ["/app/entry-point.sh"]

# Expose the port the app runs on
EXPOSE 8080

# Health check using the /health endpoint
HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
  CMD curl -f http://localhost:8080/health || exit 1
