FROM node:alpine as builder 

WORKDIR '/app'

COPY package.json .
RUN npm install
COPY . .

# /app/build will have all the stuff we care about
RUN npm run build

FROM nginx
# copies over the result from npm run build to the nginx image
COPY --from=builder /app/build /usr/share/nginx/html