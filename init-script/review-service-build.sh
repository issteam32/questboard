#build user service
BYellow='\033[1;33m'
Color_Off='\033[0m'

cd $PWD/review.service
echo -e "[${BYellow}BUILD-MESSAGE${Color_Off}] --- building demo service ---"

mvn clean
mvn package -DskipTests spring-boot:repackage


echo -e "[${BYellow}BUILD-MESSAGE${Color_Off}] --- demo service built success ---"
