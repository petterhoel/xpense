 
 /*------------------------------------------------------------------------
    File        : teamModel
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : tcoomans
    Created     : Tue Jan 26 15:27:39 CET 2016
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING gui.baseModel.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS gui.teamModel INHERITS baseModel: 
 
    {inc/dsTeam.i}
    
	DEFINE PUBLIC PROPERTY activeTeam AS CHARACTER NO-UNDO 
	GET:
	    IF AVAILABLE ttTeam
	    THEN
	      RETURN ttteam.team_name.
	    END GET.
	PRIVATE SET. 

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	METHOD PUBLIC HANDLE getTeam(  ):
		
		 getData(INPUT "app.teamBE",
		         INPUT "getTeam",
		         OUTPUT DATASET dsTeam).
	
         /* Refresh the dataset */
         DATASET dsTeam:HANDLE:TOP-NAV-QUERY(1):QUERY-OPEN ().
		
		RETURN DATASET dsTeam:HANDLE.

	END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID saveTeam(  ):
        
         disableEdit().
         saveData(INPUT "app.teamBE",
                  INPUT "saveTeam",
                  INPUT-OUTPUT DATASET dsTeam).
                  
        /* show errors dyanmic*/          
   /*     IF DATASET dsTeam:ERROR 
        THEN DO:
           DEFINE VARIABLE hQuery AS HANDLE NO-UNDO.
           DEFINE VARIABLE hBuffer AS HANDLE NO-UNDO.
           CREATE QUERY hQuery.
           hBuffer = DATASET dsTeam:GET-BUFFER-HANDLE("ttTeam").
           hQuery:ADD-BUFFER(hBuffer).
           hQuery:QUERY-PREPARE("FOR EACH " + hBuffer:NAME).
           hQuery:QUERY-OPEN().
           hQuery:GET-FIRST().
             DO WHILE NOT hQuery:QUERY-OFF-END:

               IF hBuffer:ERROR THEN
               MESSAGE hBuffer:ERROR-STRING
                   VIEW-AS ALERT-BOX ERROR BUTTONS OK.
               hQuery:GET-NEXT().
             END.
           hQuery:QUERY-CLOSE().
           DELETE OBJECT hQuery.
           RETURN ERROR.
        END. 
        */
        /* show errors static*/    
        IF DATASET dsTeam:ERROR 
        THEN DO:       
           MESSAGE "dataset error: " DATASET dsTeam:ERROR SKIP
                   "temptable error: " TEMP-TABLE ttTeam:ERROR         
           VIEW-AS ALERT-BOX.          
           FOR EACH ttTeam:
               IF BUFFER ttTeam:ERROR
               THEN MESSAGE BUFFER ttTeam:ERROR-STRING
                    VIEW-AS ALERT-BOX ERROR.
           END.    
        END.           
    
         /* Refresh the dataset */
         DATASET dsTeam:HANDLE:TOP-NAV-QUERY(1):QUERY-OPEN ().
        
        RETURN.

    END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	METHOD PUBLIC HANDLE getTeamHandle(  ):

		RETURN DATASET dsTeam:HANDLE.

	END METHOD.
	
    /*------------------------------------------------------------------------------
            Purpose: Standard method to begin editing tracking                     
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID enableEdit(  ):
        TEMP-TABLE ttTeam:TRACKING-CHANGES = YES.
    END METHOD.
    
    /*------------------------------------------------------------------------------
            Purpose: Standard method to just stop edititing                       
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID disableEdit(  ):
        TEMP-TABLE ttTeam:TRACKING-CHANGES = NO.     
    END METHOD.
    
    /*------------------------------------------------------------------------------
            Purpose: User pressed delete button                         
            Notes:   Delete the current selected row                      
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID deleteRow(  ):
        enableEdit().
        DELETE ttTeam. 
        saveTeam().
    END METHOD.

    /*------------------------------------------------------------------------------
            Purpose: User pressed Cancel Button                                     
            Notes:   Reject all changes and refresh the query                
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID CancelEdit(  ):
        disableEdit().
        DATASET dsTeam:REJECT-CHANGES().
        DATASET dsTeam:TOP-NAV-QUERY():query-open().
    END METHOD.
    
    /*------------------------------------------------------------------------------
            Purpose: User presse Create Row Button                                  
            Notes:  Insert an empty record in the temp-table                      
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID createRow(  ):
        enableEdit().
        CREATE ttTeam.
        DATASET dsTeam:TOP-NAV-QUERY():CREATE-RESULT-LIST-ENTRY().
    END METHOD.


END CLASS.