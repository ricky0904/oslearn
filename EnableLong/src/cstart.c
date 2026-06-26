#define RSDP_SIGNATURE "RSD PTR "



unsigned char* RSDPSearchStart = (unsigned char*)0xE0000;
unsigned char* RSDPSearchEnd = (unsigned char*)0xFFFFF;


int RSDPSignatureCmp(unsigned char* InputPtr)
{
	if (*InputPtr == 'R' && 
		*(InputPtr+1) == 'S' &&
		*(InputPtr+2) == 'D' &&
		*(InputPtr+3) == ' ' &&
		*(InputPtr+4) == 'P' &&
		*(InputPtr+5) == 'T' &&
		*(InputPtr+6) == 'R' &&
		*(InputPtr+7) == ' ')
	{
		return 1;
	}
	return 0;
	
}


int cstart()
{
	//short* a;
	//volatile short* a = (volatile short *)0xB8000;
	//short b = *a;
	//volatile unsigned long long *PT; 
	//unsigned char
	//PT = (volatile unsigned long long *)0x14000;
	//printchar();
	//long a = 2;
	int RSDPfound = 0;	
	for (unsigned char* ptr = RSDPSearchStart; ptr <= RSDPSearchEnd  
	return 0;
}
