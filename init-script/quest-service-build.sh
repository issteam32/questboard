#build user service
BYellow='\033[1;33m'
Color_Off='\033[0m'

echo -e "[${BYellow}BUILD-MESSAGE${Color_Off}] --- setting temporary env value ---"

if [ $1 == "local-build" ]
then
  export QUESTSVC_DB_HOST=mysql-questdb
  export QUESTSVC_DB_PORT=3306
  export QUESTSVC_DB_USER=appuser
  export QUESTSVC_DB_PASSWORD=password
  export QUESTSVC_DB_DATABASE=questdb
fi

cd $PWD/quest.service
echo -e "[${BYellow}BUILD-MESSAGE${Color_Off}] --- building quest service ---"

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
  unset QUESTSVC_DB_HOST
  unset QUESTSVC_DB_PORT
  unset QUESTSVC_DB_USER
  unset QUESTSVC_DB_PASSWORD
  unset QUESTSVC_DB_DATABASE
fi

echo -e "[${BYellow}BUILD-MESSAGE${Color_Off}] --- quest service built success ---"
