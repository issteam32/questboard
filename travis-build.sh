#deploy using skaffold
echo -e "[DEPLOY-MESSAGE] --- running travis build ---"

./init-script/user-service-build.sh
cd ./user.service
docker build -t issteam32/user-service -f Dockerfile.prod .

cd -

./init-script/quest-service-build.sh
cd ./quest.service/
docker build -t issteam32/quest-service -f Dockerfile.prod .

cd -

./init-script/chat-service-build.sh
cd ./ChatWebSocket/
docker build -t issteam32/chat-service -f Dockerfile.prod .

cd -

echo -e "[DEPLOY-MESSAGE] --- done ---"