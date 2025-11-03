FROM nginx:alpine

# Remove default Nginx HTML
RUN rm -rf /usr/share/nginx/html/*

# Copy your static files
COPY . /usr/share/nginx/html

# Enable stub_status for metrics
RUN echo 'server { \
    listen 90; \
    server_name localhost; \
    location / { \
        root /usr/share/nginx/html; \
        index index.html; \
    } \
    location /stub_status { \
        stub_status; \
        allow 127.0.0.1; \
        deny all; \
    } \
}' > /etc/nginx/conf.d/default.conf

# Install wget and download the nginx-prometheus-exporter
RUN apk add --no-cache wget ca-certificates && \
    wget -O /tmp/nginx-prometheus-exporter.tar.gz https://github.com/nginxinc/nginx-prometheus-exporter/releases/download/v0.11.0/nginx-prometheus-exporter_0.11.0_linux_amd64.tar.gz && \
    tar -xzf /tmp/nginx-prometheus-exporter.tar.gz -C /tmp && \
    mv /tmp/nginx-prometheus-exporter /usr/local/bin/nginx-prometheus-exporter && \
    chmod +x /usr/local/bin/nginx-prometheus-exporter && \
    rm -rf /tmp/*

# Copy startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Expose ports
EXPOSE 90 9113

# Start with script
CMD ["sh", "-c", "nginx -g 'daemon off;' & sleep 2 && /usr/local/bin/nginx-prometheus-exporter -nginx.scrape-uri=http://localhost:90/stub_status"]
