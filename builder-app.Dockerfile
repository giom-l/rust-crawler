# In this image we will build our application to get a containerized application.
# For the base image, we chose an image that already contains the components we want (clippy)
FROM rust-clippy:1.36.0

WORKDIR /rust-crawler
# Add our application source code
COPY . .

# Check the formatting of our source code
RUN cargo fmt --all -- --check
# Lint our code : https://github.com/rust-lang/rust-clippy
RUN cargo clippy
# build a binary named rust-crawler
RUN cargo build --release --bin rust-crawler

# Default command for build image.
CMD ./target/release/rust-crawler
