#!/bin/bash

# configure Marklogic service in environment
# cookies_file created in upload-license.sh

# fetch environment

curl -v -b cookies_file \
  -X POST \
  -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -d '{"query":"{environments {uri label}}\n","variables":null,"operationName":null}' \
  "http://localhost:5080/api/graphql" | jq -r ".data.environments[0].uri" > envUri

envURI=`cat envUri`
echo "Environment url: $envURI"

#
# generate uuid for the new service
#

uuid=`uuidgen | awk '{print tolower($0)}'`
serviceUUID="urn:uuid:$uuid"

#
# create JSON payload for graphQL request
# 

read -r -d '' createPayloadJson << EOF
{
    "operationName": "CreateMarkLogicService",
    "variables": {
        "uri": "$serviceUUID",
        "name": "ml",
        "description": "ml",
        "link1Name": "Service Apps URL",
        "link1Url": "http://ml11-1:8000",
        "link1IconName": "database-search",
        "link2Name": "Admin URL",
        "link2Url": "http://ml11-1:8001",
        "link2IconName": "monitor-dashboard",
        "link3Name": "Manage URL",
        "link3Url": "http://ml11-1:8002",
        "link3IconName": "chart-box-outline",
        "environmentUri": "$envURI"
    },
    "query": "mutation CreateMarkLogicService(\$uri: ID, \$name: String, \$description: String, \$environmentUri: ID, \$link1Name: String, \$link1Url: String, \$link1IconName: String, \$link2Name: String, \$link2Url: String, \$link2IconName: String, \$link3Name: String, \$link3Url: String, \$link3IconName: String) {\n  createMarklogicService(\n    input: {uri: \$uri, name: \$name, description: \$description, environment: {uri: \$environmentUri}, links: [{name: \$link1Name, url: \$link1Url, priority: 1, default: true, iconName: \$link1IconName}, {name: \$link2Name, url: \$link2Url, priority: 2, default: true, iconName: \$link2IconName}, {name: \$link3Name, url: \$link3Url, priority: 3, default: true, iconName: \$link3IconName}]}\n  )\n  report {\n    addedCount\n    __typename\n  }\n  commit(message: \"Add Marklogic Service\")\n}"
}
EOF

echo "payload: $createPayloadJson"

#
# add Marklogic instance API call
#

curl -v -b cookies_file \
  -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -d "$createPayloadJson" \
  "http://localhost:5080/api/graphql"
