#################### BASE IMAGE ###################

FROM node:10.4-alpine AS BASE

ENV APP_PATH=/usr/src

ENV PORT=3000 \
    HOST=0.0.0.0

EXPOSE 3000

WORKDIR $APP_PATH

#################### DEV IMAGE ###################

FROM BASE AS DEVELOPMENT

ENV NODE_ENV=development

COPY package.json yarn.lock ./

RUN yarn

COPY . .

CMD yarn start