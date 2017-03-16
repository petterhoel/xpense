 
 /*------------------------------------------------------------------------
    File        : dashboardCustomerBE
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : Administrator
    Created     : Tue Feb 02 14:20:15 UTC 2016
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING common.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS app.dashboardCountryBE INHERITS app.baseBE: 

    {inc/dsDashboardCountry.i}

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC VOID getDashboardCountry( INPUT DATASET dsFilter, OUTPUT DATASET dsDashboardCountry ):
		
        DATASET dsDashboardCountry:EMPTY-DATASET ().
        
        DEFINE VARIABLE cQueryWhereString AS CHARACTER NO-UNDO.
        
        FOR EACH ttFilter.                                                                                                                                       
            IF AVAILABLE ttFilter AND cQueryWhereString = "" THEN
                    DO:
                        ASSIGN cQueryWhereString = SUBSTITUTE("WHERE &1 &2 &3", ttFilter.filter_name, ttFilter.filter_operator, bufferHelper:getFormattedDataType(BUFFER ttCountry:handle,ttFilter.filter_name,ttFilter.filter_value)).
                    END.
              ELSE
                    DO:                                                                                                                                        
                        ASSIGN cQueryWhereString = SUBSTITUTE("AND &1 &2 &3", ttFilter.filter_name, ttFilter.filter_operator, bufferHelper:getFormattedDataType(BUFFER ttCountry:handle,ttFilter.filter_name,ttFilter.filter_value)).  
                    END.                                                                                                                                       
        END.
        
        DEFINE VARIABLE hBuffer AS HANDLE NO-UNDO.
        DEFINE VARIABLE hQuery AS HANDLE NO-UNDO.
        DEFINE VARIABLE hDataSource AS HANDLE NO-UNDO.
        
        CREATE BUFFER hBuffer FOR TABLE "country".
        CREATE QUERY hQuery.
        CREATE DATA-SOURCE hDataSource.
        
        hQuery:ADD-BUFFER (hBuffer).
        
        hDataSource:QUERY = hQuery.
        
        hQuery:QUERY-PREPARE(SUBSTITUTE ("FOR EACH country NO-LOCK &1", cQueryWhereString)).
        
        BUFFER ttCountry:SET-CALLBACK ("after-row-fill", "ttCountryAfterRowFill", THIS-OBJECT).
        
        DEFINE DATA-SOURCE srcCost FOR cost.
        
        BUFFER ttCountry:ATTACH-DATA-SOURCE (hDatasource).
        BUFFER ttCost:ATTACH-DATA-SOURCE (DATA-SOURCE srcCost:HANDLE).
        
        DATASET dsDashboardCountry:FILL().
        
        BUFFER ttCountry:DETACH-DATA-SOURCE().
        BUFFER ttCost:DETACH-DATA-SOURCE().
        
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC VOID ttCountryAfterRowFill( INPUT DATASET dsDashboardCountry ):

		DEFINE VARIABLE dProfitLoss AS DECIMAL INITIAL 0.00 NO-UNDO.
        
        FOR EACH customer NO-LOCK WHERE ttCountry.country_id = customer.country_id:

            FOR EACH project NO-LOCK WHERE project.customer_id = customer.customer_id:
            
                FOR EACH cost NO-LOCK WHERE project.project_id = cost.project_id. 
                    dProfitLoss = dProfitLoss + cost.price. 
                END.
           END.                         
        END.
        
        ttCountry.Profit_Loss = dProfitLoss.

	END METHOD.

END CLASS.