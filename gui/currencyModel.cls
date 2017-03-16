 
 /*------------------------------------------------------------------------
    File        : currencyModel
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : petter
    Created     : Tue Jan 26 14:27:40 GMT 2016
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING gui.baseModel.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS gui.currencyModel INHERITS baseModel:    
    
    {inc/dsCurrency.i}
            
    METHOD PUBLIC HANDLE getCurrencyHandle ():
        
        RETURN DATASET dsCurrency:HANDLE.
    
    END METHOD.     
    
    METHOD PUBLIC VOID createRow(  ):
        
        enableEdit().
        CREATE ttCurrency.
        DATASET dsCurrency:TOP-NAV-QUERY():CREATE-RESULT-LIST-ENTRY (). // vi må ha en entry i queryen vår også

    END METHOD.


    METHOD PUBLIC VOID getCurrency():

        getData(INPUT "app.currencyBE",
                INPUT "getCurrency",
                OUTPUT DATASET dsCurrency).                        
        DATASET dsCurrency:HANDLE:TOP-NAV-QUERY(1):QUERY-OPEN ().
        
    END METHOD. 
    
    
    METHOD PUBLIC VOID deleteRow():
        enableEdit().
        DELETE ttCurrency.
        saveCurrency().
    END METHOD.
    
    
    
    METHOD PUBLIC VOID enableEdit():
        TEMP-TABLE ttCurrency:TRACKING-CHANGES = YES. 
    END METHOD. 

    
    METHOD PUBLIC VOID disableEdit():
        TEMP-TABLE ttCurrency:TRACKING-CHANGES = NO. 
    END METHOD. 
    
    METHOD PUBLIC VOID saveCurrency():

        saveData(INPUT "app.CurrencyBE",
            INPUT "saveCurrency",
            INPUT-OUTPUT DATASET dsCurrency).
        
        // refresh dataset
        DATASET dsCurrency:HANDLE:TOP-NAV-QUERY(1):QUERY-OPEN (). 
        
    END METHOD. 
    
    METHOD PUBLIC VOID cancelEdit():
        disableEdit().
        DATASET dsCurrency:REJECT-CHANGES ().
        DATASET dsCurrency:HANDLE:TOP-NAV-QUERY(1):QUERY-OPEN ().
    END METHOD. 
    
    
END CLASS.