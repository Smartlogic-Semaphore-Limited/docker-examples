docker network create --driver bridge sem563_network_bridge
docker network connect sem563_network_bridge ses563-1
docker network connect sem563_network_bridge cs563-1
docker network connect sem563_network_bridge studio563-1
docker network connect sem563_network_bridge rs563-1

