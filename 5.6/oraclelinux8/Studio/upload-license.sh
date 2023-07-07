#!/bin/bash

#
# login and get JSESSIONID in cookie jar
#

curl -X POST \
  -H "Accept: application/json" \
  -c cookies_file \
  -d "j_username=SuperAdministrator" \
  -d "j_password=admin" \
  "http://localhost:5080/api/session/login"

#
# upload license file
#

curl -v \
  -b cookies_file \
  --form "file=@licence;type=text/plain" \
  "http://localhost:5080/api/license"


