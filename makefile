MAKEFLAGS+=--ignore-errors
MAKEFLAGS+=--no-print-directory
SHELL:=/bin/bash

.PHONY: clean
.PHONY: build
.PHONY: run

clean:
	/usr/bin/docker rm --force $$(/usr/bin/docker ps --all --quiet)
	/usr/bin/docker ps --all
	/usr/bin/docker rmi --force $$(/usr/bin/docker images | /usr/bin/grep "^<none>" | /usr/bin/awk "{print $$3}")
	/usr/bin/docker images
	/usr/bin/docker container prune --force
	/usr/bin/docker image prune --force
	/usr/bin/docker system prune --force

build:
	/usr/bin/docker build --tag centos-webpanel .


run:
	/usr/bin/docker run \
		--attach stdin \
		--attach stdout \
		--interactive \
		--privileged \
		--hostname "172.17.0.2" \
		--tty \
		centos-webpanel
