build:
	cd wit-bindgen && moon build --target wasm
	wasm-tools component embed wit wit-bindgen/target/wasm/release/build/gen/gen.wasm -o wit-bindgen/target/wasm/release/build/gen/gen.wasm --encoding utf16
	wasm-tools component new wit-bindgen/target/wasm/release/build/gen/gen.wasm -o wit-bindgen/target/wasm/release/build/gen/gen.wasm	

wit-build:
	@if [ ! -d "tmp" ]; then \
		mkdir -p tmp/wit-bindgen/gen/interface/wasi/cli; \
	fi
	cp -r wit-bindgen/gen/interface/wasi/cli/run ./tmp/wit-bindgen/gen/interface/wasi/cli
	cp wit-bindgen/moon.mod.json ./tmp/wit-bindgen/moon.mod.json
	wit-deps
	wit-bindgen moonbit wit --derive-show --derive-eq --out-dir wit-bindgen
	cp -r ./tmp/wit-bindgen/gen/interface/wasi/cli/run wit-bindgen/gen/interface/wasi/cli
	cp ./tmp/wit-bindgen/moon.mod.json wit-bindgen/moon.mod.json 
	rm -rf tmp


.PHONY: run
run: build
	wasmtime run wit-bindgen/target/wasm/release/build/gen/gen.wasm < LICENSE

build-protoc-gen-mbt:
	cd protoc-gen-mbt && go build .

clone-mbt-protoc:
	mkdir .git
	git clone git@github.com:moonbit-community/protoc-gen-mbt.git

test-run-sqlcgen: build
	rm -rf sqlc/gen
	cd sqlc && sqlc generate