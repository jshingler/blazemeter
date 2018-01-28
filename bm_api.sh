# ============================================
# BlazeMeter API
#
# Swagger Doc: https://a.blazemeter.com/api/v4/explorer/
#
# https://guide.blazemeter.com/hc/en-us/articles/206732689-BlazeMeter-REST-APIs-BlazeMeter-REST-APIs
#
# ============================================

BM_API_URL=https://a.blazemeter.com:443/api/latest

# ============================================
function test_func() {
  #statements
  echo "BM_API_URL = $BM_API_URL"
}
function userInfo() {
  #statements
  local __return=`curl -s ${BM_API_URL}/user --user ${APIKEY}`
  echo $__return
}

# ============================================
# https://a.blazemeter.com/api/v4/tests/testID/start
function startTest {
  local __return=`curl -s -X POST ${BM_API_URL}/${1}/start  -H "Content-Type: application/json" --user ${APIKEY}`
  echo $__return
}

# ============================================
# id comes from startTest output
# GET request to 'https://a.blazemeter.com/api/v4/masters/{masterId}/status?events=false'
function testStatus {
  id=${1}
  local __return=`curl -s -X get ${BM_API_URL}/masters/${1}/status?events=false --user ${APIKEY}`
  echo $__return
}

# ============================================
# /api/v4/masters/%s/reports/thresholds?format=junit
function getJUnitReport {
  id=${1}
  local __return=`curl -s -X get ${BM_API_URL}/masters/${1}/reports/thresholds?format=junit --user ${APIKEY}`
  echo $__return
}

function waitForTest {
  testID=$1
  # =======================================
  # Check Tests Status
  # =======================================
  echo "Check Test: ${testID} Status"
  while true :
  do
      #Check Test Status
      testStatusInfo=$(testStatus ${testID})
      testStatus=`echo $testStatusInfo | jq .result.status`
      #echo "testStatus == >>${testStatus}<<"

      if [ '"ENDED"' == "${testStatus}" ]
      then
        echo =======================================
        echo "testStatus=${testStatus}"
        break
      else
        echo -n "."
        sleep 10
      fi
  done
}

