# Stage 1: Use a more feature-rich base image to build the content
FROM debian:bullseye-slim AS build

WORKDIR /tmp/cafe

RUN apt update && \
    apt upgrade -y && \
    apt install -y unzip wget

RUN wget https://www.tooplate.com/zip-templates/2137_barista_cafe.zip && \
    unzip 2137_barista_cafe.zip && \
    mv 2137_barista_cafe/* /tmp/cafe

# Stage 2: Use the Nginx image for serving content
FROM nginx:latest

# Copy content from the build stage
COPY --from=build /tmp/cafe /usr/share/nginx/html/

# Expose port 80 (default for Nginx)
EXPOSE 80

# Set a non-root user to run the container
USER nginx

# Nginx is already set up to run in the foreground by default
CMD ["nginx", "-g", "daemon off;"]
