#!/bin/sh

CORES="$(( $(cat /proc/cpuinfo | grep processor | tail -n1 | awk '{print $3}') + 1 ))"
MEM="$(cat /proc/meminfo | grep MemTotal | awk '{print $2}') kB"
APK_PARAM="--no-cache --quiet --no-progress"
echo "#################################################################"
echo "# Detected ${CORES} CPUs                                             #"
echo "# Detected ${MEM} Memory                                             #"
echo "#################################################################"

# Setup Localtime
echo "#################################################################"
echo "# Setup Localtime....                                           #"
echo "#################################################################"
apk upgrade ${APK_PARAM}
apk add ${APK_PARAM} bash tzdata
cp /usr/share/zoneinfo/${ASTERISK_TZ} /etc/localtime
apk del ${APK_PARAM} tzdata

echo "#################################################################"
echo "# Installing Depencies....                                      #"
echo "#################################################################"
apk upgrade ${APK_PARAM}
apk add ${APK_PARAM} \
        curl sqlite sqlite-libs py2-pip libresample \
        gsm speex speexdsp libsrtp opus libxslt libxml2 jansson libedit libuuid \
        build-base git libical neon portaudio net-snmp doxygen \
        ncurses-dev util-linux-dev jansson-dev libxml2-dev sqlite-dev bsd-compat-headers \
        gsm-dev speex-dev speexdsp-dev libsrtp-dev opus-dev portaudio-dev net-snmp-dev \
        openldap-dev mariadb-dev libical-dev neon-dev expat-dev linux-headers libedit-dev \
        libogg-dev libxslt-dev binutils-dev popt-dev spandsp-dev libvorbis-dev \
        autoconf libtool automake python2-dev texinfo

echo "#################################################################"
echo "# Download everything....                                       #"
echo "#################################################################"
cd /tmp/build/
pip install j2cli >> /tmp/build.log 2>&1
git clone https://github.com/meduketto/iksemel.git >> /tmp/build.log 2>&1
git clone https://github.com/asterisk/pjproject.git >> /tmp/build.log 2>&1
git clone https://github.com/asterisk/asterisk.git >> /tmp/build.log 2>&1
git clone https://github.com/realM4C/asterisk-gui.git >> /tmp/build.log 2>&1
echo "#################################################################"
echo "# Build iksemel....                                             #"
echo "#################################################################"
cd /tmp/build/iksemel/
./autogen.sh >> /tmp/build.log 2>&1
./configure >> /tmp/build.log 2>&1
make -j ${CORES} >> /tmp/build.log 2>&1
make check >> /tmp/build.log 2>&1
make install >> /tmp/build.log 2>&1
echo "#################################################################"
echo "# Build pjproject....                                           #"
echo "#################################################################"
cd /tmp/build/pjproject
./configure \
                --enable-shared \
                --disable-opencore-amr \
                --disable-resample \
                --disable-sound \
                --disable-video \
                --disable-opencore-amr \
                --with-external-speex \
                --with-external-gsm \
                --with-external-srtp \
                --with-external-pa >> /tmp/build.log 2>&1
cp /tmp/build/config_site.h /tmp/build/pjproject/pjlib/include/pj/
make dep >> /tmp/build.log 2>&1
make -j ${CORES} >> /tmp/build.log 2>&1
make install >> /tmp/build.log 2>&1
echo "#################################################################"
echo "# Build asterisk....                                            #"
echo "#################################################################"
cd /tmp/build/asterisk
./configure --with-resample >> /tmp/build.log 2>&1
make menuselect/menuselect menuselect-tree menuselect.makeopts
menuselect/menuselect --enable res_config_mysql menuselect.makeopts
menuselect/menuselect --enable app_mysql menuselect.makeopts
menuselect/menuselect --enable cdr_mysql menuselect.makeopts
menuselect/menuselect --enable app_skel menuselect.makeopts
menuselect/menuselect --enable app_fax menuselect.makeopts
menuselect/menuselect --enable app_statsd menuselect.makeopts
menuselect/menuselect --enable res_ari_mailboxes menuselect.makeopts
menuselect/menuselect --enable res_stasis_mailbox menuselect.makeopts
menuselect/menuselect --enable res_chan_stats menuselect.makeopts
menuselect/menuselect --enable res_endpoint_stats menuselect.makeopts
menuselect/menuselect --disable BUILD_NATIVE menuselect.makeopts
menuselect/menuselect --enable BETTER_BACKTRACES menuselect.makeopts
menuselect/menuselect --enable BUSYDETECT_COMPARE_TONE_AND_SILENCE menuselect.makeopts
menuselect/menuselect --enable CORE-SOUNDS-EN-ULAW menuselect.makeopts
menuselect/menuselect --enable CORE-SOUNDS-EN-ALAW menuselect.makeopts
menuselect/menuselect --enable CORE-SOUNDS-EN-G722 menuselect.makeopts
menuselect/menuselect --enable CORE-SOUNDS-EN-GSM menuselect.makeopts
menuselect/menuselect --enable CORE-SOUNDS-EN-SLN16 menuselect.makeopts
menuselect/menuselect --enable CORE-SOUNDS-EN-WAV menuselect.makeopts
menuselect/menuselect --enable MOH-OPSOUND-ULAW menuselect.makeopts
menuselect/menuselect --enable MOH-OPSOUND-ALAW menuselect.makeopts
menuselect/menuselect --enable MOH-OPSOUND-G722 menuselect.makeopts
menuselect/menuselect --enable MOH-OPSOUND-GSM menuselect.makeopts
menuselect/menuselect --enable MOH-OPSOUND-SLN16 menuselect.makeopts
menuselect/menuselect --enable MOH-OPSOUND-WAV menuselect.makeopts
menuselect/menuselect --enable EXTRA-SOUNDS-EN-ULAW menuselect.makeopts
menuselect/menuselect --enable EXTRA-SOUNDS-EN-ALAW menuselect.makeopts
menuselect/menuselect --enable EXTRA-SOUNDS-EN-G722 menuselect.makeopts
menuselect/menuselect --enable EXTRA-SOUNDS-EN-GSM menuselect.makeopts
menuselect/menuselect --enable EXTRA-SOUNDS-EN-SLN16 menuselect.makeopts
menuselect/menuselect --enable EXTRA-SOUNDS-EN-WAV menuselect.makeopts
make -j ${CORES} >> /tmp/build.log 2>&1
make install >> /tmp/build.log 2>&1
make config >> /tmp/build.log 2>&1
make samples >> /tmp/build.log 2>&1
make basic-pbx >> /tmp/build.log 2>&1
make install-logrotate >> /tmp/build.log 2>&1
make progdocs >> /tmp/build.log 2>&1
if [ "x${ASTERISK_INST_GUI}" = "xyes" ]; then
echo "#################################################################"
echo "# Build asterisk-gui-2.0....                                    #"
echo "#################################################################"
cd /tmp/build/asterisk-gui-2.0
./configure >> /tmp/build.log 2>&1
make -j ${CORES} >> /tmp/build.log 2>&1
make install >> /tmp/build.log 2>&1
else
echo "#################################################################"
echo "# Not Build asterisk-gui-2.0....                                #"
echo "#################################################################"
fi
echo "#################################################################"
echo "# Get Language ${ASTERISK_EXTRA_LANG}....                                           #"
echo "#################################################################"
cd /tmp/build
curl -sL https://www.asterisksounds.org/${ASTERISK_EXTRA_LANG}/download/asterisk-sounds-core-${ASTERISK_EXTRA_LANG}-sln16.zip > core.zip
curl -sL https://www.asterisksounds.org/${ASTERISK_EXTRA_LANG}/download/asterisk-sounds-extra-${ASTERISK_EXTRA_LANG}-sln16.zip > extra.zip
mkdir /var/lib/asterisk/sounds/de
unzip -o core.zip -d /var/lib/asterisk/sounds/de/ >> /tmp/build.log 2>&1
unzip -o extra.zip -d /var/lib/asterisk/sounds/de/ >> /tmp/build.log 2>&1

# Setup user permissions
echo "#################################################################"
echo "# Setup User Permissions....                                    #"
echo "#################################################################"
addgroup -g ${ASTERISK_GID} ${ASTERISK_GROUP} >> /tmp/build.log 2>&1
adduser -h /var/lib/asterisk -G ${ASTERISK_GROUP} -H -D -u ${ASTERISK_UID} ${ASTERISK_USER} >> /tmp/build.log 2>&1
mkdir /var/run/asterisk >> /tmp/build.log 2>&1
mkdir /var/log/asterisk >> /tmp/build.log 2>&1
chown -R asterisk.asterisk /var/lib/asterisk
chown -R asterisk:asterisk /var/log/asterisk
chown -R asterisk:asterisk /var/run/asterisk
chown -R asterisk:asterisk /var/spool/asterisk
chown -R asterisk:asterisk /usr/lib/asterisk
chown -R asterisk:asterisk /etc/asterisk
#chown -R asterisk:asterisk /dev/zap
#chown -R asterisk:asterisk /dev/dahdi
#chmod -R u=rwX,g=rX,o= /var/lib/asterisk
#chmod -R u=rwX,g=rX,o= /var/log/asterisk
#chmod -R u=rwX,g=rX,o= /var/run/asterisk
#chmod -R u=rwX,g=rX,o= /var/spool/asterisk
#chmod -R u=rwX,g=rX,o= /usr/lib/asterisk
#chmod -R u=rwX,g=rX,o= /etc/asterisk

# Cleanup
echo "#################################################################"
echo "# Cleanup everything....                                        #"
echo "#################################################################"
apk del ${APK_PARAM} \
        build-base git libical neon portaudio net-snmp doxygen \
        ncurses-dev util-linux-dev jansson-dev libxml2-dev sqlite-dev bsd-compat-headers \
        gsm-dev speex-dev speexdsp-dev libsrtp-dev opus-dev portaudio-dev net-snmp-dev \
        openldap-dev mariadb-dev libical-dev neon-dev expat-dev linux-headers libedit-dev \
        libogg-dev libxslt-dev binutils-dev popt-dev spandsp-dev libvorbis-dev \
        autoconf libtool automake python2-dev texinfo
rm -r /tmp/build/
echo "#################################################################"
echo "# Display Build log....                                         #"
echo "#################################################################"
cat /tmp/build.log
