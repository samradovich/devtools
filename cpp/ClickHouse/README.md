# ClickHouse Dev Container

This container provides a development environment for ClickHouse with all necessary dependencies pre-installed.

## Prerequisites

- Docker installed on your system
- SSH key pair (the container expects `auth/id_ed25519.pub` to be available)
- ClickHouse source code directory

## Quick Start

### 1. Build the Container

```bash
docker build -t clickhouse-dev-container .
```

### 2. Run the Container

Replace /path/to/clickhouse/source with your actual ClickHouse
source directory

```bash
docker run -d \
  --name clickhouse-dev \
  -p 7776:22 \
  -v /path/to/clickhouse/source:/usr/src/app \
  clickhouse-dev-container
```

### 3. Connect via SSH

```bash
# Connect to the container via SSH
ssh -i ~/.ssh/id_ed25519 -p 7776 root@localhost
```

## Container Details

The container includes:
- **Build tools**: gcc, cmake, ninja-build, ccache
- **Compilers**: clang (latest)
- **Languages**: Rust (via rustup)
- **Development tools**: git, vim, gdb
- **SSH server**: For remote development access

## Managing the Container

### Stop the container
```bash
docker stop clickhouse-dev
```

### Remove the container
```bash
docker rm clickhouse-dev
```

### View container logs
```bash
docker logs clickhouse-dev
```

### Execute commands in running container
```bash
docker exec -it clickhouse-dev bash
```

## Development Workflow

1. **Build the container** (one-time setup)
2. **Run the container** with your source code mounted
3. **SSH into the container** for development
4. **Build ClickHouse** inside the container using the standard ClickHouse build process

## Notes

- The container exposes SSH on port 7776 (mapped from internal port 22)
- Your ClickHouse source code should be mounted at `/usr/src/app` inside the container
- The container includes all dependencies mentioned in the [ClickHouse build documentation](https://clickhouse.com/docs/development/build)
- Rust binaries are available in the PATH via `/root/.cargo/bin`