#!/bin/bash
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
  azure-event-grid-topic:latest
