# Azure Event Grid Topic

## Create Resources

- Resource Group: **wasp-events**
- Event Grid Topic: **silvios-wasp-events**

```bash
. create-event-grid-topic.sh
```

or

```bash
cd azure-platform-foundation/src

export EVENT_GRID_TOPIC_ENDPOINT=$(terraform output -raw platform_eventgrid_topic_endpoint)
export EVENT_GRID_TOPIC_KEY=$(     terraform output -raw platform_eventgrid_topic_primary_access_key) 
```

## Build Image

```bash
docker build -t azure-event-grid-topic .
```

## Send an Event

```bash
./send-event.sh TerraformEvent apply/start

./send-event.sh TerraformEvent apply/end
```

## Cleanup

```bash
az group delete --resource-group wasp-events
```
