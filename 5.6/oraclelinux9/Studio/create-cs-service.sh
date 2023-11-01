#!/bin/bash

# configure SES in environment
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

# configure CS service

csURL="http://localhost:5058/"
echo "CS URL: $csURL"

csLocalURL="http://cs564-1:5058/"
echo "CS Local URL: $csLocalURL"

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
    "operationName": "CreateClassificationService",
    "variables": {
        "uri": "$serviceUUID",
        "name": "CS",
        "description": "CS",
        "url": "$csURL",
        "localUrl": "$csLocalURL",
        "environmentUri": "$envURI",
        "cloudApiKey": "",
        "cloudTokenUrl": "",
        "isCloudConfigured": false
    },
    "query": "mutation CreateClassificationService(\$uri: ID, \$name: String, \$description: String, \$url: String, \$localUrl: String, \$environmentUri: ID, \$cloudApiKey: String, \$cloudTokenUrl: String, \$isCloudConfigured: Boolean) {\n  createClassificationService(\n    input: {uri: \$uri, name: \$name, description: \$description, url: \$url, localUrl: \$localUrl, environment: {uri: \$environmentUri}, cloudApiKey: \$cloudApiKey, cloudTokenUrl: \$cloudTokenUrl, isCloudConfigured: \$isCloudConfigured}\n  )\n  report {\n    addedCount\n    deletedCount\n    __typename\n  }\n  commit(message: \"Done\")\n}"
}
EOF

echo "payload: $createPayloadJson"

#
# add ClassificationServices instance API call
#

curl -v -b cookies_file \
  -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -d "$createPayloadJson" \
  "http://localhost:5080/api/graphql"
