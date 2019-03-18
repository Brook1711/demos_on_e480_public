; asm3-9.s
			THUMB		; Indicate THUMB code is used
			PRESERVE8	; Indicate the code here preserve 
						; 8 byte stack alignment
			AREA    |.text|, CODE, READONLY		; Start of CODE area
	IMPORT |Image$$ER_IROM1$$RO$$Base|	; RO段起始地址
	IMPORT |Image$$ER_IROM1$$RO$$Limit|	; RO段末地址后面的地址,即RW段起始地址
	IMPORT |Image$$RW_IRAM1$$RW$$Base|	; RW段在RAM里的运行区起始地址
	IMPORT |Image$$RW_IRAM1$$RW$$Limit| ;RW段在RAM里的运行区末地址后面的地址
	IMPORT |Image$$RW_IRAM1$$ZI$$Base|	; ZI段在RAM里的运行区起始地址
	IMPORT |Image$$RW_IRAM1$$ZI$$Limit|	;ZI段在RAM里的运行区末地址后面的地址
			EXPORT  MyMain
MyMain		FUNCTION
; RW段和ZI段初始化代码（第25-41行）：完成RW段数据的拷贝和ZI段的清零
			; RW段数据的拷贝：从Image里的加载区拷贝到RAM里运行区（第26-34行）
			LDR  r0,  =|Image$$ER_IROM1$$RO$$Limit|
			LDR  r1,  =|Image$$RW_IRAM1$$RW$$Base|
			LDR  r3,  =|Image$$RW_IRAM1$$ZI$$Base|
Init_RW
			CMP  r1,  r3
			LDRCC r2,  [r0], #4
			STRCC r2,  [r1], #4
			BCC  Init_RW
			; ZI段清零：ZI段在RAM里的运行区全部清零（第35-41行）
			LDR  r1,  =|Image$$RW_IRAM1$$ZI$$Limit|
			MOV  r2,  #0
Init_ZI
			CMP  r3,  r1
			STRCC r2,  [r3],#4
			BCC  Init_ZI

; 功能代码：此处调用C函数testfunc
			IMPORT  testfunc		;引入其它源文件中的函数名testfunc
			BL  testfunc			;调用testfunc函数
deadloop
			B   deadloop		; 无限循环
			ENDFUNC

; 汇编函数my_add_asm
			EXPORT  my_add_asm
my_add_asm	FUNCTION
			ADD  R0, R0, R1		;R0 = x1 + x2
			ADD  R0, R0, R2		;R0 = x1 + x2 + x3
			ADD  R0, R0, R3		;R0 = x1 + x2 + x3 + x4
			LDR  R1,  [SP]		;从 栈顶 位置取出x5到R1
			ADD  R0, R0, R1		;R0 = x1 + x2 + x3 + x4 + x5
			LDR  R2,  [SP,  #4]	;从 栈顶+4 位置取出x6到R2
			ADD  R0, R0, R2		;R0 = x1 + x2 + x3 + x4 + x5 + x6
			BX  LR				;返回结果位于R0中
			ENDFUNC
			NOP
			END
