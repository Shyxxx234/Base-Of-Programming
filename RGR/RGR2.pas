PROGRAM RGR2(INPUT, OUTPUT);
USES 
  ReadString,
  MergeFile,
  TreeStructure;
VAR
  FIn, FOut, Temp: TEXT;
BEGIN {RGR2}
  ASSIGN(FIn, 'infile-big.txt');
  ASSIGN(FOut, 'outfile2.txt');   
  RESET(FIn);
  REWRITE(FOut);
  WHILE NOT EOF(FIn)
  DO
    BEGIN
      REWRITE(Temp);
      ReadBlock(FIn);
      PrintTree(Temp);
      ClearTree;      
      Merge(FOut, Temp)
    END;
  WRITELN('The program was completed successfully')
END. {RGR2}
