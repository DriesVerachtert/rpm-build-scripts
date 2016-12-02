NAME=driesrpms/centos-6-x86_64-scl-tested
VERSION=0.0.1

.PHONY: all build tag_latest

all: build tag_latest

build:
	cp -f ../common/curlrc .
	cp -f ../common/rpmmacros .
	cp -f ../common/local.repo .
	docker build --no-cache=true -t $(NAME):$(VERSION) --rm .
	rm -f curlrc rpmmacros local.repo

tag_latest:
	docker tag $(NAME):$(VERSION) $(NAME):latest

run:
	docker run -ti $(NAME):$(VERSION)
