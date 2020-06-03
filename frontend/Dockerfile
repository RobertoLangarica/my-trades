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

# copy all the files to the container
COPY . . 

# Exposing the port for the app to run
EXPOSE 3001

#  Run in dev mode
CMD ["quasar","dev"]

# Build phase, removes any dependency and source code
FROM dev as build
RUN ls
# build and dependencies removal
RUN quasar build \
    npm uninstall \
    npm uninstall -g @quasar/cli

# Remove all except the build
RUN mv dist /usr/src/ && rm -r /usr/src/app

WORKDIR /usr/src/dist

# docker build -t langarica/my-trades:r-$(grep -w -i '"version"' package.json | cut -d '"' -f 4) https://github.com/RobertoLangarica/my-trades.git#release:frontend