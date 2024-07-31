FROM node:14 AS build_client
WORKDIR /usr/src/app
COPY . ./client 
RUN cd /usr/src/app/client/ && npm install && npm run build --prod

FROM nginx:latest
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build_client /usr/src/app/client/dist/client /usr/share/nginx/html
EXPOSE 4200

