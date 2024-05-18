# # Use an official Node.js runtime as a parent image
# FROM node:20.13.1-slim

# # Set the working directory in the container to /app
# WORKDIR /app

# # Copy package.json and package-lock.json to the working directory
# COPY package*.json ./

# # Install any needed packages specified in package.json
# RUN npm install

# RUN npm install -g @angular/cli

# # Bundle app source inside the docker image
# COPY . .

# # Make port 8080 available to the world outside this container
# EXPOSE 4200

# # Run the app when the container launches
# CMD [ "ng", "serve", "--host", "0.0.0.0" ]

# Use an official Node.js runtime as a parent image
FROM node:20.13.1-slim as build

# Set the working directory in the container to /app
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install any needed packages specified in package.json
RUN npm install

RUN npm install -g @angular/cli

# Bundle app source inside the docker image
COPY . .

# Make port 8080 available to the world outside this container
EXPOSE 4200

# Run the app when the container launches
CMD [ "ng", "build" ]

FROM nginx:1.17.1-alpine as prod-stage

COPY --from=build /app/dist/revhire /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

