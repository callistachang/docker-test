FROM node:alpine

WORKDIR '/app'

COPY package.json ./
RUN npm install
COPY . .

# /app/build will have all the stuff we care about
RUN npm run build

FROM nginx
# in the case of AWS elastic beanstalk, it looks specifically
# for any EXPOSE statements for any ports it should listen to
EXPOSE 80
# copies over the result from npm run build to the nginx image
COPY --from=0 /app/build /usr/share/nginx/html