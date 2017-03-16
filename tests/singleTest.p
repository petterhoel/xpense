 
 /*------------------------------------------------------------------------
    File        : singleTest.p 
    Syntax      : 
    Author(s)   : tcoomans
    Created     : Fri Feb 05 12:22:46 CET 2016
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OpenEdge.Core.Assert FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.



/* **********************  Internal Procedures  *********************** */


@Test.
PROCEDURE mytest:
/*------------------------------------------------------------------------------
 Purpose:
 Notes:
------------------------------------------------------------------------------*/
   DEFINE VARIABLE cOut AS INTEGER NO-UNDO.
   RUN app/single.p (INPUT "A",OUTPUT cOut ).
   
   Assert:Equals(123,cOUT).
   
   RUN app/single.p (INPUT "B",OUTPUT cOut ).
   
   Assert:Equals(456,cOUT).
   
   RUN app/single.p (INPUT "C",OUTPUT cOut ).
   
   Assert:Equals(589,cOUT).
   
   
END PROCEDURE.

@Before.
PROCEDURE setUpBeforeProcedure:
/*------------------------------------------------------------------------------
        Purpose:                                                                      
        Notes:                                                                        
------------------------------------------------------------------------------*/

END PROCEDURE. 

@Setup.
PROCEDURE setUp:
/*------------------------------------------------------------------------------
        Purpose:                                                                      
        Notes:                                                                        
------------------------------------------------------------------------------*/


   
END PROCEDURE.  

@TearDown.
PROCEDURE tearDown:
/*------------------------------------------------------------------------------
        Purpose:                                                                      
        Notes:                                                                        
------------------------------------------------------------------------------*/

END PROCEDURE. 

@After.
PROCEDURE tearDownAfterProcedure: 
/*------------------------------------------------------------------------------
        Purpose:                                                                      
        Notes:                                                                        
------------------------------------------------------------------------------*/

END PROCEDURE. 
