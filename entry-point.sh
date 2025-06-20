#!/bin/sh
set -e

# Print Java and application version information
echo "Java version:"
java -version
echo ""
echo "Application: spring-boot-demo"
echo "Version: 0.0.1-SNAPSHOT"
echo ""

# Hardcoded Java options - no external configuration needed
JAVA_OPTS="-Xmx512m -Xms256m -XX:+UseG1GC -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/app/logs/heapdump.hprof"

# Create logs directory if it doesn't exist
mkdir -p /app/logs

# Run application with fixed options - no command line args
echo "Starting application with fixed configuration"
echo "Java options: $JAVA_OPTS"

# Execute without passing any command line arguments
echo "Looking for WAR file at: $(pwd)/app.war"
if [ -f "app.war" ]; then
    echo "WAR file found at $(pwd)/app.war"
else
    echo "ERROR: WAR file not found at $(pwd)/app.war"
    echo "Contents of current directory:"
    ls -la
fi

exec java $JAVA_OPTS -jar /app/app.war
