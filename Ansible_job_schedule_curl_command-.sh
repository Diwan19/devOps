#!/bin/bash

response=$(curl -k -u "$ANSIBLE_SVC_USER":"$ANSIBLE_SVC_PASS" -H "Content-Type: application/json" -X POST \
                    -d '{
                            "name" : "'"$SCHEDULE_NAME"'",
                             "rrule": "DTSTART: '"SCHEDULE_TIME"' RRULE:FREQ=DAILY;INTERVAL=1;COUNT=1",
                             "extra_data":{
                             "some_variable1: "value1",
                             "some_variable2: "value2"
                             }
                    
                     }' \
                     "$ANSIBLE_PORTAL_URL" -s -o response.json -w "%{http_code}")
if [["response" == 201 || "response" == 202 ]]; then
    echo "ansible job scheduled successfully"
else
    echo "ERROR: ansible job not scheduled"
fi