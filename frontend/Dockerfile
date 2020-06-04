# This stage install all the node dependencies an the quasar CLI
# This stage is sufficient for development
FROM langarica/my-trades:dp-latest AS dev
# directory for the app
WORKDIR /usr/src/app

# copy all the files to the container
COPY . . 

# Exposing the port for the app to run
EXPOSE 3001

#  Run in dev mode
CMD ["quasar","dev"]

# Build phase, removes any dependency and source code
FROM dev as build

# build and dependencies removal
RUN quasar build \
    && npm uninstall \
    && npm uninstall -g @quasar/cli

# Remove all except the build
RUN mv dist /usr/src/ && rm -r /usr/src/app

WORKDIR /usr/src/dist

# Clean build
FROM nginx:1.19.0-alpine AS clean_build
WORKDIR /usr/src/app
COPY --from=0 /usr/src/ .
CMD []