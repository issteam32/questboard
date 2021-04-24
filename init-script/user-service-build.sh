#build user service
BYellow='\033[1;33m'
Color_Off='\033[0m'

if [[ $1 == "local-build" ]]
then
  echo -e "[${BYellow}BUILD-MESSAGE${Color_Off}] --- setting temporary env value ---"
  export USERSVC_DB_HOST=mysql-userdb
  export USERSVC_DB_PORT=3306
  export USERSVC_DB_USER=appuser
  export USERSVC_DB_PASSWORD=password
  export USERSVC_DB_DATABASE=userdb
  export OAUTH2SERVER_JWKURI=http://192.168.49.1:8090/auth/realms/Questboard/protocol/openid-connect/certs
  export KEYCLOAK_URI=http://192.168.49.1:8090/auth
  export KEYCLOAK_REALM=Questboard
  export KEYCLOAK_ADMIN_USERNAME=admin
  export KEYCLOAK_ADMIN_PASSWORD=password
fi

cd $PWD/user.service
echo -e "[${BYellow}BUILD-MESSAGE${Color_Off}] --- building user service ---"

mvn clean
if [ $1 == "skip-test" ]
then
  mvn package -DskipTests spring-boot:repackage
else
  mvn package spring-boot:repackage
fi

if [[ $1 == "local-build" ]]
then
  echo -e "[${BYellow}BUILD-MESSAGE${Color_Off}] --- remove temporary env value ---"
  unset USERSVC_DB_HOST
  unset USERSVC_DB_PORT
  unset USERSVC_DB_USER
  unset USERSVC_DB_PASSWORD
  unset USERSVC_DB_DATABASE
  unset OAUTH2SERVER_JWKURI
  unset KEYCLOAK_URI
  unset KEYCLOAK_REALM
  unset KEYCLOAK_ADMIN_USERNAME
  unset KEYCLOAK_ADMIN_PASSWORD
fi

echo -e "[${BYellow}BUILD-MESSAGE${Color_Off}] --- user service built success ---"
