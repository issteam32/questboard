echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker push $DOCKER_REPO/user-service:latest
docker push $DOCKER_REPO/user-service:$GIT_SHA
docker push $DOCKER_REPO/quest-service:latest
docker push $DOCKER_REPO/quest-service:$GIT_SHA
docker push $DOCKER_REPO/chat-service:latest
docker push $DOCKER_REPO/chat-service:$GIT_SHA

echo "SHA value\n"
echo $GIT_SHA