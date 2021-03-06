#!/usr/bin/env bash
set -e

zip testLambda.zip index.js  > /dev/null

json_response="$(aws lambda create-function --function-name nodeTest --zip-file fileb://testLambda.zip \
    --handler index.handler \
    --runtime nodejs12.x --role arn:aws:iam::${ACCOUNT_ID}:role/lambda-cli-role --timeout 30 )"

echo "$(python2 -c "import sys, json; print json.load(sys.stdin)['FunctionArn'] " <<< "${json_response}")"
