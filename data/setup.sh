#!/bin/bash
function __set_env(){
	if [ "x" = "x${ASTERISK_UID}" ]		; then ASTERISK_UID="9009"		; fi
	if [ "x" = "x${ASTERISK_GID}" ]		; then ASTERISK_GID="9009"		; fi
	if [ "x" = "x${ASTERISK_USER}" ]	; then ASTERISK_USER="9009"		; fi
	if [ "x" = "x${ASTERISK_GROUP}" ]	; then ASTERISK_GROUP="9009"		; fi
	if [ "x" = "x${ASTERISK_TZ}" ]		; then ASTERISK_TZ="Europe/Berlin"	; fi
	if [ "x" = "x${ASTERISK_VER}" ]		; then ASTERISK_VER="13.16.0-rc2"	; fi
	if [ "x" = "x${ASTERISK_DEVEL}" ]	; then ASTERISK_DEVEL="no"		; fi
	if [ "x" = "x${ASTERISK_EXTRA_LANG}" ]	; then ASTERISK_EXTRA_LANG="de"		; fi
	if [ "x" = "x${ASTERISK_EXTRA_PJSIP}" ]	; then ASTERISK_EXTRA_PJSIP="no"	; fi
	if [ "x" = "x${ASTERISK_EXTRA_OPUS}" ]	; then ASTERISK_EXTRA_OPUS="1.1.4"	; fi
	if [ "x" = "x${ASTERISK_INST_GUI}" ]	; then ASTERISK_INST_GUI="no"		; fi
	DEBIAN_FRONTEND=noninteractive
	CORES="$(( $(cat /proc/cpuinfo | grep processor | tail -n1 | awk '{print $3}') + 1 ))"
	MEM="$(cat /proc/meminfo | grep MemTotal | awk '{print $2}') kB"
	PKGP="-q -y --no-install-recommends"
	PKG_SERVICE="nano tar htop curl tzdata"
#PKG_DEV="uuid-dev libxml2-dev libjansson-dev libncurses5-dev libgsm1-dev libspeex-dev libspeexdsp-dev libssl-dev libsqlite3-dev unixodbc-dev libsrtp0-dev libasound2-dev libmysqlclient-dev"
	PKG_DEV="autotools-dev binutils-dev comerr-dev corosync-dev dpkg-dev freetds-dev libasound2-dev:amd64 libasprintf-dev:amd64 libatk1.0-dev libbluetooth-dev libbsd-dev:amd64 libc-client2007e-dev libc-dev-bin libc6-dev:amd64 libcairo2-dev libcfg-dev libconfdb-dev libcoroipcc-dev libcoroipcs-dev libcorosync-dev libcpg-dev libcurl4-gnutls-dev:amd64 libdbus-1-dev:amd64 libedit-dev:amd64 libevs-dev libexpat1-dev:amd64 libfontconfig1-dev:amd64 libfreetype6-dev libgcc-4.9-dev:amd64 libgdk-pixbuf2.0-dev libgettextpo-dev:amd64 libglib2.0-cil-dev libglib2.0-dev libgsm1-dev:amd64 libgtk2.0-cil-dev libgtk2.0-dev libharfbuzz-dev libical-dev libice-dev:amd64 libiksemel-dev:amd64 libjack-jackd2-dev:amd64 libjansson-dev:amd64 libjbig-dev:amd64 libjpeg-dev libjpeg62-turbo-dev:amd64 libldap2-dev:amd64 liblogsys-dev libltdl-dev:amd64 liblua5.1-0-dev:amd64 liblzma-dev:amd64 libmysqlclient-dev libncurses5-dev:amd64 libneon27-dev libnewt-dev:amd64 libobjc-4.9-dev:amd64 libogg-dev:amd64 libpam0g-dev:amd64 libpango1.0-dev libpci-dev libpcre3-dev:amd64 libpixman-1-dev libpload-dev libpng12-dev:amd64 libpopt-dev:amd64 libpq-dev libpthread-stubs0-dev:amd64 libpython-dev:amd64 libpython2.7-dev:amd64 libquorum-dev libreadline-dev:amd64 libreadline6-dev:amd64 libresample1-dev libsam-dev libsensors4-dev libslang2-dev:amd64 libsm-dev:amd64 libsnmp-dev libspandsp-dev:amd64 libspeex-dev:amd64 libspeexdsp-dev:amd64 libsqlite0-dev libsqlite3-dev:amd64 libsrtp0-dev libssl-dev:amd64 libstdc++-4.9-dev:amd64 libtiff5-dev:amd64 libtinfo-dev:amd64 libtotem-pg-dev libusb-dev libvorbis-dev:amd64 libvotequorum-dev libwrap0-dev:amd64 libx11-dev:amd64 libxau-dev:amd64 libxcb-render0-dev:amd64 libxcb-shm0-dev:amd64 libxcb1-dev:amd64 libxcomposite-dev libxcursor-dev:amd64 libxdamage-dev:amd64 libxdmcp-dev:amd64 libxext-dev:amd64 libxfixes-dev:amd64 libxft-dev libxi-dev libxinerama-dev:amd64 libxml2-dev:amd64 libxrandr-dev:amd64 libxrender-dev:amd64 libxslt1-dev:amd64 linux-libc-dev:amd64 portaudio19-dev python-dev python2.7-dev unixodbc-dev uuid-dev:amd64 x11proto-composite-dev x11proto-core-dev x11proto-damage-dev x11proto-fixes-dev x11proto-input-dev x11proto-kb-dev x11proto-randr-dev x11proto-render-dev x11proto-xext-dev x11proto-xinerama-dev xtrans-dev zlib1g-dev:amd64"
	PKG_LIBS="libxml2 libxslt1.1 libjansson4 libedit2 libiksemel3 libjack0 libresample1 libmysqlclient18 libportaudio2 libgsm1 libspeex1 libspeexdsp1 libvorbis0a libvorbisenc2 libvorbisfile3 libogg0 libcurl3-gnutls libspeex1 libspeexdsp1 liblua5.1-0 libneon27 libical1a libsqlite3-0 libcpg4 libcfg4 libspandsp2 libtiff5 libodbc1 libsensors4 libpci3 libwrap0 libsrtp0 libsnmp30 libsqlite0"
	PKG_LIBS_UNUSED="libbluetooth3 libpq5 libsybdb5 libasound2 libx11-6"
	PKG_BUILD="wget subversion git ca-certificates build-essential pkg-config autoconf automake gtk2.0 xmlstarlet aptitude doxygen unzip"
	PKG_RUN="openssl sqlite3 fail2ban iptables"
	echo ""
}
function __init(){
	echo "#################################################################"
	echo "# Installing Depencies....                                      #"
	apt-get update ${PKGP} >> /tmp/build.log 2>&1
	apt-get upgrade ${PKGP} >> /tmp/build.log 2>&1
	apt-get install ${PKGP} ${PKG_RUN} ${PKG_SERVICE} ${PKG_DEV} ${PKG_LIBS} ${PKG_BUILD} >> /tmp/build.log 2>&1
	cp /usr/share/zoneinfo/${ASTERISK_TZ} /etc/localtime >> /tmp/build.log 2>&1
	echo ""
}
function __download(){
	echo "#################################################################"
	echo "# Download everything....                                       #"
	cd /tmp/build/
	if [ "x${ASTERISK_EXTRA_PJSIP}" != "xno" ]; then
		echo "# Downloading PJSIP in Version ${ASTERISK_EXTRA_PJSIP}..."
		echo "########  PJSIP  ########" >> /tmp/build.log 2>&1
		wget -nv -O pjproject.tar.bz2 http://www.pjsip.org/release/${ASTERISK_EXTRA_PJSIP}/pjproject-${ASTERISK_EXTRA_PJSIP}.tar.bz2 >> /tmp/build.log 2>&1
		mkdir -p pjproject >> /tmp/build.log 2>&1
		tar xjvf pjproject.tar.bz2 -C ./pjproject --strip-components=1 >> /tmp/build.log 2>&1
		rm pjproject.tar.bz2 >> /tmp/build.log 2>&1
	fi
	if [ "x${ASTERISK_EXTRA_OPUS}" != "xno" ]; then
		echo "# Downloading OPUS in Version ${ASTERISK_EXTRA_OPUS}..."
		echo "########  OPUS  ########" >> /tmp/build.log 2>&1
		wget -nv -O opus.tar.gz http://downloads.xiph.org/releases/opus/opus-${ASTERISK_EXTRA_OPUS}.tar.gz >> /tmp/build.log 2>&1
		mkdir -p opus >> /tmp/build.log 2>&1
		tar -xzvf opus.tar.gz -C ./opus --strip-components=1 >> /tmp/build.log 2>&1
		rm opus.tar.gz >> /tmp/build.log 2>&1
	fi
	echo "# Downloading ASTERISK in Version ${ASTERISK_VER}..."
	echo "########  ASTERISK  ########" >> /tmp/build.log 2>&1
	wget -nv -O asterisk.tar.gz http://downloads.asterisk.org/pub/telephony/asterisk/releases/asterisk-${ASTERISK_VER}.tar.gz >> /tmp/build.log 2>&1
	mkdir -p asterisk >> /tmp/build.log 2>&1
	tar -xzvf asterisk.tar.gz -C ./asterisk --strip-components=1 >> /tmp/build.log 2>&1
	rm asterisk.tar.gz >> /tmp/build.log 2>&1
	wget -nv -O codec_g729.so http://asterisk.hosting.lv/bin/codec_g729-ast140-gcc4-glibc-x86_64-pentium4.so >> /tmp/build.log 2>&1
	echo ""
}
function __build(){
	echo "#################################################################"
	echo "# Build everything....                                          #"
	cd /tmp/build/
	if [ "x${ASTERISK_EXTRA_PJSIP}" != "xno" ]; then
		echo "# Building PJSIP in Version ${ASTERISK_EXTRA_OPUS}..."
		echo "########  PJSIP  ########" >> /tmp/build.log 2>&1
		cd pjproject
	fi
	cd /tmp/build/
	if [ "x${ASTERISK_EXTRA_OPUS}" != "xno" ]; then
		echo "# Building OPUS in Version ${ASTERISK_EXTRA_OPUS}..."
		echo "########  OPUS  ########" >> /tmp/build.log 2>&1
		cd opus
		./configure >> /tmp/build.log 2>&1
		make all -j ${CORES} >> /tmp/build.log 2>&1
		make install >> /tmp/build.log 2>&1
		make check >> /tmp/build.log 2>&1
	fi
	cd /tmp/build/
	echo "# Building ASTERISK in Version ${ASTERISK_VER}..."
	echo "########  ASTERISK  ########" >> /tmp/build.log 2>&1
	cd asterisk
	./bootstrap.sh >> /tmp/build.log 2>&1
	sh contrib/scripts/get_mp3_source.sh >> /tmp/build.log 2>&1
	mv contrib/scripts/install_prereq contrib/scripts/install_prereq.orig
	sed 's/libvpb\-dev//g' contrib/scripts/install_prereq.orig > contrib/scripts/install_prereq
	chmod +x contrib/scripts/install_prereq
	sh contrib/scripts/install_prereq install-unpackaged >> /tmp/build.log 2>&1
	./configure --with-crypto --with-ssl --with-pjproject-bundled --with-resample --libdir=/usr/lib/x86_64-linux-gnu >> /tmp/build.log 2>&1
	make menuselect.makeopts >> /tmp/build.log 2>&1
	/tmp/build/menuselect.sh >> /tmp/build.log 2>&1
	make -j ${CORES} >> /tmp/build.log 2>&1
	make install >> /tmp/build.log 2>&1
	make samples >> /tmp/build.log 2>&1
	make config >> /tmp/build.log 2>&1
	make install-logrotate >> /tmp/build.log 2>&1
	mv codec_g729.so /usr/lib/x86_64-linux-gnu/asterisk/modules/ >> /tmp/build.log 2>&1
	if [ "x${ASTERISK_DEVEL}" = "yes" ]; then
		make progdocs >> /tmp/build.log 2>&1
	fi
	touch /var/log/auth.log /var/log/asterisk/messages /var/log/asterisk/security /var/log/asterisk/cdr-csv >> /tmp/build.log 2>&1
	echo ""
}
function __i18n(){
	echo "#################################################################"
	echo "# Get Language ${ASTERISK_EXTRA_LANG}....                                           #"
	cd /tmp/build
	wget -nv -O core.zip https://www.asterisksounds.org/${ASTERISK_EXTRA_LANG}/download/asterisk-sounds-core-${ASTERISK_EXTRA_LANG}-sln16.zip >> /tmp/build.log 2>&1
	wget -nv -O extra.zip https://www.asterisksounds.org/${ASTERISK_EXTRA_LANG}/download/asterisk-sounds-extra-${ASTERISK_EXTRA_LANG}-sln16.zip >> /tmp/build.log 2>&1
	mkdir /var/lib/asterisk/sounds/de >> /tmp/build.log 2>&1
	unzip -o core.zip -d /var/lib/asterisk/sounds/de/ >> /tmp/build.log 2>&1
	unzip -o extra.zip -d /var/lib/asterisk/sounds/de/ >> /tmp/build.log 2>&1
	echo ""
}
function __f2b(){
	echo "#################################################################"
	echo "# Setup Fail2Ban....                                            #"
	rm /etc/fail2ban/filter.d/asterisk.conf >> /tmp/build.log 2>&1
	cp /tmp/build/f2b_asterisk*.conf /etc/fail2ban/filter.d/ >> /tmp/build.log 2>&1
	cat /tmp/build/jail.conf >> /etc/fail2ban/jail.conf >> /tmp/build.log 2>&1
	echo ""
}
function __cleanup(){
	echo "#################################################################"
	echo "# Clean up everthing and everywhere....                         #"
	apt-get remove --purge ${PKGP} ${PKG_BUILD} ${PKG_DEV} >> /tmp/build.log 2>&1
	apt-get autoremove ${PKGP} >> /tmp/build.log 2>&1
	apt-get clean ${PKGP} >> /tmp/build.log 2>&1
	rm -rf /tmp/build /var/tmp/* >> /tmp/build.log 2>&1
	rm -rf /var/lib/apt/lists/* >> /tmp/build.log 2>&1
	echo ""
	echo "#  DONE DONE DONE DONE DONE DONE DONE DONE DONE DONE DONE DONE  #"
	echo "#################################################################"
}

__set_env
echo "#################################################################"
echo "# Detected ${CORES} CPUs                                               #"
echo "# Detected ${MEM} Memory                                    #"
echo "#################################################################"
__init
__download
__build
__i18n
__f2b
__cleanup

echo "#################################################################"
echo "# Display Build log....                                         #"
echo "#################################################################"
cat /tmp/build.log

exit 0





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

