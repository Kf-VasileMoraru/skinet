FROM node:16.15.1-alpine
WORKDIR /src
COPY package.json package-lock.json ./
RUN npm install
COPY . .
CMD ["npm", "start"]
