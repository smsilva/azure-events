#!/bin/bash

COMPANY_NAME="silvios"
PLATFORM_NAME="wasp"
EVENT_GRID_TOPIC_RESOURCE_GROUP_NAME="${PLATFORM_NAME}-events"
EVENT_GRID_TOPIC_NAME="${COMPANY_NAME}-${PLATFORM_NAME}-events"

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

EVENT_TYPE="${1-TerraformEvent}"
EVENT_SUBJECT="${2-apply/start}"

LOCAL_TERRAFORM_OUTPUT_DIRECTORY="${PWD}/output"
mkdir -p "${LOCAL_TERRAFORM_OUTPUT_DIRECTORY}"

docker run \
  -v "${LOCAL_TERRAFORM_OUTPUT_DIRECTORY}:/opt/output/" \
  -e EVENT_GRID_TOPIC_ENDPOINT="${EVENT_GRID_TOPIC_ENDPOINT?}" \
  -e EVENT_GRID_TOPIC_KEY="${EVENT_GRID_TOPIC_KEY?}" \
  -e EVENT_TYPE="${EVENT_TYPE?}" \
  -e EVENT_SUBJECT="${EVENT_SUBJECT?}" \
  silviosilva/azure-event-grid-topic:1.0
