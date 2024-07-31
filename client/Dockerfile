FROM node:20.16 AS BUILD_CLIENT
WORKDIR /usr/src/app
COPY . ./client 
RUN cd /usr/src/app/client && npm install && npm run build --prod

FROM nginx:latest
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=BUILD_CLIENT /usr/src/app/client/dist/client /usr/share/nginx/html
EXPOSE 4200

