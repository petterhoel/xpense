 
 /*------------------------------------------------------------------------
    File        : teamBE
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : tcoomans
    Created     : Mon Jan 25 15:01:03 CET 2016
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS app.teamBE: 

{inc/dsFilter.i}
{inc/dsTeam.i}
	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	CONSTRUCTOR PUBLIC teamBE (  ):
		SUPER ().
		
	END CONSTRUCTOR.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	METHOD PUBLIC VOID getTeam(INPUT DATASET dsFilter,
	                           OUTPUT DATASET dsTeam):

        DEFINE VARIABLE cWhere AS CHARACTER NO-UNDO.
        
        /* empty dataset */
        DATASET dsTeam:EMPTY-DATASET ().
        
        /* Create Filter query */
        FOR EACH ttFilter:
        
           ASSIGN cWhere = IF cWhere EQ ""
                           THEN  SUBSTITUTE("WHERE &1 &2 &3",ttFilter.filter_name,ttFilter.filter_operator,QUOTER(ttFilter.filter_value))
                           ELSE cWhere + SUBSTITUTE(" AND &1 &2 &3",ttFilter.filter_name,ttFilter.filter_operator,QUOTER(ttFilter.filter_value)).
            
        END.  
		
        /* static code */
		DEFINE QUERY qTeam FOR team.
		DEFINE DATA-SOURCE srcTeam FOR QUERY qTeam.
		
		QUERY qTeam:QUERY-PREPARE(SUBSTITUTE("FOR EACH team no-lock &1",cWhere)). 

/*        MESSAGE SUBSTITUTE("FOR EACH team no-lock &1",cWhere)*/
/*        VIEW-AS ALERT-BOX.                                   */
        
        BUFFER ttTeam:ATTACH-DATA-SOURCE (DATA-SOURCE srcTeam:handle).
        DATASET dsTeam:FILL().        
        BUFFER ttTeam:DETACH-DATA-SOURCE ().
	
	
	    /* Dynamic */
/*	    DEFINE VARIABLE cTableName AS CHARACTER INITIAL "Team" NO-UNDO.                 */
/*	                                                                                     */
/*	    DEFINE VARIABLE hBuffer AS HANDLE NO-UNDO.                                      */
/*	    DEFINE VARIABLE hQuery AS HANDLE NO-UNDO.                                       */
/*        DEFINE VARIABLE hDataSource AS HANDLE NO-UNDO.                               */
/*                                                                                     */
/*	    CREATE BUFFER hBuffer FOR TABLE cTableName.                                     */
/*	   	                                                                                     */
/*	    CREATE QUERY hQuery.                                                            */
/*	    hQuery:ADD-BUFFER (hBuffer).                                                    */
/*	                                                                                     */
/*	    CREATE DATA-SOURCE hDataSource.                                                 */
/*        hDataSource:QUERY = hQuery.                                                  */
/*                                                                                     */
/*        hQuery:QUERY-PREPARE(SUBSTITUTE("FOR EACH &1 no-lock &2",cTableName,cWhere)).*/
/*                                                                                     */
/*        BUFFER ttTeam:ATTACH-DATA-SOURCE (hDataSource).                              */
/*        DATASET dsTeam:FILL().                                                       */
/*                                                                                     */
/*        BUFFER ttTeam:DETACH-DATA-SOURCE ().                                         */
		        
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC VOID saveTeam(INPUT-OUTPUT DATASET dsTeam):
	    
	    validateTeam(INPUT-OUTPUT DATASET dsTeam).
	    IF DATASET dsTeam:error
	    THEN RETURN.
	    
        DEFINE VARIABLE lResult AS LOGICAL NO-UNDO.
        DEFINE DATA-SOURCE srcTeam FOR Team.
              
        BUFFER ttTeam:ATTACH-DATA-SOURCE (DATA-SOURCE srcTeam:handle).
        
        FOR EACH Before_ttTeam:
          lResult = BUFFER Before_ttTeam:SAVE-ROW-CHANGES (1,"team_id").
          IF lResult
          THEN
            BUFFER Before_ttTeam:ACCEPT-ROW-CHANGES ().
        END.
        
        BUFFER ttTeam:DETACH-DATA-SOURCE (). 

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC VOID validateTeam(INPUT-OUTPUT DATASET dsTeam):
		
		FOR EACH ttTeam:
		    
		    IF ttTeam.team_name EQ ""
		    THEN ASSIGN BUFFER ttTeam:ERROR-STRING = "Team name can not be empty"
		                BUFFER ttTeam:ERROR = TRUE
		                TEMP-TABLE ttTeam:ERROR = TRUE
		                DATASET dsteam:ERROR = TRUE.
		    
		    
		END.
		
		RETURN.

	END METHOD.

END CLASS.