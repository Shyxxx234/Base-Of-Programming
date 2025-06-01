UNIT CharFormat;

INTERFACE

CONST
  Undefined = 3;
  Greater = 2;
  Less = 1;
  Equal = 0;

FUNCTION CompareStrings(VAR Str1, Str2: STRING): INTEGER; {Compare 2 strings}
PROCEDURE SwitchToLowerRegister(VAR Ch: CHAR); {Turn Ch to lower register}

IMPLEMENTATION

FUNCTION ComparedWithE(VAR Str1, Str2: STRING; VAR I: INTEGER): INTEGER;
{å < ¸ < æ}
BEGIN {ComparedWithE}
  Result := Equal;
  IF (Str1[I] = '¸') AND (Str2[I] <= 'å') AND (Str2[I] >= 'à')
  THEN
    Result := Greater
  ELSE
    IF (Str1[I] = '¸') AND (Str2[I] >= 'æ')
    THEN
      Result := Less;
  IF (Str2[I] = '¸') AND (Str1[I] <= 'å') AND (Str1[I] >= 'à')
  THEN
    Result := Less
  ELSE
    IF (Str2[I] = '¸') AND (Str1[I] >= 'æ')
    THEN
      Result := Greater
END; {ComparedWithE}
  
FUNCTION CompareStrings(VAR Str1, Str2: STRING): INTEGER;
{Compare 2 strings by lexic-graphic order}
VAR
  I, MinLen: INTEGER;
BEGIN {CompareStrings}
  IF (Str1 <> '') AND (Str2 <> '')
  THEN
    BEGIN
      Result := Equal;
      I := 1;
      MinLen := LENGTH(Str1);
      IF LENGTH(Str2) < MinLen 
      THEN
        MinLen := LENGTH(Str2);
      WHILE (I <= MinLen) AND (Result = Equal)
      DO
        BEGIN
          IF (Str1[I] <> '¸') AND (Str2[I] <> '¸')
          THEN
            BEGIN
              IF Str1[I] < Str2[I]  
              THEN
                Result := Less
              ELSE
                IF Str1[I] > Str2[I]   
                THEN
                  Result := Greater
            END
          ELSE
            Result := ComparedWithE(Str1, Str2, I);
          I := I + 1
        END;
      IF Result = Equal 
      THEN
        IF LENGTH(Str1) < LENGTH(Str2) 
        THEN
          Result := Less
        ELSE
          IF LENGTH(Str1) > LENGTH(Str2)
          THEN
            Result := Greater
    END
  ELSE
    Result := Undefined
END; {CompareStrings}


PROCEDURE SwitchToLowerRegister(VAR Ch: CHAR);
{Ch := CHR(ORD(Ch) + 32)}
BEGIN {SwitchToLowerRegister}
  IF ((Ch >= 'A') AND (Ch <= 'Z')) OR ((Ch >= 'À') AND (Ch <= 'ß')) 
  THEN
    Ch := CHR(ORD(Ch) + 32)
  ELSE 
    IF (Ch = '¨') 
    THEN
      Ch := '¸'
END; {SwitchToLowerRegister}

BEGIN {CharFormat}
END. {CharFormat}
