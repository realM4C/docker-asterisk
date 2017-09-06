WARNING THIS DOCKER CONTAINER IS DEPRACED


# docker-asterisk13
Asterisk on Debian with freepbx gui without dahdi

[![](https://images.microbadger.com/badges/image/amssn/asterisk:asterisk13-deb.svg)](https://microbadger.com/images/amssn/asterisk:asterisk13-deb "Get your own image badge on microbadger.com")

[![](https://images.microbadger.com/badges/version/amssn/asterisk:asterisk13-deb.svg)](https://microbadger.com/images/amssn/asterisk:asterisk13-deb "Get your own version badge on microbadger.com")

# Usage:
docker run -d --restart=always --name=asterisk --publish=5060:5060/udp --publish=5060:5060/tcp \ 
--volume=[to-your-config-direcotry]:/etc/asterisk/ amssn/asterisk:asterisk13-deb

You can use:
docker exec -it [name-of-asterisk-container] /usr/sbin/rasterisk
to connect to the CLI of Asterisk

# Default ENVIREMENT Variablen
- ASTERISK_UID='9009'
- ASTERISK_GID='9009'
- ASTERISK_USER='asterisk'
- ASTERISK_GROUP='asterisk'
- ASTERISK_TZ='Europe/Berlin'
- ASTERISK_VER='13.16.0-rc2'
- ASTERISK_DEVEL='no'
- ASTERISK_EXTRA_LANG='de'
- ASTERISK_EXTRA_PJSIP='no'
- ASTERISK_EXTRA_OPUS='1.1.4'
- ASTERISK_INST_GUI='13.0-latest'
- ASTERISK_INT_DB='yes'

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

# Build Log:
You can find the build Logfile at /tmp/build.log

