LJMP START
	LCDstatus equ 0FF2EH
	LCDcontrol equ 0FF2CH
	LCDdataWR equ 0FF2DH
	LCDdataRD equ 0FF2FH

	#define HOME 0x80
	#define INITDISP 0x38
	#define HOM2 0xc0
	#define LCDON 0x0e
	#define CLEAR 0x01	
	P5 EQU 0F8H
	P7 EQU 0DBH

ORG 0100H
	
	LCDcntrlWR MACRO x
			LOCAL loop

	loop:	MOV DPTR, #LCDstatus
			MOVX A, @DPTR
			JB ACC.7, loop

			MOV DPTR, #LCDcontrol
			MOV	A, x
			MOVX @DPTR, A
			ENDM

	LCDcharWR MACRO
			LOCAL loop1, loop2

			PUSH ACC  
	loop1:	MOV DPTR, #LCDstatus
			MOVX A, @DPTR
			JB ACC.7, loop1

	loop2:	MOV DPTR, #LCDdataWR
			POP ACC
			MOVX @DPTR, A
			ENDM

	init_LCD MACRO
			LCDcntrlWR #INITDISP
			LCDcntrlWR #CLEAR
			LCDcntrlWR #LCDON
			ENDM 

	putchrLCD:
			LCDcharWR
			RET

	putstrLCD:
			CLR A
			MOVC A, @A+DPTR
			JZ EXIT
			PUSH DPH
			PUSH DPL
			CALL putchrLCD
			POP DPL
			POP DPH
			INC DPTR
			SJMP putstrLCD
	EXIT:	RET

INITIALIZE:
		MOV DPTR, #80EBH	//0
	MOV A, #30H
	MOVX @DPTR, A

	MOV DPTR, #8077H	   //1
	MOV A, #31H
	MOVX @DPTR, A

	MOV DPTR, #807BH	 //2
	MOV A, #32H
	MOVX @DPTR, A

	MOV DPTR, #807DH	   //3
	MOV A, #33H
	MOVX @DPTR, A

	MOV DPTR, #80B7H	   //4
	MOV A, #34H
	MOVX @DPTR, A

	MOV DPTR, #80BBH		//5
	MOV A, #35H
	MOVX @DPTR, A

	MOV DPTR, #80BDH		//6
	MOV A, #36H
	MOVX @DPTR, A

	MOV DPTR, #80D7H		  //7
	MOV A, #37H
	MOVX @DPTR, A

	MOV DPTR, #80DBH		  //8
	MOV A, #38H
	MOVX @DPTR, A

	MOV DPTR, #80DDH	 //9
	MOV A, #39H
	MOVX @DPTR, A

	MOV DPTR, #807EH    //A
	MOV A, #41H
	MOVX @DPTR, A

	MOV DPTR, #80BEH	   //B
	MOV A, #42H
	MOVX @DPTR, A

	MOV DPTR, #80DEH
	MOV A, #43H
	MOVX @DPTR, A

	MOV DPTR, #80EEH	   //D
	MOV A, #44H
	MOVX @DPTR, A

	MOV DPTR, #80E7H		 //*
	MOV A, #2AH
	MOVX @DPTR, A

	MOV DPTR, #80EDH		//#
	MOV A, #23H
	MOVX @DPTR, A
	RET	

	CZY_WCISNIETY:
		MOV A, P7
		ANL A, R0
		MOV R2, A
		CLR C
		SUBB A, R0
		MOV R5, A
 		RET
	
	W1:
		MOV R0, #7FH
		MOV A, R0
		MOV P5, A

		CALL CZY_WCISNIETY
		MOV A, R2
		MOV	R3, A
		MOV A, R5
		JZ EXIT1

SPUST:		
		CALL CZY_WCISNIETY
		JNZ SPUST

		MOV A, R3
		MOV DPH, #80H
		MOV DPL, A
		MOVX A, @DPTR
		LCDcntrlWR #CLEAR
		CALL putchrLCD
		MOV P1, A
			
EXIT1:
		RET

	W2:	 
		MOV R0, #0BFH
		MOV A, R0
		MOV P5, A
		
		CALL CZY_WCISNIETY
		MOV A, R2
		MOV	R3, A
		MOV A, R5
		JZ EXIT2
SPUST2:		
		CALL CZY_WCISNIETY
		JNZ SPUST2

		MOV A, R3
		MOV DPH, #80H
		MOV DPL, A
		MOVX A, @DPTR

		MOV P1, A
EXIT2:
		RET

	W3:
		MOV R0, #0DFH
		MOV A, R0
		MOV P5, A

		CALL CZY_WCISNIETY
		MOV A, R2
		MOV	R3, A
		MOV A, R5
		JZ EXIT3
SPUST3:		
		CALL CZY_WCISNIETY
		JNZ SPUST3

		MOV A, R3
		MOV DPH, #80H
		MOV DPL, A
		MOVX A, @DPTR

		MOV P1, A
EXIT3:
		RET

	W4:
		MOV R0, #0EFH
		MOV A, R0
		MOV P5, A

		CALL CZY_WCISNIETY
		MOV A, R2
		MOV	R3, A
		MOV A, R5
		JZ WYJSCIE
SPUST4:		
		CALL CZY_WCISNIETY
		JNZ SPUST4

		MOV A, R3
		MOV DPH, #80H
		MOV DPL, A
		MOVX A, @DPTR

		MOV P1, A
WYJSCIE:
		RET

START:

			  
	CALL INITIALIZE
		  init_LCD
PETLA:
		

		CALL W1
		CALL W2
		CALL W3
		CALL W4	


		JMP PETLA
		
		
		NOP
		NOP
		NOP
		
		JMP $
		END START	