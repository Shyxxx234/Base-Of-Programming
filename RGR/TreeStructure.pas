UNIT TreeStructure;

INTERFACE   

PROCEDURE PrintTree(VAR F: TEXT); {Print tree in file}
PROCEDURE Insert(VAR Data: STRING); {Insert data into tree}
PROCEDURE ClearTree; {Delete all pointers}  

IMPLEMENTATION
USES
  CharFormat; 
  
TYPE
  Tree = ^NodeType;
  NodeType = RECORD
               Key: STRING;
               Quantity: INTEGER;
               Left, Right: Tree
             END;
             
VAR
  Root: Tree;

PROCEDURE InsertIntoTree(VAR Ptr: Tree; Data: STRING);
BEGIN {InsertIntoTree}
  IF Ptr = NIL
  THEN
    BEGIN
      NEW(Ptr);
      Ptr^.Key := Data;
      Ptr^.Left := NIL;
      Ptr^.Right := NIL;
      Ptr^.Quantity := 1
    END
  ELSE
    CASE CompareStrings(Ptr^.Key, Data) OF
      Greater: InsertIntoTree(Ptr^.Left, Data);
      Less: InsertIntoTree(Ptr^.Right, Data);
      Equal: Ptr^.Quantity := Ptr^.Quantity + 1
    END
END; {InsertIntoTree}

PROCEDURE Insert(VAR Data: STRING);
BEGIN {Insert}
  InsertIntoTree(Root, Data)
END; {Insert}
          
PROCEDURE PrintTreeRecursive(VAR Ptr: Tree; VAR F: TEXT);
BEGIN {PrintTreeRecursive}
  IF Ptr <> NIL
  THEN
    BEGIN
      PrintTreeRecursive(Ptr^.Left, F);
      WRITE(F, Ptr^.Key);
      WRITELN(F, ' ', Ptr^.Quantity);
      PrintTreeRecursive(Ptr^.Right, F)
    END
END; {PrintTreeRecursive}

PROCEDURE ClearTreeRecursive(VAR Ptr: Tree);
BEGIN {ClearTree}
  IF Ptr <> NIL
  THEN
    BEGIN
      ClearTreeRecursive(Ptr^.Left);
      ClearTreeRecursive(Ptr^.Right);
      DISPOSE(Ptr)
    END
END; {ClearTree}

PROCEDURE ClearTree;
BEGIN {ClearTree}
  ClearTreeRecursive(Root);
  Root := NIL
END; {ClearTree}

PROCEDURE PrintTree(VAR F: TEXT);
BEGIN {PrintTree}
  PrintTreeRecursive(Root, F);
  WRITELN(F)
END; {PrintTree}

BEGIN {TreeStructure}
  Root := NIL
END. {TreeStructure}
