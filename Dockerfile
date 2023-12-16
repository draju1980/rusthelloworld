# Rust as the base image
FROM rust:1.52.1

# 1. Create a new empty shell project
RUN USER=root cargo new --bin helloworld
WORKDIR /holodeck

# 2. Copy our manifests
COPY ./Cargo.lock ./Cargo.lock
COPY ./Cargo.toml ./Cargo.toml

# 4. Now that the dependency is built, copy your source code
COPY ./src ./src

# 5. Build for release.
RUN cargo build --release
RUN cargo install --path .

CMD ["helloworld"]