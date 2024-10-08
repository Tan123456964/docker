# Use the official Node.js image as the base image
FROM node:20.18.0-alpine

# Set the working directory inside the container
WORKDIR /usr/src/appserver

# Copy everything from the current directory to the working directory
COPY . .

# RUN npm ci
RUN npm ci

# Expose the port on which the server will run
EXPOSE 3000

# Start the server
CMD [ "npm", "run", "dev" ]



