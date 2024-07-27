FROM ubuntu/apache2:latest

# Update and install required packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y wget unzip && \
    rm -rf /var/lib/apt/lists/*

# Download, unzip the template, and move files to the appropriate directory
RUN wget https://www.tooplate.com/zip-templates/2137_barista_cafe.zip && \
    unzip 2137_barista_cafe.zip && \
    mv 2137_barista_cafe/* /var/www/html/ && \
    rm -rf 2135_mini_finance 2137_barista_cafe.zip

# Expose port 80
EXPOSE 8080

# Start the Apache server
CMD ["apache2ctl", "-D", "FOREGROUND"]
