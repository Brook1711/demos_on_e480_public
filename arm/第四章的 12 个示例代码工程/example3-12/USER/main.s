;
;实验名称：LED延时闪烁实验
;
;硬件模块：计算机原理应用实验箱
;
;硬件接线：ARM P12接口---------LED P2接口
;           PF0~PF7----------LED1~LED8
;		     注：可使用20P排线直连P12、P2接口。
;					 
;实验现象：LED灯每500毫秒电平翻转一次，实现延时闪烁效果。
;
;更新时间：2018-10-11
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
        BL       RCC_AHB1PeriphClockCmd	;开启GPIOF的时钟
        MOV      r0,#0xffff
        STR      r0,[sp,#0]				;选择引脚，全部引脚
        MOVS     r0,#1	
        STRB     r0,[sp,#4]				;输出模式
        MOVS     r0,#0	
        STRB     r0,[sp,#6]				;推挽输出
        MOVS     r0,#1	
        STRB     r0,[sp,#5]				;输出速率25MHz
        MOV      r1,sp
        LDR      r0,|GPIOF|
        BL       GPIO_Init				;端口初始化
        BL       Delay_Init				;延时初始化
        MOVS     r1,#0xff				
        LDR      r0,|GPIOF|					
        BL       GPIO_Write				;GPIOF赋初值
        B        |while|
		
|loop|
        MOVS     r1,#0
        LDR      r0,|GPIOF|				;GPIOF写0x00，LED灯熄灭
        BL       GPIO_Write
        MOV      r0,#0x1f4
        BL       Delay_Ms				;延时500ms
        MOVS     r1,#0xff
        LDR      r0,|GPIOF|				;GPIOF写0xff，LED灯点亮 
        BL       GPIO_Write
        MOV      r0,#0x1f4
        BL       Delay_Ms				;延时500ms
|while|
        B        |loop|
        ENDP

        END
