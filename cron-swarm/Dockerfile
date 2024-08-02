FROM node:22-alpine3.18


RUN apk update && \
    apk upgrade && \
    apk add --no-cache curl bash redis

WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install

COPY . .

# Copy the cron job script into the image
COPY my-cron-job.sh /usr/local/bin/my-cron-job.sh
RUN chmod +x /usr/local/bin/my-cron-job.sh

# Add the cron job to crontab
RUN echo "*/5 * * * * /usr/local/bin/my-cron-job.sh" > /etc/crontabs/root


EXPOSE 3000

CMD ["sh", "-c", "crond && node index.js"]
