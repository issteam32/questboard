#build user service
BYellow='\033[1;33m'
Color_Off='\033[0m'

cd $PWD/quest.service
echo -e "[${BYellow}BUILD-MESSAGE${Color_Off}] --- building quest service ---"

mvn clean
if [ $1 == "skip-test" ]
then
  mvn package -DskipTests spring-boot:repackage
else
  mvn package spring-boot:repackage
fi

echo -e "[${BYellow}BUILD-MESSAGE${Color_Off}] --- quest service built success ---"
