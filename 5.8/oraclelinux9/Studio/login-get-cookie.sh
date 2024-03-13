#!/bin/bash

#
# login and get JSESSIONID in cookie jar
#

curl -X POST \
  -H "Accept: application/json" \
  -c cookies_file \
  -d "j_username=${SEMAPHORE_ADMIN_USERNAME}" \
  -d "j_password=${SEMAPHORE_ADMIN_PASSWORD}" \
  "http://localhost:5080/api/session/login"

