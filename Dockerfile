FROM node:18.12-alpine

RUN apk update
RUN apk add --no-cache git curl bash
RUN npm install husky -g
RUN yarn global add knex-migrator ember-cli
RUN export GHOST_ENVIRONMENT=development

WORKDIR /app
COPY . .
RUN export CONTENT_PATH=$(jq -r '.paths.contentPath // "."' config.${GHOST_ENVIRONMENT}.json)
RUN mkdir -p ${CONTENT_PATH}/adapters/storage/gcloud
RUN cat > ${CONTENT_PATH}/adapters/storage/gcloud/index.js << EOL
RUN module.exports = require('ghost-google-cloud-storage');

RUN mkdir -p content/adapters/storage/gcs
RUN npm install ghost-v3-google-cloud-storage
RUN mv node_modules/ghost-v3-google-cloud-storage/* content/adapters/storage/gcs/
RUN yarn setup
#this is for app engine
EXPOSE 8080

ENTRYPOINT [ "yarn" ,"dev" ,"--portal"]