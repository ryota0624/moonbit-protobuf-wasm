# ryota0624/protobuf-wasm

# Setup
cargo install wit-bindgen-cli
cargo install wit-deps-cli

# build

wit-deps
wit-bindgen moonbit wit --derive-show --derive-eq --out-dir .
moon build --target wasm
wasm-tools component embed wit target/wasm/release/build/gen/gen.wasm -o target/wasm/release/build/gen/gen.wasm --encoding utf16 & wasm-tools component new target/wasm/release/build/gen/gen.wasm -o target/wasm/release/build/gen/gen.wasm

wasmtime run target/wasm/release/build/gen/gen.wasm


---
jco transpile wit-bindgen/target/wasm/release/build/gen/gen.wasm -o out-dir

node app.js <<EOF                                                                                    
Works
EOF