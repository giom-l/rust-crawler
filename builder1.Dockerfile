FROM rust:1.36.0

# Naive method to construct a complete Rust toolchain with its components.
# Only the toolchain is available in it, no app.
RUN rustup update && rustup component add rustfmt && rustup component add clippy
