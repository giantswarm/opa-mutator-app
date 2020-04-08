#!/bin/bash

echo "Rules Coverage"
opa test -c -f=pretty . | jq -r '.files | keys[] as $k | select($k | contains("rules")) | "\($k)\t\t\(.[$k] | .coverage)%"'