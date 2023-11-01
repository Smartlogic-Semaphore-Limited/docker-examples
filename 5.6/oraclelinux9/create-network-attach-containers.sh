docker network create --driver bridge sem564_network_bridge
docker network connect sem564_network_bridge ses564-1
docker network connect sem564_network_bridge cs564-1
docker network connect sem564_network_bridge studio564-1
docker network connect sem564_network_bridge rs564-1
docker network connect sem564_network_bridge ml11-1 

