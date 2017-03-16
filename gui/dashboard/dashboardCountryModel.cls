 
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

CLASS gui.dashboard.dashboardCountryModel INHERITS gui.baseModel: 

    {inc/dsDashboardCountry.i}
     
    DEFINE PUBLIC PROPERTY activeCountryId AS INTEGER NO-UNDO 
    GET:
        IF AVAILABLE ttCountry
        THEN RETURN ttCountry.country_id.
    END GET.
    PRIVATE SET.
        
    /*------------------------------------------------------------------------------
     Purpose:  Gets the customerBE class and creates a handle for it
     Notes:
    ------------------------------------------------------------------------------*/

    METHOD PUBLIC VOID getDashboardCountry(  ):
        
        getData(INPUT "app.dashboardCountryBE", INPUT "getDashboardCountry", OUTPUT DATASET dsDashboardCountry).
        
        DATASET dsDashboardCountry:HANDLE:TOP-NAV-QUERY(1):QUERY-OPEN ().
        
        clearFilter().
    
    END METHOD.    
    
    /*------------------------------------------------------------------------------
     Purpose:  Returns the handle to the form.
     Notes:
    ------------------------------------------------------------------------------*/

    METHOD PUBLIC HANDLE getDashboardCountryHandle(  ):
                
        RETURN DATASET dsDashboardCountry:HANDLE.

    END METHOD. 

END CLASS.