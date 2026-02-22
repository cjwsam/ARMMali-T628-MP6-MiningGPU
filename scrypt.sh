#!/bin/bash
set -e

# ==============================
# CONFIGURATION - Edit these values if needed
# ==============================
OPENCL_INCLUDE_DIR="${OPENCL_INCLUDE_DIR:-/usr/include/CL}"
BUILD_JOBS="${BUILD_JOBS:-$(nproc)}"
COMPUTE_LIB_VERSION="${COMPUTE_LIB_VERSION:-v18.03}"

echo "=== ARM Mali GPU Mining Setup Script ==="
echo "OpenCL header directory: $OPENCL_INCLUDE_DIR"
echo "Build jobs: $BUILD_JOBS"
echo ""

# Install required packages
echo "=== Installing dependencies ==="
apt-get install automake autoconf pkg-config libcurl4-openssl-dev libjansson-dev libssl-dev libgmp-dev make g++ git libncurses5-dev libtool opencl-headers mali-fbdev -y

# Download required OpenCL headers from ARM Compute Library
echo "=== Downloading ARM Compute Library ($COMPUTE_LIB_VERSION) ==="
wget "https://github.com/ARM-software/ComputeLibrary/releases/download/${COMPUTE_LIB_VERSION}/arm_compute-${COMPUTE_LIB_VERSION}-bin-linux.tar.gz"

# Extract and install OpenCL headers
echo "=== Installing OpenCL headers to $OPENCL_INCLUDE_DIR ==="
tar -zxf "arm_compute-${COMPUTE_LIB_VERSION}-bin-linux.tar.gz"
mkdir -p "$OPENCL_INCLUDE_DIR"
mv "./arm_compute-${COMPUTE_LIB_VERSION}-bin-linux/include/CL/"* "$OPENCL_INCLUDE_DIR/"
rm -rf "./arm_compute-${COMPUTE_LIB_VERSION}-bin-linux"
rm -f "arm_compute-${COMPUTE_LIB_VERSION}-bin-linux.tar.gz"

# Download compatible miner (sgminer-arm)
echo "=== Cloning sgminer-arm ==="
git clone https://github.com/hominoids/sgminer-arm

# Configure and build
echo "=== Building sgminer-arm ==="
cd sgminer-arm
git submodule init
git submodule update
autoreconf -fi
CFLAGS="-Os -Wall -march=native -std=gnu99 -mfpu=neon" ./configure --disable-git-version --disable-adl --disable-adl-checks

# Compile using available cores
make -j"$BUILD_JOBS"

echo ""
echo "=== Build complete! ==="
echo "Edit MINE.sh to set your wallet address and pool, then run it to start mining."


