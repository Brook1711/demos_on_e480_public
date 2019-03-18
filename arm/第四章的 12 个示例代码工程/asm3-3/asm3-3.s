; asm3-3.s
N1			EQU		456
N2			EQU		1278
N3			EQU		85

; 栈配置
Stack_Size		EQU		0x00000400	; 定义栈空间大小
			AREA    MyStack, NOINIT, READWRITE, ALIGN=3	; 声明栈段
Stack_Mem	SPACE   Stack_Size		; 分配内存空间
__initial_sp

; 异常/中断向量表（复位后，向量表位于地址 0 处）
			AREA    Reset, DATA, READONLY	; 声明Reset数据段
__Vectors		DCD     __initial_sp		; 栈顶地址（MSP初始值）
			DCD     Reset_Handler		; “复位”异常处理代码的起始地址

			THUMB		; 表示接下来的代码为THUMB指令集
			PRESERVE8	; 表示接下来的代码保持8 字节栈对齐
			AREA    Init, CODE, READONLY		; 声明代码段
			ENTRY
; “复位”异常处理代码
Reset_Handler
			LDR  r0,  =N1		; 取第1个数
			LDR  r1,  =N2		; 取第2个数
			LDR  r2,  =N3		; 取第3个数
			CMP  r0,  r1		; 比较r0,  r1大小
			BHI  next			; 若r0大则跳转到next
			MOV  r0,  r1		; 若r1大则存入r0
next
			CMP  r0,  r2		; 比较r0,  r2大小
			BHI  deadloop		; 若r0大则跳转到deadloop
			MOV  r0,  r2		; 若r2大则存入r0
			
;			CMP  r0,  r1		; 比较r0,  r1大小
;			MOVLT  r0,  r1	; 如果r0 < r1, 将 r1 -> r0
;			CMP  r0,  r2		; 比较r0,  r2大小
;			MOVLT  r0,  r2	; 如果r0 < r2, 将 r2 -> r0
			
deadloop
			B   deadloop		; 无限循环
			NOP
			END
