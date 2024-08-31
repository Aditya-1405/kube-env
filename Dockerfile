# Use a Debian-based HTTPD image as the base
FROM debian:latest

# Install HTTPD, wget, and unzip
RUN apt-get update && \
    apt-get install -y apache2 wget unzip

# Download and unzip the file
WORKDIR /tmp
RUN wget https://www.tooplate.com/zip-templates/2137_barista_cafe.zip && \
    unzip 2137_barista_cafe.zip -d /var/www/html && \
    rm 2137_barista_cafe.zip

# Expose port 80
EXPOSE 80

# Start HTTPD
CMD ["apachectl", "-D", "FOREGROUND"]
