FROM node

RUN npm install -g broken-link-checker

ENTRYPOINT [ "blc" ]
