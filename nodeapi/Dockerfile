FROM node:14 AS build_node
WORKDIR /usr/src/app/
COPY . ./node
RUN cd /usr/src/app/node && npm install

FROM node:14
WORKDIR /usr/src/app/
COPY --from=build_node /usr/src/app/node/ ./
EXPOSE 5000
CMD ["/bin/sh","-c","cd /usr/src/app/ && npm start"]