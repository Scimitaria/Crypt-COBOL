       IDENTIFICATION DIVISION.
       PROGRAM-ID. Encrypt.
       AUTHOR. Scimitaria.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       SELECT InputFile ASSIGN TO "IO.txt".
       SELECT OutputFile ASSIGN TO "encrypt.txt".

       DATA DIVISION.
       FILE SECTION.
       FD InputFile.
       01 Contents        PIC X(1000).
        88 EndOfInputFile VALUE HIGH-VALUES.
       FD OutputFile.
       01 Printy          PIC X(1000).
       WORKING-STORAGE SECTION.
       01 FILLER                 PIC 9.
           88 ValidSubProgName   VALUE ZERO.
           88 InvalidSubProgName VALUE 1.
       01 Operation              PIC X(6).
           88 progFlip        VALUE "FLIP" "Flip" "flip".
       01 Alpha     PIC X(26) VALUE "ABCDEFGHIJKLMNOPQRSTUVWXYZ".
       01 Beta      PIC X(26) VALUE "ZYXWVUTSRQPONMLKJIHGFEDCBA".

       PROCEDURE DIVISION.
           DISPLAY "Text: " WITH NO ADVANCING
           OPEN INPUT InputFile
           OPEN OUTPUT OutputFile
           READ InputFile
               AT END SET EndOfInputFile TO TRUE
           END-READ
           MOVE FUNCTION UPPER-CASE(Contents) TO Contents
           DISPLAY "Enter encryption name:" WITH NO ADVANCING
           ACCEPT Operation
            EVALUATE TRUE
                WHEN progFlip PERFORM Flip
                WHEN OTHER DISPLAY Operation " is invalid op"
           CLOSE InputFile
           CLOSE OutputFile
       STOP RUN.

       Flip.
           INSPECT Contents CONVERTING Alpha TO Beta
           WRITE Printy FROM Contents.
