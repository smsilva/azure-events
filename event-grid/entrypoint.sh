#!/bin/sh
EVENTS_OUTPUT_DIRECTORY="/opt/events/output" && mkdir -p "${EVENTS_OUTPUT_DIRECTORY}"
EVENTS_JSON_FILE_NAME=$(date +"event-%Y-%m-%d_%H%M%S.json")
EVENTS_JSON_FILE="${EVENTS_OUTPUT_DIRECTORY}/${EVENTS_JSON_FILE_NAME}"
EVENT_ID="$(uuidgen)"
EVENT_TIME="$(date +%Y-%m-%dT%H:%M:%S%z)"

echo "EVENT_GRID_TOPIC_ENDPOINT....: ${EVENT_GRID_TOPIC_ENDPOINT}"
echo "EVENT_GRID_TOPIC_KEY.........: ${#EVENT_GRID_TOPIC_KEY}"
echo "EVENT_ID.....................: ${EVENT_ID}"
echo "EVENT_TIME...................: ${EVENT_TIME}"
echo "EVENT_TYPE...................: ${EVENT_TYPE}"
echo "EVENT_SUBJECT................: ${EVENT_SUBJECT}"
echo "EVENTS_JSON_FILE.............: ${EVENTS_JSON_FILE}"

cat <<EOF > "{EVENTS_JSON_FILE?}"
[
  {
    "id": "${EVENT_ID}",
    "eventType": "${EVENT_TYPE}",
    "subject": "${EVENT_SUBJECT}",
    "eventTime": "${EVENT_TIME}",
    "data": {},
    "dataVersion": "1.0"
  }
]
EOF

curl \
  --include \
  --request POST "${EVENT_GRID_TOPIC_ENDPOINT}" \
  --header "aeg-sas-key: ${EVENT_GRID_TOPIC_KEY?}" \
  --data @"{EVENTS_JSON_FILE?}"
