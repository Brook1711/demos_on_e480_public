; asm3-2.s
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
			MOV  r3, 0x0A		; 把待转换的一位16进制数放入R3第4位
			CMPS  r3, #9		; 判断R3是否已大于9
			BLE  Next		; 不大于9则跳转
			ADD  r3, r3, #7		; 大于9，预增7
Next
			ADD  r3, r3, #'0' 	; 转换为ASCII码
			; 此时R3低8位是转换后的ASCII码
deadloop
			B   deadloop		; 无限循环
			NOP
			END
