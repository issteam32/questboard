#build user service
BYellow='\033[1;33m'
Color_Off='\033[0m'

if [ $1 == "local-build" ]
then
  export REVIEWSVC_DB_HOST=mysql-reviewdb
  export REVIEWSVC_DB_PORT=3306
  export REVIEWSVC_DB_USER=appuser
  export REVIEWSVC_DB_PASSWORD=password
  export REVIEWSVC_DB_DATABASE=reviewdb
fi
cd $PWD/review.service
echo -e "[${BYellow}BUILD-MESSAGE${Color_Off}] --- building review service ---"

mvn clean
mvn package -DskipTests spring-boot:repackage

if [ $1 == "local-build" ]
then
  unset REVIEWSVC_DB_HOST
  unset REVIEWSVC_DB_PORT
  unset REVIEWSVC_DB_USER
  unset REVIEWSVC_DB_PASSWORD
  unset REVIEWSVC_DB_DATABASE
fi

echo -e "[${BYellow}BUILD-MESSAGE${Color_Off}] --- review service built success ---"
