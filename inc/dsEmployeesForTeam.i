    
/*------------------------------------------------------------------------
    File        : From template DataSet - template for DataSet. 
    Author(s)   : <author>
    Created     : Tue Feb 02 14:13:09 UTC 2016
    Version     : 1.0
    Notes       :
  ----------------------------------------------------------------------*/  /*------------------------------------------------------------------------
    File        : From template TempTable - template for temp-table. 
    Author(s)   : <author>
    Created     : Tue Feb 02 14:13:09 UTC 2016
    Version     : 
    Notes       :
  ----------------------------------------------------------------------*/
  /* temp-table definition for ttEmployee_team */
  
  @com.openedge.t4bl.model(modeFile="platform:/resource/Xpense/appModel.t4bl", uuid="_nJ0sAMjaEeWRnuGSLTwjTQ").
 				 
  DEFINE TEMP-TABLE ttEmployee_team
   NO-UNDO   BEFORE-TABLE Before_ttEmployee_team
     FIELD employee_id AS INTEGER LABEL "Employee Id" FORMAT "->,>>>,>>9" 
     FIELD team_id AS INTEGER LABEL "Team Id" FORMAT "->,>>>,>>9" 
     FIELD employee_team_id AS INTEGER LABEL "Employee Team Id" FORMAT "->,>>>,>>9" 
     FIELD role_id AS INTEGER LABEL "Role Id" FORMAT "->,>>>,>>9" 
     FIELD employee_cost AS DECIMAL LABEL "Employee Cost" FORMAT "->>,>>9.99" DECIMALS 2 
     FIELD role_name AS CHARACTER LABEL "Role Name" FORMAT "x(40)" 
     FIELD role_cost AS DECIMAL LABEL "Role Cost" FORMAT "->>,>>9.99" DECIMALS 2 
     FIELD employee_name AS CHARACTER LABEL "Employee Name" FORMAT "x(40)" 
     FIELD department_name AS CHARACTER LABEL "Department Name" FORMAT "x(40)" 
   INDEX iEmployeeId     
      employee_id ASCENDING
   INDEX iRoleId     
      role_id ASCENDING
   INDEX iTeamId     
      team_id ASCENDING
  .  		

  
 
  @com.openedge.t4bl.model(modeFile="platform:/resource/Xpense/appModel.t4bl", uuid="_mW4MtcjaEeWRnuGSLTwjTQ").
 				  
  DEFINE DATASET dsEmployeesForTeam FOR ttEmployee_team .
