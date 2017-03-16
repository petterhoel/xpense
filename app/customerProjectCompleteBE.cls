 
 /*------------------------------------------------------------------------
    File        : customerprojectCompleteBE
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : tcoomans
    Created     : Wed Jan 27 11:43:25 CET 2016
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING common.*.



BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS app.customerprojectCompleteBE: 

{inc\dsCustomerprojectComplete.i}
{inc\dsFilter.i}

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
		
	CONSTRUCTOR PUBLIC customerprojectCompleteBE (  ):
		SUPER ().
/*		getCustomerProjectComplete(INPUT DATASET dsFilter,                                            */
/*		                           OUTPUT DATASET dsCustomerProjectComplete).                         */
/*		                                                                                                */
/*		FOR EACH ttCustomer:                                                                          */
/*		    DISPLAY ttCustomer.                                                                       */
/*		                                                                                                */
/*		    FOR EACH ttProject OF ttCustomer:                                                         */
/*		        DISPLAY ttProject.                                                                    */
/*		                                                                                                */
/*		        FOR EACH ttCost WHERE ttCost.project_id =  ttProject.project_id:		                    */
/*		            DISPLAY ttCost.                                                                   */
/*		        END.                                                                                  */
/*                FOR EACH ttProject_time WHERE ttProject_time.project_id =  ttProject.project_id:*/
/*                    DISPLAY ttProject_time.                                                     */
/*                END. 		                                                                         */
/*		    END.                                                                                      */
/*		                                                                                                */
/*		END.                                                                                          */
		
	END CONSTRUCTOR.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC VOID getCustomerProjectComplete(INPUT DATASET dsFilter,
	                                              OUTPUT DATASET dsCustomerProjectComplete):
		
		DEFINE VARIABLE cWhere AS CHARACTER NO-UNDO.
		
		/* create filter where string */
		FOR EACH ttFilter:
		    
           ASSIGN cWhere = IF cWhere EQ ""
                           THEN SUBSTITUTE("WHERE &1 &2 &3",ttFilter.filter_name,ttFilter.filter_operator,bufferHelper:getFormattedDataType(BUFFER ttCustomer:handle,ttFilter.filter_name,ttFilter.filter_value))
                           ELSE cWhere + SUBSTITUTE(" AND &1 &2 &3",ttFilter.filter_name,ttFilter.filter_operator,bufferHelper:getFormattedDataType(BUFFER ttCustomer:handle,ttFilter.filter_name,ttFilter.filter_value)).
		END.    
		
		/* use query to fill country name */
		DEFINE QUERY qCustomer FOR customer, country.
		QUERY qCustomer:QUERY-PREPARE(SUBSTITUTE("FOR EACH customer NO-LOCK &1, 
		                                 FIRST country NO-LOCK 
		                                   WHERE country.country_id EQ customer.country_id",cWhere)). 

        /* use query to fill employee name */
        DEFINE QUERY qProject_time FOR project_time, employee.
        QUERY qProject_time:QUERY-PREPARE("FOR EACH project_time NO-LOCK, 
                                             FIRST employee NO-LOCK 
                                               WHERE employee.employee_id EQ project_time.employee_id"). 
		
		/* define datasources */
		DEFINE DATA-SOURCE srcCustomer FOR QUERY qCustomer.
		DEFINE DATA-SOURCE srcProject FOR project.
        DEFINE DATA-SOURCE srcCost FOR cost.
        DEFINE DATA-SOURCE srcProject_time FOR QUERY qProject_time.
		
		/* define callback to listen to after-row-fill events */
		BUFFER ttProject:SET-CALLBACK ("after-row-fill","ttProjectAfterRowFill",THIS-OBJECT).
		BUFFER ttCost:SET-CALLBACK ("after-row-fill","ttCostAfterRowFill",THIS-OBJECT).
		
		BUFFER ttCustomer:ATTACH-DATA-SOURCE (DATA-SOURCE srcCustomer:handle).
		BUFFER ttProject:ATTACH-DATA-SOURCE (DATA-SOURCE srcProject:handle).
		BUFFER ttCost:ATTACH-DATA-SOURCE (DATA-SOURCE srcCost:handle).
		BUFFER ttProject_time:ATTACH-DATA-SOURCE (DATA-SOURCE srcProject_time:handle).
		
		DATASET dsCustomerProjectComplete:fill().
		 
		BUFFER ttCustomer:DETACH-DATA-SOURCE ().
		BUFFER ttProject:DETACH-DATA-SOURCE ().
		BUFFER ttCost:DETACH-DATA-SOURCE ().
		BUFFER ttProject_time:DETACH-DATA-SOURCE ().
		
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	METHOD PUBLIC VOID ttProjectAfterRowFill(INPUT DATASET dsCustomerProjectComplete):
	    
	    FIND FIRST team NO-LOCK
	      WHERE team.team_id EQ ttProject.team_id NO-ERROR.
	    IF AVAILABLE team
	    THEN
	      ASSIGN ttProject.team_name = team.team_name.
	    ELSE
	      ASSIGN ttProject.team_name = "UNKNOWN TEAM".
	      
	END METHOD.
	
    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID ttCostAfterRowFill(INPUT DATASET dsCustomerProjectComplete):
        
        /* get cost_type name */
        FIND FIRST cost_type NO-LOCK
          WHERE cost_type.cost_type_id EQ ttCost.cost_type_id NO-ERROR.
        IF AVAILABLE cost_type
        THEN
          ASSIGN ttCost.cost_type_name = cost_type.cost_type_name.
        ELSE
          ASSIGN ttCost.cost_type_name = "UNKNOWN COST TYPE".
        
        /* get currency symbol */
        FIND FIRST currency NO-LOCK
          WHERE currency.currency_id EQ ttCost.currency_id NO-ERROR.
        IF AVAILABLE currency
        THEN
          ASSIGN ttCost.symbol = currency.symbol.
        ELSE
          ASSIGN ttCost.symbol = "UNKNOWN COST TYPE".
            
    END METHOD.
END CLASS.