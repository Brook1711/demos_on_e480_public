; asm3-5.s
N			EQU		10	; ���峣��NֵΪ10

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
			; ��ʼ���Ĵ���
			LDR  r0,  =N		; ��ʼ��ѭ������ֵ
			BL  funcadd
			; ��ʱR1���Ǽ�����
deadloop
			B   deadloop		; ����ѭ��
; �ӳ�����ڲ���R0�����ڲ���R1
funcadd
			MOV  r1,  #0		; ��ʼ��������
			; ����ֵ N,N-1,...,2,1��ӣ��������� R1 ��
loop
			ADD  r1,  r0	; R1 = R1 + R0
			SUBS  r0,  #1	; ��СR0, ���±�־λ ('S' ��׺)
			BNE	 loop		; ����һ��SUBSָ���������0�������� loop
			BX   LR		; �ӳ��򷵻�
			NOP
			END
