FVM ?= fvm
FLUTTER ?= $(FVM) flutter
DART ?= $(FVM) dart

.PHONY: help setup check-flutter check upgrade-deps api api-check api-update clean get swagger coverage fix

.DEFAULT_GOAL := help

help: ## Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

# Runs before every Flutter/Dart target so a missing command fails with a hint
# instead of "command not found".
check-flutter:
	@command -v $(firstword $(FLUTTER)) >/dev/null 2>&1 || { \
		echo "'$(FLUTTER)' not found: Flutter is managed by FVM here (see .fvmrc)."; \
		echo "Install it (https://fvm.app) and run 'make setup'."; \
		exit 1; \
	}

setup: check-flutter ## Install the pinned Flutter SDK (fvm) and fetch dependencies
	$(FVM) install
	$(FLUTTER) pub get

upgrade-deps: check-flutter ## Upgrade all dependencies to latest versions
	$(FLUTTER) pub upgrade --major-versions

api: check-flutter ## Generate the Tonik API client from the committed v2 spec
	$(DART) run tonik --package-name=analog_api --spec=swagger/coffeecard_api_v2.json --output-dir=packages --backend=dio --overwrite
	$(DART) format packages/analog_api/lib

api-check: api ## Regenerate the client and fail if the committed output drifted
	@if ! git diff --quiet -- packages/analog_api || [ -n "$$(git ls-files --others --exclude-standard packages/analog_api)" ]; then \
		echo "Generated API client is out of date. Run 'make api' and commit the result."; \
		git status --short -- packages/analog_api; \
		exit 1; \
	fi

api-update: swagger api ## Fetch the latest v2 spec, then regenerate the client

clean: check-flutter ## Clean build artifacts and reset dependencies
	$(FLUTTER) clean
	$(FLUTTER) pub get

get: check-flutter ## Get dependencies
	$(FLUTTER) pub get

swagger: ## Fetch the latest v2 OpenAPI spec
	curl -o swagger/coffeecard_api_v2.json https://core.dev.analogio.dk/swagger/v2/swagger.json

coverage: check-flutter ## Run tests with coverage and generate report
	$(FLUTTER) test --coverage
	genhtml coverage/lcov.info -o coverage/html

check: check-flutter ## Run the checks CI runs (format, analyze, tests)
	$(DART) format --set-exit-if-changed --output=none lib test
	$(FLUTTER) analyze lib test
	$(FLUTTER) test

fix: check-flutter ## Format code and fix issues that can be fixed automatically
	$(DART) format .
	$(DART) fix --apply
