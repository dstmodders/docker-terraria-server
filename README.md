# docker-terraria-server

## Overview

[Docker] images for the [Terraria] game servers, including official and
community [TShock] variants, emphasizing pure vanilla experience by default.

- [Environment variables](#environment-variables)
- [Usage](#usage)
- [Supported architectures](#supported-architectures)
- [Supported build arguments](#supported-build-arguments)
- [Build](#build)

## Environment variables

| Name                      | Image                 | Value     | Description        |
| ------------------------- | --------------------- | --------- | ------------------ |
| `TERRARIA_VERSION`        | `official` + `tshock` | `1.4.4.9` | [Terraria] version |
| `TZ`                      | `official` + `tshock` | `UTC`     | Timezone           |
| `TERRARIA_TSHOCK_VERSION` | `tshock`              | `5.2.0`   | [TShock] version   |

## Usage

For the latest official server:

```shell
$ docker pull dstmodders/terraria-server:latest
# or
$ docker pull ghcr.io/dstmodders/terraria-server:latest
```

For the latest community [TShock] server:

```shell
$ docker pull dstmodders/terraria-server:tshock
# or
$ docker pull ghcr.io/dstmodders/terraria-server:tshock
```

See [tags] for a list of all available versions.

By default, the official [Terraria] server stores worlds in
`/home/terraria/.local/share/Terraria/Worlds/`, while the [TShock] server uses
`/home/tshock/.local/share/Terraria/Worlds/`. [TShock]'s default configurations
are located in `/opt/tshock/tshock/`. To maintain default settings, mount your
host directories to these container paths.

In the examples below, we will override the default locations using the
corresponding command-line parameters provided by both official [Terraria] and
community [TShock] servers to store all the necessary data in a single `/data/`
directory. In the future, we are planning to use the custom paths as the default
ones to simplify the mounting process.

#### Shell/Bash (Linux & macOS)

```shell
# for official
$ docker run --rm -it -v "$(pwd):/data/" dstmodders/terraria-server \
    ./TerrariaServer.bin.x86_64 -config /data/config.txt

# for tshock
$ docker run --rm -it -v "$(pwd):/data/" dstmodders/terraria-server:tshock \
    ./TShock.Server \
      -configpath /data/tshock/ \
      -crashdir /data/tshock/crashes/ \
      -logpath /data/tshock/logs/ \
      -additionalplugins /data/plugins/ \
      -worldselectpath /data/worlds/
```

#### CMD (Windows)

```cmd
REM for official
> docker run --rm -it -v "%CD%:/data/" dstmodders/terraria-server \
    ./TerrariaServer.bin.x86_64 -config /data/config.txt

REM for tshock
> docker run --rm -it -v "%CD%:/data/" dstmodders/terraria-server:tshock \
    ./TShock.Server \
      -configpath /data/tshock/ \
      -crashdir /data/tshock/crashes/ \
      -logpath /data/tshock/logs/ \
      -additionalplugins /data/plugins/ \
      -worldselectpath /data/worlds/
```

#### PowerShell (Windows)

```powershell
# for official
PS:\> docker run --rm -it -v "${PWD}:/data/" dstmodders/terraria-server \
    ./TerrariaServer.bin.x86_64 -config /data/config.txt

# for tshock
PS:\> docker run --rm -it -v "${PWD}:/data/" dstmodders/terraria-server:tshock \
    ./TShock.Server \
      -configpath /data/tshock/ \
      -crashdir /data/tshock/crashes/ \
      -logpath /data/tshock/logs/ \
      -additionalplugins /data/plugins/ \
      -worldselectpath /data/worlds/
```

### Docker Compose

#### Official

```yaml
version: '3.7'

services:
  official:
    image: 'dstmodders/terraria-server:latest'
    command:
      - ./TerrariaServer.bin.x86_64
      - '-config /data/config.txt'
    ports:
      - '7777:7777'
    volumes:
      - './test/official/:/data/:rw'
```

#### TShock

```yaml
version: '3.7'

services:
  tshock:
    image: 'dstmodders/terraria-server:tshock'
    command:
      - ./TShock.Server
      - '-configpath /data/tshock/'
      - '-crashdir /data/tshock/crashes/'
      - '-logpath /data/tshock/logs/'
      - '-additionalplugins /data/plugins/'
      - '-worldselectpath /data/worlds/'
    ports:
      - '7777:7777'
      - '7878:7878' # REST API
    volumes:
      - './test/tshock/:/data/:rw'
```

## Supported architectures

| Image      | Architecture(s) |
| ---------- | --------------- |
| `official` | `linux/amd64`   |
| `tshock`   | `linux/amd64`   |

## Supported build arguments

| Name                      | Image                 | Default   | Description        |
| ------------------------- | --------------------- | --------- | ------------------ |
| `TERRARIA_VERSION`        | `official` + `tshock` | `1.4.4.9` | [Terraria] version |
| `TERRARIA_TSHOCK_VERSION` | `tshock`              | `5.2.0`   | [TShock] version   |

## Build

To build images locally:

```shell
$ docker build ./official/ --tag='dstmodders/terraria-server:latest'
$ docker build ./tshock/ --tag='dstmodders/terraria-server:tshock'
```

## License

Released under the [MIT License](https://opensource.org/licenses/MIT).

[docker]: https://www.docker.com/
[tags]: https://hub.docker.com/r/dstmodders/imagemagick/tags
[terraria]: https://terraria.org/
[tshock]: https://github.com/Pryaxis/TShock
