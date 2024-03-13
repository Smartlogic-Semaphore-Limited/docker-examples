#!/bin/bash

# configure Concepts Service in environment
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
    "operationName": "CreateConceptsService",
    "variables": {
        "uri": "$serviceUUID",
        "name": "Concepts",
        "description": "Concepts Service",
        "url": "http://localhost:5092",
        "localUrl": "http://cons580-1:5092",
        "environmentUri": "$envURI",
        "cloudApiKey": "",
        "cloudTokenUrl": "",
        "isCloudConfigured": false
    },
    "query": "mutation CreateConceptsService(\$uri: ID, \$name: String, \$description: String, \$url: String, \$localUrl: String, \$environmentUri: ID, \$cloudApiKey: String, \$cloudTokenUrl: String, \$isCloudConfigured: Boolean) {\n  createConceptsService(\n    input: {uri: \$uri, name: \$name, description: \$description, url: \$url, localUrl: \$localUrl, environment: {uri: \$environmentUri}, cloudApiKey: \$cloudApiKey, cloudTokenUrl: \$cloudTokenUrl, isCloudConfigured: \$isCloudConfigured}\n  )\n  report {\n    addedCount\n    deletedCount\n    __typename\n  }\n  commit(message: \"Done\")\n}"
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
