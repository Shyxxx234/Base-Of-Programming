UNIT MergeFile;

INTERFACE

PROCEDURE Merge(VAR FDrain, FSource: TEXT); {Merge two files}

IMPLEMENTATION

USES
  ReadString,
  ReadNumber,
  CharFormat;

CONST
  Equal = 0;
  Less = 1;
  Greater = 2;
  
VAR
  Str1, Str2: STRING;
  Temp: TEXT;
  I1, I2, Condition: INTEGER;

PROCEDURE CopyFile(VAR F1, F2: TEXT);
VAR
  Ch: CHAR;
BEGIN {CopyFile}
  WHILE NOT EOF(F1)
  DO
    BEGIN
      WHILE NOT EOLN(F1)
      DO
        BEGIN
          READ(F1, Ch);
          WRITE(F2, Ch)
        END;
      READLN(F1);
      WRITELN(F2)
    END
END; {CopyFIle}  

PROCEDURE ReadStringAndNumber(VAR F: TEXT; VAR Str: STRING; VAR I: INTEGER);
VAR
  Ch: CHAR;
BEGIN {ReadStringAndNumber}
  IF NOT EOLN(F)
  THEN
    BEGIN
      ReadWordWithDash(F, Str);
      ReadNumberFromFile(F, I)        
    END;
  READLN(F)
END; {ReadStringAndNumber} 

PROCEDURE InsertWord(VAR FDrain, FSource: TEXT);
BEGIN {InsertWord}
  Condition := CompareStrings(Str1, Str2); 
  IF Condition = Equal
  THEN
    BEGIN
      WRITELN(Temp, Str1, ' ', I1 + I2);
      Str1 := '';
      Str2 := ''
    END
  ELSE
    IF Condition = Less
    THEN
      BEGIN 
        IF Str1 <> ''
        THEN    
          WRITELN(Temp, Str1, ' ', I1);
        Str1 := ''
      END
    ELSE
      IF Condition = Greater
      THEN            
        BEGIN  
          IF Str2 <> ''
          THEN 
            WRITELN(Temp, Str2, ' ', I2); 
          Str2 := ''   
        END     
END; {InsertWord}

PROCEDURE CopyRemain(VAR F: TEXT; VAR Str, AnotherStr: STRING; VAR I: INTEGER);
BEGIN {CopyRemain}
  WHILE NOT EOF(F)                                             
  DO
   BEGIN
      IF CompareStrings(Str, AnotherStr) = Equal
      THEN
        I := I1 + I2;
      IF Str <> ''
      THEN 
        WRITELN(Temp, Str, ' ', I);
      Str := '';
      ReadStringAndNumber(F, Str, I)
    END 
END; {CopyRemain}

PROCEDURE Merge(VAR FDrain, FSource: TEXT);
BEGIN {Merge} 
  REWRITE(Temp);
  RESET(FDrain);
  RESET(FSource); 
  ReadStringAndNumber(FDrain, Str1, I1);
  ReadStringAndNumber(FSource, Str2, I2);
  WHILE (NOT EOF(FDrain)) AND (NOT EOF(FSource))
  DO
    BEGIN
      InsertWord(FDrain, FSource);
      CASE Condition OF
        Equal: BEGIN
                 ReadStringAndNumber(FDrain, Str1, I1);
                 ReadStringAndNumber(FSource, Str2, I2)
               END;
        Less: ReadStringAndNumber(FDrain, Str1, I1);
        Greater: ReadStringAndNumber(FSource, Str2, I2)
      END
    END;
  IF (EOF(FDrain)) OR (EOF(FSource))
  THEN
    InsertWord(FDrain, FSource);
  CopyRemain(FDrain, Str1, Str2, I1);
  CopyRemain(FSource, Str2, Str1, I2);
  REWRITE(FDrain);
  RESET(Temp);
  CopyFile(Temp, FDrain);
  WRITELN(FDrain) 
END;{Merge}   

BEGIN {MergeFile}
  Str1 := '';
  Str2 := ''
END. {MergeFile}
