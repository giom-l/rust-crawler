# Example of multistage pattern image build.

# Here we're going to produce a first container "builder" that will contain all our build tools.
FROM rust:1.36.0 as builder

WORKDIR /rust-crawler
# Add our source code
COPY . .
# Install toolchain components
RUN rustup update && rustup component add rustfmt && rustup component add clippy
# Check the formatting of our source code
RUN cargo fmt --all -- --check
# Lint our code : https://github.com/rust-lang/rust-clippy
RUN cargo clippy
# build a binary named rust-crawler
RUN cargo build --release --bin rust-crawler


# Now, we are running a way smaller image than rust one to run our built application
FROM debian:stretch-slim
# Install required dependencies to run our application
RUN apt-get update -y && \
    apt-get install -y libpq-dev openssl libssl1.0-dev ca-certificates

WORKDIR /rust-crawler
# Copy the build binary from the previous stage
COPY --from=builder /rust-crawler/target/release/rust-crawler .

# Default command
CMD ./rust-crawler
