echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker push $DOCKER_REPO/user-service
docker push $DOCKER_REPO/quest-service
docker push $DOCKER_REPO/chat-service