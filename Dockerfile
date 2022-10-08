
# build phase
FROM node:16-alpine as builder

USER node
RUN mkdir -p /home/node/app

WORKDIR '/app'
COPY --chown=node:node ./package.json ./
RUN npm install
COPY --chown=node:node ./ ./


# run phase/container (each container starts with a new FROM statement)
FROM nginx
# copy something from the builder phase 
COPY --from=builder /app/build /usr/share/nginx/html