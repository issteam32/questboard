#deploy using skaffold
BYellow='\033[1;33m'
Color_Off='\033[0m'

echo -e "[${BYellow}DEPLOY-MESSAGE${Color_Off}] --- running travis build ---"

./init-script/user-service-build.sh
docker build -t issteam32/user-service -f ./user.service/Dockerfile .

./init-script/quest-service-build.sh
docker build -t issteam32/quest-service -f ./quest.service/Dockerfile .

./init-script/chat-service-build.sh
docker build -t issteam32/chat-service -f ./ChatWebsocket/Dockerfile .

echo -e "[${BYellow}DEPLOY-MESSAGE${Color_Off}] --- done ---"