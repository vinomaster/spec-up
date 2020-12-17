# Copyright (c) 2020 ToIP Foundation

FROM node:latest

RUN apt update -y \
    && apt install -y \
        build-essential \
        git

# Establish environment name for volume mounted local folder
WORKDIR /host_specup

ADD package.json .

# Force seems to be needed to Fix the upstream dependency conflicts
RUN npm install -g gulp-cli \
    && npm install --force

# Start Node Server and subsequently use Gulp to watch for dev changes
CMD nohup npm run serve & npm run dev
