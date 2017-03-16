 
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

CLASS gui.dashboard.dashboardProjectChartModel INHERITS gui.baseModel: 

    {inc/dsDashboardProjectChart.i}

    /*------------------------------------------------------------------------------
     Purpose:  Gets the customerBE class and creates a handle for it
     Notes:
    ------------------------------------------------------------------------------*/

    METHOD PUBLIC VOID getDashboardProject(  ):
        
        getData(INPUT "app.dashboardProjectChartBE", INPUT "getDashboardProjectChart", OUTPUT DATASET dsDashboardProjectChart).
        
        DATASET dsDashboardProjectChart:HANDLE:TOP-NAV-QUERY(1):QUERY-OPEN ().
        
        clearFilter().
    
    END METHOD.    
  
    /*------------------------------------------------------------------------------
     Purpose:  Returns the handle to the form.
     Notes:
    ------------------------------------------------------------------------------*/

    METHOD PUBLIC HANDLE getDashboardProjectChartHandle(  ):
                
        RETURN DATASET dsDashboardProjectChart:HANDLE.

    END METHOD. 
    
END CLASS.