docker network create --driver bridge sem505_network_bridge
docker network connect sem505_network_bridge ses505-1
docker network connect sem505_network_bridge cs505-1
docker network connect sem505_network_bridge studio505-1

