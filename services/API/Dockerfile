# EXPRESS JS for api rest
FROM node:alpine
# Create app directory
RUN mkdir -p /app
WORKDIR /app
# Install app dependencies
COPY package.json /app
COPY yarn.lock /app
RUN yarn
# Bundle app source
COPY . /app
#EXPOSE 8080
CMD [ "yarn", "dev" ]
#CMD [ "yarn", "start" ]