# ARM Mali T628 MP6 Monero GPU Mining

A proof-of-concept project for mining Monero (XMR) using the CryptoNight algorithm on ARM Mali GPUs via OpenCL. This project provides setup scripts and a mining launcher built around [sgminer-arm](https://github.com/hominoids/sgminer-arm), configured specifically for boards like the ODROID-XU4.

> **Note:** This project is a configuration wrapper. The core mining software (sgminer-arm) is developed by [hominoids](https://github.com/hominoids/sgminer-arm). This repo provides convenience scripts and documentation for getting it running on ARM Mali hardware.

---

## Hardware Requirements

- **ARM board** with a Mali GPU that supports OpenCL (tested on ODROID-XU4)
- **GPU:** ARM Mali-T628 MP6 (or compatible Mali GPU with OpenCL support)
- **RAM:** At least 2 GB recommended
- **Storage:** At least 2 GB free disk space for build tools and dependencies
- **Power supply:** Adequate for your board under sustained GPU load (5V/4A for ODROID-XU4)
- **Cooling:** Heatsink and active fan strongly recommended -- the GPU will run at full load

### Tested Hardware

| Board       | GPU              | Status  |
|-------------|------------------|---------|
| ODROID-XU4  | Mali-T628 MP6   | Working |

Other ARM boards with Mali GPUs that have OpenCL support may also work but have not been tested.

---

## Software Prerequisites

- A Debian/Ubuntu-based Linux distribution (e.g., Ubuntu, Armbian)
- Root access (required for package installation)
- Internet connection (for downloading dependencies and the miner source)
- The following packages are installed automatically by the setup script:
  - `automake`, `autoconf`, `pkg-config`
  - `libcurl4-openssl-dev`, `libjansson-dev`, `libssl-dev`, `libgmp-dev`
  - `make`, `g++`, `git`
  - `libncurses5-dev`, `libtool`
  - `opencl-headers`, `mali-fbdev`

---

## Setup Instructions

### 1. Clone this repository

```bash
git clone https://github.com/cjwsam/ARMMali-T628-MP6-MiningGPU.git
cd ARMMali-T628-MP6-MiningGPU
```

### 2. Run the setup script

The setup script installs all dependencies, downloads the ARM Compute Library OpenCL headers, clones sgminer-arm, and compiles it.

```bash
sudo bash scrypt.sh
```

This will:
1. Install required system packages
2. Download and install ARM Compute Library OpenCL headers
3. Clone the sgminer-arm repository
4. Configure and compile the miner

The build uses all available CPU cores by default. You can override this:

```bash
BUILD_JOBS=4 sudo bash scrypt.sh
```

### 3. Configure the miner

Before mining, **you must edit `MINE.sh`** to set your wallet address and pool:

```bash
nano MINE.sh
```

Change these values:
- `WALLET` -- Set this to your Monero wallet address
- `POOL_URL` -- Set this to your preferred mining pool (default: `stratum+tcp://pool.supportxmr.com:3333`)

You can also override these via environment variables without editing the file:

```bash
WALLET="your_monero_address" POOL_URL="stratum+tcp://your.pool:port" bash MINE.sh
```

### 4. Start mining

```bash
bash MINE.sh
```

---

## Configuration Reference

All mining parameters in `MINE.sh` can be set via environment variables:

| Variable             | Default                                      | Description                              |
|----------------------|----------------------------------------------|------------------------------------------|
| `POOL_URL`           | `stratum+tcp://pool.supportxmr.com:3333`     | Mining pool address                      |
| `WALLET`             | `YOUR_WALLET_ADDRESS_HERE`                   | Your Monero wallet address               |
| `PASSWORD`           | `x`                                          | Pool password (usually `x`)              |
| `INTENSITY`          | `7`                                          | Mining intensity (higher = more GPU load) |
| `WORKSIZE`           | `32`                                         | GPU work size                            |
| `DEVICES`            | `0,1`                                        | GPU device indices to use                |
| `THREAD_CONCURRENCY` | `8192`                                       | Thread concurrency for the CryptoNight kernel |
| `SGMINER_PATH`       | `./sgminer-arm/sgminer`                      | Path to the sgminer binary               |

Setup script variables in `scrypt.sh`:

| Variable              | Default            | Description                                  |
|-----------------------|--------------------|----------------------------------------------|
| `OPENCL_INCLUDE_DIR`  | `/usr/include/CL`  | Where to install OpenCL headers              |
| `BUILD_JOBS`          | Auto-detected      | Number of parallel compile jobs              |
| `COMPUTE_LIB_VERSION` | `v18.03`           | ARM Compute Library version to download      |

---

## Performance Expectations

ARM Mali GPUs are **not competitive** with dedicated mining hardware. Expect hash rates in the range of **tens of hashes per second** on a Mali-T628 MP6, compared to thousands of H/s on desktop GPUs or tens of thousands on ASICs.

This project is best suited for:
- Learning about GPU mining on ARM platforms
- Proof-of-concept and experimentation
- Understanding OpenCL on embedded hardware

---

## Troubleshooting

- **"OpenCL not found" during build:** Make sure `mali-fbdev` and `opencl-headers` are installed and that the OpenCL headers were copied correctly.
- **Miner crashes on launch:** Try lowering the intensity (`INTENSITY=5`) or thread concurrency (`THREAD_CONCURRENCY=4096`).
- **"No devices found":** Ensure your Mali GPU is recognized. Check `ls /dev/mali*` for device nodes.
- **Thermal throttling:** Install a heatsink and fan. Monitor temperature with `cat /sys/class/thermal/thermal_zone*/temp`.

---

## Disclaimer

- **Mining profitability:** Mining Monero on ARM Mali GPUs is almost certainly **not profitable** after accounting for electricity costs. This project exists as a proof of concept and educational resource.
- **Electricity costs:** Running your ARM board at full GPU load 24/7 will increase your power bill. Calculate your costs before committing to long-term mining.
- **Hardware wear:** Sustained full-load GPU operation may reduce the lifespan of your hardware.
- **No warranty:** This software is provided as-is. Use at your own risk.
- **Legal compliance:** Ensure cryptocurrency mining is legal in your jurisdiction.

---

## License

This project is a wrapper around [sgminer-arm](https://github.com/hominoids/sgminer-arm). Please refer to the sgminer-arm repository for its licensing terms.

---

## Acknowledgments

- [sgminer-arm](https://github.com/hominoids/sgminer-arm) by hominoids -- the core mining software
- [ARM Compute Library](https://github.com/ARM-software/ComputeLibrary) -- for OpenCL headers
- The ODROID community for ARM board support and documentation
