#! /bin/sh

spi_write /dev/spidev2.1 0x10 0x01
while [ true ]
do
	spi_write /dev/spidev2.1 0x08 0x20
	sleep 1
	spi_write /dev/spidev2.1 0x08 0xff
	sleep 1
done
