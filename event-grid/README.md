# Azure Event Grid Topic

## Create Resources

- Resource Group: **wasp-events**
- Event Grid Topic: **silvios-wasp-events**

```bash
. create-event-grid-topic.sh
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
