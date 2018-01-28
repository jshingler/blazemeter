#!/bin/bash
#set -x


source ./bm_api.sh

ENV=${1:-dev}
function prop {
    grep "${1}" ./${ENV}.properties|cut -d'=' -f2
}

TEST_ID=$(prop 'TEST_ID')
APIKEY=$(prop 'APIKEY')

userInfo=$(userInfo)
echo $userInfo  | jq '. | {api: .api_version, firstName: .result.firstName}'

# =======================================
# Start Tests
# =======================================
echo "Start Test: "
#testInfo=$(startTest ${TEST_ID})
#testID=`echo $testInfo | jq .result.id`
#echo "TestID = ${testID}"
#sleep 4



test=17192939
waitForTest $test

getJUnitReport $test
