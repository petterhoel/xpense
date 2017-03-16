 
 /*------------------------------------------------------------------------
    File        : dashboardCustomerModel
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : Administrator
    Created     : Tue Feb 02 11:13:30 UTC 2016
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS gui.dashboard.dashboardProjectModel INHERITS gui.baseModel: 

    {inc/dsDashboardProject.i}

    DEFINE PUBLIC PROPERTY activeProjectId AS INTEGER NO-UNDO 
    GET:
        IF AVAILABLE ttProject
        THEN RETURN ttProject.project_id.
    END GET.
    PRIVATE SET.

    /*------------------------------------------------------------------------------
     Purpose:  Gets the customerBE class and creates a handle for it
     Notes:
    ------------------------------------------------------------------------------*/

    METHOD PUBLIC VOID getDashboardProject(  ):
        
        getData(INPUT "app.dashboardProjectBE", INPUT "getDashboardProject", OUTPUT DATASET dsDashboardProject).
        
        DATASET dsDashboardProject:HANDLE:TOP-NAV-QUERY(1):QUERY-OPEN ().
        
        clearFilter().
    
    END METHOD.    
    
	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC VOID getDashboardProjectCountry(  ):
		
		getData(INPUT "app.dashboardProjectBE", INPUT "getDashboardProjectCountry", OUTPUT DATASET dsDashboardProject).
        
        DATASET dsDashboardProject:HANDLE:TOP-NAV-QUERY(1):QUERY-OPEN ().
        
        clearFilter().

	END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:  Returns the handle to the form.
     Notes:
    ------------------------------------------------------------------------------*/

    METHOD PUBLIC HANDLE getDashboardProjectHandle(  ):
                
        RETURN DATASET dsDashboardProject:HANDLE.

    END METHOD. 
    
    /*------------------------------------------------------------------------------
     Purpose:  Returns the handle to the form.
     Notes:
    ------------------------------------------------------------------------------*/

    METHOD PUBLIC HANDLE getDashboardProjectHandle2(  ):
                
        RETURN DATASET dsDashboardProject:HANDLE.

    END METHOD. 

END CLASS.