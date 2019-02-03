build:
	@docker build -t warpigg/ami-awscodebuild-alpine:$(version) .
run:
	@docker run --name=ami-awscodebuild-alpine -d warpigg/ami-awscodebuild-alpine:$(version) --entry-point "/bin/sh"
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
buildpushreg:
	@aws ecr get-login --no-include-email --profile hostingdemo-fulladmin | bash
	@docker build -t $(uri):$(version) .
	@docker push $(uri)
