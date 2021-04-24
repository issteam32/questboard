#build reward service
BYellow='\033[1;33m'
Color_Off='\033[0m'

if [[ $1 == "local-build" ]]
then
  export REWARDSVC_DB_HOST=mysql-rewarddb
  export REWARDSVC_DB_PORT=3306
  export REWARDSVC_DB_USER=appuser
  export REWARDSVC_DB_PASSWORD=password
  export REWARDSVC_DB_DATABASE=rewarddb
  export OAUTH2SERVER_JWKURI=http://192.168.49.1:8090/auth/realms/Questboard/protocol/openid-connect/certs
fi

cd $PWD/reward.service
echo -e "[${BYellow}BUILD-MESSAGE${Color_Off}] --- building reward service ---"

mvn clean
if [[ $1 == "skip-test" ]]
then
  mvn package -DskipTests spring-boot:repackage
else
  mvn package spring-boot:repackage
fi

if [[ $1 == "local-build" ]]
then
  unset REWARDSVC_DB_HOST
  unset REWARDSVC_DB_PORT
  unset REWARDSVC_DB_USER
  unset REWARDSVC_DB_PASSWORD
  unset REWARDSVC_DB_DATABASE
  unset OAUTH2SERVER_JWKURI
fi

echo -e "[${BYellow}BUILD-MESSAGE${Color_Off}] --- reward service built success ---"