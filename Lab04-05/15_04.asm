LJMP START
	P5 EQU 0F8H
	P7 EQU 0DBH

ORG 0100H
		

START:
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
			  


	W1:
		MOV R0, #7FH
		MOV A, R0
		MOV P5, A
		MOV A, P7
		ANL A, R0

		MOV R2, A
		CLR C
		SUBB A, R0
		JZ W2
		MOV A, R2
		MOV DPH, #80H
		MOV DPL, A
		MOVX A, @DPTR

		MOV P1, A
	
	W2:		

		MOV R0, #0BFH
		MOV A, R0
		MOV P5, A
		MOV A, P7
		ANL A, R0
			
		MOV R2, A
		CLR C
		SUBB A, R0
		JZ W3
		MOV A, R2
		MOV DPH, #80H
		MOV DPL, A
		MOVX A, @DPTR

		MOV P1, A

	W3:
		MOV R0, #0DFH
		MOV A, R0
		MOV P5, A
		MOV A, P7
		ANL A, R0
	
		MOV R2, A
		CLR C
		SUBB A, R0
		JZ W4
		MOV A, R2
		MOV DPH, #80H
		MOV DPL, A
		MOVX A, @DPTR

		MOV P1, A

	W4:
		MOV R0, #0EFH
		MOV A, R0
		MOV P5, A
		MOV A, P7
		ANL A, R0

		MOV R2, A
		CLR C
		SUBB A, R0
		JZ W1
		MOV A, R2
		MOV DPH, #80H
		MOV DPL, A
		MOVX A, @DPTR

		MOV P1, A

		JMP START
		
		
		NOP
		NOP
		NOP
		
		JMP $
		END START	