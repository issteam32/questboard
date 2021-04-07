#build user service
BYellow='\033[1;33m'
Color_Off='\033[0m'

echo -e "[${BYellow}BUILD-MESSAGE${Color_Off}] --- setting temporary env value ---"

if [ $1 == "local-build" ]
then
  export USERSVC_DB_HOST=mysql-userdb
  export USERSVC_DB_PORT=3306
  export USERSVC_DB_USER=appuser
  export USERSVC_DB_PASSWORD=password
  export USERSVC_DB_DATABASE=userdb
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

echo -e "[${BYellow}BUILD-MESSAGE${Color_Off}] --- remove temporary env value ---"

if [ $1 == "local-build" ]
then
  unset USERSVC_DB_HOST
  unset USERSVC_DB_PORT
  unset USERSVC_DB_USER
  unset USERSVC_DB_PASSWORD
  unset USERSVC_DB_DATABASE
fi

echo -e "[${BYellow}BUILD-MESSAGE${Color_Off}] --- user service built success ---"
