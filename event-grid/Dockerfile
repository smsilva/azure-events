FROM alpine:3.13.6

RUN apk --no-cache add \
  curl \
  bind-tools \

ADD entrypoint.sh /opt/events/entrypoint.sh

WORKDIR /opt/events/

ENV EVENT_GRID_TOPIC_ENDPOINT=""
ENV EVENT_GRID_TOPIC_KEY=""
ENV EVENT_TYPE=""
ENV EVENT_SUBJECT=""
