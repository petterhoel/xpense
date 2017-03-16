 
 /*------------------------------------------------------------------------
    File        : databaseBE
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : tcoomans
    Created     : Thu Feb 04 12:41:59 CET 2016
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS app.databaseBE: 

  DEFINE TEMP-TABLE ttTable 
    FIELD tableName AS CHARACTER.
  DEFINE DATASET dsTable FOR ttTable.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC VOID getTables(OUTPUT DATASET dsTable):
		
		FOR EACH _file NO-LOCK
		  WHERE _file._file-num GT 0
		    AND _file._file-num LT 32000:
		    
		    CREATE ttTable.
		    ASSIGN ttTable.tableName = _file._file-name.
		END.         

	END METHOD.

END CLASS.