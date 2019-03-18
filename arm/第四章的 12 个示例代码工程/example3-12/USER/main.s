;
;ʵ�����ƣ�LED��ʱ��˸ʵ��
;
;Ӳ��ģ�飺�����ԭ��Ӧ��ʵ����
;
;Ӳ�����ߣ�ARM P12�ӿ�---------LED P2�ӿ�
;           PF0~PF7----------LED1~LED8
;		     ע����ʹ��20P����ֱ��P12��P2�ӿڡ�
;					 
;ʵ������LED��ÿ500�����ƽ��תһ�Σ�ʵ����ʱ��˸Ч����
;
;����ʱ�䣺2018-10-11
;**************************************************************
        THUMB
        REQUIRE8
        PRESERVE8

__ARM_use_no_argv EQU 0

        EXPORT __ARM_use_no_argv
        EXPORT main

        IMPORT RCC_AHB1PeriphClockCmd
        IMPORT GPIO_Init
        IMPORT Delay_Init
        IMPORT GPIO_Write
        IMPORT Delay_Ms

        AREA ||i.main||, CODE, READONLY, ALIGN=2

|GPIOF|
        DCD      0x40021400
;int main(void)		
main PROC
        PUSH     {r2-r4,lr}
        MOVS     r1,#1
        MOVS     r0,#0x20
        BL       RCC_AHB1PeriphClockCmd	;����GPIOF��ʱ��
        MOV      r0,#0xffff
        STR      r0,[sp,#0]				;ѡ�����ţ�ȫ������
        MOVS     r0,#1	
        STRB     r0,[sp,#4]				;���ģʽ
        MOVS     r0,#0	
        STRB     r0,[sp,#6]				;�������
        MOVS     r0,#1	
        STRB     r0,[sp,#5]				;�������25MHz
        MOV      r1,sp
        LDR      r0,|GPIOF|
        BL       GPIO_Init				;�˿ڳ�ʼ��
        BL       Delay_Init				;��ʱ��ʼ��
        MOVS     r1,#0xff				
        LDR      r0,|GPIOF|					
        BL       GPIO_Write				;GPIOF����ֵ
        B        |while|
		
|loop|
        MOVS     r1,#0
        LDR      r0,|GPIOF|				;GPIOFд0x00��LED��Ϩ��
        BL       GPIO_Write
        MOV      r0,#0x1f4
        BL       Delay_Ms				;��ʱ500ms
        MOVS     r1,#0xff
        LDR      r0,|GPIOF|				;GPIOFд0xff��LED�Ƶ��� 
        BL       GPIO_Write
        MOV      r0,#0x1f4
        BL       Delay_Ms				;��ʱ500ms
|while|
        B        |loop|
        ENDP

        END
