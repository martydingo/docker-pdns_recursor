FROM alpine:3.13

RUN apk add --no-cache \
    pdns-recursor

RUN mkdir -p /etc/pdns/recursor.conf.d \
  && chown -R recursor: /etc/pdns/recursor.conf.d \
  && mkdir -p /var/run/pdns-recursor \
  && chown -R recursor: /var/run/pdns-recursor

ENV VERSION=4.4 \
  PDNS_setuid=recursor \
  PDNS_setgid=recursor \
  PDNS_daemon=no

COPY docker-entrypoint.sh /
COPY recursor.conf /etc/pdns/recursor.conf

EXPOSE 53
EXPOSE 53/udp
EXPOSE 8082

ENTRYPOINT [ "sh", "docker-entrypoint.sh" ]
CMD [ "/usr/sbin/pdns_recursor" ]

