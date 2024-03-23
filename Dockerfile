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

RUN yarn setup
#this is for app engine

ENTRYPOINT [ "yarn" ,"dev" ,"--portal"]