UNIT ReadString;

INTERFACE

FUNCTION ReadWordWithDash(VAR F: TEXT; VAR Str: STRING): BOOLEAN;  {Read string with dash}
FUNCTION ReadBlock(VAR FIn: TEXT): BOOLEAN; {Bufferization}

IMPLEMENTATION

USES
  TreeStructure,
  CharFormat;

CONST
  Alphabet = ['a' .. 'z', 'à' .. 'ÿ', '¸', ''''];
  Dash = '-';
  BufferSize = 100;

VAR
  Ch: CHAR;

FUNCTION ReadWord(VAR F: TEXT; VAR Str: STRING): BOOLEAN;
{<w, '', R> -> <'', w, R>: w - any word}
BEGIN {ReadWord}
  ReadWord := FALSE;
  IF NOT EOLN(F)
  THEN
    BEGIN
      READ(F, Ch);
      SwitchToLowerRegister(Ch)
    END;
  WHILE (NOT EOLN(F)) AND (Ch IN Alphabet)
  DO
    BEGIN 
      Str := Str + Ch;  
      READ(F, Ch);
      SwitchToLowerRegister(Ch);
      ReadWord := TRUE
    END;
  IF Ch IN Alphabet
  THEN
    BEGIN
      Str := Str + Ch;
      ReadWord := TRUE
    END
END; {ReadWord}

FUNCTION ReadWordWithDash(VAR F: TEXT; VAR Str: STRING): BOOLEAN;
{<w-w, '', R> -> <'', w-w, R>: w - any word}
VAR
  DoubleDash: BOOLEAN;
BEGIN {ReadWordWithDash}        
  ReadWordWithDash := FALSE;
  DoubleDash := FALSE;
  IF ReadWord(F, Str)
  THEN
    BEGIN
      ReadWordWithDash := TRUE;
      WHILE (Ch = Dash) AND (NOT DoubleDash) 
      DO
        BEGIN
          Str := Str + Dash;
          IF NOT ReadWord(F, Str)
          THEN
            BEGIN
              DELETE(Str, LENGTH(Str), 1);
              IF Ch = Dash
              THEN
                DoubleDash := TRUE
            END
        END
    END
END; {ReadWordWithDash}

FUNCTION ReadBlock(VAR FIn: TEXT): BOOLEAN;
VAR
  Str: STRING;
  Counter: INTEGER;
BEGIN {ReadBlock}
  ReadBlock := FALSE;
  Counter := 0;
  WHILE (Counter < BufferSize) AND (NOT EOF(FIn))
  DO
    BEGIN
      WHILE NOT EOLN(FIn)
      DO
        BEGIN
          Str := '';
          IF ReadWordWithDash(FIn, Str)
          THEN
            BEGIN
              Insert(Str);
              ReadBlock := TRUE;
              Counter := Counter + 1
            END
        END;
      READLN(FIn)
    END;
END; {ReadBlock}

BEGIN {ReadString}
END. {ReadString} 
