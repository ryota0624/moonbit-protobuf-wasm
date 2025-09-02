#!/bin/sh
../.devbox/nix/profile/default/bin/wasmtime run plugin/wasm-p1/target/wasm/release/build/sqlc-plugin-wasm-p1.wasm <&0 2>&2