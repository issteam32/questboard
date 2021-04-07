#build user service
BYellow='\033[1;33m'
Color_Off='\033[0m'

if [[ $1 == "local-build" ]]
then
  echo -e "[${BYellow}BUILD-MESSAGE${Color_Off}] --- setting temporary env value ---"
  export MONGODB_CONNECTION_STRING=
fi

cd $PWD/ChatWebSocket
echo -e "[${BYellow}BUILD-MESSAGE${Color_Off}] --- building chat service ---"

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
  unset MONGODB_CONNECTION_STRING
fi

echo -e "[${BYellow}BUILD-MESSAGE${Color_Off}] --- chat service built success ---"
