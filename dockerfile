FROM node:14.16.0-alpine AS build

WORKDIR /build

COPY package.json .
COPY package-lock.json .
COPY tsconfig.json .

RUN npm install --loglevel verbose

COPY ./src ./src
COPY ./public ./public
RUN npm run build

FROM node:14.16.0-alpine

RUN npm install -g serve

WORKDIR /app

COPY --from=build /build/build ./app

EXPOSE 5000

CMD ["serve", "-s", "app"]