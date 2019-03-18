// add.c
__asm  int  my_add_embedded_asm(int x1,int x2,int x3,int x4,int x5,int x6)
{
	ADD  R0, R0, R1		//R0 = x1 + x2
	ADD  R0, R0, R2		//R0 = x1 + x2 + x3
	ADD  R0, R0, R3		//R0 = x1 + x2 + x3 + x4
	LDR  R1,  [SP]		//从 栈顶 位置取出x5到R1
	ADD  R0, R0, R1		//R0 = x1 + x2 + x3 + x4 + x5
	LDR  R2,  [SP,  #4]	//从 栈顶+4 位置取出x6到R2
	ADD  R0, R0, R2		//R0 = x1 + x2 + x3 + x4 + x5 + x6
	BX  LR				//返回结果位于R0中
}

void  testfunc ()
{
	int  y = 0;
	y  =  my_add_embedded_asm (1,2,3,4,5,6);
	int z = y;
}
