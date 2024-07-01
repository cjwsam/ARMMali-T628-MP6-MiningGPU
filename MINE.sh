#!/bin/bash

export GPU_FORCE_64BIT_PTR=1
export GPU_USE_SYNC_OBJECTS=1
export GPU_MAX_ALLOC_PERCENT=100
export GPU_SINGLE_ALLOC_PERCENT=100
export GPU_MAX_HEAP_SIZE=100

./sgminer -k cryptonight -o stratum+tcp://pool.supportxmr.com:3333 -u 48QVbfvwkqzQofZTYDmcVEzKLbAqWEQ4iXCPYVshvCf5tW9zAnwvRf8N4uXmjJ91tACtSdf9ocwrJLoRqJxmwoTU4ebJy16 -p x  -I 7 -w 32 -d 0,1 --thread-concurrency 8192 --monero --pool-no-keepalive
