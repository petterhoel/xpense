 
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

CLASS gui.dashboard.dashboardCustomerModel INHERITS gui.baseModel: 

    {inc/dsDashboardCustomer.i}
                
    DEFINE PUBLIC PROPERTY activeCustomerId AS INTEGER NO-UNDO 
    GET:
        IF AVAILABLE ttCustomer
        THEN RETURN ttCustomer.customer_id.
    END GET.
    PRIVATE SET.
    
    /*------------------------------------------------------------------------------
     Purpose:  Gets the customerBE class and creates a handle for it
     Notes:
    ------------------------------------------------------------------------------*/

    METHOD PUBLIC VOID getDashboardCustomer(  ):
        
        getData(INPUT "app.dashboardCustomerBE", INPUT "getDashboardCustomer", OUTPUT DATASET dsDashboardCustomer).
        
        DATASET dsDashboardCustomer:HANDLE:TOP-NAV-QUERY(1):QUERY-OPEN ().
        
        clearFilter().
    
    END METHOD.    
    
    /*------------------------------------------------------------------------------
     Purpose:  Returns the handle to the form.
     Notes:
    ------------------------------------------------------------------------------*/

    METHOD PUBLIC HANDLE getDashboardCustomerHandle(  ):
                
        RETURN DATASET dsDashboardCustomer:HANDLE.

    END METHOD. 

END CLASS.