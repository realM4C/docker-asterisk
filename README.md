# docker-asterisk14
Asterisk on AlpineLinux without dahdi

[![](https://images.microbadger.com/badges/image/amssn/asterisk14.svg)](https://microbadger.com/images/amssn/asterisk14 "Get your own image badge on microbadger.com")

[![](https://images.microbadger.com/badges/version/amssn/asterisk14.svg)](https://microbadger.com/images/amssn/asterisk14 "Get your own version badge on microbadger.com")

# Usage:
docker run -d --restart=always --name=asterisk --publish=5060:5060/udp --publish=5060:5060/tcp \ 
--volume=[to-your-config-direcotry]:/etc/asterisk/ amssn/asterisk14:latest

You can use:
docker exec -it [name-of-asterisk-container] /usr/sbin/rasterisk
to connect to the CLI of Asterisk

# ENVIREMENT Variablen
- ASTERISK_UID='9009'
- ASTERISK_GID='9009'
- ASTERISK_USER='asterisk'
- ASTERISK_GROUP='asterisk'
- ASTERISK_TZ='Europe/Berlin'
- ASTERISK_EXTRA_LANG="de"
- ASTERISK_INST_GUI="yes"

# Ports:
- 5060/tcp        # xxx
- 5060/udp        # xxx
- 8088/tcp        # the HTTP Port for the webinterface
- 8089/tcp        # the HTTPS Port for the webinterface
- 10000-10099/udp # SIP Forwarded Ports

# Volume:
- /etc/asterisk
- /var/lib/asterisk
- /var/log/asterisk

# TODO:
Create a better usage

# Build Log:
You can find the build Logfile at /tmp/build.log

