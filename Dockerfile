FROM node:18.12-alpine

RUN apk update
RUN apk add --no-cache git curl bash
RUN npm install husky -g
RUN yarn global add knex-migrator ember-cli

WORKDIR /app
COPY . .
RUN mkdir -p content/adapters/storage/gcs
RUN npm install ghost-google-cloud-storage --force
RUN mv node_modules/ghost-google-cloud-storage/* content/adapters/storage/gcs/


RUN yarn setup
#this is for app engine
EXPOSE 8080

ENTRYPOINT [ "yarn" ,"dev" ,"--portal"]