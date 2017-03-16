
/*------------------------------------------------------------------------
    File        : myTest.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Thu Jan 28 15:46:03 CET 2016
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */
DEFINE OUTPUT PARAMETER cResult AS CHARACTER NO-UNDO.

cResult = "works".
