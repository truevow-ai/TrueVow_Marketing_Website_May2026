FROM node:18-alpine
WORKDIR /app

COPY package*.json ./
RUN npm install --omit=dev

COPY . .

RUN node scripts/prepare_dist.js

ENV PORT=80
ENV NODE_ENV=production

EXPOSE 80

CMD ["node", "server.js"]
