FROM alpine:latest
LABEL maintainer "AMSSN <info@amssn.eu>"

ENV ASTERISK_UID='9009'
ENV ASTERISK_GID='9009'
ENV ASTERISK_USER='asterisk'
ENV ASTERISK_GROUP='asterisk'
ENV ASTERISK_TZ='Europe/Berlin'
ENV ASTERISK_EXTRA_LANG='de'
ENV ASTERISK_INST_GUI="no"

COPY data/setup.sh /tmp/build/
COPY data/config_site.h /tmp/build/
COPY data/entry.sh /

RUN chmod +x /tmp/build/setup.sh /entry.sh
RUN /tmp/build/setup.sh

EXPOSE 5060/tcp 5060/udp
EXPOSE 8088/tcp 8089/tcp
EXPOSE 10000-10099/udp

VOLUME ["/etc/asterisk"]
VOLUME ["/var/lib/asterisk"]
VOLUME ["/var/log/asterisk"]

#ENTRYPOINT /entry.sh
CMD ["/entry.sh","/usr/sbin/asterisk","-vvvdddfcTin","-U","asterisk","-G","asterisk"]
