; asm3-8.s
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

; 功能代码：此处调用C函数my_add_c
			STMFD  SP!,  {R0-R3, LR}	;调用者负责压栈保存 R0-R3, LR旧值
			STMFD  SP!,  {R4-R5}	;本函数用到了R4-R5,所以负责压栈保存R4-R5旧值
			MOV  R0,  #1		;第1个参数(x1)
			MOV  R1,  #2		;第2个参数(x2)
			MOV  R2,  #3		;第3个参数(x3)
			MOV  R3,  #4		;第4个参数(x4)
			MOV  R4,  #5		;第5个参数(x5)
			MOV  R5,  #6		;第6个参数(x6)
			STMFD  SP!,  {R4-R5}	;注意入栈顺序：x6先入栈，x5后入栈
			IMPORT  my_add_c		;引入其它源文件中的函数名my_add_c
			BL  my_add_c			;调用my_add_c函数，返回结果位于R0中
			LDR  R5,  = Result		;取得变量Result的地址
			STR  R0,  [R5] 		;把my_add_c函数返回结果存入变量Result
			ADD  SP,  SP,  #4	; 清除栈中参数x5,本语句执行完后SP指向栈中参数x6
			ADD  SP,  SP,  #4	; 清除栈中参数x6,本语句执行完后SP指向栈中R4旧值
			LDMFD  SP!,  { R4-R5}		; 弹栈恢复R4-R5旧值
			LDMFD  SP!,  {R0-R3, LR}	; 调用者负责弹栈恢复R0-R3, LR旧值
deadloop
			B   deadloop		; 无限循环
			ENDFUNC
			NOP

			AREA    MyData, DATA, READWRITE	; 声明MyData数据段
Result		DCD		0		; 该变量用于保存my_add_c函数的返回值
			END
