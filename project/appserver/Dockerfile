# Use the official Node.js image as the base image
FROM node:20.18.0-alpine

# Set the working directory inside the container
WORKDIR /usr/src/appserver

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./


# RUN npm ci
RUN npm install

# Copy the rest of the application code to the working directory
COPY server.js ./
COPY sqldb.js ./

# Expose the port on which the server will run
EXPOSE 3000


# Start the server
CMD [ "node", "server.js" ]



