buf-generate:
	buf generate

.PHONY: build-p1
build-p1:
	buf generate
	cd sqlc/plugin/wasm-p1 && moon build --target wasm

build-protoc-gen-mbt:
	cd protoc-gen-mbt && moon build -C cli

clone-mbt-protoc:
	mkdir .git
	git clone git@github.com:moonbit-community/protoc-gen-mbt.git

test-run-sqlcgen-p1: build-p1
	rm -rf sqlc/sqlitegen-p1
	cd sqlc && sqlc generate
