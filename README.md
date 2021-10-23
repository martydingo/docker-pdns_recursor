# Docker - PDNS Recursor
## Description
This is a image that builds an Alpine Linux container, and installs pdns-recursor. This image avoids the need to have a ready-made recursor.conf as to out-of-the-box functionaility, while providing the same level of customisation that including your own recursor.conf brings.

The following configuration is baked into this image:

```conf
daemon=no
local-address=0.0.0.0
webserver=yes
webserver-address=0.0.0.0
webserver-port=8082
webserver-allow-from=0.0.0.0/0,::/0
include-dir=/etc/pdns/recursor.conf.d/
```

This configuration can be overwritten/appended to by mounting a configuration directory holding `*.conf` files, to `/etc/pdns/recursor.conf.d/`

The webserver is enabled by default as so metrics can be scraped with no further configuration. However, the API will need a password configuring, and appended to a conf file inside the aforementioned configuration directory mount. This is accessible by default on `0.0.0.0:8082`

Alternatively, the `recursor.conf` inside the `src` directory can be modified, and a new image can be built by renaming `docker-compose.yml.build` to `docker-compose.yml`, and then running `docker-compose build`.

## Usage
To run this image, use the included docker-compose.yml and modify to your requirements.

```yaml
services:
  pdns_recursor:
    image: martydingo/pdns-recursor:latest
    ports:
      - 53:53
      - 53:53/udp
      - 8082:8082
    volumes:
      - <path_to_config>:/etc/pdns/recursor.conf.d/
```

To build from scratch, configure the following `docker-compose.yml`

```yaml
services:
  recursor:
    build:
      context: .
      dockerfile: Dockerfile
    ports:
      - 53:53
      - 53:53/udp
      - 8082:8082
    volumes:
      - <path_to_config>:/etc/pdns/recursor.conf.d/
```

Note: substitute `<path_to_config>` for the path where your configuration files are located.

