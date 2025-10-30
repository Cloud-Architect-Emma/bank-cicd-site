# Use a lightweight web server image
FROM nginx:alpine

# Remove default nginx content
RUN rm -rf /usr/share/nginx/html/*

# Copy your static site files into the container
COPY . /usr/share/nginx/html

# Expose port 90
EXPOSE 90

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
