FROM node:10
WORKDIR /app
COPY package-lock.json .
COPY package.json .
RUN yarn install 
COPY dist .
CMD node index.js
