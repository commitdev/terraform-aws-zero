#!/bin/sh
# Receive/parse variable from terraform external datasource
eval "$(jq -r '@sh "export SENDGRID_API_KEY=\(.sendgrid_api_key) DOMAIN=\(.sendgrid_domain)"')"

## Important: call/curls must not print to STDOUT except the output, the stdout must be JSON serializable
SENDGRID_ENDPOINT=https://api.sendgrid.com/v3/
JQ_DOMAIN_COUNT_QUERY="[ .[] | select(.domain == \"${DOMAIN}\")] | length"
MATCHING_DOMAIN_COUNT=$(curl -s -XGET "${SENDGRID_ENDPOINT}whitelabel/domains" -H "Authorization:Bearer ${SENDGRID_API_KEY}" | jq -c "${JQ_DOMAIN_COUNT_QUERY}");

## Posts to create if not already exist
## This condition is a simple way of making sure this script is idempotent, should yield same result no matter how many times we call it
if [ "${MATCHING_DOMAIN_COUNT}" -lt "1" ]; then
  curl -s -XPOST "${SENDGRID_ENDPOINT}whitelabel/domains" -H "Authorization:Bearer ${SENDGRID_API_KEY}" --data "{\"domain\": \"${DOMAIN}\"}" > /dev/null
fi

## Print our CNAMES for our target domain
## IMPORTANT: must print out map[string]string in JSON format, where all values must be string(CANNOT be int/numbers/boolean)
JQ_CNAMES_QUERY=".[] | select( .domain == \"${DOMAIN}\" ) | { domain_id : .id|tostring } +  (.dns | with_entries(.key |=\"\(.)_host\" | .value |=.host ) )+  (.dns | with_entries(.key |=\"\(.)_value\" | .value |=.data ) )"
curl -s -XGET "${SENDGRID_ENDPOINT}whitelabel/domains" -H "Authorization:Bearer ${SENDGRID_API_KEY}" | jq -r "${JQ_CNAMES_QUERY}"
