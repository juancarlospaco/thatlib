# ThatLib

![](https://raw.githubusercontent.com/juancarlospaco/thatlib/nim/thatlib-logo.jpg "Faster pathlib for Python")

[![Benchmark Results](https://raw.githubusercontent.com/juancarlospaco/thatlib/nim/results_graph.png "Benchmark Results")](https://youtu.be/QiKwnlyhKrk?t=5)

![](https://img.shields.io/github/languages/top/juancarlospaco/thatlib?style=for-the-badge)
![](https://img.shields.io/github/languages/count/juancarlospaco/thatlib?logoColor=green&style=for-the-badge)
![](https://img.shields.io/github/stars/juancarlospaco/thatlib?style=for-the-badge)
![](https://img.shields.io/maintenance/yes/2021?style=for-the-badge)
![](https://img.shields.io/github/languages/code-size/juancarlospaco/thatlib?style=for-the-badge)
![](https://img.shields.io/github/issues-raw/juancarlospaco/thatlib?style=for-the-badge)
![](https://img.shields.io/github/issues-pr-raw/juancarlospaco/thatlib?style=for-the-badge)
![](https://img.shields.io/github/last-commit/juancarlospaco/thatlib?style=for-the-badge)

# Use

- [See the examples folder (20+ simple tiny examples).](https://github.com/juancarlospaco/thatlib/tree/nim/examples)
- https://juancarlospaco.github.io/thatlib


# Type-safe DotEnv

Thatlib has builtin support for Type-safe `.env`.

Type-safe `.env` file is just a `.env` but Typed.

Types are enforced via a comment, so it is still a "vanilla" `.env`.

Type-safe `.env` file can be used with unsafe `.env` parsers, legacy parsers will ignore the comment.

Keys must be a non-empty ASCII string `[a-zA-Z0-9_]`, keys are validated. Key-Value separator must be `=`.

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

- Python 3.6+ 64Bit.


# PYPI

- https://pypi.org/project/thatlib


# Stars

![](https://starchart.cc/juancarlospaco/thatlib.svg)
