; start.s
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
			IMPORT  MyMain
			ENTRY
; ����λ���쳣�������
Reset_Handler
			LDR     R0, = MyMain	; ����MyMain�ĵ�ַ
			BX      R0			; ����MyMain
			END
