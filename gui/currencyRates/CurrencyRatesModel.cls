 
 /*------------------------------------------------------------------------
    File        : CurrencyRatesModel
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : Administrator
    Created     : Mon Feb 01 14:52:29 UTC 2016
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING gui.baseModel.

BLOCK-LEVEL ON ERROR UNDO, THROW. 

CLASS gui.currencyRates.CurrencyRatesModel INHERITS baseModel:
{inc/dsCurrencyRates.i}

METHOD PUBLIC HANDLE getCurrencyRates(  ):
        
    getData(INPUT "app.currencyRates.CurrencyRatesBE",
        INPUT "getCurrencyRates",
        OUTPUT DATASET dsCurrencyRates).
    
    /* Refresh the dataset */
    DATASET dsCurrencyRates:HANDLE:TOP-NAV-QUERY(1):QUERY-OPEN ().
        
    RETURN DATASET dsCurrencyRates:HANDLE.

END METHOD.
METHOD PUBLIC VOID saveCurrencyRates(  ):
        
        disableEdit().
        saveData(INPUT "app.CurrencyRatesBE",
            INPUT "saveCurrencyRates",
            INPUT-OUTPUT DATASET dsCurrencyRates).
    
        /* Refresh the dataset */
        DATASET dsCurrencyRates:HANDLE:TOP-NAV-QUERY(1):QUERY-OPEN ().
        
        RETURN.

    END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC HANDLE getCurrencyRatesHandle(  ):

        RETURN DATASET dsCurrencyRates:HANDLE.

    END METHOD.
    
    /*------------------------------------------------------------------------------
            Purpose: Standard method to begin editing tracking                     
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID enableEdit(  ):
        
        TEMP-TABLE ttCurrency:TRACKING-CHANGES = YES.
    END METHOD.
    
    /*------------------------------------------------------------------------------
            Purpose: Standard method to just stop edititing                       
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID disableEdit(  ):
        TEMP-TABLE ttCurrency:TRACKING-CHANGES = NO.
           
    END METHOD.
    
    /*------------------------------------------------------------------------------
            Purpose: User pressed delete button                         
            Notes:   Delete the current selected row                      
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID deleteRow(  ):
        enableEdit().
        DELETE ttCurrency. 
        saveCurrencyRates().
    END METHOD.

    /*------------------------------------------------------------------------------
            Purpose: User pressed Cancel Button                                     
            Notes:   Reject all changes and refresh the query                
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID CancelEdit(  ):
        disableEdit().
        DATASET dsCurrencyRates:REJECT-CHANGES().
        DATASET dsCurrencyRates:TOP-NAV-QUERY():query-open().
    END METHOD.
    
    /*------------------------------------------------------------------------------
            Purpose: User presse Create Row Button                                  
            Notes:  Insert an empty record in the temp-table                      
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID createRow(  ):
        enableEdit().
        CREATE ttCurrency.
        DATASET dsCurrencyRates:TOP-NAV-QUERY():CREATE-RESULT-LIST-ENTRY().
    END METHOD.




END CLASS.