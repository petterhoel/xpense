 
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

CLASS app.dashboardCustomerBE INHERITS app.baseBE: 

    {inc/dsDashboardCustomer.i}

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC VOID getDashboardCustomer( INPUT DATASET dsFilter, OUTPUT DATASET dsDashboardCustomer ):
		
        DATASET dsDashboardCustomer:EMPTY-DATASET ().
        
        DEFINE VARIABLE cQueryWhereString AS CHARACTER NO-UNDO.

        DEFINE QUERY qCustomerQueryString FOR customer, country.
        
        FOR EACH ttFilter.                                                                                                                                       
            IF AVAILABLE ttFilter AND cQueryWhereString = "" THEN
                    DO:
                        ASSIGN cQueryWhereString = SUBSTITUTE("WHERE &1 &2 &3", ttFilter.filter_name, ttFilter.filter_operator, bufferHelper:getFormattedDataType(BUFFER ttCustomer:handle,ttFilter.filter_name,ttFilter.filter_value)).
                    END.
              ELSE
                    DO:                                                                                                                                        
                        ASSIGN cQueryWhereString = SUBSTITUTE("AND &1 &2 &3", ttFilter.filter_name, ttFilter.filter_operator, bufferHelper:getFormattedDataType(BUFFER ttCustomer:handle,ttFilter.filter_name,ttFilter.filter_value)).  
                    END.                                                                                                                                       
        END.
        
        QUERY qCustomerQueryString:QUERY-PREPARE(SUBSTITUTE("FOR EACH customer NO-LOCK &1, FIRST country WHERE customer.country_id = country.country_id", cQueryWhereString)).
        
        BUFFER ttCustomer:SET-CALLBACK ("after-row-fill", "ttCustomerAfterRowFill", THIS-OBJECT).
        
        DEFINE DATA-SOURCE srcCustomer FOR QUERY qCustomerQueryString.
        DEFINE DATA-SOURCE srcCost FOR cost.
        
        BUFFER ttCustomer:ATTACH-DATA-SOURCE (DATA-SOURCE srcCustomer:HANDLE).
        BUFFER ttCost:ATTACH-DATA-SOURCE (DATA-SOURCE srcCost:HANDLE).
        
        DATASET dsDashboardCustomer:FILL().
        
        BUFFER ttCustomer:DETACH-DATA-SOURCE().
        
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC VOID ttCustomerAfterRowFill( INPUT DATASET dsDashboardCustomer ):

		DEFINE VARIABLE dProfitLoss AS DECIMAL INITIAL 0.00 DECIMALS 2 NO-UNDO.
        
        FOR EACH project WHERE project.customer_id = ttCustomer.customer_id.
        
            FOR EACH cost NO-LOCK WHERE project.project_id = cost.project_id.
                dProfitLoss = dProfitLoss + cost.price.            
            END.
        END.
        
        IF ERROR-STATUS:ERROR THEN
            ttCustomer.Profit_Loss = 0.00.
        ELSE
            ttCustomer.Profit_Loss = dProfitLoss.

	END METHOD.

END CLASS.