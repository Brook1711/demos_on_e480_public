; asm3-7.s
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
; RW段和ZI段初始化代码（第14-30行）：完成RW段数据的拷贝和ZI段的清零
			; RW段数据的拷贝：从Image里的加载区拷贝到RAM里运行区（第15-23行）
			LDR  r0,  =|Image$$ER_IROM1$$RO$$Limit|
			LDR  r1,  =|Image$$RW_IRAM1$$RW$$Base|
			LDR  r3,  =|Image$$RW_IRAM1$$ZI$$Base|
Init_RW
			CMP  r1,  r3
			LDRCC r2,  [r0], #4
			STRCC r2,  [r1], #4
			BCC  Init_RW
			; ZI段清零：ZI段在RAM里的运行区全部清零（第24-30行）
			LDR  r1,  =|Image$$RW_IRAM1$$ZI$$Limit|
			MOV  r2,  #0
Init_ZI
			CMP  r3,  r1
			STRCC r2,  [r3],#4
			BCC  Init_ZI

; 功能代码：将4位十六进制数转换为相应的ASCII码字符串
			LDR  r0,  =Number		; 待转换的4位十六进制数的地址
			LDR  r1, [r0] 			; 待转换的4位十六进制数存入r1
			LDR  r2,  =String		; 把存放字符串的首地址存入r2
			STMFD  SP!,  {r1-r2 }	; 把R1-R2压入堆栈，倒序压入(先R2后R1)
			BL  Hex2String			; 调用子程序
			LDMFD  SP!,  {r1-r2 }	; 参数出栈（释放保存R1-R2的栈空间）
			; 此时String中是转换完的字符串
deadloop
			B   deadloop		; 无限循环
			ENDFUNC

; 子程序Hex2String：4位十六进制数转换为字符串
Hex2String		FUNCTION
			STMFD  SP!,  {r0-r6, LR}	; 保护现场，R0-R6, LR入栈
			ADD  r6,  SP,  #8*4  ; 使R7指向参数(跳过栈顶的8个寄存器)
			LDR  r0,  [r6], #4	; 取出 待转换的4位十六进制数 到R0，R6加4
			LDR  r1,  [r6] 	; 取出 存放字符串4字节单元 的首地址 到R1
			ADD  r1,  #3		; 使R1指向 存放字符串4字节单元 的最后一个
			MOV  r2,  #4	    ; 循环计数寄存器r2赋初值为4
loop
			MOV  r3,  r0		; 将 待转换的4位十六进制数 复制到R3
			AND  r3,  r3,  #0x0F	; 取出低4位
			BL    Hex2ASCII		; 调用1位16进制数转换为ASCII子程序
			STRB  r3,  [r1],  #-1	; 保存转换结果ASCII
			MOV  r0,  r0,  LSR #4	; R0右移4位，准备处理下一个4位
			SUBS  r2, r2, #1			; 循环计数器减1
			BNE  loop			; 循环计数器不等于0，继续循环
			LDMFD  SP!,  {r0-r6, LR}	; 恢复现场，R0-R6, LR出栈
			BX   LR		; 子程序返回
			ENDFUNC

; 子程序Hex2ASCII：把1位16进制数转换为ASCII，入口参数R3，出口参数R3。
Hex2ASCII 	FUNCTION
			CMPS  r3, #9	; 判断R3是否已大于9
			BLE  Next		; 不大于9则跳转
			ADD  r3, r3, #7		; 大于9，预增7
Next
			ADD  r3, r3, #'0' 	; 转换为ASCII码
			BX   LR			; 子程序返回
			ENDFUNC

			AREA    MyData, DATA, READWRITE	; 声明MyData数据段
Number		DCD		0x8AF5			; 待转换的4位十六进制数
String		DCB		0, 0, 0, 0			; 保存字符串的空间
			END
