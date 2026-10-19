# Detect OS for cross-platform sed compatibility
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
	SED_INPLACE := sed -i '' -E
else
	SED_INPLACE := sed -i -E
endif

.PHONY: help upgrade-flutter upgrade-deps generate gen clean get swagger coverage fix

.DEFAULT_GOAL := help

help: ## Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

upgrade-flutter: ## Upgrade Flutter/Dart and pin versions in config files
	flutter upgrade
	@set -eu; \
	flutter_version=$$(flutter --version | awk 'NR == 1 { print $$2 }'); \
	dart_version=$$(dart --version 2>&1 | awk '{print $$4}'); \
	if [ -z "$$flutter_version" ] || [ -z "$$dart_version" ]; then \
		echo "Failed to detect Flutter/Dart versions"; \
		exit 1; \
	fi; \
	echo "Updating Flutter version to $$flutter_version and Dart version to $$dart_version"; \
	awk -v flutter_version="$$flutter_version" -v dart_version="$$dart_version" '\
		BEGIN { in_environment = 0 } \
		/^environment:/ { in_environment = 1; print; next } \
		in_environment && /^[^[:space:]]/ { in_environment = 0 } \
		in_environment && /^  sdk:/ { print "  sdk: ^" dart_version; next } \
		in_environment && /^  flutter:/ { print "  flutter: " flutter_version; next } \
		{ print } \
	' pubspec.yaml > pubspec.yaml.tmp; \
	mv pubspec.yaml.tmp pubspec.yaml; \
	$(SED_INPLACE) "s/^([[:space:]]*flutter_version:).*/\\1 $$flutter_version/" .github/workflows/main.yaml
	flutter pub get

upgrade-deps: ## Upgrade all dependencies to latest versions
	flutter pub upgrade --major-versions

generate: ## Run build_runner to generate code
	dart run build_runner build

gen: ## Alias for generate
	dart run build_runner build

clean: ## Clean build artifacts and reset dependencies
	dart run build_runner clean
	flutter clean
	flutter pub get

get: ## Get dependencies
	flutter pub get

swagger: ## Fetch latest Swagger API specs
	curl -o swagger/coffeecard_api_v1.json https://core.dev.analogio.dk/swagger/v1/swagger.json
	curl -o swagger/coffeecard_api_v2.json https://core.dev.analogio.dk/swagger/v2/swagger.json

coverage: ## Run tests with coverage and generate report
	flutter test --coverage
	genhtml coverage/lcov.info -o coverage/html

fix: ## Format code and fix issues that can be fixed automatically
	dart format .
	dart fix --apply
