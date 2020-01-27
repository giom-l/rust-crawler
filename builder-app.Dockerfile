FROM rust-clippy:1.36.0

WORKDIR /rust-crawler
COPY . .

RUN cargo fmt --all -- --check
RUN cargo clippy
RUN cargo build --release --bin rust-crawler

CMD ./target/release/rust-crawler
