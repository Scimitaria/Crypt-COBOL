       IDENTIFICATION DIVISION.
       PROGRAM-ID. EncryptIO.
       AUTHOR. Scimitaria.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 TextLine  PIC X(70).
       01 FILLER                 PIC 9.
           88 ValidSubProgName   VALUE ZERO.
           88 InvalidSubProgName VALUE 1.
       01 Operation              PIC X(6).

       PROCEDURE DIVISION.
           DISPLAY "Text: " WITH NO ADVANCING
           ACCEPT TextLine
           MOVE FUNCTION UPPER-CASE(TextLine) TO TextLine
           DISPLAY "Enter encryption name:" WITH NO ADVANCING
           ACCEPT Operation
           CALL Operation USING BY CONTENT TextLine
               ON EXCEPTION     DISPLAY Operation " is invalid op"
                                SET InvalidSubProgName TO TRUE
               NOT ON EXCEPTION SET ValidSubProgName   TO TRUE
           END-CALL
           CANCEL Operation
       STOP RUN.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. Flip.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 Alpha     PIC X(26) VALUE "ABCDEFGHIJKLMNOPQRSTUVWXYZ".
       01 Beta      PIC X(26) VALUE "ZYXWVUTSRQPONMLKJIHGFEDCBA".
       LINKAGE SECTION.
       01 TextIn   PIC X(70).
       PROCEDURE DIVISION USING TextIn.
           INSPECT TextIn CONVERTING
               Alpha TO Beta
                   AFTER  INITIAL "@>"
                   BEFORE INITIAL "<@"
           DISPLAY TextIn
           EXIT PROGRAM.
       END PROGRAM Flip.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. Offset.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 Offset PIC 99.
       01 idx    PIC 999.
       LINKAGE SECTION.
       01 TextIn PIC X(70).
       PROCEDURE DIVISION USING TextIn.
           DISPLAY "Enter offset (0-26): " WITH NO ADVANCING
           ACCEPT Offset
      *     PERFORM VARYING idx FROM 1 BY 1 UNTIL EndOfInputFile
      *        FUNCTION CHAR(FUNCTION ORD(TextIn(idx)+Offset))
      *     END-PERFORM
           DISPLAY TextIn
       EXIT PROGRAM.
       END PROGRAM Offset.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. Time.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 CurrentTime.
          02 CurrentHour   PIC 99.
          02 CurrentMinute PIC 99.
       01 idx    PIC 999.
       LINKAGE SECTION.
       01 TextIn   PIC X(70).
       PROCEDURE DIVISION USING TextIn.
           ACCEPT CurrentTime FROM TIME
      *     PERFORM VARYING idx FROM 1 BY 1 UNTIL idx>FUNCTION LENGTH(TextIn)
      *        FUNCTION CHAR(FUNCTION ORD(TextIn(idx)+Offset))
      *     END-PERFORM
           DISPLAY TextIn
       EXIT PROGRAM.
       END PROGRAM Time.
       