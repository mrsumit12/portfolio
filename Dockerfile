# Use the official Nginx base image
FROM nginx:alpine

# Remove the default nginx.conf (optional)
RUN rm /etc/nginx/conf.d/default.conf

# Copy custom nginx config (optional, if needed)
# COPY nginx.conf /etc/nginx/conf.d

# Copy your static site content to the nginx html directory
COPY . /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
