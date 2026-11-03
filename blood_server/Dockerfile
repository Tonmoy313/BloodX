# Build from the project root with:
# docker build -f blood_server/Dockerfile .

# Build stage
FROM dart:3.8.0 AS build

# Create a minimal workspace that preserves locked server dependency versions.
WORKDIR /app
# Use a Docker-specific workspace pubspec (excludes blood_flutter)
COPY blood_server/docker/pubspec.yaml pubspec.yaml
COPY blood_client blood_client
COPY blood_server blood_server

# Compile the server executable.
WORKDIR /app/blood_server
RUN dart pub get
RUN dart compile exe bin/main.dart -o bin/server
# Add a fallback for the copy of possibly missing directories.
RUN mkdir -p config web migrations lib/src/generated

# Final stage
# FROM alpine:latest
FROM dart:3.8.0
WORKDIR /app

# Environment variables
ENV runmode=production
ENV serverid=default
ENV logging=normal
ENV role=monolith

# Copy runtime dependencies
# COPY --from=build /runtime/ /

# Copy compiled server executable
COPY --from=build /app/blood_server/bin/server server

# Copy configuration files and resources
COPY --from=build /app/blood_server/config/ config/
COPY --from=build /app/blood_server/web/ web/
COPY --from=build /app/blood_server/migrations/ migrations/

# This file is required to enable the endpoint log filter in Insights.
COPY --from=build /app/blood_server/lib/src/generated/protocol.yaml lib/src/generated/protocol.yaml

# Expose ports
EXPOSE 8080
EXPOSE 8081
EXPOSE 8082

# Define the entrypoint command
# ENTRYPOINT ./server --mode=$runmode --server-id=$serverid --logging=$logging --role=$role
ENTRYPOINT ["sh", "-c", "./server --mode=$runmode --server-id=$serverid --logging=$logging --role=$role"]