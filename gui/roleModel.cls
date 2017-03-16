 
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

CLASS gui.roleModel INHERITS baseModel: 
 
    {inc/dsRole.i}
    
	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	METHOD PUBLIC HANDLE getRole(  ):
		
		 getData(INPUT "app.roleBE",
		         INPUT "getRole",
		         OUTPUT DATASET dsRole).
	
         /* Refresh the dataset */
         DATASET dsRole:HANDLE:TOP-NAV-QUERY(1):QUERY-OPEN ().
		
		RETURN DATASET dsRole:HANDLE.

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC VOID getValueList(INPUT-OUTPUT objValueList AS Infragistics.Win.ValueList ):
        FIND FIRST ttRole NO-LOCK NO-ERROR.
        IF NOT AVAILABLE ttRole THEN
            getRole().
        

        FOR EACH ttRole NO-LOCK:
            objValueList:ValueListItems:Add(ttRole.role_id, ttRole.role_name).
        END.

	END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID saveRole(  ):
        
         disableEdit().
         saveData(INPUT "app.roleBE",
                  INPUT "saveRole",
                  INPUT-OUTPUT DATASET dsRole).
    
         /* Refresh the dataset */
         DATASET dsRole:HANDLE:TOP-NAV-QUERY(1):QUERY-OPEN ().
        
        RETURN.

    END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	METHOD PUBLIC HANDLE getRoleHandle(  ):

		RETURN DATASET dsRole:HANDLE.

	END METHOD.
	
    /*------------------------------------------------------------------------------
            Purpose: Standard method to begin editing tracking                     
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID enableEdit(  ):
        TEMP-TABLE ttRole:TRACKING-CHANGES = YES.
    END METHOD.
    
    /*------------------------------------------------------------------------------
            Purpose: Standard method to just stop edititing                       
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID disableEdit(  ):
        TEMP-TABLE ttRole:TRACKING-CHANGES = NO.     
    END METHOD.
    
    /*------------------------------------------------------------------------------
            Purpose: User pressed delete button                         
            Notes:   Delete the current selected row                      
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID deleteRow(  ):
        enableEdit().
        DELETE ttRole. 
    END METHOD.

    /*------------------------------------------------------------------------------
            Purpose: User pressed Cancel Button                                     
            Notes:   Reject all changes and refresh the query                
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID CancelEdit(  ):
        disableEdit().
        DATASET dsRole:REJECT-CHANGES().
        DATASET dsRole:TOP-NAV-QUERY():query-open().
    END METHOD.
    
    /*------------------------------------------------------------------------------
            Purpose: User presse Create Row Button                                  
            Notes:  Insert an empty record in the temp-table                      
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID createRow(  ):
        enableEdit().
        CREATE ttRole.
        DATASET dsRole:TOP-NAV-QUERY():CREATE-RESULT-LIST-ENTRY().
    END METHOD.


END CLASS.