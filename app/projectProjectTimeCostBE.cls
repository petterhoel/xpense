USING Progress.Lang.*.
USING common.bufferHelper. 

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS app.projectProjectTimeCostBE: 
    {inc/dsProjectProjectTimeCost.i}
    {inc/dsFilter.i}
    
    CONSTRUCTOR PUBLIC projectProjectTimeCostBE(): 
        SUPER().
    END CONSTRUCTOR. 
    
    METHOD PUBLIC VOID saveProjectProjectTimeCost(INPUT-OUTPUT DATASET dsProjectProjectTimeCost): 
        
        DEFINE DATA-SOURCE srcProject FOR Project.
        DEFINE DATA-SOURCE srcProjectTime FOR project_time. 
        DEFINE DATA-SOURCE srcCost FOR cost. 
         
        
        BUFFER ttProject:ATTACH-DATA-SOURCE (DATA-SOURCE srcProject:handle).
        BUFFER ttProject_time:ATTACH-DATA-SOURCE (DATA-SOURCE srcProjectTime:handle).
        BUFFER ttCost:ATTACH-DATA-SOURCE (DATA-SOURCE srcCost:handle).
        
        DEFINE VARIABLE lResult AS LOGICAL NO-UNDO.
        
        // project row changes
        FOR EACH Before_ttProject:            
            lResult = BUFFER Before_ttProject:SAVE-ROW-CHANGES (1, "project_id").
            IF lResult THEN 
                BUFFER Before_ttProject:ACCEPT-ROW-CHANGES ().
        END.       
        BUFFER ttProject:DETACH-DATA-SOURCE ().
        
        // project time row changes
        FOR EACH Before_ttProject_time:
            lResult = BUFFER Before_ttProject_time:SAVE-ROW-CHANGES (1, "project_time_id").
            IF lResult THEN 
                BUFFER Before_ttProject_time:ACCEPT-ROW-CHANGES ().
        END. 
        BUFFER ttProject_time:DETACH-DATA-SOURCE ().
        
        // cost row changes
        FOR EACH Before_ttCost: 
            lResult = BUFFER Before_ttCost:SAVE-ROW-CHANGES (1, "cost_id").
            IF lResult THEN 
                BUFFER Before_ttCost:ACCEPT-ROW-CHANGES ().
        END. 
        BUFFER ttCost:DETACH-DATA-SOURCE ().
    
        
    END METHOD. 
    
    METHOD PUBLIC VOID getProjectProjectTimeCost(INPUT DATASET dsFilter, 
                                                 OUTPUT DATASET dsProjectProjectTimeCost):
        
        DATASET dsProjectProjectTimeCost:EMPTY-DATASET ().
        
        
        // set filtered query for project
        DEFINE VARIABLE cWhereProject AS CHARACTER NO-UNDO.            
        FOR EACH ttFilter WHERE ttFilter.table_to_filter EQ "": 
            ASSIGN 
                cWhereProject = IF cWhereProject EQ ""
                THEN SUBSTITUTE("WHERE &1 &2 &3",ttFilter.filter_name,ttFilter.filter_operator,bufferHelper:getFormattedDataType(BUFFER ttProject:handle,ttFilter.filter_name,ttFilter.filter_value))
                           ELSE cWhereProject + SUBSTITUTE(" AND &1 &2 &3",ttFilter.filter_name,ttFilter.filter_operator,bufferHelper:getFormattedDataType(BUFFER ttProject:handle,ttFilter.filter_name,ttFilter.filter_value)).
      
        END. 
        DEFINE QUERY qProject FOR project. 
        QUERY qProject:QUERY-PREPARE (SUBSTITUTE("FOR EACH project NO-LOCK &1", cWhereProject)).
        
        // set filtered query for project_time
        DEFINE VARIABLE cWhereProjectTime AS CHARACTER NO-UNDO.
        FOR EACH ttFilter WHERE ttFilter.table_to_filter EQ "project_time": 
            ASSIGN 
               cWhereProjectTime = IF cWhereProjectTime EQ ""
               THEN SUBSTITUTE("WHERE &1 &2 &3",ttFilter.filter_name,ttFilter.filter_operator,bufferHelper:getFormattedDataType(BUFFER ttProject_time:handle,ttFilter.filter_name,ttFilter.filter_value))
                           ELSE cWhereProjectTime + SUBSTITUTE(" AND &1 &2 &3",ttFilter.filter_name,ttFilter.filter_operator,bufferHelper:getFormattedDataType(BUFFER ttProject_time:handle,ttFilter.filter_name,ttFilter.filter_value)).
      
        END. 
 
        DEFINE QUERY qProjectTime FOR project_time. 
        QUERY qProjectTime:QUERY-PREPARE (SUBSTITUTE("FOR EACH project_time NO-LOCK &1", cWhereProjectTime)).
        
        // data sources
        DEFINE DATA-SOURCE srcProject     FOR QUERY qProject. 
        DEFINE DATA-SOURCE srcProjectTime FOR QUERY qProjectTime. 
        DEFINE DATA-SOURCE srcCost        FOR cost. 
        
        BUFFER ttProject:SET-CALLBACK ("after-row-fill", 
                                       "ttProjectAfterRowFillCallback", 
                                       THIS-OBJECT).

        BUFFER ttProject_time:SET-CALLBACK ("after-row-fill",
                                            "ttProjectTimeAfterRowFillCallback",
                                            THIS-OBJECT).
                                            
       BUFFER ttCost:SET-CALLBACK ( "after-row-fill",
                                    "ttCostAfterRowFillCallback",
                                    THIS-OBJECT).
        
        BUFFER ttProject:ATTACH-DATA-SOURCE (DATA-SOURCE srcProject:Handle ).
        BUFFER ttProject_time:ATTACH-DATA-SOURCE (DATA-SOURCE srcProjectTime:handle).
        BUFFER ttCost:ATTACH-DATA-SOURCE (DATA-SOURCE srcCost:handle).
        
        DATASET dsProjectProjectTimeCost:fill().
        
        BUFFER ttProject:DETACH-DATA-SOURCE ().
        BUFFER ttProject_time:DETACH-DATA-SOURCE ().
        BUFFER ttCost:DETACH-DATA-SOURCE ().
        
    END METHOD. 
  
  
    
    // get names for project IDs
    METHOD PUBLIC VOID ttProjectAfterRowFillCallback(INPUT DATASET dsProjectProjectTimeCost): 
        ttProjectGetCustomerName(DATASET dsProjectProjectTimeCost).
        ttProjectGetTeamName(DATASET dsProjectProjectTimeCost).
    END METHOD.
 
 
    
    // get names for project time ids
    METHOD PUBLIC VOID ttProjectTimeAfterRowFillCallback(INPUT DATASET dsProjectProjectTimeCost):
        ttProjectTimeGetEmployeeName(DATASET dsProjectProjectTimeCost).
    END METHOD. 
  
  
    
    // get names for cost ids
    METHOD PUBLIC VOID ttCostAfterRowFillCallback(INPUT DATASET dsProjectProjectTimeCost):
        ttCostGetCostTypeName(DATASET dsProjectProjectTimeCost).
        ttCostGetCurrencyName(DATASET dsProjectProjectTimeCost).
    END METHOD. 
    
    
    
    // tt Cost
    METHOD PUBLIC VOID ttCostGetCostTypeName(INPUT DATASET dsProjectProjectTimeCost): 
        FIND FIRST cost_type NO-LOCK
            WHERE cost_type.cost_type_id = ttCost.cost_type_id NO-ERROR.
        IF AVAILABLE cost_type THEN 
            ttCost.cost_type_name = cost_type.cost_type_name. 
        ELSE ttCost.cost_type_name = "N/A".     
    END METHOD.    
    
    
    
    METHOD PUBLIC VOID ttCostGetCurrencyName(INPUT DATASET dsProjectProjectTimeCost): 
        FIND FIRST currency NO-LOCK
            WHERE currency.currency_id = ttCost.currency_id NO-ERROR.
        IF AVAILABLE cost_type THEN 
            ttCost.currency_name = currency.currency_name. 
        ELSE ttCost.currency_name = "N/A".     
    END METHOD.  
    
    
    
    // tt projectTime
    METHOD PUBLIC VOID ttProjectTimeGetEmployeeName(INPUT DATASET dsProjectProjectTimeCost): 
        FIND FIRST employee NO-LOCK
            WHERE employee.employee_id = ttProject_time.employee_id NO-ERROR. 
        IF AVAILABLE employee THEN 
            ttProject_time.employee_name = employee.employee_name. 
        ELSE ttProject_time.employee_name = "N/A".
    END METHOD. 
    
    
    
    // tt project
    METHOD PUBLIC VOID ttProjectGetCustomerName(INPUT DATASET dsProjectProjectTimeCost):
        FIND FIRST customer NO-LOCK
            WHERE customer.customer_id EQ ttProject.customer_id NO-ERROR. 
        IF AVAILABLE customer THEN 
            ttProject.customer_name = customer.customer_name.
        ELSE 
            ttProject.customer_name = "N/A".   
    END METHOD. 
   
   
   
    
    METHOD PUBLIC VOID ttProjectGetTeamName(INPUT DATASET dsProjectProjectTimeCost):
        FIND FIRST team NO-LOCK
            WHERE team.team_id EQ ttProject.team_id NO-ERROR. 
        IF AVAILABLE team THEN 
            ttProject.team_name = team.team_name.
        ELSE
            ttProject.team_name = "N/A".
    END METHOD. 
    
    
END CLASS.