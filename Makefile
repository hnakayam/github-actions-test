# note: build docker image using Ubuntu 18.04 or newer
# requires docker engine and required components
# see https://docs.docker.com/engine/install/ubuntu/

#include $(FBDIR)/configs/$(CONFIGLIST)

#VERSION=$(fbdockerimgversion)
#REPO=$(fbdockerrepo)

# replace REPO for your docker HUB path or equivalents
REPO=hnakayam/fbubuntu
VERSION=18.04

build:
	@if [ -n "$(http_proxy)" -o -n "$(https_proxy)" ]; then \
	     if [ -z "$(http_proxy)" -o -z "$(https_proxy)" -o -z "$(no_proxy)" ]; then \
		 echo Please set http_proxy, https_proxy and no_proxy ! && exit 1; \
	     fi; \
	     docker build -t $(REPO):$(VERSION) --build-arg http_proxy=$(http_proxy) --network host \
	                  --build-arg https_proxy=$(https_proxy) --build-arg no_proxy=$(no_proxy) . ; \
	 else \
	     docker build -t $(REPO):$(VERSION) --network host . ; \
	 fi
