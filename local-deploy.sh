#deploy using skaffold
BYellow='\033[1;33m'
Color_Off='\033[0m'

if [ $1 == "skip-test" ]
then
  ./init-script/user-service-build.sh skip-test
  ./init-script/quest-service-build.sh skip-test
#  ./init-script/chat-service-build.sh skip-test
#  ./init-script/demo-service-build.sh skip-test
else
  ./init-script/user-service-build.sh
  ./init-script/quest-service-build.sh
#  ./init-script/chat-service-build.sh
#  ./init-script/demo-service-build.sh
fi

echo -e "[${BYellow}DEPLOY-MESSAGE${Color_Off}] --- deploying using skaffold ---"

skaffold run

echo -e "[${BYellow}DEPLOY-MESSAGE${Color_Off}] --- done ---"