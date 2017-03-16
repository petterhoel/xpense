    
/*------------------------------------------------------------------------
    File        : From template DataSet - template for DataSet. 
    Author(s)   : <author>
    Created     : Thu Jan 28 10:33:37 UTC 2016
    Version     : 1.0
    Notes       :
  ----------------------------------------------------------------------*/  /*------------------------------------------------------------------------
    File        : From template TempTable - template for temp-table. 
    Author(s)   : <author>
    Created     : Thu Jan 28 10:33:37 UTC 2016
    Version     : 
    Notes       :
  ----------------------------------------------------------------------*/
  /* temp-table definition for ttProject_time */
  
  @com.openedge.t4bl.model(modeFile="platform:/resource/Xpense/appModel.t4bl", uuid="_1jHcMMT9EeWeo94oZ3equg").
 				 
  DEFINE TEMP-TABLE ttProject_time
   NO-UNDO   BEFORE-TABLE Before_ttProject_time
     FIELD project_time_id AS INTEGER LABEL "Project Time ID" FORMAT "->,>>>,>>9" 
     FIELD project_id AS INTEGER LABEL "Project ID" FORMAT "->,>>>,>>9" 
     FIELD employee_id AS INTEGER LABEL "Employee ID" FORMAT "->,>>>,>>9" 
     FIELD start_date_time AS DATETIME LABEL "Start" FORMAT "99/99/9999 HH:MM:SS" 
     FIELD stop_date_time AS DATETIME LABEL "Stop" FORMAT "99/99/9999 HH:MM:SS" 
     FIELD comment AS CHARACTER LABEL "Comment" FORMAT "x(70)" 
     FIELD project_name AS CHARACTER LABEL "Project Name" FORMAT "x(70)" 
     FIELD role_name AS CHARACTER LABEL "Role Name" FORMAT "x(40)" 
   INDEX iProjectTimeId IS  PRIMARY UNIQUE     
      project_time_id ASCENDING
   INDEX iEmployeeId     
      employee_id ASCENDING
   INDEX iProjectId     
      project_id ASCENDING
   INDEX iStartDateTime     
      start_date_time ASCENDING
  .  		  /*------------------------------------------------------------------------
    File        : From template TempTable - template for temp-table. 
    Author(s)   : <author>
    Created     : Thu Jan 28 10:33:37 UTC 2016
    Version     : 
    Notes       :
  ----------------------------------------------------------------------*/
  /* temp-table definition for ttEmployee */
  
  @com.openedge.t4bl.model(modeFile="platform:/resource/Xpense/appModel.t4bl", uuid="_T4M4IMWqEeWLU4-L5zdklg").
 				 
  DEFINE TEMP-TABLE ttEmployee
   NO-UNDO   BEFORE-TABLE Before_ttEmployee
     FIELD employee_id AS INTEGER LABEL "Employee Id" FORMAT "->,>>>,>>9" 
     FIELD employee_name AS CHARACTER LABEL "Employee Name" FORMAT "x(40)" 
     FIELD department_id AS INTEGER LABEL "Department Id" FORMAT "->,>>>,>>9" 
     FIELD department_name AS CHARACTER LABEL "Department Name" FORMAT "x(40)" 
   INDEX iEmployeeId IS  PRIMARY UNIQUE     
      employee_id ASCENDING
   INDEX iDepartmentId     
      department_id ASCENDING
   INDEX iEmployeeName     
      employee_name ASCENDING
  .  		

  
 
  @com.openedge.t4bl.model(modeFile="platform:/resource/Xpense/appModel.t4bl", uuid="_uVR4XsTfEeWPP-WpmosW9A").
 				  
  DEFINE DATASET dsEmployeeProjectTime FOR ttProject_time, ttEmployee
	  DATA-RELATION drEmployeeProjectTime FOR ttEmployee, ttProject_time
		RELATION-FIELDS (employee_id,employee_id)    .
