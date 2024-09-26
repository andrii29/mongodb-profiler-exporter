.PHONY: build run

IMAGE_NAME = mongodb-profiler-exporter
IMAGE_VERSION = latest

IMAGE_DOCKERHUB = andriik/$(IMAGE_NAME)

# dockerhub
docker-build-dockerhub:
	docker build -t $(IMAGE_DOCKERHUB):$(IMAGE_VERSION) .
docker-run:
	docker run -p 9179:9179 -e MAX_STRING_SIZE=200 -e VERBOSE=true -e MONGODB_URI='mongodb://127.0.0.1:27017/' --network host --rm --name $(IMAGE_NAME) $(IMAGE_DOCKERHUB):$(IMAGE_VERSION)
