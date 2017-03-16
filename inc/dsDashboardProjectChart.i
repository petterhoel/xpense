    
/*------------------------------------------------------------------------
    File        : From template DataSet - template for DataSet. 
    Author(s)   : <author>
    Created     : Thu Feb 04 12:56:43 UTC 2016
    Version     : 1.0
    Notes       :
  ----------------------------------------------------------------------*/  /*------------------------------------------------------------------------
    File        : From template TempTable - template for temp-table. 
    Author(s)   : <author>
    Created     : Thu Feb 04 12:56:43 UTC 2016
    Version     : 
    Notes       :
  ----------------------------------------------------------------------*/
  /* temp-table definition for ttProject */
  
  @com.openedge.t4bl.model(modeFile="platform:/resource/Xpense/appModel.t4bl", uuid="_E56vIMs1EeWyfYlQmct83Q").
 				 
  DEFINE TEMP-TABLE ttProject
   NO-UNDO   BEFORE-TABLE Before_ttProject
     FIELD project_id AS INTEGER LABEL "Project Id" FORMAT "->,>>>,>>9" 
     FIELD project_name AS CHARACTER LABEL "Project Name" FORMAT "x(70)" 
     FIELD Profit_Loss AS DECIMAL LABEL "Profit/Loss" FORMAT "->,>>>,>>9" DECIMALS 2 
   INDEX iProjectId IS  PRIMARY UNIQUE     
      project_id ASCENDING
  .  		

  
 
  @com.openedge.t4bl.model(modeFile="platform:/resource/Xpense/appModel.t4bl", uuid="_EE3WcMs1EeWyfYlQmct83Q").
 				  
  DEFINE DATASET dsDashboardProjectChart FOR ttProject .
