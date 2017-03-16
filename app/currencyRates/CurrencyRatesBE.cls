 
 /*------------------------------------------------------------------------
    File        : CurrencyRatesBE
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : Administrator
    Created     : Tue Feb 02 09:54:56 UTC 2016
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*. 

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS app.currencyRates.CurrencyRatesBE: 
    {inc/dsFilter.i}
    {inc/dsCurrencyRates.i}
    /*------------------------------------------------------------------------------
         Purpose:
         Notes:
        ------------------------------------------------------------------------------*/
    CONSTRUCTOR PUBLIC CurrencyRatesBE (  ):
        SUPER ().
        
    END CONSTRUCTOR.
    /*------------------------------------------------------------------------------
         Purpose:
         Notes:
        ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID getCurrencyRates(INPUT DATASET dsFilter,
        OUTPUT DATASET dsCurrencyRates):


         
        
        DATASET dsCurrencyRates:EMPTY-DATASET ().   
        
        //DEFINE QUERY qcurrecnyRates FOR currency, currency_rates.
            //QUERY qcurrecnyRates:QUERY-PREPARE("FOR EACH currency NO-LOCK,
                 //                           FIRST currency_rates NO-LOCK WHERE currency_rates.currency_id EQ currency.currency_id").
        
        DEFINE DATA-SOURCE srcCurrency FOR currency.
        DEFINE DATA-SOURCE srcCurrency_rates FOR currency_rates. //QUERY qcurrecnyRates.
        
    
        BUFFER ttcurrency:ATTACH-DATA-SOURCE (DATA-SOURCE srccurrency:HANDLE). 
        BUFFER ttcurrency_rates:ATTACH-DATA-SOURCE (DATA-SOURCE srcCurrency_rates:HANDLE).
           
           
    
        DATASET dsCurrencyRates:FILL().
        
        BUFFER ttcurrency:DETACH-DATA-SOURCE ().
        BUFFER ttcurrency_rates:DETACH-DATA-SOURCE().


                                                                                           
    END METHOD.
        
        
        METHOD PUBLIC VOID saveCurrencyRates(INPUT-OUTPUT DATASET dsCurrencyRates):
        
            DEFINE VARIABLE lResult AS LOGICAL NO-UNDO.
            DEFINE DATA-SOURCE srcCurrencyRates FOR currency.  
           BUFFER ttCurrency:ATTACH-DATA-SOURCE (DATA-SOURCE srcCurrencyrates:handle).
           FOR EACH           
            Before_ttcurrency: lResult = BUFFER Before_ttCurrency:SAVE-ROW-CHANGES (1,"currency_id").
            
                IF lResult
                    THEN
                    
                    BUFFER Before_ttcurrency:ACCEPT-ROW-CHANGES ().
         
            END.
           BUFFER ttcurrency:DETACH-DATA-SOURCE ().
            
            END METHOD.
    
END CLASS.

