FROM node:18-slim

WORKDIR /app

COPY . /app
RUN apt-get update
CMD ["yarn", "dev", "--host"]
