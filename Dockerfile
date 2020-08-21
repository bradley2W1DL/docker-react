FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# each "phase" block can only have one "FROM" statement
# this makes each new "FROM" statement the implicit start of another phase
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html

# default command of nginx container will start up the nginx process
