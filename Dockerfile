# Rust as the base image
FROM rust:1.52.1

# Create a new empty shell project
RUN USER=root cargo new --bin helloworld

COPY ./target/release/deps/helloworld* ./helloworld


CMD ["helloworld"]