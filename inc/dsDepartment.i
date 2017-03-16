    
/*------------------------------------------------------------------------
    File        : From template DataSet - template for DataSet. 
    Author(s)   : <author>
    Created     : Thu Jan 28 10:05:29 UTC 2016
    Version     : 1.0
    Notes       :
  ----------------------------------------------------------------------*/  /*------------------------------------------------------------------------
    File        : From template TempTable - template for temp-table. 
    Author(s)   : <author>
    Created     : Thu Jan 28 10:05:29 UTC 2016
    Version     : 
    Notes       :
  ----------------------------------------------------------------------*/
  /* temp-table definition for ttDepartment */
  
  @com.openedge.t4bl.model(modeFile="platform:/resource/Xpense/appModel.t4bl", uuid="_jARnUMWmEeWDn9_s_Xh79w").
 				 
  DEFINE TEMP-TABLE ttDepartment
   NO-UNDO   BEFORE-TABLE Before_ttDepartment
     FIELD department_id AS INTEGER LABEL "Department ID" FORMAT "->,>>>,>>9" 
     FIELD department_name AS CHARACTER LABEL "Department Name" FORMAT "x(40)" 
   INDEX iDepartmentid IS  PRIMARY UNIQUE     
      department_id ASCENDING
  .  		

  
 
  @com.openedge.t4bl.model(modeFile="platform:/resource/Xpense/appModel.t4bl", uuid="_nOB5yMUVEeWDUpX9RD9Bow").
 				  
  DEFINE DATASET dsDepartment FOR ttDepartment .
