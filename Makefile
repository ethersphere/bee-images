BEE_VERSION ?= "0.5.3"
COMMIT ?= "$(shell git describe --long --dirty --always --match "" || true)"
IMAGES ?= $$(ls -1 images)

.PHONY: all
all: build publish

.PHONY: build
build:
	for image in $(IMAGES); do \
        docker build -t docker.pkg.github.com/ethersphere/bee-images/$$image:$(BEE_VERSION)-$(COMMIT) --build-arg VERSION=$(BEE_VERSION) images/$$image -f $$PWD/Dockerfile ; \
		docker tag docker.pkg.github.com/ethersphere/bee-images/$$image:$(BEE_VERSION)-$(COMMIT) docker.pkg.github.com/ethersphere/bee-images/$$image:latest ; \
    done

.PHONY: publish
publish:
	for image in $(IMAGES); do \
		docker push docker.pkg.github.com/ethersphere/bee-images/$$image:latest ; \
        docker push docker.pkg.github.com/ethersphere/bee-images/$$image:$(BEE_VERSION)-$(COMMIT) ; \
    done
