# Use the official Ubuntu base image
FROM ubuntu:latest

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Expose SSH port
# (todo): Expose a port for remote GDB, probably 7777
EXPOSE 22

# Update the package list
RUN apt-get update

# Install essential development tools and SSH server
RUN apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    git \
    vim \
    gdb \
    curl \
    wget \
    openssh-server \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install ClickHouse-specific dependencies
RUN apt-get update && \
    apt-get install -y \
    ccache \
    python3 \
    ninja-build \
    nasm \
    yasm \
    gawk \
    lsb-release \
    wget \
    software-properties-common \
    gnupg \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install clang
RUN bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"
ENV CC=clang-19
ENV CXX=clang++-19

# Install rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Create a directory for the SSH daemon to run
RUN mkdir /var/run/sshd

# Setup SSH
COPY auth/id_ed25519.pub /tmp/id_ed25519.pub
COPY deps/sshd_config /etc/ssh/sshd_config
RUN mkdir -p /root/.ssh && \
    touch /root/.ssh/authorized_keys && \
    cat /tmp/id_ed25519.pub >> /root/.ssh/authorized_keys && \
    rm /tmp/id_ed25519.pub

# Set the working directory inside the container
WORKDIR /usr/src/app

# Alacritty terminfo
RUN curl -sSL https://raw.githubusercontent.com/alacritty/alacritty/master/extra/alacritty.info | tic -x -

# Start the SSH service
CMD ["/usr/sbin/sshd", "-D"]

# Note: You can add additional RUN commands to install other dependencies
