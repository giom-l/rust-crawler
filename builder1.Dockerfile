FROM rust:1.36.0

RUN rustup update && rustup component add rustfmt && rustup component add clippy
