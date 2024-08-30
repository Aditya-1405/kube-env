FROM ubuntu/apache2:latest

# Update and install required packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y wget unzip

# Download, unzip the template, and move files to the appropriate directory
RUN wget https://www.tooplate.com/zip-templates/2137_barista_cafe.zip && \
    unzip 2137_barista_cafe.zip && \
    mv 2137_barista_cafe/* /var/www/html/ && \
    rm -rf 2137_barista_cafe.zip 2137_barista_cafe

# Ensure the Apache run directory is writable by the container's user
ENV APACHE_RUN_DIR=/tmp/apache2
RUN mkdir -p $APACHE_RUN_DIR && \
    chmod -R 755 $APACHE_RUN_DIR && \
    chown -R www-data:www-data /var/www/html

# Expose port 80 (default for Apache)
EXPOSE 80

# Start the Apache server in the foreground
CMD ["apache2ctl", "-D", "FOREGROUND"]
