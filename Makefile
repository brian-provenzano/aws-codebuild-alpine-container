remove=0.1
old_version := $(shell echo "scale=2; ${version} - ${remove}" | bc)
build:
	@docker build -t warpigg/ami-awscodebuild-alpine:$(version) .
tag:
	@docker tag warpigg/ami-awscodebuild-alpine:$(version) 680991002562.dkr.ecr.us-west-2.amazonaws.com/brian-provenzano:$(version)
push:
	@aws ecr get-login --no-include-email --profile hostingdemo-fulladmin | bash
	@docker push 680991002562.dkr.ecr.us-west-2.amazonaws.com/brian-provenzano:$(version)
	aws ecr batch-delete-image --repository-name brian-provenzano --image-ids imageTag=$(old_version) --profile hostingdemo-fulladmin
start:
	@docker container start ami-awscodebuild-alpine
stop:
	@docker container stop ami-awscodebuild-alpine
show:
	@docker container ls
logs: 
	@docker logs ami-awscodebuild-alpine
cli:
	@docker container exec -it -u root ami-awscodebuild-alpine /bin/sh
prune:
	@docker volume prune
clean:	stop
	@docker container rm ami-awscodebuild-alpine
cleanall: clean prune
test:
	@echo $(old_version)

