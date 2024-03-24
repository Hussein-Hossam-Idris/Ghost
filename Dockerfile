FROM node:18.12-alpine

RUN apk update
RUN apk add --no-cache git curl bash
RUN echo fs.inotify.max_user_watches=524288 | tee -a /etc/sysctl.conf && sysctl -p
RUN cat /proc/sys/fs/inotify/max_user_watches
RUN npm install husky -g
RUN yarn global add knex-migrator ember-cli

WORKDIR /app
COPY . .

RUN yarn setup

#this is for app engine
EXPOSE 8080

ENTRYPOINT [ "yarn" ,"dev" ,"--portal"]