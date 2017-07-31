#include <stdio.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdint.h>
#include <string.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <linux/types.h>
#include <linux/spi/spidev.h>
#define ARRAY_SIZE(array) sizeof(array)/sizeof(array[0])

#define BUF_SIZE 4

static char __str2char(char byte)
{
	char ret;

	if(byte <= 0x39)
		ret = byte - 0x30;
	else
		ret = byte - 0x57;

	return ret;
}

static uint8_t str2char(char *string)
{
	char high;
	char low;
	uint8_t ret;
	int _ret;

	if(strncmp(string, "0x", 2))
	{
		printf("Not the right format\n");
		exit(1);
	}
	else 
	{
		high = string[2];
		low = string[3];
	}

	low = __str2char(low);
	high = __str2char(high);
	_ret = high << 4 | low;
	ret = (uint8_t) _ret;

#ifdef DEBUG
	printf("Low: 0x%02x\n", low);
	printf("High: 0x%02x\n", high);
	printf("_ret: 0x%02x\n", _ret);
	printf("ret: 0x%02x\n", ret);
#endif

	return ret;
}

static int do_read(int fd, int len, uint8_t addr)
{
	uint8_t buf[BUF_SIZE];
	int ret, i;
	struct spi_ioc_transfer xfer[2];

	memset(xfer, 0, sizeof(xfer));
	memset(buf, 0, sizeof(buf));

	buf[0] = addr;
	xfer[0].tx_buf = (unsigned long) buf;
	xfer[0].len = 1;

	xfer[1].rx_buf = (unsigned long) buf;
	xfer[1].len = len;

	ret = ioctl(fd, SPI_IOC_MESSAGE(2), xfer);

	if (ret <= 0)
	{
		perror("Recieve Error");
		return -1;
	}

	/*printf("response(%2d, %2d): ", len, ret);*/
	for (i = 0; i < len; i++)
		printf("[0x%02X]", buf[i]);
	printf("\n");

	return ret;
}


int main(int argc, char *argv[])
{
	int fd, len;
	uint8_t addr;

	if (argc < 4)
	{
		printf("Usage:\n%s [device] [addr] [len]\n", argv[0]);
		exit(1);
	}

	addr = str2char(argv[2]);
	len = atoi(argv[3]);

	fd = open(argv[1], O_RDWR);

	if (fd <= 0)
	{
		printf("%s: Device %s not found\n", argv[0], argv[1]);
		exit(1);
	}

	do_read(fd, len, addr); 

	return 0;
}
