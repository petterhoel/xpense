 
 /*------------------------------------------------------------------------
    File        : departmentBE
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : Administrator
    Created     : Mon Jan 25 14:01:46 UTC 2016
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS app.departmentBE: 

{inc/dsFilter.i}    
{inc/dsDepartment.i}




	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
		
	CONSTRUCTOR PUBLIC departmentBE (  ):
		SUPER ().
		
/*		getEmployee(OUTPUT DATASET dsDepartment).*/
/*		                                         */
/*		FOR EACH ttDepartment:   */
/*		    DISPLAY ttDepartment.*/
/*		END.                   */
	END CONSTRUCTOR.


	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC VOID getDepartment(INPUT DATASET dsFilter,
	                               OUTPUT DATASET dsDepartment):

		
        DEFINE VARIABLE cWhere AS CHARACTER NO-UNDO.
        

        /* empty or the filter will not have an effect */
        DATASET dsDepartment:EMPTY-DATASET().
        
		/* Create filter */
		FOR EACH ttFilter:
		    
		    ASSIGN cWhere = IF cWhere = "" THEN 
                		      SUBSTITUTE(" WHERE &1 &2 &3", filter_name, filter_operator, QUOTER(filter_value))
                		    ELSE
                		      cwhere + SUBSTITUTE(" AND &1 &2 &3", filter_name, filter_operator, QUOTER(filter_value)).
		    
		END.
		
/* fixed 		
        DEFINE QUERY qEmployee FOR employee.
        DEFINE DATA-SOURCE srcEmployee FOR QUERY qEmployee.

		QUERY qEmployee:QUERY-PREPARE(SUBSTITUTE("FOR EACH employee NO-LOCK &1",cWhere)).
		
		BUFFER ttDepartment:ATTACH-DATA-SOURCE (DATA-SOURCE srcEmployee:handle).

/*        Clear dataset and refil                  */		 
/*        DATASET dsDepartment:FILL-MODE = "empty".  */

/*        Update each line                         */
/*        DATASET dsDepartment:FILL-MODE = "replace".*/

/*        Default mode add new don't update        */
/*        DATASET dsDepartment:FILL-MODE = "merge".  */ 
       		 
		DATASET dsDepartment:FILL().
		
		BUFFER ttDepartment:DETACH-DATA-SOURCE().		 
 end fixed */
/* dynamic */
        DEFINE VARIABLE cTableName AS CHARACTER INITIAL "Department" NO-UNDO.
        DEFINE VARIABLE hBuffer AS HANDLE NO-UNDO.
        DEFINE VARIABLE hQuery AS HANDLE NO-UNDO.
        DEFINE VARIABLE hDataSource AS HANDLE NO-UNDO.
        
        CREATE BUFFER hBuffer FOR TABLE cTableName.
        
        CREATE QUERY hQuery.
        hQuery:ADD-BUFFER (hBuffer).
        
        CREATE DATA-SOURCE hDataSource.
        hDataSource:QUERY = hQuery.
        
        hQuery:QUERY-PREPARE(SUBSTITUTE("FOR EACH &1 NO-LOCK &2",cTableName,cWhere)).
        
          
  /* below are not dynamic but could be */      
        BUFFER ttDepartment:ATTACH-DATA-SOURCE (hDataSource).
        DATASET dsDepartment:FILL().
        BUFFER ttDepartment:DETACH-DATA-SOURCE().
/* end dynamic */

	END METHOD.




END CLASS.