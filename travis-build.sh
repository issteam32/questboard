#deploy using skaffold
echo -e "[DEPLOY-MESSAGE] --- running travis build ---"

./init-script/user-service-build.sh
cd ./user.service
docker build -t issteam32/user-service -f Dockerfile.prod .

#./init-script/quest-service-build.sh
#docker build -t issteam32/quest-service -f ./quest.service/Dockerfile .
#
#./init-script/chat-service-build.sh
#docker build -t issteam32/chat-service -f ./ChatWebsocket/Dockerfile .

echo -e "[DEPLOY-MESSAGE] --- done ---"