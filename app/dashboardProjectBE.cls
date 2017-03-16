 
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

CLASS app.dashboardProjectBE INHERITS app.baseBE: 

    {inc/dsDashboardProject.i}
    
    /*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC VOID getDashboardProject( INPUT DATASET dsFilter, OUTPUT DATASET dsDashboardProject ):
		
        DATASET dsDashboardProject:EMPTY-DATASET ().
        
        DEFINE VARIABLE cQueryWhereString AS CHARACTER NO-UNDO.

        DEFINE QUERY qProjectQueryString FOR project.
        
        FOR EACH ttFilter.                                                                                                                                       
            IF AVAILABLE ttFilter AND cQueryWhereString = "" THEN
                    DO:
                        ASSIGN cQueryWhereString = SUBSTITUTE("WHERE &1 &2 &3", ttFilter.filter_name, ttFilter.filter_operator, bufferHelper:getFormattedDataType(BUFFER ttProject:handle,ttFilter.filter_name,ttFilter.filter_value)).
                    END.
              ELSE
                    DO:                                                                                                                                        
                        ASSIGN cQueryWhereString = cQueryWhereString + SUBSTITUTE(" AND &1 &2 &3", ttFilter.filter_name, ttFilter.filter_operator, bufferHelper:getFormattedDataType(BUFFER ttProject:handle,ttFilter.filter_name,ttFilter.filter_value)).  
                    END.                                                                                                                                       
        END.

        QUERY qProjectQueryString:QUERY-PREPARE(SUBSTITUTE("FOR EACH project NO-LOCK &1", cQueryWhereString)).
        
        BUFFER ttProject:SET-CALLBACK ("after-row-fill", "ttProjectAfterRowFill", THIS-OBJECT).
        
        DEFINE DATA-SOURCE srcProject FOR QUERY qProjectQueryString.
        DEFINE DATA-SOURCE srcCost FOR cost.
        
        BUFFER ttProject:ATTACH-DATA-SOURCE (DATA-SOURCE srcProject:handle).
        BUFFER ttCost:ATTACH-DATA-SOURCE (DATA-SOURCE srcCost:HANDLE).
        
        DATASET dsDashboardProject:FILL().
        
        BUFFER ttProject:DETACH-DATA-SOURCE().
        BUFFER ttCost:DETACH-DATA-SOURCE().
        
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC VOID getDashboardProjectCountry( INPUT DATASET dsFilter, OUTPUT DATASET dsDashboardProject ):
		
		DATASET dsDashboardProject:EMPTY-DATASET ().
        
        DEFINE VARIABLE cQueryWhereString AS CHARACTER NO-UNDO.
         DEFINE VARIABLE cQueryWhereString2 AS CHARACTER NO-UNDO.

        DEFINE QUERY qProjectQueryString FOR project, customer.
        
        FOR EACH ttFilter WHERE ttFilter.filter_name NE "country_id":                                                                                                                                    
            IF AVAILABLE ttFilter AND cQueryWhereString = "" THEN
                    DO:
                        ASSIGN cQueryWhereString = SUBSTITUTE("WHERE &1 &2 &3", ttFilter.filter_name, ttFilter.filter_operator, bufferHelper:getFormattedDataType(BUFFER ttProject:handle,ttFilter.filter_name,ttFilter.filter_value)).
                    END.
              ELSE
                    DO:                                                                                                                                        
                        ASSIGN cQueryWhereString = cQueryWhereString + SUBSTITUTE(" AND &1 &2 &3", ttFilter.filter_name, ttFilter.filter_operator, bufferHelper:getFormattedDataType(BUFFER ttProject:handle,ttFilter.filter_name,ttFilter.filter_value)).  
                    END.                                                                                                                                       
        END.
        
        FOR EACH ttFilter WHERE ttFilter.filter_name EQ "country_id":                                                                                                                                    
            IF AVAILABLE ttFilter AND cQueryWhereString2 = "" THEN
                    DO:
                        ASSIGN cQueryWhereString2 = SUBSTITUTE("and &1 &2 &3", ttFilter.filter_name, ttFilter.filter_operator, bufferHelper:getFormattedDataType(BUFFER ttProject:handle,ttFilter.filter_name,ttFilter.filter_value)).
                    END.
              ELSE
                    DO:                                                                                                                                        
                        ASSIGN cQueryWhereString2 = cQueryWhereString2 + SUBSTITUTE(" AND &1 &2 &3", ttFilter.filter_name, ttFilter.filter_operator, bufferHelper:getFormattedDataType(BUFFER ttProject:handle,ttFilter.filter_name,ttFilter.filter_value)).  
                    END.                                                                                                                                       
        END.
        
        QUERY qProjectQueryString:QUERY-PREPARE(SUBSTITUTE("FOR EACH project NO-LOCK &1, FIRST customer NO-LOCK WHERE customer.customer_id = project.customer_id &2" , cQueryWhereString,cQueryWhereString2)).
        
        BUFFER ttProject:SET-CALLBACK ("after-row-fill", "ttProjectAfterRowFill", THIS-OBJECT).
        
        DEFINE DATA-SOURCE srcProject FOR QUERY qProjectQueryString.
        DEFINE DATA-SOURCE srcCost FOR cost.
        
        BUFFER ttProject:ATTACH-DATA-SOURCE (DATA-SOURCE srcProject:handle).
        BUFFER ttCost:ATTACH-DATA-SOURCE (DATA-SOURCE srcCost:HANDLE).
        
        DATASET dsDashboardProject:FILL().
        
        BUFFER ttProject:DETACH-DATA-SOURCE().
        BUFFER ttCost:DETACH-DATA-SOURCE().

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC VOID ttProjectAfterRowFill( INPUT DATASET dsDashboardProject ):

		DEFINE VARIABLE dProfitLoss AS DECIMAL INITIAL 0.00 NO-UNDO.
        
        FOR EACH cost WHERE cost.project_id = ttProject.project_id.
            dProfitLoss = dProfitLoss + cost.price.
        END.
        
        ttProject.Profit_Loss = dProfitLoss.

	END METHOD.

END CLASS.