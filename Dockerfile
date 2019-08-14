FROM node:10
WORKDIR /app
COPY package-lock.json .
COPY package.json .
RUN yarn install 
COPY dist .
COPY wait-for-it.sh .
CMD node index.js
