#!/bin/sh
../.devbox/nix/profile/default/bin/wasmtime run ../wit-bindgen/target/wasm/release/build/gen/gen.wasm <&0 2>&2