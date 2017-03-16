 
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
USING common.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS app.employeesForTeamBE: 

{inc/dsFilter.i}    
{inc/dsEmployeesForTeam.i}




	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
		
	CONSTRUCTOR PUBLIC employeesForTeamBE (  ):
		SUPER ().
		
/*      getEmployee(INPUT DATASET dsFilter,OUTPUT DATASET dsEmployeesForTeam).*/
/*                                                                            */
/*      FOR EACH ttEmployee_team:                                             */
/*          DISPLAY ttEmployee_team.                                          */
/*      END.                                                                  */
	END CONSTRUCTOR.


	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC VOID getEmployee(INPUT DATASET dsFilter,
	                               OUTPUT DATASET dsEmployeesForTeam):

		
        DEFINE VARIABLE cWhere AS CHARACTER NO-UNDO.
        

        /* empty or the filter will not have an effect */
        DATASET dsEmployeesForTeam:EMPTY-DATASET().
        
		/* Create filter */
		FOR EACH ttFilter:

         ASSIGN cWhere = IF cWhere EQ ""
                           THEN  SUBSTITUTE(" WHERE &1 &2 &3",ttFilter.filter_name,ttFilter.filter_operator,bufferHelper:getFormattedDataType(INPUT BUFFER ttEmployee_team:HANDLE, INPUT filter_name, INPUT filter_value))
                           ELSE cWhere + SUBSTITUTE(" AND &1 &2 &3",ttFilter.filter_name,ttFilter.filter_operator,bufferHelper:getFormattedDataType(INPUT BUFFER ttEmployee_team:HANDLE, INPUT filter_name, INPUT filter_value)).	    
		END.

/* fixed*/ 		
        DEFINE QUERY qEmployee FOR employee_team.

		QUERY qEmployee:QUERY-PREPARE(SUBSTITUTE("FOR EACH employee_team NO-LOCK &1 BY employee_id",cWhere)).

        DEFINE DATA-SOURCE srcEmployee FOR QUERY qEmployee.

        BUFFER ttEmployee_team:SET-CALLBACK("after-row-fill","ttEmployeeAfterRowFill", THIS-OBJECT).

		BUFFER ttEmployee_team:ATTACH-DATA-SOURCE (DATA-SOURCE srcEmployee:handle).

/*        Clear dataset and refil                  */		 
/*        DATASET dsEmployee:FILL-MODE = "empty".  */

/*        Update each line                         */
/*        DATASET dsEmployee:FILL-MODE = "replace".*/

/*        Default mode add new don't update        */
/*        DATASET dsEmployee:FILL-MODE = "merge".  */ 
       		 
		DATASET dsEmployeesForTeam:FILL().
		
		BUFFER ttEmployee_team:DETACH-DATA-SOURCE().		
  /*fixed */


	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC VOID saveEmployee(INPUT-OUTPUT DATASET dsEmployeesForTeam):
		
		DEFINE VARIABLE lResult AS LOGICAL NO-UNDO.
		
		DEFINE DATA-SOURCE srcEmployee FOR employee_team.
		
		BUFFER ttEmployee_team:ATTACH-DATA-SOURCE (DATA-SOURCE srcEmployee:HANDLE).
		
		FOR EACH before_ttEmployee_team:
		  lResult = BUFFER before_ttEmployee_team:SAVE-ROW-CHANGES (1,"employee_team_id").
           
 		  IF lResult THEN
		  DO:
		      ttEmployeeTeamRowUpdate().
		      
    	      BUFFER  before_ttEmployee_team:ACCEPT-ROW-CHANGES ().
		  END. 
		END.

		BUFFER ttEmployee_team:DETACH-DATA-SOURCE ().

	END METHOD.
	
    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/

    METHOD PUBLIC VOID ttEmployeeTeamRowUpdate():
        FIND FIRST Employee_team WHERE Employee_team.employee_id = before_ttEmployee_team.employee_id 
                                     AND Employee_team.team_id = before_ttEmployee_team.team_id NO-ERROR.
        IF AVAILABLE Employee_team THEN
        DO:
              FIND FIRST role WHERE role.role_id = Employee_team.role_id NO-LOCK NO-ERROR.
            IF AVAILABLE role THEN
                ASSIGN Employee_team.employee_cost = role.role_cost.
        END.
    END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/

    METHOD PUBLIC VOID ttEmployeeAfterRowFill(INPUT DATASET dsEmployeesForTeam  ):
        FIND FIRST employee WHERE employee.employee_id = ttEmployee_team.employee_id NO-LOCK NO-ERROR.
        IF AVAILABLE employee THEN
        DO:
            ASSIGN ttEmployee_team.employee_name = employee.employee_name.         
            FIND FIRST department WHERE department.department_id = employee.department_id NO-LOCK NO-ERROR.
            IF AVAILABLE department THEN
                ASSIGN ttEmployee_team.department_name = department.department_name.
            ELSE
                ASSIGN ttEmployee_team.department_name = "Unknown".
        END.
        ELSE
            ASSIGN ttEmployee_team.employee_name = "Unknown"
                   ttEmployee_team.department_name = "Unknown".
                

	    
		FIND FIRST role WHERE role.role_id = ttEmployee_team.role_id NO-LOCK NO-ERROR.
        IF AVAILABLE role THEN
            ASSIGN ttEmployee_team.role_name = role.role_name
                   ttEmployee_team.role_cost = role.role_cost.
                   
        ELSE
            ASSIGN ttEmployee_team.role_name = "Unknown"
                   ttEmployee_team.role_cost = 0.

	END METHOD.

END CLASS.