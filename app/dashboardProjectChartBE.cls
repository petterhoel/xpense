 
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

CLASS app.dashboardProjectChartBE INHERITS app.baseBE: 

    {inc/dsDashboardProjectChart.i}
    
    /*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC VOID getDashboardProjectChart( INPUT DATASET dsFilter, OUTPUT DATASET dsDashboardProjectChart ):
		
        DATASET dsDashboardProjectChart:EMPTY-DATASET ().
        
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
        
        BUFFER ttProject:SET-CALLBACK ("after-row-fill", "ttProjectAfterRowFill", THIS-OBJECT).
        
        QUERY qProjectQueryString:QUERY-PREPARE(SUBSTITUTE("FOR EACH project NO-LOCK &1", cQueryWhereString)).
                
        DEFINE DATA-SOURCE srcProject FOR QUERY qProjectQueryString.
        
        BUFFER ttProject:ATTACH-DATA-SOURCE (DATA-SOURCE srcProject:handle).
        
        DATASET dsDashboardProjectChart:FILL().
        
        BUFFER ttProject:DETACH-DATA-SOURCE().
   
	END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/

    METHOD PUBLIC VOID ttProjectAfterRowFill( INPUT DATASET dsDashboardProjectChart ):

        DEFINE VARIABLE dProfitLoss AS DECIMAL INITIAL 0.00 NO-UNDO.
        
        FOR EACH cost WHERE cost.project_id = ttProject.project_id.
            dProfitLoss = dProfitLoss + cost.price.
        END.
        
        ttProject.Profit_Loss = dProfitLoss.

    END METHOD.

END CLASS.