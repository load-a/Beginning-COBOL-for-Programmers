IDENTIFICATION DIVISION.
PROGRAM-ID. Gadget-List.
AUTHOR. Saramir.
DATE-WRITTEN. 2025-01-29.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
	SELECT StockFile ASSIGN TO "stock_files.txt" ORGANIZATION IS LINE SEQUENTIAL.

DATA DIVISION.
FILE SECTION.
FD StockFile.
	01 ItemRecord.
		88 EndOfFile VALUE HIGH-VALUES.
		02 GadgetID PIC 9(6).
		02 GadgetName PIC X(30).
		02 GadgetQuantity PIC 9(4).
		02 Price.
			03 RawPrice PIC 9(4)V99.
			03 FormattedPrice PIC Z(3)9.99.

WORKING-STORAGE SECTION.
01 TotalValue.
	02 RawValue PIC 9(8)V99.
	02 FormattedValue PIC Z(7)9.99.
01 StockTotal.
	02 RawTotal PIC 9(8)V99.
	02 FormattedTotal PIC Z(7)9.99.

PROCEDURE DIVISION.
Main-Logic.
	OPEN INPUT StockFile

	PERFORM Process-File

	PERFORM Process-File UNTIL EndOfFile

	MOVE RawTotal TO FormattedTotal

	DISPLAY "STOCK TOTAL: $" FUNCTION TRIM (FormattedTotal)

	CLOSE StockFile
STOP RUN.

Display-Item-Listing.
	PERFORM Calculate-Totals
	MOVE RawValue TO FormattedValue
	DISPLAY GadgetName SPACE "$" FUNCTION TRIM (FormattedValue).

Calculate-Totals.
	MULTIPLY GadgetQuantity BY RawPrice GIVING RawValue
	ADD RawValue TO RawTotal.

Process-File.
	READ StockFile
		AT END SET EndOfFile TO TRUE
		NOT AT END PERFORM Display-Item-Listing
	END-READ.
