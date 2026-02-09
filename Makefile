# Detect OS for cross-platform sed compatibility
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
	SED_INPLACE := sed -i '' -E
else
	SED_INPLACE := sed -i -E
endif

.PHONY: help upgrade generate clean get swagger coverage fix

.DEFAULT_GOAL := help

help: ## Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

upgrade: ## Upgrade Flutter/Dart and pin versions in config files
	flutter upgrade
	$(eval FLUTTER_VERSION := $(shell flutter --version | head -1 | awk '{print $$2}'))
	$(eval DART_VERSION := $(shell dart --version 2>&1 | awk '{print $$4}'))
	@echo "Updating Flutter version to $(FLUTTER_VERSION) and Dart version to $(DART_VERSION)"
	$(SED_INPLACE) 's/flutter: [0-9.]+/flutter: $(FLUTTER_VERSION)/' pubspec.yaml
	$(SED_INPLACE) 's/sdk: \^[0-9.]+/sdk: ^$(DART_VERSION)/' pubspec.yaml
	$(SED_INPLACE) 's/flutter_version: [0-9.]+/flutter_version: $(FLUTTER_VERSION)/' .github/workflows/main.yaml
	flutter pub get

generate: ## Run build_runner to generate code
	dart run build_runner build --delete-conflicting-outputs

clean: ## Clean build artifacts and reset dependencies
	dart run build_runner clean
	flutter clean
	flutter pub get

get: ## Get dependencies
	flutter pub get

swagger: ## Fetch latest Swagger API specs
	curl -o swagger/coffeecard_api_v1.json https://core.dev.analogio.dk/swagger/v1/swagger.json
	curl -o swagger/coffeecard_api_v2.json https://core.dev.analogio.dk/swagger/v2/swagger.json

fix: ## Format code and fix issues that can be fixed automatically
	dart format .
	dart fix --apply
