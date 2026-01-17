.PHONY: generate clean get swagger

generate:
	dart run build_runner build --delete-conflicting-outputs

clean:
	dart run build_runner clean
	flutter clean
	flutter pub get

get:
	flutter pub get

swagger:
	curl -o swagger/coffeecard_api_v1.json https://core.dev.analogio.dk/swagger/v1/swagger.json
	curl -o swagger/coffeecard_api_v2.json https://core.dev.analogio.dk/swagger/v2/swagger.json
