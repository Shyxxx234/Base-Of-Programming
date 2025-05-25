PROGRAM RGR1(INPUT, OUTPUT);
USES 
  ReadString,
  TreeStructure;
VAR
  Str: STRING;
  FIn, FOut: TEXT;
BEGIN {RGR1}
  ASSIGN(FIn, 'infile-big.txt');
  ASSIGN(FOut, 'outfile.txt');
  RESET(FIn);
  REWRITE(FOut);
  WHILE NOT EOF(FIn)
  DO
    BEGIN
      WHILE NOT EOLN(FIn) 
      DO
        BEGIN
          Str := '';
          IF ReadWordWithDash(FIn, Str)
          THEN
            Insert(Str)
        END;
      READLN(FIn)
    END;
  PrintTree(FOut);
  WRITELN('The program was completed successfully')
END. {RGR1}
