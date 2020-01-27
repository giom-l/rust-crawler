FROM rust:1.36.0 as builder

WORKDIR /rust-crawler
COPY . .
RUN rustup update && rustup component add rustfmt && rustup component add clippy
RUN cargo fmt --all -- --check
RUN cargo clippy
RUN cargo build --release --bin rust-crawler



FROM debian:stretch-slim
RUN apt-get update -y && \
    apt-get install -y libpq-dev openssl libssl1.0-dev ca-certificates

WORKDIR /rust-crawler
COPY --from=builder /rust-crawler/target/release/rust-crawler .

CMD ./rust-crawler
