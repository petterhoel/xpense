 
 /*------------------------------------------------------------------------
    File        : currencyBE
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : petter
    Created     : Mon Jan 25 14:01:04 GMT 2016
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS app.currencyBE: 
    {inc/dsCurrency.i}
    {inc/dsFilter.i}
CONSTRUCTOR PUBLIC currencyBE (): 
    SUPER().
/*    getCurrency(OUTPUT DATASET dsCurrency).*/
/*    FOR EACH ttCurrency:                   */
/*        DISPLAY ttCurrency.                */
/*    END.                                   */
 
END CONSTRUCTOR. 


METHOD PUBLIC VOID getCurrency(INPUT DATASET dsFilter, 
                               OUTPUT DATASET dsCurrency):
/*    EMPTY DATASET*/
    DATASET dsCurrency:EMPTY-DATASET (). 
    
    DEFINE VARIABLE cWhere AS CHARACTER NO-UNDO. 
       
    
    /*    CREATE filter query*/
    FOR EACH ttFilter:
        
        ASSIGN 
            cWhere = IF cWhere EQ ""
                THEN SUBSTITUTE ("WHERE &1 &2 &3", ttFilter.filter_name,
                                                   ttFilter.filter_operator,
                                                   QUOTER(ttfilter.filter_value))
                ELSE cWhere + substitute(" AND &1 &2 &3", ttFilter.filter_name, 
                                                          ttFilter.filter_operator, 
                                                          QUOTER(ttfilter.filter_value))  
            .
    END.
    
    /*    STATIC MODE*/
    /*    DEFINE QUERY qCurrency FOR currency.                                                */
    /*    DEFINE DATA-SOURCE srcCurrency FOR QUERY qCurrency.                                 */
    /*                                                                                        */
    /*    QUERY qCurrency:QUERY-PREPARE (SUBSTITUTE ("FOR EACH currency NO-LOCK &1", cWhere)).*/
    /*                                                                                        */
    /*    MESSAGE SUBSTITUTE ("FOR EACH currency NO-LOCK &1", cWhere) VIEW-AS ALERT-BOX.      */
    /*                                                                                        */
    /*    BUFFER ttCurrency:ATTACH-DATA-SOURCE (DATA-SOURCE srcCurrency:handle).              */
    /*    DATASET dsCurrency:FILL ().                                                         */
    /*    BUFFER ttCurrency:DETACH-DATA-SOURCE ().                                            */    
    /*                                                                          */
    /*    BUFFER ttCurrency:ATTACH-DATA-SOURCE (DATA-SOURCE srcCurrency:handle).*/
    /*     DATASET dsCurrency:FILL ().                                           */
    /*    BUFER ttCurrency:DETACH-DATA-SOURCE ()                               */


/*  semi DYNAMIC mode*/
    DEFINE VARIABLE hBuffer AS HANDLE NO-UNDO.
    DEFINE VARIABLE hQuery AS HANDLE NO-UNDO.
    DEFINE VARIABLE hDataSource AS HANDLE NO-UNDO.

    CREATE BUFFER hBuffer FOR TABLE "Currency".

    CREATE QUERY hQuery.
    hQuery:ADD-BUFFER (hBuffer).

    CREATE DATA-SOURCE hDataSource.
    hDataSource:QUERY = hquery.

    hquery:QUERY-PREPARE (SUBSTITUTE ("FOR EACH currency NO-LOCK &1", cWhere)).

    BUFFER ttCurrency:ATTACH-DATA-SOURCE (hDataSource).
    DATASET dsCurrency:FILL ().
    BUFFER ttCurrency:DETACH-DATA-SOURCE ().
    
    
  
    

    
END METHOD. 

/*    METHOD PUBLIC VOID saveCurrency(INPUT-OUTPUT DATASET dsCurrency):         */
/*       /*                                                                     */
/*        DEFINE QUERY qCurrency FOR currency.                                  */
/*        DEFINE DATA-SOURCE scrCurrency FOR QUERY qCurrency.                   */
/*        QUERY qCurrency:QUERY-PREPARE("FOR EACH currency NO-LOCK").*/         */
/*                                                                              */
/*        DEFINE DATA-SOURCE srcCurrency FOR currency.                          */
/*                                                                              */
/*        BUFFER ttCurrency:ATTACH-DATA-SOURCE (DATA-SOURCE srcCurrency:handle).*/
/*                                                                              */
/*        FOR EACH Before_ttCurrency:                                           */
/*                                                                              */
/*            BUFFER Before_ttCurrency:SAVE-ROW-CHANGES (1, "currency_id").     */
/*        END.                                                                  */
/*                                                                              */
/*        BUFFER ttCurrency:DETACH-DATA-SOURCE ().                              */
/*                                                                              */
/*    END METHOD.                                                               */
    
    METHOD PUBLIC VOID saveCurrency(INPUT-OUTPUT DATASET dsCurrency):
    
        
    DEFINE DATA-SOURCE srcCurrency FOR currency. 
        DEFINE VARIABLE lResult AS LOGICAL NO-UNDO.
        BUFFER ttCurrency:ATTACH-DATA-SOURCE (DATA-SOURCE srcCurrency:handle).
        
        FOR EACH Before_ttCurrency: 
            
            lResult = BUFFER Before_ttCurrency:SAVE-ROW-CHANGES (1, "currency_id").
            IF lResult THEN 
                BUFFER Before_ttCurrency:ACCEPT-ROW-CHANGES ().
        END. 
        
        BUFFER ttCurrency:DETACH-DATA-SOURCE ().
        
    END METHOD. 



END CLASS.