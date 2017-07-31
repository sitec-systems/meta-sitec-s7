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

static int do_write(int fd, uint8_t cmd, uint8_t data)
{
	uint8_t wr_buf[] = {cmd, data};
	int ret;

	ret = write(fd, wr_buf, ARRAY_SIZE(wr_buf));

	if (ret != ARRAY_SIZE(wr_buf))
	{
		perror("Transmit Error");
		return -1;
	}

	return ret;
}


int main(int argc, char *argv[])
{
	int fd, ret;
	uint8_t cmd, data;

	if (argc < 4)
	{
		printf("Usage:\n%s [device] [cmd] [data]\n", argv[0]);
		exit(1);
	}

	cmd = str2char(argv[2]);
	data = str2char(argv[3]);
	
	fd = open(argv[1], O_RDWR);

	if (fd <= 0)
	{
		printf("%s: Device %s not found\n", argv[0], argv[1]);
		exit(1);
	}

	ret = do_write(fd, cmd, data);
    
    close(fd);

	return 0;
}
