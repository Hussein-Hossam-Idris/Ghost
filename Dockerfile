FROM node:18.12-alpine

RUN apk update
RUN apk add --no-cache git curl bash
RUN npm install husky -g
RUN yarn global add knex-migrator ember-cli
# Verify installation
RUN node -v
RUN npm -v


WORKDIR /app
COPY . .
RUN mkdir -p content/adapters/storage/gcs
RUN npm install ghost-v3-google-cloud-storage
RUN mv node_modules/ghost-v3-google-cloud-storage/* content/adapters/storage/gcs/
RUN yarn setup
#this is for app engine
EXPOSE 2368

ENTRYPOINT [ "yarn" ,"dev" ,"--portal"]