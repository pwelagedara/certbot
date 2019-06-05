#!/bin/bash

# http://pbxhacks.com/automating-lets-encrypt-ssl-certs-via-godaddy-dns-challenge/

# GoDaddy Credentials
GODADDY_API_KEY=""
GODADDY_API_SECRET=""
GODADDY_URL="https://api.godaddy.com"

# DNS Settings
DNS_REC_TYPE=TXT
DNS_REC_NAME_BASE="old_acme-challenge"
DNS_REC_DATA="$CERTBOT_VALIDATION"
DNS_REC_TTL="600"

DNS_REC_NAME=${DNS_REC_NAME_BASE}.${CERTBOT_DOMAIN}

GODADDY_DNS_REC_NAME="${DNS_REC_NAME%.*}"
GODADDY_DNS_REC_NAME="${GODADDY_DNS_REC_NAME%.*}"

echo "[[ INFO ]] Changing TXT Record"

if $(curl -X PUT "${GODADDY_URL}/v1/domains/${CERTBOT_DOMAIN}/records/${DNS_REC_TYPE}" -H  "accept: application/json" -H  "Content-Type: application/json" -H  "Authorization: sso-key ${GODADDY_API_KEY}:${GODADDY_API_SECRET}" -d "[{ \"data\": \"${DNS_REC_DATA}\", \"name\": \"${GODADDY_DNS_REC_NAME}\", \"ttl\": ${DNS_REC_TTL} }]" --silent); then
 	echo "[[ INFO ]] Successfully Changed TXT Record"
else
 	echo "[[ ERROR ]] Error Changing TXT Record"
 	exit 1
fi

echo "[[ INFO ]] Success Cleaning Up"