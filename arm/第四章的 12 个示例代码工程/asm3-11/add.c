// add.c
int my_add_inline_asm (int x1, int x2, int x3, int x4, int x5, int x6)
{
	__asm
	{
		ADD x1, x2 	// x1+x2
		ADD x1, x3 	// x1+x2+x3
		ADD x1, x4 	// x1+x2+x3+x4
		ADD x1, x5 	// x1+x2+x3+x4+x5
		ADD x1, x6 	// x1+x2+x3+x4+x5+x6
	}
	return (x1);
}

void  testfunc ()
{
	int  y = 0;
	y  =  my_add_inline_asm (1,2,3,4,5,6);
	int z = y;
}
