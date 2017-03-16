 
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

CLASS gui.employeeProjectTimeModel INHERITS baseModel: 
    
    {inc/dsEmployeeProjectTime.i}
      
	/*------------------------------------------------------------------------------
	 Purpose: Gets the employee records
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC VOID getEmployeeProjectTime(  ):
        /* get data */
          getData(INPUT "app.employeeProjectTimeBE",
                INPUT "getEmployeeProjectTime",
                OUTPUT DATASET dsEmployeeProjectTime).      
        
        DATASET dsEmployeeProjectTime:HANDLE:TOP-NAV-QUERY(1):QUERY-OPEN().

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC HANDLE getEmployeeProjectTimeHandle(  ):
		
		RETURN DATASET dsEmployeeProjectTime:HANDLE.

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC HANDLE getEmployeeProjectTimeHandleAndData(  ):
		
		getEmployeeProjectTime().

		RETURN  DATASET dsEmployeeProjectTime:HANDLE.

	END METHOD.

END CLASS.