# First stage: Build Angular app and generate SSL certificates
FROM node:20.18.0-alpine as build

WORKDIR /usr/src/webserver

# Install dependencies for Angular and OpenSSL
RUN apk add --no-cache openssl

# copy everything from current directory to container working directory
COPY . .

# Install Angular dependencies
RUN npm ci

# Build the Angular app for production
RUN npm run build --prod

# Generate SSL certificates
RUN mkdir -p /etc/nginx/ssl \
    && openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
       -keyout /etc/nginx/ssl/nginx.key \
       -out /etc/nginx/ssl/nginx.crt \
       -subj "/CN=localhost"


# Second stage: Use NGINX to serve the Angular app with SSL
FROM nginx:alpine

# Copy the Angular build output from the build stage
COPY --from=build /usr/src/webserver/dist/webserver /usr/share/nginx/html

# Copy SSL certificates from the build stage
COPY --from=build /etc/nginx/ssl /etc/nginx/ssl

# Copy your custom NGINX configuration (if needed)
COPY --from=build /usr/src/webserver/nginx/conf/nginx.conf /etc/nginx/nginx.conf

# Expose port 8080 for HTTPS
EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]

