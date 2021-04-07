echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker push issteam32/user-service
docker push issteam32/quest-service
docker push issteam32/chat-service