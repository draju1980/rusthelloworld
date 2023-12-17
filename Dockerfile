FROM rust:1.67 AS build
COPY . .
RUN rustup target add x86_64-helloworld-linux-musl
RUN cargo install --path . --target x86_64-helloworld-linux-musl

FROM alpine:3.16.0 AS runtime
COPY --from=build /usr/local/cargo/bin/helloworld /usr/local/bin/helloworld

FROM runtime as action
COPY entrypoint.sh /entrypoint.sh

EXPOSE 8080

ENTRYPOINT [ /entrypoint.sh ]
