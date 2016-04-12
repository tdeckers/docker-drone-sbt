IMAGE_NAME=tdeckers/docker-drone-sbt
build:
	docker build -t $(IMAGE_NAME) .

login:
	docker login

push:
	docker push $(IMAGE_NAME)
