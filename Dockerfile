FROM nginx:latest

WORKDIR /tmp/cafe

RUN apt update && \
    apt upgrade -y && \
    apt install -y unzip wget

RUN wget https://www.tooplate.com/zip-templates/2137_barista_cafe.zip && \
    unzip 2137_barista_cafe.zip && \
    mv 2137_barista_cafe/* /usr/share/nginx/html/

# Expose port 80 (default for Nginx)
EXPOSE 80

# Nginx is already set up to run in the foreground by default
CMD ["nginx", "-g", "daemon off;"]
