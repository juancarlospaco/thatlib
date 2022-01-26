# ThatLib

![](https://raw.githubusercontent.com/juancarlospaco/thatlib/nim/thatlib-logo.jpg "Faster pathlib for Python")

[![Benchmark Results](https://raw.githubusercontent.com/juancarlospaco/thatlib/nim/results_graph.png "Benchmark Results")](https://youtu.be/QiKwnlyhKrk?t=5)

![](https://img.shields.io/github/languages/top/juancarlospaco/thatlib?style=for-the-badge)
![](https://img.shields.io/github/languages/count/juancarlospaco/thatlib?logoColor=green&style=for-the-badge)
![](https://img.shields.io/github/stars/juancarlospaco/thatlib?style=for-the-badge)
![](https://img.shields.io/github/languages/code-size/juancarlospaco/thatlib?style=for-the-badge)
![](https://img.shields.io/github/issues-raw/juancarlospaco/thatlib?style=for-the-badge)
![](https://img.shields.io/github/issues-pr-raw/juancarlospaco/thatlib?style=for-the-badge)
![](https://img.shields.io/github/last-commit/juancarlospaco/thatlib?style=for-the-badge)


# Using Pathlib can make your project +50x Slower

[![Using Pathlib can make your project 50x Slower](https://img.youtube.com/vi/tFrh9hKMS6Y/0.jpg)](https://www.youtube.com/watch?v=tFrh9hKMS6Y)


# Use

- Same API as `pathlib`, nothing new to remember.
- [See the examples folder (20+ simple tiny examples).](https://github.com/juancarlospaco/thatlib/tree/nim/examples)
- https://juancarlospaco.github.io/thatlib


# Type-safe DotEnv

Thatlib has builtin support for Type-safe `.env`. Type-safe `.env` file is just a `.env` but Typed.

Types are enforced via a comment, so it is still a "vanilla" `.env`.

Type-safe `.env` file can be used with unsafe `.env` parsers, legacy parsers will ignore the comment.

Keys must be a non-empty ASCII string `[a-zA-Z0-9_]`, keys are validated. Key-Value separator must be `=`.

Parses the same `.env` file from the vanilla implementation tests.

Several orders of magnitude faster than the vanilla implementation. Implementation is ~ 50 lines of code.

Examples:

```ini
# This is a comment
DB_HOST=localhost  # string
DB_USER=root       # string
DB_PASS="123"      # string
DB_TIMEOUT=42      # int
DELAY=3.14         # float
ACTIVE=true        # bool
```

- `.env` file example https://github.com/juancarlospaco/thatlib/blob/nim/examples/.env
- Python use example https://github.com/juancarlospaco/thatlib/blob/nim/examples/example_dotenv.py


# Requisites

- Python 1.x or 2.x or 3.x, 64Bit, CPython implementation.


# PYPI

- https://pypi.org/project/thatlib


# Dependencies

- None.


# Stars

![](https://starchart.cc/juancarlospaco/thatlib.svg)


# Sponsor this project

<details> 
<summary title="Send Bitcoin"><kbd> Bitcoin BTC </kbd></summary>

**BEP20 Binance Smart Chain Network BSC**
```
0xb78c4cf63274bb22f83481986157d234105ac17e
```
**BTC Bitcoin Network**
```
1Pnf45MgGgY32X4KDNJbutnpx96E4FxqVi
```
</details>

<details> 
<summary><kbd> Ethereum ETH </kbd> <kbd> Dai DAI </kbd> <kbd> Uniswap UNI </kbd> <kbd> Axie Infinity AXS </kbd> <kbd> Smooth Love Potion SLP </kbd> </summary>

**BEP20 Binance Smart Chain Network BSC**
```
0xb78c4cf63274bb22f83481986157d234105ac17e
```
**ERC20 Ethereum Network**
```
0xb78c4cf63274bb22f83481986157d234105ac17e
```
</details>
<details> 
<summary title="Send Tether"><kbd> Tether USDT </kbd></summary>

**BEP20 Binance Smart Chain Network BSC**
```
0xb78c4cf63274bb22f83481986157d234105ac17e
```
**ERC20 Ethereum Network**
```
0xb78c4cf63274bb22f83481986157d234105ac17e
```
**TRC20 Tron Network**
```
TWGft53WgWvH2mnqR8ZUXq1GD8M4gZ4Yfu
```
</details>
<details> 
<summary title="Send Solana"><kbd> Solana SOL </kbd></summary>

**BEP20 Binance Smart Chain Network BSC**
```
0xb78c4cf63274bb22f83481986157d234105ac17e
```
**SOL Solana Network**
```
FKaPSd8kTUpH7Q76d77toy1jjPGpZSxR4xbhQHyCMSGq
```
</details>
<details> 
<summary title="Send Cardano"><kbd> Cardano ADA </kbd></summary>

**BEP20 Binance Smart Chain Network BSC**
```
0xb78c4cf63274bb22f83481986157d234105ac17e
```
**ADA Cardano Network**
```
DdzFFzCqrht9Y1r4Yx7ouqG9yJNWeXFt69xavLdaeXdu4cQi2yXgNWagzh52o9k9YRh3ussHnBnDrg7v7W2hSXWXfBhbo2ooUKRFMieM
```
</details>
<details> 
<summary title="Send Sandbox"><kbd> Sandbox SAND </kbd> <kbd> Decentraland MANA </kbd></summary>

**ERC20 Ethereum Network**
```
0xb78c4cf63274bb22f83481986157d234105ac17e
```
</details>
<details> 
<summary title="Send Algorand"><kbd> Algorand ALGO </kbd></summary>

**ALGO Algorand Network**
```
WM54DHVZQIQDVTHMPOH6FEZ4U2AU3OBPGAFTHSCYWMFE7ETKCUUOYAW24Q
```
</details>

<details> 
<summary title="Send via Binance Pay"> Binance </summary>
  
https://pay.binance.com/en/checkout/e92e536210fd4f62b426ea7ee65b49c3
</details>
