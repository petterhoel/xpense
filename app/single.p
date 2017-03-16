
/*------------------------------------------------------------------------
    File        : single.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Fri Feb 05 12:20:38 CET 2016
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */
DEFINE INPUT  PARAMETER c AS CHARACTER NO-UNDO.
DEFINE OUTPUT PARAMETER i AS INTEGER NO-UNDO.

CASE c:
    WHEN "A"
    THEN
      ASSIGN i = 123.
    WHEN "B"
    THEN
      ASSIGN i = 456.
    WHEN "C"
    THEN
      ASSIGN i = 589.
    OTHERWISE
      ASSIGN i = 987.
END CASE.      
      
      
      