int complete_flush()
{
	unsigned short*  charBuffer=(unsigned short*)0xB8000;
	unsigned char character = 'V';
	*charBuffer = (0x1F << 8)|character;
	return 0;
}

