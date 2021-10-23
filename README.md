# Docker - PDNS Recursor
## Description
This is a image that builds an Alpine Linux container, and installs pdns-recursor. 

This image uses a pre-built recursor.conf to provide out-of-the-box functionaility.

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

