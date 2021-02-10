FROM node:alpine as builder
WORKDIR '/app'
COPY ./package.json ./
RUN npm install
RUN adduser node root
RUN chmod -R 775 /app/node_modules
RUN chown -R node:root /app/node_modules
COPY . .
USER node
CMD ["npm", "run", "build"]

FROM nginx
EXPOSE 3000
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/build /usr/share/nginx/html