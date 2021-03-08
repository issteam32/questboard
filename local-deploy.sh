#deploy using skaffold
BYellow='\033[1;33m'
Color_Off='\033[0m'

./user-service-build.sh

echo -e "[${BYellow}DEPLOY-MESSAGE${Color_Off}] --- deploying using skaffold ---"

skaffold run

echo -e "[${BYellow}DEPLOY-MESSAGE${Color_Off}] --- done ---"