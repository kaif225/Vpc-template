#!/bin/sh

REDIS_HOST="redis"
REDIS_PORT=6379
LOCK_KEY="cronjob-lock"
LOCK_TIMEOUT=120 # seconds
LOCK_VALUE=$(hostname)

# Attempt to acquire the lock
ACQUIRED=$(redis-cli -h $REDIS_HOST -p $REDIS_PORT set $LOCK_KEY $LOCK_VALUE nx ex $LOCK_TIMEOUT)

if [ "$ACQUIRED" = "OK" ]; then
    echo "Lock acquired by $(hostname). Running cron job."
    # Your cron job logic here
    echo "Cron job executed at $(date)" >> /var/log/cron-job.log
else
    echo "Could not acquire lock. Another instance is running."
fi
