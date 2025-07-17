# docker run --rm --runtime=io.containerd.wasmtime.v1 --platform=wasi/wasm

FROM --platform=$BUILDPLATFORM scratch
WORKDIR /app
COPY wit-bindgen/target/wasm/release/build/gen/gen.wasm /app/main.wasm
ENTRYPOINT [ "/app/main.wasm" ]

# docker build --output . - <<EOF
# FROM rust:latest as build
# RUN apt update && apt install -y libseccomp-dev && apt install -y protobuf-compiler
# RUN protoc --version
# RUN cargo install \
#     --git https://github.com/containerd/runwasi.git \
#     --bin containerd-shim-wasmtime-v1 \
#     --root /out \
#     containerd-shim-wasmtime
# FROM scratch
# COPY --from=build /out/bin /
# EOF