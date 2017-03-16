 
 /*------------------------------------------------------------------------
    File        : departmentModel
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

CLASS gui.departmentModel INHERITS baseModel: 
    
    {inc/dsDepartment.i}
     
     
	/*------------------------------------------------------------------------------
	 Purpose: Gets the department records
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC VOID getDepartment(  ):
        /* get data */
        getData(INPUT "app.departmentBE",
                INPUT "getDepartment",
                OUTPUT DATASET dsDepartment).
       
        
        DATASET dsDepartment:HANDLE:TOP-NAV-QUERY(1):QUERY-OPEN().

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC HANDLE getDepartmentHandle(  ):
		
		RETURN DATASET dsDepartment:HANDLE.

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC HANDLE getDepartmentHandleAndData(  ):
		
		getdepartment().

		RETURN getDepartmentHandle().

	END METHOD.

END CLASS.