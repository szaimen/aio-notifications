#!/bin/bash

echo "Notifications started"

while true; do
  nc -l 10000 | /notify.sh
done
