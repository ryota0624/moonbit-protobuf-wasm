build:
	cd bindgen && moon build --target wasm
	wasm-tools component embed wit bindgen/target/wasm/release/build/gen/gen.wasm -o bindgen/target/wasm/release/build/gen/gen.wasm --encoding utf16
	wasm-tools component new bindgen/target/wasm/release/build/gen/gen.wasm -o bindgen/target/wasm/release/build/gen/gen.wasm	

wit-build:
	@if [ ! -d "tmp" ]; then \
		mkdir -p tmp/bindgen/gen/interface/wasi/cli; \
	fi
	cp -r bindgen/gen/interface/wasi/cli/run ./tmp/bindgen/gen/interface/wasi/cli
	wit-deps
	wit-bindgen moonbit wit --derive-show --derive-eq --out-dir bindgen
	cp -r ./tmp/bindgen/gen/interface/wasi/cli/run bindgen/gen/interface/wasi/cli 
	rm -rf tmp


.PHONY: run
run: build
	wasmtime run bindgen/target/wasm/release/build/gen/gen.wasm < LICENSE

build-protoc-gen-mbt:
	cd .bin/protoc-gen-mbt && go build .