FROM node:16.15.1-alpine as build
WORKDIR /src
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx:latest
COPY --from=build /src/dist/client /usr/share/nginx/html
COPY --from=build /src/conf/nginx.conf /etc/nginx/conf.d/default.conf
CMD nginx -g "daemon off;"
