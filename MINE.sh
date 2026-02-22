#!/bin/bash

export GPU_FORCE_64BIT_PTR=1
export GPU_USE_SYNC_OBJECTS=1
export GPU_MAX_ALLOC_PERCENT=100
export GPU_SINGLE_ALLOC_PERCENT=100
export GPU_MAX_HEAP_SIZE=100

# ==============================
# CONFIGURATION - Edit these values before running
# ==============================
POOL_URL="${POOL_URL:-stratum+tcp://pool.supportxmr.com:3333}"
WALLET="${WALLET:-YOUR_WALLET_ADDRESS_HERE}"
PASSWORD="${PASSWORD:-x}"
INTENSITY="${INTENSITY:-7}"
WORKSIZE="${WORKSIZE:-32}"
DEVICES="${DEVICES:-0,1}"
THREAD_CONCURRENCY="${THREAD_CONCURRENCY:-8192}"
SGMINER_PATH="${SGMINER_PATH:-./sgminer-arm/sgminer}"

$SGMINER_PATH -k cryptonight -o "$POOL_URL" -u "$WALLET" -p "$PASSWORD" -I "$INTENSITY" -w "$WORKSIZE" -d "$DEVICES" --thread-concurrency "$THREAD_CONCURRENCY" --monero --pool-no-keepalive
