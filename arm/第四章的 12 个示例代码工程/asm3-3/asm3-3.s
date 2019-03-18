; asm3-3.s
N1			EQU		456
N2			EQU		1278
N3			EQU		85

; ջ����
Stack_Size		EQU		0x00000400	; ����ջ�ռ��С
			AREA    MyStack, NOINIT, READWRITE, ALIGN=3	; ����ջ��
Stack_Mem	SPACE   Stack_Size		; �����ڴ�ռ�
__initial_sp

; �쳣/�ж���������λ��������λ�ڵ�ַ 0 ����
			AREA    Reset, DATA, READONLY	; ����Reset���ݶ�
__Vectors		DCD     __initial_sp		; ջ����ַ��MSP��ʼֵ��
			DCD     Reset_Handler		; ����λ���쳣����������ʼ��ַ

			THUMB		; ��ʾ�������Ĵ���ΪTHUMBָ�
			PRESERVE8	; ��ʾ�������Ĵ��뱣��8 �ֽ�ջ����
			AREA    Init, CODE, READONLY		; ���������
			ENTRY
; ����λ���쳣�������
Reset_Handler
			LDR  r0,  =N1		; ȡ��1����
			LDR  r1,  =N2		; ȡ��2����
			LDR  r2,  =N3		; ȡ��3����
			CMP  r0,  r1		; �Ƚ�r0,  r1��С
			BHI  next			; ��r0������ת��next
			MOV  r0,  r1		; ��r1�������r0
next
			CMP  r0,  r2		; �Ƚ�r0,  r2��С
			BHI  deadloop		; ��r0������ת��deadloop
			MOV  r0,  r2		; ��r2�������r0
			
;			CMP  r0,  r1		; �Ƚ�r0,  r1��С
;			MOVLT  r0,  r1	; ���r0 < r1, �� r1 -> r0
;			CMP  r0,  r2		; �Ƚ�r0,  r2��С
;			MOVLT  r0,  r2	; ���r0 < r2, �� r2 -> r0
			
deadloop
			B   deadloop		; ����ѭ��
			NOP
			END
