#!/bin/bash -e

# This script will wait till pulsar-manager starts to respond
# and then creates a superuser account named "pulsar" with password "pulsar"

while ! curl -sf http://localhost:7750/pulsar-manager/csrf-token; do
  echo "==> CSRF token not ready, will retry in 3s"
  sleep 3
done

CSRF_TOKEN=$(curl -sf http://localhost:7750/pulsar-manager/csrf-token)

curl -s -X PUT "http://localhost:7750/pulsar-manager/users/superuser" \
  -H "X-XSRF-TOKEN: $CSRF_TOKEN" \
  -H "Cookie: XSRF-TOKEN=$CSRF_TOKEN;" \
  -H "Content-Type: application/json" \
  -d '{"name": "pulsar", "password": "pulsar", "email": "pulsar@example.com", "description": "pulsar"}' \

echo "==> You can now login with user/pass pulsar:pulsar to Pulsar Manager at http://localhost:9527"
