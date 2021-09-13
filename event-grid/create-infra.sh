#!/bin/bash

COMPANY_NAME="silvios"
PLATFORM_NAME="wasp"
EVENT_GRID_TOPIC_RESOURCE_GROUP_NAME="${PLATFORM_NAME}-events"
EVENT_GRID_TOPIC_NAME="${COMPANY_NAME}-${PLATFORM_NAME}-events"
EVENT_GRID_TOPIC_LOCATION="centralus"

az group create \
  --resource-group "${EVENT_GRID_TOPIC_RESOURCE_GROUP_NAME}" \
  --location "${EVENT_GRID_TOPIC_LOCATION}"

az eventgrid topic create \
  --name "${EVENT_GRID_TOPIC_NAME}" \
  --location "${EVENT_GRID_TOPIC_LOCATION}" \
  --resource-group "${EVENT_GRID_TOPIC_RESOURCE_GROUP_NAME}"

EVENT_GRID_TOPIC_ENDPOINT=$(az eventgrid topic show \
  --name "${EVENT_GRID_TOPIC_NAME}" \
  --resource-group "${EVENT_GRID_TOPIC_RESOURCE_GROUP_NAME}" \
  --query "endpoint" \
  --output tsv)

EVENT_GRID_TOPIC_KEY=$(az eventgrid topic key list \
  --name "${EVENT_GRID_TOPIC_NAME}" \
  --resource-group "${EVENT_GRID_TOPIC_RESOURCE_GROUP_NAME}" \
  --query "key1" \
  --output tsv)

EVENT_TYPE="TerraformEvent"
EVENT_SUBJECT="apply/start"

echo "COMPANY_NAME............................: ${COMPANY_NAME}" && \
echo "PLATFORM_NAME...........................: ${PLATFORM_NAME}" && \
echo "EVENT_GRID_TOPIC_RESOURCE_GROUP_NAME....: ${EVENT_GRID_TOPIC_RESOURCE_GROUP_NAME}" && \
echo "EVENT_GRID_TOPIC_LOCATION...............: ${EVENT_GRID_TOPIC_LOCATION}" && \
echo "EVENT_GRID_TOPIC_ENDPOINT...............: ${EVENT_GRID_TOPIC_ENDPOINT}" && \
echo "EVENT_GRID_TOPIC_NAME...................: ${EVENT_GRID_TOPIC_NAME}" && \
echo "EVENT_GRID_TOPIC_KEY....................: ${#EVENT_GRID_TOPIC_KEY}" && \
echo "EVENT_TYPE..............................: ${EVENT_TYPE}" && \
echo "EVENT_SUBJECT...........................: ${EVENT_SUBJECT}"

LOCAL_TERRAFORM_OUTPUT_DIRECTORY="${PWD}/output" && mkdir -p "${LOCAL_TERRAFORM_OUTPUT_DIRECTORY}" && touch "${LOCAL_TERRAFORM_OUTPUT_DIRECTORY}/events.json"

docker run \
  -v "${LOCAL_TERRAFORM_OUTPUT_DIRECTORY}:/opt/output/" \
  -e ARM_CLIENT_ID="${ARM_CLIENT_ID?}" \
