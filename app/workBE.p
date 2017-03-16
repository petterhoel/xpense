
/*------------------------------------------------------------------------
    File        : workBE
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Fri Feb 05 12:09:45 CET 2016
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */



/* **********************  Internal Procedures  *********************** */

PROCEDURE calcWorks:
/*------------------------------------------------------------------------------
 Purpose:
 Notes:
------------------------------------------------------------------------------*/
DEFINE OUTPUT PARAMETER cOut AS CHARACTER NO-UNDO.

cOut = "hidlekldke".

END PROCEDURE.

PROCEDURE getWork:
/*------------------------------------------------------------------------------
 Purpose:
 Notes:
------------------------------------------------------------------------------*/
DEFINE INPUT  PARAMETER cType AS CHARACTER NO-UNDO.
DEFINE OUTPUT PARAMETER cOut AS CHARACTER NO-UNDO.

IF cType EQ "A"
THEN
  ASSIGN cOut = "works".
ELSE
  ASSIGN cOut = "not works".  


END PROCEDURE.

