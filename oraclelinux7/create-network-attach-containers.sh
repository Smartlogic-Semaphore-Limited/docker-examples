docker network create --driver bridge sem522_network_bridge
docker network connect sem522_network_bridge ses522-1
docker network connect sem522_network_bridge cs522-1
docker network connect sem522_network_bridge studio522-1

