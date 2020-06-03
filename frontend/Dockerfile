# This stage install all the node dependencies an the quasar CLI
# This stage is sufficient for development
FROM node:13 AS dev
# directory for the app
WORKDIR /usr/src/app

# Copy package and pacakge-lock
COPY package*.json ./

# install dependencies
RUN npm install \
    npm install -g @quasar/cli

# Exposing the port for the app to run
EXPOSE 3001

#  Run in dev mode
CMD ["quasar","dev"]

# This phase allows to run the current version as dev
FROM dev AS dev_run
# copy all the files to the container
COPY . . 

# Exposing the port for the app to run
EXPOSE 3001

#  Run in dev mode
CMD ["quasar","dev"]

# This is the build phase an it removes any dependency after
FROM dev as build
# build and dependencies removal
RUN quasar build \
    npm uninstall \
    npm uninstall -g @quasar/cli

# Remove all except the build
RUN mv dist /usr/src/ && rm -r /usr/src/app

WORKDIR /usr/src/dist