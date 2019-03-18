// add.c
extern  int  my_add_asm(int x1, int x2, int x3, int x4, int x5, int x6);
void  testfunc ()
{
	int  y = 0;
	y  =  my_add_asm(1,2,3,4,5,6);
	int z = y;
}
