
FROM node:14.9.0-alpine
ENV NODE_ENV=production
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install --production
COPY . .
EXPOSE 1234
CMD ["node", "app.js"]


