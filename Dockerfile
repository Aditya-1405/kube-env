FROM ubuntu:latest

# Update and install required packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y apache2 wget unzip && \
    rm -rf /var/lib/apt/lists/*

# Download, unzip the template, and move files to the appropriate directory
RUN wget https://www.tooplate.com/zip-templates/2137_barista_cafe.zip && \
    unzip 2137_barista_cafe.zip && \
    mv 2137_barista_cafe/* /var/www/html/ && \
    rm -rf 2137_barista_cafe.zip 2137_barista_cafe

# Create necessary directories and set permissions
RUN mkdir -p /var/run/apache2 && \
    chown -R www-data:www-data /var/www/html /var/run/apache2 && \
    chmod 755 /var/run/apache2

# Expose port 80 (default for Apache)
EXPOSE 80

# Start the Apache server
CMD ["apache2ctl", "-D", "FOREGROUND"]
