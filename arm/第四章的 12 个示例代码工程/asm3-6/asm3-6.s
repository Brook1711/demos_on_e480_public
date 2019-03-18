; asm3-6.s
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
	IMPORT |Image$$ER_IROM1$$RO$$Base|	; RO����ʼ��ַ
	IMPORT |Image$$ER_IROM1$$RO$$Limit|	; RO��ĩ��ַ����ĵ�ַ,��RW����ʼ��ַ
	IMPORT |Image$$RW_IRAM1$$RW$$Base|	; RW����RAM�����������ʼ��ַ
	IMPORT |Image$$RW_IRAM1$$RW$$Limit| ;RW����RAM���������ĩ��ַ����ĵ�ַ
	IMPORT |Image$$RW_IRAM1$$ZI$$Base|	; ZI����RAM�����������ʼ��ַ
	IMPORT |Image$$RW_IRAM1$$ZI$$Limit|	;ZI����RAM���������ĩ��ַ����ĵ�ַ
			ENTRY
; ����λ���쳣�������
Reset_Handler
; RW�κ�ZI�γ�ʼ�����루��25-41�У������RW�����ݵĿ�����ZI�ε�����
			; RW�����ݵĿ�������Image��ļ�����������RAM������������26-34�У�
			LDR  r0,  =|Image$$ER_IROM1$$RO$$Limit|
			LDR  r1,  =|Image$$RW_IRAM1$$RW$$Base|
			LDR  r3,  =|Image$$RW_IRAM1$$ZI$$Base|
Init_RW
			CMP  r1,  r3
			LDRCC r2,  [r0], #4
			STRCC r2,  [r1], #4
			BCC  Init_RW
			; ZI�����㣺ZI����RAM���������ȫ�����㣨��35-41�У�
			LDR  r1,  =|Image$$RW_IRAM1$$ZI$$Limit|
			MOV  r2,  #0
Init_ZI
			CMP  r3,  r1
			STRCC r2,  [r3],#4
			BCC  Init_ZI

; ���ܴ��룺��4λʮ��������ת��Ϊ��Ӧ��ASCII���ַ���
			LDR  r0,  =Number		; ��ת����4λʮ���������ĵ�ַ
			LDR  r1, [r0] 			; ��ת����4λʮ������������r1
			LDR  r2,  =String		; �Ѵ���ַ������׵�ַ����r2
			STMFD  SP!,  {r1-r2 }	; ��R1-R2ѹ���ջ������ѹ��(��R2��R1)
			BL  Hex2String			; �����ӳ���
			LDMFD  SP!,  {r1-r2 }	; ������ջ���ͷű���R1-R2��ջ�ռ䣩
			; ��ʱString����ת������ַ���
deadloop
			B   deadloop		; ����ѭ��
; �ӳ���Hex2String��4λʮ��������ת��Ϊ�ַ���
Hex2String
			STMFD  SP!,  {r0-r6, LR}	; �����ֳ���R0-R6, LR��ջ
			ADD  r6,  SP,  #8*4  ; ʹR7ָ�����(����ջ����8���Ĵ���)
			LDR  r0,  [r6], #4	; ȡ�� ��ת����4λʮ�������� ��R0��R6��4
			LDR  r1,  [r6] 	; ȡ�� ����ַ���4�ֽڵ�Ԫ ���׵�ַ ��R1
			ADD  r1,  #3		; ʹR1ָ�� ����ַ���4�ֽڵ�Ԫ �����һ��
			MOV  r2,  #4	    ; ѭ�������Ĵ���r2����ֵΪ4
loop
			MOV  r3,  r0		; �� ��ת����4λʮ�������� ���Ƶ�R3
			AND  r3,  r3,  #0x0F	; ȡ����4λ
			BL    Hex2ASCII		; ����1λ16������ת��ΪASCII�ӳ���
			STRB  r3,  [r1],  #-1	; ����ת�����ASCII
			MOV  r0,  r0,  LSR #4	; R0����4λ��׼��������һ��4λ
			SUBS  r2, r2, #1			; ѭ����������1
			BNE  loop			; ѭ��������������0������ѭ��
			LDMFD  SP!,  {r0-r6, LR}	; �ָ��ֳ���R0-R6, LR��ջ
			BX   LR		; �ӳ��򷵻�
; �ӳ���Hex2ASCII����1λ16������ת��ΪASCII����ڲ���R3�����ڲ���R3��
Hex2ASCII
			CMPS  r3, #9	; �ж�R3�Ƿ��Ѵ���9
			BLE  Next		; ������9����ת
			ADD  r3, r3, #7		; ����9��Ԥ��7
Next
			ADD  r3, r3, #'0' 	; ת��ΪASCII��
			BX   LR			; �ӳ��򷵻�
			NOP

			AREA    MyData, DATA, READWRITE	; ����MyData���ݶ�
Number		DCD		0x8AF5			; ��ת����4λʮ��������
String		DCB		0, 0, 0, 0			; �����ַ����Ŀռ�
			END
