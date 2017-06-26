FROM debian:jessie
LABEL maintainer "AMSSN <info@amssn.eu>"

ENV ASTERISK_UID='9009' ASTERISK_GID='9009' ASTERISK_USER='asterisk' ASTERISK_GROUP='asterisk' ASTERISK_TZ='Europe/Berlin' ASTERISK_VER='13.16.0-rc2' ASTERISK_DEVEL='no' ASTERISK_EXTRA_LANG='de' ASTERISK_EXTRA_PJSIP='no' ASTERISK_EXTRA_OPUS='1.1.4' ASTERISK_INST_GUI='13.0-latest' ASTERISK_INT_DB='yes'

ADD data/* /tmp/build/

RUN chmod +x /tmp/build/setup.sh /tmp/build/entry.sh /tmp/build/menuselect.sh
RUN /tmp/build/setup.sh

EXPOSE 5060/tcp 5060/udp 8088/tcp 8089/tcp 10000-10099/udp

VOLUME ["/etc/asterisk","/var/lib/asterisk","/var/log/asterisk"]

CMD ["/entry.sh"]
