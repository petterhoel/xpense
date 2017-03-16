 
 /*------------------------------------------------------------------------
    File        : employeeModel
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : Administrator
    Created     : Tue Jan 26 14:27:43 UTC 2016
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING gui.baseModel.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS gui.employeeModel INHERITS baseModel: 
    
    {inc/dsEmployee.i}
    /*------------------------------------------------------------------------------
    Purpose: User pressed Cancel Button
    Notes: Reject all changes and refresh the query
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID CancelEdit( ):
        disableEdit().
        DATASET dsEmployee:REJECT-CHANGES().
        DATASET dsEmployee:TOP-NAV-QUERY():QUERY-OPEN().
    END METHOD.

    /*------------------------------------------------------------------------------
    Purpose: User presse Create Row Button
    Notes: Insert an empty record in the temp-table
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID createRow( ):
        enableEdit().
        CREATE ttEmployee.
        DATASET dsEmployee:TOP-NAV-QUERY():CREATE-RESULT-LIST-ENTRY().
    END METHOD.

    /*------------------------------------------------------------------------------
    Purpose: User pressed delete button
    Notes: Delete the current selected row
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID deleteRow( ):
        enableEdit().
        DELETE ttEmployee.
        saveRowChanges().
    END METHOD.
    /*------------------------------------------------------------------------------
    Purpose: Standard method to stop editing tracking
    Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID disableEdit( ):
        TEMP-TABLE ttEmployee:TRACKING-CHANGES = NO.
    END METHOD. 
    
    
    /*------------------------------------------------------------------------------
    Purpose: Standard method to begin editing tracking
    Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID enableEdit( ):
        TEMP-TABLE ttEmployee:TRACKING-CHANGES = YES.
    END METHOD.  
    
       
	/*------------------------------------------------------------------------------
	 Purpose: Gets the employee records
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC VOID getEmployee(  ):
        /* get data */
        
        getData(INPUT "app.employeeBE",
                INPUT "getEmployee",
                OUTPUT DATASET dsEmployee). 
        
        DATASET dsEmployee:HANDLE:TOP-NAV-QUERY(1):QUERY-OPEN().
        /* we'll see */
/*        TEMP-TABLE ttEmployee:TRACKING-CHANGES = TRUE.*/
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC HANDLE getEmployeeHandle(  ):
		
		RETURN DATASET dsEmployee:HANDLE.

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC HANDLE getEmployeeHandleAndData(  ):
		
        getEmployee().

        RETURN  DATASET dsEmployee:HANDLE.

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC VOID saveEmployee():
        disableEdit().

        saveData(INPUT "app.employeeBE", 
                 INPUT "saveEmployee", 
                 INPUT-OUTPUT DATASET dsEmployee).
        
	END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/

    METHOD PUBLIC VOID saveRowChanges():
        /* we'll see */
        disableEdit().
        
        DEFINE VARIABLE hChangedDataset AS HANDLE NO-UNDO.
        CREATE DATASET hChangedDataset.
        hChangedDataset:CREATE-LIKE (DATASET dsEmployee:HANDLE).
        hChangedDataset:GET-CHANGES (DATASET dsEmployee:HANDLE).

        saveData(INPUT "app.employeeBE",
                 INPUT "saveEmployee", 
                 INPUT-OUTPUT DATASET-HANDLE hChangedDataset).

        
    END METHOD.
END CLASS.