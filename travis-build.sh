#deploy using skaffold
echo -e "[TRAVIS-BUILD-MESSAGE] --- running travis build ---"

./init-script/user-service-build.sh
cd ./user.service
docker build -t issteam32/user-service:latest -t issteam32/user-service:$GIT_SHA -f Dockerfile.prod .

cd -

./init-script/quest-service-build.sh
cd ./quest.service/
docker build -t issteam32/quest-service:latest -t issteam32/quest-service:$GIT_SHA -f Dockerfile.prod .

cd -

./init-script/chat-service-build.sh
cd ./ChatWebSocket/
docker build -t issteam32/chat-service:latest -t issteam32/chat-service:$GIT_SHA -f Dockerfile.prod .

cd -

echo "SHA value\n"
echo $GIT_SHA

echo -e "[TRAVIS-BUILD-MESSAGE] --- done ---"