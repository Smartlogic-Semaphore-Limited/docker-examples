docker network create --driver bridge sem541_network_bridge
docker network connect sem541_network_bridge ses541-1
docker network connect sem541_network_bridge cs541-1
docker network connect sem541_network_bridge studio541-1

