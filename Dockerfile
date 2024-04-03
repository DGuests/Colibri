FROM lambci/lambda:build-nodejs12.x

WORKDIR /src/

EXPOSE 3000

COPY package.json package-lock.json* /src/

RUN npm ci --silent

COPY . .

CMD npm run start
