UNIT ReadNumber;

INTERFACE

PROCEDURE ReadNumberFromFile(VAR F1: TEXT; VAR S: INTEGER);

IMPLEMENTATION

PROCEDURE CharToInt(VAR Ch: CHAR; VAR I: INTEGER);
BEGIN {CharToInt}
  IF Ch = '0' THEN I := 0 ELSE
  IF Ch = '1' THEN I := 1 ELSE
  IF Ch = '2' THEN I := 2 ELSE
  IF Ch = '3' THEN I := 3 ELSE
  IF Ch = '4' THEN I := 4 ELSE
  IF Ch = '5' THEN I := 5 ELSE
  IF Ch = '6' THEN I := 6 ELSE
  IF Ch = '7' THEN I := 7 ELSE
  IF Ch = '8' THEN I := 8 ELSE
  IF Ch = '9' THEN I := 9 ELSE
  I := -1
END; {CharToInt}

PROCEDURE ReadDigit(VAR FIn: TEXT; VAR Result: INTEGER);
VAR
  Ch: CHAR;  
BEGIN {ReadDigit}
  IF (NOT EOF(FIn)) AND (NOT EOLN(FIn))
  THEN
    BEGIN
      READ(FIn, Ch);
      CharToInt(Ch, Result)
    END
  ELSE
    Result := -1
END; {ReadDigit}

PROCEDURE ReadNumberFromFile(VAR F1: TEXT; VAR S: INTEGER);
VAR
  I: INTEGER;
BEGIN {ReadNumber}
  S := 0;
  ReadDigit(F1, I);
  IF I = -1
  THEN
    S := -1
  ELSE
    BEGIN
      WHILE(S >= 0) AND (I >= 0)
      DO
        BEGIN
          IF S < (MaxInt - I) DIV 10
          THEN
            S := S * 10 + I                                                  
          ELSE
            S := -2;
          ReadDigit(F1, I)
        END
    END
END; {ReadNumber}

BEGIN {ReadNumber}
END. {ReadNumber}
