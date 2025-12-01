#!/bin/bash

while read -r line
do
    echo "Message received: '$line'"
    SUBJECT=$(echo "$line" | cut -d "|" -f 1)
    MESSAGE=$(echo "$line" | cut -d "|" -f 2)

    # Check if nextcloud is reachable
    if ! nc -z "nextcloud-aio-nextcloud" 9001; then
        echo "It looks like Nextcloud is not reachable. Not sending the notification."
    else
        # Send message via docker exec
        docker exec nextcloud-aio-nextcloud bash /notify.sh "$SUBJECT" "$MESSAGE"
    fi
done
