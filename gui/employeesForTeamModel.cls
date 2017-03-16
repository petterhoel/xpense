 
 /*------------------------------------------------------------------------
    File        : employeesForTeamModel
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

CLASS gui.employeesForTeamModel INHERITS baseModel: 
    
    {inc/dsEmployeesForTeam.i}
    /*------------------------------------------------------------------------------
    Purpose: User pressed Cancel Button
    Notes: Reject all changes and refresh the query
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID CancelEdit( ):
        disableEdit().
        DATASET dsEmployeesForTeam:REJECT-CHANGES().
        DATASET dsEmployeesForTeam:TOP-NAV-QUERY():QUERY-OPEN().
    END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC VOID createNewEmployeeTeam(INPUT team_id AS INTEGER,
	                                         INPUT employee_Id AS INTEGER,
	                                         INPUT employee_name AS CHARACTER,
	                                         INPUT department_name AS CHARACTER):
	                                            
		

        enableEdit().
        CREATE ttEmployee_team.
        ASSIGN ttEmployee_team.team_id = team_id
               ttEmployee_team.employee_id = employee_Id
               ttEmployee_team.employee_name = employee_name
               ttEmployee_team.department_name = department_name.

        DATASET dsEmployeesForTeam:TOP-NAV-QUERY():CREATE-RESULT-LIST-ENTRY().


	END METHOD.

    /*------------------------------------------------------------------------------
    Purpose: User presse Create Row Button
    Notes: Insert an empty record in the temp-table
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID createRow( ):
        enableEdit().
        CREATE ttEmployee_team.
        DATASET dsEmployeesForTeam:TOP-NAV-QUERY():CREATE-RESULT-LIST-ENTRY().
    END METHOD.

    /*------------------------------------------------------------------------------
    Purpose: User pressed delete button
    Notes: Delete the current selected row
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID deleteRow( ):
        enableEdit().
        DELETE ttEmployee_team.
    END METHOD.
    /*------------------------------------------------------------------------------
    Purpose: Standard method to stop editing tracking
    Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID disableEdit( ):
        TEMP-TABLE ttEmployee_team:TRACKING-CHANGES = NO.
    END METHOD. 
    
    
    /*------------------------------------------------------------------------------
    Purpose: Standard method to begin editing tracking
    Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID enableEdit( ):
        TEMP-TABLE ttEmployee_team:TRACKING-CHANGES = YES.
    END METHOD.  
    
       
	/*------------------------------------------------------------------------------
	 Purpose: Gets the employee records
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC VOID getEmployee(  ):
        /* get data */
        
        getData(INPUT "app.employeesForTeamBE",
                INPUT "getEmployee",
                OUTPUT DATASET dsEmployeesForTeam). 
        
        DATASET dsEmployeesForTeam:HANDLE:TOP-NAV-QUERY(1):QUERY-OPEN().

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC HANDLE getEmployeeHandle(  ):
		
		RETURN DATASET dsEmployeesForTeam:HANDLE.

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC HANDLE getEmployeeHandleAndData(  ):
		
        getEmployee().

        RETURN  DATASET dsEmployeesForTeam:HANDLE.

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

/*	METHOD PUBLIC VOID getFilterForEmployeeExcluding(INPUT-OUTPUT toFilter AS gui.employeeModel   ):    */
/*		                                                                                                     */
/*		toFilter:clearFilter().                                                                            */
/*		FOR EACH ttEmployee_team NO-LOCK:                                                                  */
/*		    toFilter:addFilter(INPUT "employee_id", INPUT "NE", INPUT STRING(ttEmployee_team.employee_id)).*/
/*		END.                                                                                               */
/*                                                                                                     */
/*	END METHOD.                                                                                         */

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC VOID refreshData(  ):
		
		DATASET dsEmployeesForTeam:HANDLE:TOP-NAV-QUERY(1):QUERY-OPEN().

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC VOID saveEmployee():
        disableEdit().

        saveData(INPUT "app.employeesForTeamBE", 
                 INPUT "saveEmployee", 
                 INPUT-OUTPUT DATASET dsEmployeesForTeam).
        
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
        hChangedDataset:CREATE-LIKE (DATASET dsEmployeesForTeam:HANDLE).
        hChangedDataset:GET-CHANGES (DATASET dsEmployeesForTeam:HANDLE).

        saveData(INPUT "app.employeesForTeamBE",
                 INPUT "saveEmployee", 
                 INPUT-OUTPUT DATASET-HANDLE hChangedDataset).

        
    END METHOD.
    

END CLASS.