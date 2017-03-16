 
 
 /*------------------------------------------------------------------------
    File        : myProceduretTestSuite.p 
    Syntax      : 
    Author(s)   : tcoomans
    Created     : Fri Feb 05 12:31:38 CET 2016
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
BLOCK-LEVEL ON ERROR UNDO, THROW.
@TestSuite(procedures="singleTest.p,workBETest.p").
  