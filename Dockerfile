FROM node:16-alpine as builder
USER node
RUN mkdir -p /home/node/app
WORKDIR /home/node/app

COPY --chown=node ./package.json ./
RUN npm install
COPY --chown=node ./ ./
RUN npm run build

#/home/node/app/build 

FROM nginx
EXPOSE 80
COPY --from=builder /home/node/app/build /usr/share/nginx/html