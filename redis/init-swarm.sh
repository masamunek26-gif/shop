#!/bin/sh
set -e

echo "Waiting for 6 redis nodes..."
for i in $(seq 1 30); do
  IPS=""
  OK=0
  for h in redis-1 redis-2 redis-3 redis-4 redis-5 redis-6; do
    IP=$(getent hosts "$h" | awk '{print $1}' | head -n1)
    if [ -n "$IP" ]; then
      IPS="$IPS $IP:6379"
      OK=$((OK+1))
    fi
  done
  if [ "$OK" -eq 6 ]; then
    break
  fi
  sleep 1
done

sleep 2
echo "Creating cluster with: $IPS"
redis-cli --cluster create $IPS --cluster-replicas 1 --cluster-yes || true