#!/bin/bash

API_TOKEN="${KANBOARD_API_TOKEN}"
API_ENDPOINT="http://${KANBOARD_HOST}/jsonrpc.php"

# echo "Current directory is $(pwd)"
JSON_FILE=$(tdg -root "/Users/taraskushnir/work/clarifai/go/src/clarifai" -include "\.go$") || exit $?

PAYLOAD="{\"jsonrpc\": \"2.0\", \"id\": 123456789, \"method\": \"importTodoComments\", \"params\": ${JSON_FILE}}"

echo "Sending TODO comments to kanboard..."
CURL_OUT=$(curl -m 60 -s -u "jsonrpc:${API_TOKEN}" -d "${PAYLOAD}" "${API_ENDPOINT}")
if [[ $CURL_OUT == *'"success":true'* ]]; then
    echo "Sync was successful"
else
    echo "Could not finish sync"
    echo "curl output: ${CURL_OUT}"
    CURRENT_DATE=`date '+%F'`
    JSON_FILENAME="kanboard_payload_${CURRENT_DATE}.json"
    echo $JSON_FILE > "${JSON_FILENAME}"
    echo "You can check latest payload in ${JSON_FILENAME}"
    exit 1
fi
