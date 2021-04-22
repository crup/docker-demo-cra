FROM node:15.14.0-alpine3.10 as builder
WORKDIR /usr/src/app
COPY package*.json ./
RUN yarn
COPY . ./
RUN yarn build

FROM nginx:1.19.10-alpine
RUN mkdir -p app
WORKDIR /app
COPY --from=builder ./usr/src/app/build ./
COPY nginx.conf /etc/nginx/nginx.conf
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
