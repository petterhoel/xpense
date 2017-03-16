    
/*------------------------------------------------------------------------
    File        : From template DataSet - template for DataSet. 
    Author(s)   : <author>
    Created     : Tue Feb 02 09:34:54 UTC 2016
    Version     : 1.0
    Notes       :
  ----------------------------------------------------------------------*/  /*------------------------------------------------------------------------
    File        : From template TempTable - template for temp-table. 
    Author(s)   : <author>
    Created     : Tue Feb 02 09:34:54 UTC 2016
    Version     : 
    Notes       :
  ----------------------------------------------------------------------*/
  /* temp-table definition for ttProject */
  
  @com.openedge.t4bl.model(modeFile="platform:/resource/Xpense/appModel.t4bl", uuid="_62Z-kMmOEeWVGP1hEVy59w").
 				 
  DEFINE TEMP-TABLE ttProject
   NO-UNDO   BEFORE-TABLE Before_ttProject
     FIELD project_id AS INTEGER LABEL "Project ID" FORMAT "->,>>>,>>9" 
     FIELD customer_id AS INTEGER LABEL "Customer ID" FORMAT "->,>>>,>>9" 
     FIELD project_name AS CHARACTER LABEL "Project Name" FORMAT "x(70)" 
     FIELD start_date AS DATE LABEL "Start Date" FORMAT "99/99/9999" 
     FIELD due_date AS DATE LABEL "Due Date" FORMAT "99/99/9999" 
     FIELD team_id AS INTEGER LABEL "Team ID" FORMAT "->,>>>,>>9" 
     FIELD project_description AS CHARACTER LABEL "Project Description" FORMAT "x(70)" 
   INDEX iProjectId IS  PRIMARY UNIQUE     
      project_id ASCENDING
   INDEX iCustomerId     
      customer_id ASCENDING
  .  		

  
 
  @com.openedge.t4bl.model(modeFile="platform:/resource/Xpense/appModel.t4bl", uuid="_yLnOIMmNEeWN35WbfLzi0w").
 				  
  DEFINE DATASET dsProject FOR ttProject .
