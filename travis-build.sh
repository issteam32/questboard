#deploy using skaffold
BYellow='\033[1;33m'
Color_Off='\033[0m'

echo -e "[${BYellow}DEPLOY-MESSAGE${Color_Off}] --- running travis build ---"

./init-script/user-service-build.sh
docker build -t issteam32/user-service -f ./user.service/Dockerfile .

echo -e "[${BYellow}DEPLOY-MESSAGE${Color_Off}] --- done ---"