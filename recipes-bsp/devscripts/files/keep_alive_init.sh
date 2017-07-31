#! /bin/sh

case $1 in
	start)
    start-stop-daemon -x /usr/bin/keep_alive -m -b -p /var/run/keep_alive.pid -S
		;;
	stop)
    start-stop-daemon -p /var/run/keep_alive.pid -K
		spi_write /dev/spidev2.1 0x08 0xff
		spi_write /dev/spidev2.1 0x10 0x02
		;;
	*)
		exit 1
esac
