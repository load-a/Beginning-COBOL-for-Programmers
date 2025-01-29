IDENTIFICATION DIVISION.
PROGRAM-ID. Listing4-2.

ENVIRONMENT DIVISION.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 Num1 	PIC 9 VALUE 5.
01 Num2 	PIC 9 VALUE 4.
01 Result 	PIC --9.99 VALUE ZEROS.

01 Operation PIC A.
88 ValidOperation VALUE "+", "-", "*", "/".

01 TerminationChar	PIC X.
	88 TerminateProgram VALUE "s".

PROCEDURE DIVISION.
Main-Logic.
PERFORM Ask-for-Input THROUGH Apply-Operation UNTIL TerminateProgram

STOP RUN.

Ask-for-Input.
DISPLAY "Enter a single digit number: " WITH NO ADVANCING
ACCEPT TerminationChar

DISPLAY TerminationChar

MOVE TerminationChar TO Num1

IF TerminateProgram
	GO TO Break
END-IF

DISPLAY "Enter a single digit number: " WITH NO ADVANCING
ACCEPT Num2

DISPLAY "Enter an operation (+, -, *, /): " WITH NO ADVANCING
ACCEPT Operation.

Apply-Operation.
EVALUATE Operation
WHEN "+"
	ADD Num1 TO Num2 GIVING Result
WHEN "-"
	SUBTRACT Num2 FROM Num1 GIVING Result
WHEN "*"
	MULTIPLY Num1 BY Num2 GIVING Result
WHEN "/" 
	DIVIDE Num1 BY Num2 GIVING Result
WHEN OTHER
	DISPLAY "ERROR: INVALID OPERATION"
END-EVALUATE

DISPLAY "The result: " Num1 SPACE Operation SPACE Num2 " = " Result.

Break.
CONTINUE.

