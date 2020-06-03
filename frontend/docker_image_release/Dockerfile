# Base image
FROM node:13

# directory for the app
WORKDIR /usr/src/app

# Copy package and pacakge-lock
COPY package*.json ./

# install dependencies
RUN npm install && npm install -g @quasar/cli

# copy all the files to the container
COPY . . 


# Exposing the port for the app to run
EXPOSE 3001

# run in dev mode
CMD ["quasar","dev"]