#include <string.h>
#define RSDP_SIGNATURE "RSD PTR "




unsigned char* RSDPSearchStart = (unsigned char*)0xE0000;
unsigned char* RSDPSearchEnd = (unsigned char*)0xFFFFF;

int verifyChecksum(unsigned char* InputPtr)
{
	unsigned char sum = 0;
	for (unsigned char* ptr=InputPtr; ptr <= InputPtr+19; ptr = ptr + 1) 
	{
		sum = sum + *ptr;
	}
	if (sum == 0)
	{
		return 0;
	}
	else
	{
		return 1;
	}

} 


int RSDPSignatureCmp(unsigned char* InputPtr)
{
	int valid = 0;
	unsigned char b[] = RSDP_SIGNATURE; 
	 
	if (*InputPtr == 'R' && 
		*(InputPtr+1) == 'S' &&
		*(InputPtr+2) == 'D' &&
		*(InputPtr+3) == ' ' &&
		*(InputPtr+4) == 'P' &&
		*(InputPtr+5) == 'T' &&
		*(InputPtr+6) == 'R' &&
		*(InputPtr+7) == ' ')
	{
		valid = verifyChecksum(InputPtr);
		valid = strcmp(InputPtr, b);
		return 0;
	}
	else
	{
		return 1;	
	}
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
	for (unsigned char* ptr = RSDPSearchStart; ptr <= RSDPSearchEnd - 7; ptr = ptr + 1)
	{
		RSDPSignatureCmp(ptr);
	} 
	return 0;
}
