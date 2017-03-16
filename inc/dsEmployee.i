    
/*------------------------------------------------------------------------
    File        : From template DataSet - template for DataSet. 
    Author(s)   : <author>
    Created     : Mon Feb 01 16:37:05 UTC 2016
    Version     : 1.0
    Notes       :
  ----------------------------------------------------------------------*/  /*------------------------------------------------------------------------
    File        : From template TempTable - template for temp-table. 
    Author(s)   : <author>
    Created     : Mon Feb 01 16:37:05 UTC 2016
    Version     : 
    Notes       :
  ----------------------------------------------------------------------*/
  /* temp-table definition for ttEmployee */
  
  @com.openedge.t4bl.model(modeFile="platform:/resource/Xpense/appModel.t4bl", uuid="_vaHoMMT-EeWeo94oZ3equg").
 				 
  DEFINE TEMP-TABLE ttEmployee
   NO-UNDO   BEFORE-TABLE Before_ttEmployee
     FIELD employee_id AS INTEGER LABEL "Employee ID" FORMAT "->,>>>,>>9" 
     FIELD employee_name AS CHARACTER LABEL "Employee Name" FORMAT "x(40)" 
     FIELD department_name AS CHARACTER LABEL "Department Name" FORMAT "x(40)" 
     FIELD department_id AS INTEGER LABEL "Department ID" FORMAT "->,>>>,>>9" 
   INDEX iEmployeeId IS  PRIMARY UNIQUE     
      employee_id ASCENDING
   INDEX iEmployeeName     
      employee_name ASCENDING
  .  		

  
 
  @com.openedge.t4bl.model(modeFile="platform:/resource/Xpense/appModel.t4bl", uuid="_uXu-IMT-EeWeo94oZ3equg").
 				  
  DEFINE DATASET dsEmployee FOR ttEmployee .
