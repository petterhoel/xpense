 
 /*------------------------------------------------------------------------
    File        : employeeBE
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : Administrator
    Created     : Mon Jan 25 14:01:46 UTC 2016
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.


BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS app.employeeBE: 

{inc/dsFilter.i}    
{inc/dsEmployee.i}




	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
		
	CONSTRUCTOR PUBLIC employeeBE (  ):
		SUPER ().
		
/*		getEmployee(OUTPUT DATASET dsEmployee).*/
/*		                                         */
/*		FOR EACH ttEmployee:   */
/*		    DISPLAY ttEmployee.*/
/*		END.                   */
	END CONSTRUCTOR.


	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC VOID getEmployee(INPUT DATASET dsFilter,
	                               OUTPUT DATASET dsEmployee):

		
        DEFINE VARIABLE cWhere AS CHARACTER NO-UNDO.
        

        /* empty or the filter will not have an effect */
        DATASET dsEmployee:EMPTY-DATASET().
        
		/* Create filter */
		FOR EACH ttFilter:
		    
         ASSIGN cWhere = IF cWhere EQ ""
                           THEN  SUBSTITUTE("WHERE &1 &2 &3",ttFilter.filter_name,ttFilter.filter_operator,QUOTER(ttFilter.filter_value))
                           ELSE cWhere + SUBSTITUTE(" AND &1 &2 &3",ttFilter.filter_name,ttFilter.filter_operator,QUOTER(ttFilter.filter_value)).	    
		END.
				
/* fixed 		
        DEFINE QUERY qEmployee FOR employee.
        DEFINE DATA-SOURCE srcEmployee FOR QUERY qEmployee.

		QUERY qEmployee:QUERY-PREPARE(SUBSTITUTE("FOR EACH employee NO-LOCK &1",cWhere)).
		
		BUFFER ttEmployee:ATTACH-DATA-SOURCE (DATA-SOURCE srcEmployee:handle).

/*        Clear dataset and refil                  */		 
/*        DATASET dsEmployee:FILL-MODE = "empty".  */

/*        Update each line                         */
/*        DATASET dsEmployee:FILL-MODE = "replace".*/

/*        Default mode add new don't update        */
/*        DATASET dsEmployee:FILL-MODE = "merge".  */ 
       		 
		DATASET dsEmployee:FILL().
		
		BUFFER ttEmployee:DETACH-DATA-SOURCE().		 
 end fixed */
/* dynamic */
        DEFINE VARIABLE cTableName AS CHARACTER INITIAL "Employee" NO-UNDO.
        DEFINE VARIABLE hBuffer AS HANDLE NO-UNDO.
        DEFINE VARIABLE hQuery AS HANDLE NO-UNDO.
        DEFINE VARIABLE hDataSource AS HANDLE NO-UNDO.
        
        CREATE BUFFER hBuffer FOR TABLE cTableName.
        
        CREATE QUERY hQuery.
        hQuery:ADD-BUFFER (hBuffer).
        
        CREATE DATA-SOURCE hDataSource.
        hDataSource:QUERY = hQuery.
        
        hQuery:QUERY-PREPARE(SUBSTITUTE("FOR EACH &1 NO-LOCK &2 by employee_ID",cTableName,cWhere)).
        
        
        BUFFER ttEmployee:SET-CALLBACK("after-row-fill", "ttEmployeeAfterRowFill", THIS-OBJECT).
          
  /* below are not dynamic but could be */      
        BUFFER ttEmployee:ATTACH-DATA-SOURCE (hDataSource).
        DATASET dsEmployee:FILL().
        BUFFER ttEmployee:DETACH-DATA-SOURCE().
/* end dynamic */

	END METHOD.



	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC VOID saveEmployee(INPUT-OUTPUT DATASET dsEmployee):
		
		DEFINE VARIABLE lResult AS LOGICAL NO-UNDO.
		
		DEFINE DATA-SOURCE srcEmployee FOR employee.
		
		BUFFER ttEmployee:ATTACH-DATA-SOURCE (DATA-SOURCE srcEmployee:HANDLE).
		
		FOR EACH before_ttEmployee:
		  lResult = BUFFER before_ttEmployee:SAVE-ROW-CHANGES (1,"employee_id").
          ttEmployeeRowUpdate(INPUT-OUTPUT DATASET dsEmployee  ).
          
 		  IF lResult THEN
		  DO:
    	      BUFFER  before_ttEmployee:ACCEPT-ROW-CHANGES ().
		  END. 
		END.

		BUFFER ttEmployee:DETACH-DATA-SOURCE ().

	END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    -------------------------------------------------ttEmployeeAfterRowFill-----------------------------*/

    METHOD PUBLIC VOID ttEmployeeRowUpdate(INPUT-OUTPUT DATASET dsEmployee  ):
        FIND FIRST ttEmployee WHERE ttemployee.employee_id = before_ttemployee.employee_id NO-ERROR.
        IF AVAILABLE ttEmployee THEN
        DO:
            FIND FIRST department WHERE department.department_id = ttEmployee.department_id NO-LOCK NO-ERROR.
            IF AVAILABLE department THEN
                ASSIGN ttEmployee.department_name = department.department_name.
            ELSE
                ASSIGN ttEmployee.department_name = "Unknown".
        END.
    END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC VOID ttEmployeeAfterRowFill(INPUT DATASET dsEmployee  ):
		FIND FIRST department WHERE department.department_id = ttEmployee.department_id NO-LOCK NO-ERROR.
        IF AVAILABLE department THEN
            ASSIGN ttEmployee.department_name = department.department_name.
        ELSE
            ASSIGN ttEmployee.department_name = "Unknown".

	END METHOD.

END CLASS.