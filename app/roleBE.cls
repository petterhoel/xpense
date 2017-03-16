 
 /*------------------------------------------------------------------------
    File        : roleBE
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : tcoomans
    Created     : Mon Jan 25 15:01:03 CET 2016
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS app.roleBE: 

{inc/dsFilter.i}
{inc/dsRole.i}
	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	CONSTRUCTOR PUBLIC roleBE (  ):
		SUPER ().
		
	END CONSTRUCTOR.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	METHOD PUBLIC VOID getRole(INPUT DATASET dsFilter,
	                           OUTPUT DATASET dsRole):

        DEFINE VARIABLE cWhere AS CHARACTER NO-UNDO.
        
        /* empty dataset */
        DATASET dsRole:EMPTY-DATASET ().
        
        /* Create Filter query */
        FOR EACH ttFilter:
        
           ASSIGN cWhere = IF cWhere EQ ""
                           THEN  SUBSTITUTE("WHERE &1 &2 &3",ttFilter.filter_name,ttFilter.filter_operator,QUOTER(ttFilter.filter_value))
                           ELSE cWhere + SUBSTITUTE(" AND &1 &2 &3",ttFilter.filter_name,ttFilter.filter_operator,QUOTER(ttFilter.filter_value)).
            
        END.  
		
        /* static code */
		DEFINE QUERY qRole FOR role.
		DEFINE DATA-SOURCE srcRole FOR QUERY qRole.
		
		QUERY qRole:QUERY-PREPARE(SUBSTITUTE("FOR EACH role no-lock &1",cWhere)). 

        
        BUFFER ttRole:ATTACH-DATA-SOURCE (DATA-SOURCE srcRole:handle).
        DATASET dsRole:FILL().        
        BUFFER ttRole:DETACH-DATA-SOURCE ().
	
	
		        
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC VOID saveRole(INPUT-OUTPUT DATASET dsRole):
	    
        DEFINE VARIABLE lResult AS LOGICAL NO-UNDO.
        DEFINE DATA-SOURCE srcRole FOR role.
              
        BUFFER ttRole:ATTACH-DATA-SOURCE (DATA-SOURCE srcRole:handle).
        
        FOR EACH Before_ttRole:
          lResult = BUFFER Before_ttRole:SAVE-ROW-CHANGES (1,"role_id").
          IF lResult
          THEN
            BUFFER Before_ttRole:ACCEPT-ROW-CHANGES ().
        END.
        
        BUFFER ttRole:DETACH-DATA-SOURCE (). 

	END METHOD.

END CLASS.