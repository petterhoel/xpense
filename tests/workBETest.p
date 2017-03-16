 
 /*------------------------------------------------------------------------
    File        : workBETest.p 
    Syntax      : 
    Author(s)   : tcoomans
    Created     : Fri Feb 05 12:12:18 CET 2016
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OpenEdge.Core.Assert FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.
DEFINE VARIABLE hPers AS HANDLE NO-UNDO.
DEFINE VARIABLE cOut AS CHARACTER NO-UNDO.
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

RUN app/WorkBE.p PERSISTENT SET hPers.


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

@Test.  
PROCEDURE TestcalcWorks: 
/*------------------------------------------------------------------------------
        Purpose:                                                                      
        Notes:                                                                        
------------------------------------------------------------------------------*/

RUN calcworks IN hPers (OUTPUT cOut).

Assert:Equals("Hi",cOut).

END PROCEDURE.

@Test.  
PROCEDURE TestgetWork: 
/*------------------------------------------------------------------------------
        Purpose:                                                                      
        Notes:                                                                        
------------------------------------------------------------------------------*/
RUN getWork IN hPers (INPUT "A", OUTPUT cOut).

Assert:Equals("Works",cOut).


END PROCEDURE.
