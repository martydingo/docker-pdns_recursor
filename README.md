# Docker - PDNS Recursor
This is a image that builds an Alpine Linux container, and installs pdns-recursor. 

This image uses a pre-built recursor.conf with the following configuration 

```
daemon=no
local-address=0.0.0.0
webserver=yes
webserver-address=0.0.0.0
webserver-port=8082
webserver-allow-from=0.0.0.0/0,::/0
include-dir=/etc/pdns/recursor.conf.d/
```

This configuration can be overwritten/appended to by mounting a configuration directory holding `*.conf` files, to `/etc/pdns/recursor.conf.d/`

## Usage
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