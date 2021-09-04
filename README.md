# MySQL

[![Release](https://github.com/cash-track/mysql/actions/workflows/release.yml/badge.svg)](https://github.com/cash-track/mysql/actions/workflows/release.yml)

The primary database used for store important data for the system

## Push to registry

```bash
$ docker build . -t cashtrack/mysql:latest --no-cache
$ docker push cashtrack/mysql:latest
```
