 
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

CLASS app.employeeProjectTimeBE: 

{inc/dsFilter.i}    
{inc/dsEmployeeProjectTime.i}



	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
		
	CONSTRUCTOR PUBLIC employeeProjectTimeBE (  ):
		SUPER ().
		
/*		getEmployeeProjectTime(OUTPUT DATASET dsEmployeeProjectTime).*/
/*		                                                               */
/*		FOR EACH ttEmployee:                                         */
/*		    DISPLAY ttEmployee.                                      */
/*		    FOR EACH ttProject_time OF ttemployee:                   */
/*		         DISPLAY ttproject_time.                             */
/*		    END.                                                     */
/*		END.                                                         */
	END CONSTRUCTOR.


	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC VOID getEmployeeProjectTime(INPUT DATASET dsFilter,
                                   OUTPUT DATASET dsEmployeeProjectTime):

       DEFINE VARIABLE cEmployeeWhere AS CHARACTER NO-UNDO.
       DEFINE VARIABLE cProjectTimeWhere AS CHARACTER NO-UNDO.


        /* empty or the filter will not have an effect */
        DATASET dsEmployeeProjectTime:EMPTY-DATASET().

        /* Create filter */
        FOR EACH ttFilter:

            IF filter_name = "Employee_name" OR filter_name = "department_id" THEN
                ASSIGN cEmployeeWhere = 
                       cEmployeeWhere + SUBSTITUTE(" AND &1 &2 &3", filter_name, filter_operator, bufferHelper:getFormattedDataType(INPUT BUFFER ttEmployee:HANDLE, INPUT filter_name, INPUT filter_value)).

            ELSE
                ASSIGN cProjectTimeWhere =
                       cProjectTimeWhere + SUBSTITUTE(" AND &1 &2 &3", filter_name, filter_operator, bufferHelper:getFormattedDataType(INPUT BUFFER ttProject_time:HANDLE, INPUT filter_name, INPUT filter_value)).

        END.
 
        DEFINE QUERY qEmployee FOR employee, department.
        QUERY qEmployee:QUERY-PREPARE (SUBSTITUTE("FOR EACH employee NO-LOCK,
                                                        FIRST department NO-LOCK
                                                        WHERE department.department_id = employee.department_id &1",cEmployeeWhere)).
        
        DEFINE QUERY qProjectTime FOR project_time, project.
        QUERY qProjectTime:QUERY-PREPARE (SUBSTITUTE("FOR EACH project_time NO-LOCK,
                                              FIRST project NO-LOCK
                                              WHERE project.project_id EQ project_time.project_id &1",cProjectTimeWhere)).
                                              
    /*  get role name by linking */
    /*    DEFINE QUERY qProjectTime FOR project_time, project, employee_team, role .*/
    /*  QUERY qProjectTime:QUERY-PREPARE ("FOR EACH project_time NO-LOCK,                                   */
    /*                                          FIRST project NO-LOCK                                       */
    /*                                          WHERE project.project_id EQ project_time.project_id ,       */
    /*                                          FIRST employee_team NO-LOCK                                 */
    /*                                          WHERE employee_team.team_id EQ project.team_id              */
    /*                                            and employee_team.employee_id eq project_time.employee_id,*/
    /*                                          FIRST role NO-LOCK                                          */
    /*                                          WHERE role.role_id EQ employee_team.role_id").              */
     
        DEFINE DATA-SOURCE srcEmployee FOR QUERY qEmployee.
        DEFINE DATA-SOURCE srcProjectTime FOR QUERY qProjectTime.
        
        /* get role name by using call back */
        BUFFER ttProject_time:SET-CALLBACK("after-row-fill","ttProjectTimeAfterRowFill", THIS-OBJECT).
            
        BUFFER ttEmployee:ATTACH-DATA-SOURCE (DATA-SOURCE srcEmployee:handle).  
        BUFFER ttProject_time:ATTACH-DATA-SOURCE (DATA-SOURCE srcProjectTime:handle).  
        DATASET dsEmployeeProjectTime:FILL().
        BUFFER ttEmployee:DETACH-DATA-SOURCE().      
        BUFFER ttProject_time:DETACH-DATA-SOURCE().      
        
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose: callback function to add rolename
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC VOID ttProjectTimeAfterRowFill(INPUT DATASET dsEmployeeProjectTime  ):
		
		FIND FIRST project WHERE project.project_id = ttProject_time.project_id NO-LOCK NO-ERROR.
		IF AVAILABLE project THEN
		DO:
		  FIND FIRST employee_team WHERE employee_team.team_id = project.team_id 
		      AND employee_team.employee_id = ttProject_time.employee_id NO-LOCK NO-ERROR.
		  IF AVAILABLE employee_team THEN
		  DO:
		      FIND FIRST role WHERE role.role_id = employee_team.role_id NO-LOCK NO-ERROR.
		      IF AVAILABLE role THEN
	                  ASSIGN ttProject_time.role_name = role.role_name.
	   	  END.    
        END.
        
        IF ttProject_time.role_name = "" THEN
            ASSIGN ttProject_time.role_name = "Unknown".
            
	END METHOD.

END CLASS.
