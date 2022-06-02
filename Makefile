help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build-build-container: ## Create the build container
	@docker build -t arch-pkgbuilds:latest .

build-tcpbutcher: build-build-container ## Build tcpbutcher
	@docker run -it arch-pkgbuilds:latest tcpbutcher

build-test-package: build-build-container ## Build test-package
	@docker run -it arch-pkgbuilds:latest test-package

