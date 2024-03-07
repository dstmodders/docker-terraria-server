# docker-terraria-server

[![Official Size]](https://hub.docker.com/r/dstmodders/terraria-server)
[![TShock Size]](https://hub.docker.com/r/dstmodders/terraria-server)
[![CI]](https://github.com/dstmodders/docker-terraria-server/actions/workflows/ci.yml)
[![Build]](https://github.com/dstmodders/docker-terraria-server/actions/workflows/build.yml)

## Supported tags and respective `Dockerfile` links

- [`1.4.4.9-official`, `1.4.4.9`, `official`, `latest`](https://github.com/dstmodders/docker-terraria-server/blob/43d8a19739b3f180152c984fbd597e4425a097eb/official/Dockerfile)
- [`1.4.4.9-tshock-5.2.0`, `1.4.4.9-tshock`, `tshock-5.2.0`, `5.2.0`, `tshock`](https://github.com/dstmodders/docker-terraria-server/blob/43d8a19739b3f180152c984fbd597e4425a097eb/tshock/Dockerfile)

## Overview

[Docker] images for the [Terraria] game servers, including official and
community [TShock] variants, emphasizing pure vanilla experience by default.

- [Quickstart](#quickstart)
- [Usage](#usage)
- [Supported environment variables](#supported-environment-variables)
- [Supported architectures](#supported-architectures)
- [Supported build arguments](#supported-build-arguments)
- [Build](#build)

## Quickstart

To begin, the simplest method is to clone this repository and execute
[Docker Compose] from within either the `official` or `tshock` directory. This
will automatically handle the pulling, creation, and mounting of all necessary
components for you:

### Step 1/4. Clone the repository and move into the corresponding directory

For [Official](#official) server:

```shell
$ git clone https://github.com/dstmodders/docker-terraria-server.git
$ cd ./docker-terraria-server/official/
```

For [TShock](#tshock) server, we also need to create the corresponding data
directories:

```shell
$ git clone https://github.com/dstmodders/docker-terraria-server.git
$ cd ./docker-terraria-server/tshock/
$ mkdir -p ./data/tshock/crashes/ ./data/tshock/logs/ ./data/plugins/ ./data/worlds/
```

### Step 2/4. Start the server

```shell
$ docker compose up
```

All the server data, including the world and server settings, will be stored
within the `./data/` directory.

### Step 3/4. Attach to send server commands

```shell
$ docker compose attach terraria
```

> [!TIP]
> To detach, use <kbd>CTRL</kbd> + <kbd>P</kbd> and then <kbd>CTRL</kbd> +
> <kbd>Q</kbd>.

### Step 4/4. Stop the server

```shell
$ docker compose down
```

Once you've tested everything successfully, you can move the example
`./docker-compose.yml` into any directory of your choice and edit it according
to your specific needs. Remember to also move the `./data/` directory if you
wish to preserve your existing world and server settings.

For more detailed usage instructions, continue reading the next [Usage](#usage)
chapter.

## Usage

- [Official](#official)
- [TShock](#tshock)

### Official

> [!IMPORTANT]
> By default, the official [Terraria] server stores worlds in the home
> directory: `/home/terraria/.local/share/Terraria/Worlds/`. We have changed the
> default path to `/data/worlds/` instead to simplify the mounting process.

- [Docker Run (official)](#docker-run-official)
- [Docker Compose (official)](#docker-compose-official)

#### Docker Run (official)

To pull the latest official server:

```shell
$ docker pull dstmodders/terraria-server:latest
# or
$ docker pull ghcr.io/dstmodders/terraria-server:latest
```

> [!TIP]
> See [tags] for a list of all available versions.

##### Shell/Bash (Linux & macOS)

```shell
$ docker run --rm -it -v "$(pwd):/data/" -p 7777:7777 dstmodders/terraria-server
```

<details>
<summary><b>The same, but with default environment variables</b></summary>
<p><pre>$ docker run --rm -it -v "$(pwd):/data/" -p 7777:7777 \
    -e DISABLE_COLORS=0 \
    -e TZ=UTC \
    -e TERRARIA_AUTOCREATE=3 \
    -e TERRARIA_BANLIST=/data/banlist.txt \
    -e TERRARIA_DIFFICULTY=0 \
    -e TERRARIA_LANGUAGE='en-US' \
    -e TERRARIA_MAXPLAYERS=8 \
    -e TERRARIA_MOTD="Please don't cut the purple trees!" \
    -e TERRARIA_NPCSTREAM=60 \
    -e TERRARIA_PASSWORD='' \
    -e TERRARIA_PORT=7777 \
    -e TERRARIA_PRIORITY=1 \
    -e TERRARIA_SECURE=1 \
    -e TERRARIA_SEED='' \
    -e TERRARIA_UPNP=1 \
    -e TERRARIA_WORLD=/data/worlds/World.wld \
    -e TERRARIA_WORLDNAME=World \
    -e TERRARIA_WORLDPATH=/data/worlds/ \
    -e TERRARIA_JOURNEYPERMISSION_BIOMESPREAD_SETFROZEN=2 \
    -e TERRARIA_JOURNEYPERMISSION_GODMODE=2 \
    -e TERRARIA_JOURNEYPERMISSION_INCREASEPLACEMENTRANGE=2 \
    -e TERRARIA_JOURNEYPERMISSION_RAIN_SETFROZEN=2 \
    -e TERRARIA_JOURNEYPERMISSION_RAIN_SETSTRENGTH=2 \
    -e TERRARIA_JOURNEYPERMISSION_SETDIFFICULTY=2 \
    -e TERRARIA_JOURNEYPERMISSION_SETSPAWNRATE=2 \
    -e TERRARIA_JOURNEYPERMISSION_TIME_SETDAWN=2 \
    -e TERRARIA_JOURNEYPERMISSION_TIME_SETDUSK=2 \
    -e TERRARIA_JOURNEYPERMISSION_TIME_SETFROZEN=2 \
    -e TERRARIA_JOURNEYPERMISSION_TIME_SETMIDNIGHT=2 \
    -e TERRARIA_JOURNEYPERMISSION_TIME_SETNOON=2 \
    -e TERRARIA_JOURNEYPERMISSION_TIME_SETSPEED=2 \
    -e TERRARIA_JOURNEYPERMISSION_WIND_SETFROZEN=2 \
    -e TERRARIA_JOURNEYPERMISSION_WIND_SETSTRENGTH=2 \
    -e TERRARIA_ANNOUNCEMENTBOXRANGE='' \
    -e TERRARIA_DISABLEANNOUNCEMENTBOX='' \
    -e TERRARIA_FORCEPRIORITY='' \
    -e TERRARIA_IP='' \
    -e TERRARIA_LOBBY='' \
    -e TERRARIA_STEAM=0 \
    dstmodders/terraria-server</pre></p>
</details>

##### CMD (Windows)

```cmd
> docker run --rm -it -v "%CD%:/data/" -p 7777:7777 dstmodders/terraria-server
```

<details>
<summary><b>The same, but with default environment variables</b></summary>
<p><pre>> docker run --rm -it -v "%CD%:/data/" -p 7777:7777 ^
    -e DISABLE_COLORS=0 ^
    -e TZ=UTC ^
    -e TERRARIA_AUTOCREATE=3 ^
    -e TERRARIA_BANLIST=/data/banlist.txt ^
    -e TERRARIA_DIFFICULTY=0 ^
    -e TERRARIA_LANGUAGE="en-US" ^
    -e TERRARIA_MAXPLAYERS=8 ^
    -e TERRARIA_MOTD="Please don't cut the purple trees!" ^
    -e TERRARIA_NPCSTREAM=60 ^
    -e TERRARIA_PASSWORD="" ^
    -e TERRARIA_PORT=7777 ^
    -e TERRARIA_PRIORITY=1 ^
    -e TERRARIA_SECURE=1 ^
    -e TERRARIA_SEED="" ^
    -e TERRARIA_UPNP=1 ^
    -e TERRARIA_WORLD=/data/worlds/World.wld ^
    -e TERRARIA_WORLDNAME=World ^
    -e TERRARIA_WORLDPATH=/data/worlds/ ^
    -e TERRARIA_JOURNEYPERMISSION_BIOMESPREAD_SETFROZEN=2 ^
    -e TERRARIA_JOURNEYPERMISSION_GODMODE=2 ^
    -e TERRARIA_JOURNEYPERMISSION_INCREASEPLACEMENTRANGE=2 ^
    -e TERRARIA_JOURNEYPERMISSION_RAIN_SETFROZEN=2 ^
    -e TERRARIA_JOURNEYPERMISSION_RAIN_SETSTRENGTH=2 ^
    -e TERRARIA_JOURNEYPERMISSION_SETDIFFICULTY=2 ^
    -e TERRARIA_JOURNEYPERMISSION_SETSPAWNRATE=2 ^
    -e TERRARIA_JOURNEYPERMISSION_TIME_SETDAWN=2 ^
    -e TERRARIA_JOURNEYPERMISSION_TIME_SETDUSK=2 ^
    -e TERRARIA_JOURNEYPERMISSION_TIME_SETFROZEN=2 ^
    -e TERRARIA_JOURNEYPERMISSION_TIME_SETMIDNIGHT=2 ^
    -e TERRARIA_JOURNEYPERMISSION_TIME_SETNOON=2 ^
    -e TERRARIA_JOURNEYPERMISSION_TIME_SETSPEED=2 ^
    -e TERRARIA_JOURNEYPERMISSION_WIND_SETFROZEN=2 ^
    -e TERRARIA_JOURNEYPERMISSION_WIND_SETSTRENGTH=2 ^
    -e TERRARIA_ANNOUNCEMENTBOXRANGE="" ^
    -e TERRARIA_DISABLEANNOUNCEMENTBOX="" ^
    -e TERRARIA_FORCEPRIORITY="" ^
    -e TERRARIA_IP="" ^
    -e TERRARIA_LOBBY="" ^
    -e TERRARIA_STEAM=0 ^
    dstmodders/terraria-server</pre></p>
</details>

##### PowerShell (Windows)

```powershell
PS:\> docker run --rm -it -v "${PWD}:/data/" -p 7777:7777 dstmodders/terraria-server
```

<details>
<summary><b>The same, but with default environment variables</b></summary>
<p><pre>PS:\> docker run --rm -it -v "${PWD}:/data/" -p 7777:7777 `
    -e DISABLE_COLORS=0 `
    -e TZ=UTC `
    -e TERRARIA_AUTOCREATE=3 `
    -e TERRARIA_BANLIST=/data/banlist.txt `
    -e TERRARIA_DIFFICULTY=0 `
    -e TERRARIA_LANGUAGE='en-US' `
    -e TERRARIA_MAXPLAYERS=8 `
    -e TERRARIA_MOTD="Please don't cut the purple trees!" `
    -e TERRARIA_NPCSTREAM=60 `
    -e TERRARIA_PASSWORD='' `
    -e TERRARIA_PORT=7777 `
    -e TERRARIA_PRIORITY=1 `
    -e TERRARIA_SECURE=1 `
    -e TERRARIA_SEED='' `
    -e TERRARIA_UPNP=1 `
    -e TERRARIA_WORLD=/data/worlds/World.wld `
    -e TERRARIA_WORLDNAME=World `
    -e TERRARIA_WORLDPATH=/data/worlds/ `
    -e TERRARIA_JOURNEYPERMISSION_BIOMESPREAD_SETFROZEN=2 `
    -e TERRARIA_JOURNEYPERMISSION_GODMODE=2 `
    -e TERRARIA_JOURNEYPERMISSION_INCREASEPLACEMENTRANGE=2 `
    -e TERRARIA_JOURNEYPERMISSION_RAIN_SETFROZEN=2 `
    -e TERRARIA_JOURNEYPERMISSION_RAIN_SETSTRENGTH=2 `
    -e TERRARIA_JOURNEYPERMISSION_SETDIFFICULTY=2 `
    -e TERRARIA_JOURNEYPERMISSION_SETSPAWNRATE=2 `
    -e TERRARIA_JOURNEYPERMISSION_TIME_SETDAWN=2 `
    -e TERRARIA_JOURNEYPERMISSION_TIME_SETDUSK=2 `
    -e TERRARIA_JOURNEYPERMISSION_TIME_SETFROZEN=2 `
    -e TERRARIA_JOURNEYPERMISSION_TIME_SETMIDNIGHT=2 `
    -e TERRARIA_JOURNEYPERMISSION_TIME_SETNOON=2 `
    -e TERRARIA_JOURNEYPERMISSION_TIME_SETSPEED=2 `
    -e TERRARIA_JOURNEYPERMISSION_WIND_SETFROZEN=2 `
    -e TERRARIA_JOURNEYPERMISSION_WIND_SETSTRENGTH=2 `
    -e TERRARIA_ANNOUNCEMENTBOXRANGE='' `
    -e TERRARIA_DISABLEANNOUNCEMENTBOX='' `
    -e TERRARIA_FORCEPRIORITY='' `
    -e TERRARIA_IP='' `
    -e TERRARIA_LOBBY='' `
    -e TERRARIA_STEAM=0 `
    dstmodders/terraria-server</pre></p>
</details>

#### Docker Compose (official)

> [!NOTE]
> The provided environment variables are all optional, as they use the default
> values. We've added them to our example just so that you wouldn't have to dig
> for them in [supported environment variables](#supported-environment-variables).

```yaml
version: '3.7'

services:
  terraria:
    image: 'dstmodders/terraria-server:latest'
    stdin_open: true
    tty: true
    ports:
      - '7777:7777'
    volumes:
      - './data/:/data/:rw'
    environment:
      # system parameters
      DISABLE_COLORS: 0
      TZ: UTC
      # general parameters
      TERRARIA_AUTOCREATE: 3
      TERRARIA_BANLIST: /data/banlist.txt
      TERRARIA_DIFFICULTY: 0
      TERRARIA_LANGUAGE: 'en-US'
      TERRARIA_MAXPLAYERS: 8
      TERRARIA_MOTD: "Please don't cut the purple trees!"
      TERRARIA_NPCSTREAM: 60
      TERRARIA_PASSWORD: ''
      TERRARIA_PORT: 7777
      TERRARIA_PRIORITY: 1
      TERRARIA_SECURE: 1
      TERRARIA_SEED: ''
      TERRARIA_UPNP: 1
      TERRARIA_WORLD: /data/worlds/World.wld
      TERRARIA_WORLDNAME: World
      TERRARIA_WORLDPATH: /data/worlds/
      # journey parameters
      TERRARIA_JOURNEYPERMISSION_BIOMESPREAD_SETFROZEN: 2
      TERRARIA_JOURNEYPERMISSION_GODMODE: 2
      TERRARIA_JOURNEYPERMISSION_INCREASEPLACEMENTRANGE: 2
      TERRARIA_JOURNEYPERMISSION_RAIN_SETFROZEN: 2
      TERRARIA_JOURNEYPERMISSION_RAIN_SETSTRENGTH: 2
      TERRARIA_JOURNEYPERMISSION_SETDIFFICULTY: 2
      TERRARIA_JOURNEYPERMISSION_SETSPAWNRATE: 2
      TERRARIA_JOURNEYPERMISSION_TIME_SETDAWN: 2
      TERRARIA_JOURNEYPERMISSION_TIME_SETDUSK: 2
      TERRARIA_JOURNEYPERMISSION_TIME_SETFROZEN: 2
      TERRARIA_JOURNEYPERMISSION_TIME_SETMIDNIGHT: 2
      TERRARIA_JOURNEYPERMISSION_TIME_SETNOON: 2
      TERRARIA_JOURNEYPERMISSION_TIME_SETSPEED: 2
      TERRARIA_JOURNEYPERMISSION_WIND_SETFROZEN: 2
      TERRARIA_JOURNEYPERMISSION_WIND_SETSTRENGTH: 2
      # command-line parameters
      TERRARIA_ANNOUNCEMENTBOXRANGE: ''
      TERRARIA_DISABLEANNOUNCEMENTBOX: ''
      TERRARIA_FORCEPRIORITY: ''
      TERRARIA_IP: ''
      TERRARIA_LOBBY: ''
      TERRARIA_STEAM: 0
```

### TShock

> [!IMPORTANT]
> By default, the [TShock] server stores worlds in the home directory:
> `/home/tshock/.local/share/Terraria/Worlds/`. The [TShock] server
> configurations are stored in `/opt/tshock/tshock/`. In the future, we are
> planning to change the default paths to simplify the mounting process, just
> like we did with the official one.

- [Docker Run (tshock)](#docker-run-tshock)
- [Docker Compose (tshock)](#docker-compose-tshock)

#### Docker Run (tshock)

To pull the latest community [TShock] server:

```shell
$ docker pull dstmodders/terraria-server:tshock
# or
$ docker pull ghcr.io/dstmodders/terraria-server:tshock
```

> [!TIP]
> See [tags] for a list of all available versions.

In the examples below, we will override the default [TShock] paths using the
corresponding command-line parameters to store all the necessary data in a
single `/data/` directory, as for now, we don't override them by default.

##### Shell/Bash (Linux & macOS)

```shell
$ docker run --rm -it -v "$(pwd):/data/" -p 7777:7777 dstmodders/terraria-server:tshock \
    ./TShock.Server \
      -configpath /data/tshock/ \
      -crashdir /data/tshock/crashes/ \
      -logpath /data/tshock/logs/ \
      -additionalplugins /data/plugins/ \
      -worldselectpath /data/worlds/
```

##### CMD (Windows)

```cmd
> docker run --rm -it -v "%CD%:/data/" -p 7777:7777 dstmodders/terraria-server:tshock ^
    ./TShock.Server ^
      -configpath /data/tshock/ ^
      -crashdir /data/tshock/crashes/ ^
      -logpath /data/tshock/logs/ ^
      -additionalplugins /data/plugins/ ^
      -worldselectpath /data/worlds/
```

##### PowerShell (Windows)

```powershell
PS:\> docker run --rm -it -v "${PWD}:/data/" -p 7777:7777 dstmodders/terraria-server:tshock `
    ./TShock.Server `
      -configpath /data/tshock/ `
      -crashdir /data/tshock/crashes/ `
      -logpath /data/tshock/logs/ `
      -additionalplugins /data/plugins/ `
      -worldselectpath /data/worlds/
```

#### Docker Compose (tshock)

```yaml
version: '3.7'

services:
  terraria:
    image: 'dstmodders/terraria-server:tshock'
    command: >
      ./TShock.Server \
      -configpath /data/tshock/ \
      -crashdir /data/tshock/crashes/ \
      -logpath /data/tshock/logs/ \
      -additionalplugins /data/plugins/ \
      -worldselectpath /data/worlds/
    stdin_open: true
    tty: true
    ports:
      - '7777:7777'
      - '7878:7878' # REST API
    volumes:
      - './data/:/data/:rw'
```

## Supported environment variables

- [System](#system)
- [General](#general)
- [Journey permissions](#journey-permissions)
- [Command-line](#command-line)

### System

System environment variables are unrelated to the [Terraria] server and are
exclusive to the system.

| Name                      | Image                    | Default   | Description              |
| ------------------------- | ------------------------ | --------- | ------------------------ |
| `DISABLE_COLORS`          | `official`               | `0`       | Toggles colored output   |
| `TERRARIA_TSHOCK_VERSION` | `tshock`                 | `5.2.0`   | Shows [TShock] version   |
| `TERRARIA_VERSION`        | `official`<br />`tshock` | `1.4.4.9` | Shows [Terraria] version |
| `TZ`                      | `official`<br />`tshock` | `UTC`     | Sets the timezone.       |

### General

General environment variables represent the [Terraria] server features that
can be configured through the default configuration file `/data/config.txt`.
While most have corresponding command-line parameters in the server binary, they
are primarily set through the configuration file instead.

| Name                  | Image      | Default                              | Description                                                                                                                                                                                                                                                                                                                   |
| --------------------- | ---------- | ------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `TERRARIA_AUTOCREATE` | `official` | `3`                                  | <p>Creates a new world if none is found. World size is specified by:</p><ul><li>`1` (small)</li><li>`2` (medium)</li><li>`3` (large)</li></ul>                                                                                                                                                                                |
| `TERRARIA_BANLIST`    | `official` | `/data/banlist.txt`                  | Sets the location of the banlist.                                                                                                                                                                                                                                                                                             |
| `TERRARIA_DIFFICULTY` | `official` | `0`                                  | <p>Sets the world difficulty when using `autocreate`. Options:</p><ul><li>`0` (normal)</li><li>`1` (expert)</li><li>`2` (master)</li><li>`3` (journey)</li></ul>                                                                                                                                                              |
| `TERRARIA_LANGUAGE`   | `official` | `en-US`                              | <p>Sets the server language from its language code. Available codes:</p><ul><li>`en-US` (English)</li><li>`de-DE` (German)</li><li>`it-IT` (Italian)</li><li>`fr-FR` (French)</li><li>`es-ES` (Spanish)</li><li>`ru-RU` (Russian)</li><li>`zh-Hans` (Chinese)</li><li>`pt-BR` (Portuguese)</li><li>`pl-PL` (Polish)</li></ul> |
| `TERRARIA_MAXPLAYERS` | `official` | `8`                                  | Sets the max number of players allowed on a server. Value must be between `1` and `255`.                                                                                                                                                                                                                                      |
| `TERRARIA_MOTD`       | `official` | `Please don't cut the purple trees!` | Sets the message of the day.                                                                                                                                                                                                                                                                                                  |
| `TERRARIA_NPCSTREAM`  | `official` | `60`                                 | Reduces enemy skipping but increases bandwidth usage. The lower the number the less skipping will happen, but more data is sent. `0` is off.                                                                                                                                                                                  |
| `TERRARIA_PASSWORD`   | `official` |                                      | Sets the server password.                                                                                                                                                                                                                                                                                                     |
| `TERRARIA_PORT`       | `official` | `7777`                               | Sets the port number.                                                                                                                                                                                                                                                                                                         |
| `TERRARIA_PRIORITY`   | `official` | `1`                                  | <p>Sets the default system priority:</p><ul><li>`0` (realtime)</li><li>`1` (high)</li><li>`2` (above normal)</li><li>`3` (normal)</li><li>`4` (below normal)</li><li>`5` (idle)</li></ul>                                                                                                                                     |
| `TERRARIA_SECURE`     | `official` | `1`                                  | Toggles additional cheat protection.                                                                                                                                                                                                                                                                                          |
| `TERRARIA_SEED`       | `official` |                                      | Sets the world seed when using `autocreate`.                                                                                                                                                                                                                                                                                  |
| `TERRARIA_UPNP`       | `official` | `1`                                  | Toggles automatic ports forwarding with uPNP.                                                                                                                                                                                                                                                                                 |
| `TERRARIA_WORLDNAME`  | `official` | `World`                              | Sets the name of the world when using `autocreate`.                                                                                                                                                                                                                                                                           |
| `TERRARIA_WORLDPATH`  | `official` | `/data/worlds/`                      | Sets the directory where world files will be stored.                                                                                                                                                                                                                                                                          |
| `TERRARIA_WORLD`      | `official` | `/data/worlds/World.wld`             | Loads a world and automatically starts the server.                                                                                                                                                                                                                                                                            |

### Journey permissions

Journey permissions environment variables are related to individual power
permissions under journey difficulty:

- `0` (locked for everyone)
- `1` (can only be changed by host)
- `2` (can be changed by everyone)

Only applicable when `difficulty` is set to `3` (journey) like when setting the
`TERRARIA_DIFFICULTY` environment variable to `3`. They are only configurable
through the server configuration file.

| Name                                                | Image      | Default |
| --------------------------------------------------- | ---------- | ------- |
| `TERRARIA_JOURNEYPERMISSION_BIOMESPREAD_SETFROZEN`  | `official` | `2`     |
| `TERRARIA_JOURNEYPERMISSION_GODMODE`                | `official` | `2`     |
| `TERRARIA_JOURNEYPERMISSION_INCREASEPLACEMENTRANGE` | `official` | `2`     |
| `TERRARIA_JOURNEYPERMISSION_RAIN_SETFROZEN`         | `official` | `2`     |
| `TERRARIA_JOURNEYPERMISSION_RAIN_SETSTRENGTH`       | `official` | `2`     |
| `TERRARIA_JOURNEYPERMISSION_SETDIFFICULTY`          | `official` | `2`     |
| `TERRARIA_JOURNEYPERMISSION_SETSPAWNRATE`           | `official` | `2`     |
| `TERRARIA_JOURNEYPERMISSION_TIME_SETDAWN`           | `official` | `2`     |
| `TERRARIA_JOURNEYPERMISSION_TIME_SETDUSK`           | `official` | `2`     |
| `TERRARIA_JOURNEYPERMISSION_TIME_SETFROZEN`         | `official` | `2`     |
| `TERRARIA_JOURNEYPERMISSION_TIME_SETMIDNIGHT`       | `official` | `2`     |
| `TERRARIA_JOURNEYPERMISSION_TIME_SETNOON`           | `official` | `2`     |
| `TERRARIA_JOURNEYPERMISSION_TIME_SETSPEED`          | `official` | `2`     |
| `TERRARIA_JOURNEYPERMISSION_WIND_SETFROZEN`         | `official` | `2`     |
| `TERRARIA_JOURNEYPERMISSION_WIND_SETSTRENGTH`       | `official` | `2`     |

### Command-line

Command-line environment variables represent features unique to [Terraria]
server binary parameters.

| Name                              | Image      | Default | Description                                                                                                                                                                                                                                                    |
| --------------------------------- | ---------- | ------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `TERRARIA_ANNOUNCEMENTBOXRANGE`   | `official` |         | Sets the "Announcement Box" text messaging range in pixels, `-1` for serverwide announcements.                                                                                                                                                                 |
| `TERRARIA_DISABLEANNOUNCEMENTBOX` | `official` |         | Disables the text announcements that "Announcement Box" makes when pulsed from wire.                                                                                                                                                                           |
| `TERRARIA_FORCEPRIORITY`          | `official` |         | <p>Sets the process priority for this task:</p><ul><li>`0` (realtime)</li><li>`1` (high)</li><li>`2` (above normal)</li><li>`3` (normal)</li><li>`4` (below normal)</li><li>`5` (idle)</li></ul><p>If this is used the `priority` setting will be ignored.</p> |
| `TERRARIA_IP`                     | `official` |         | Sets the IP address for the server to listen on.                                                                                                                                                                                                               |
| `TERRARIA_LOBBY`                  | `official` |         | <p>Allows only friends to join the server or sets it to private if Steam is enabled:</p><ul><li>`friends`</li><li>`private`</li></ul>                                                                                                                          |
| `TERRARIA_STEAM`                  | `official` | `0`     | Toggles Steam support.                                                                                                                                                                                                                                         |

## Supported architectures

| Image      | Architecture(s) |
| ---------- | --------------- |
| `official` | `linux/amd64`   |
| `tshock`   | `linux/amd64`   |

## Supported build arguments

| Name                      | Image                    | Default   | Description             |
| ------------------------- | ------------------------ | --------- | ----------------------- |
| `TERRARIA_VERSION`        | `official`<br />`tshock` | `1.4.4.9` | Sets [Terraria] version |
| `TERRARIA_TSHOCK_VERSION` | `tshock`                 | `5.2.0`   | Sets [TShock] version   |

## Build

To build images locally:

```shell
$ docker build ./official/ --tag='dstmodders/terraria-server:latest'
$ docker build ./tshock/ --tag='dstmodders/terraria-server:tshock'
```

## License

Released under the [MIT License](https://opensource.org/licenses/MIT).

[build]: https://img.shields.io/github/actions/workflow/status/dstmodders/docker-terraria-server/build.yml?branch=main&label=build&logo=github
[ci]: https://img.shields.io/github/actions/workflow/status/dstmodders/docker-terraria-server/ci.yml?branch=main&label=ci&logo=github
[docker compose]: https://docs.docker.com/compose/
[docker]: https://www.docker.com/
[official size]: https://img.shields.io/docker/image-size/dstmodders/terraria-server/official?label=official%20size&logo=docker
[tags]: https://hub.docker.com/r/dstmodders/terraria-server/tags
[terraria]: https://terraria.org/
[tshock size]: https://img.shields.io/docker/image-size/dstmodders/terraria-server/tshock?label=tshock%20size&logo=docker
[tshock]: https://github.com/Pryaxis/TShock
