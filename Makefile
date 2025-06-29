build:
	cd bindgen && moon build --target wasm
	wasm-tools component embed wit bindgen/target/wasm/release/build/gen/gen.wasm -o bindgen/target/wasm/release/build/gen/gen.wasm --encoding utf16
	wasm-tools component new bindgen/target/wasm/release/build/gen/gen.wasm -o bindgen/target/wasm/release/build/gen/gen.wasm	

wit-build:
	wit-deps
	@if [ ! -d "bindgen" ]; then \
		wit-bindgen moonbit wit --derive-show --derive-eq --out-dir bindgen; \
	fi

.PHONY: run
run: build
	wasmtime run bindgen/target/wasm/release/build/gen/gen.wasm