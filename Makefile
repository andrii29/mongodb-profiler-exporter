.PHONY: build run

IMAGE_NAME = mongodb-profiler-exporter
IMAGE_VERSION = latest

docker-build:
	docker build -t $(IMAGE_NAME):$(IMAGE_VERSION) .

docker-run:
	docker run -p 9179:9179 -e MAX_STRING_SIZE=15 --network host --rm --name $(IMAGE_NAME) $(IMAGE_NAME):$(IMAGE_VERSION)
