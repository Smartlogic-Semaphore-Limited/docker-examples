
#
# add SemaphoreSuperAdministrators permissions to publish to environment
#

curl -v -b cookies_file \
  -X POST \
  -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -d '{"query":"{environments {uri label}}\n","variables":null,"operationName":null}' \
  "http://localhost:5080/api/graphql" | jq -r ".data.environments[0].uri" > envUri

envURI=`cat envUri`
echo "Environment url: $envURI"


#
# create JSON payload for graphQL query
#
read -r -d '' addPermissionPayloadJson << EOF
{
    "operationName": "UpdateEnvironmentPermissionsMutation",
    "variables": {
        "uri": "$envURI",
        "removePublishers": [],
        "removeAdministrators": [],
        "addPublishers": [],
        "addAdministrators": [
            {
                "uri": "http://www.smartlogic.com/2019/08/studio/role/SemaphoreSuperAdministrators"
            },
            {
                "uri": "http://www.smartlogic.com/2019/08/studio/role/SemaphoreAdministrators"
            }
        ]
    },
    "query": "mutation UpdateEnvironmentPermissionsMutation(\$uri: ID!, \$removePublishers: [RDFNode]!, \$removeAdministrators: [RDFNode]!, \$addPublishers: [Authorizable_Input], \$addAdministrators: [Authorizable_Input]) {\n  deletePublishers: deleteValues(\n    resource: \$uri\n    predicate: \"http://www.smartlogic.com/2019/08/studio/publisher\"\n    values: \$removePublishers\n  )\n  deleteAdministrators: deleteValues(\n    resource: \$uri\n    predicate: \"http://www.smartlogic.com/2019/08/studio/administrator\"\n    values: \$removeAdministrators\n  )\n  addToEnvironment(\n    input: {uri: \$uri, publisher: \$addPublishers, administrator: \$addAdministrators}\n  )\n  report {\n    addedCount\n    deletedCount\n    __typename\n  }\n  commit\n}"
}
EOF

echo "add permission payload: $addPermissionPayloadJson"

#
# add permssion API call
#

curl -v -b cookies_file \
  -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -d "$addPermissionPayloadJson" \
  "http://localhost:5080/api/graphql"



