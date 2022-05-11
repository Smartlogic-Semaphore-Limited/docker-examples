docker network create --driver bridge sem540_network_bridge
docker network connect sem540_network_bridge ses540-1
docker network connect sem540_network_bridge cs540-1
docker network connect sem540_network_bridge studio540-1

