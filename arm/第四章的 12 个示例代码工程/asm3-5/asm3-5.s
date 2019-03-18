; asm3-5.s
N			EQU		10	; 定义常量N值为10

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
			; 初始化寄存器
			LDR  r0,  =N		; 初始化循环计数值
			BL  funcadd
			; 此时R1中是计算结果
deadloop
			B   deadloop		; 无限循环
; 子程序：入口参数R0，出口参数R1
funcadd
			MOV  r1,  #0		; 初始化计算结果
			; 将数值 N,N-1,...,2,1相加，计算结果在 R1 中
loop
			ADD  r1,  r0	; R1 = R1 + R0
			SUBS  r0,  #1	; 减小R0, 更新标志位 ('S' 后缀)
			BNE	 loop		; 若上一条SUBS指令计算结果非0，则跳到 loop
			BX   LR		; 子程序返回
			NOP
			END
