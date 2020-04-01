FROM node:10

WORKDIR /usr/src/app

COPY /src/package*.json ./

# Install dependencies
RUN npm install

COPY /src ./

# Run app and tests
RUN node app --location Newcastle && \
    npm test && \
    npm run cover

EXPOSE 3000
CMD ["npm", "start"]