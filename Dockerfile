FROM node:10

WORKDIR /usr/src/app

COPY /src/package*.json ./

COPY /src ./

EXPOSE 3000
CMD ["npm", "start"]

