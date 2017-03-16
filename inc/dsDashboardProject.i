    
/*------------------------------------------------------------------------
    File        : From template DataSet - template for DataSet. 
    Author(s)   : <author>
    Created     : Wed Feb 03 16:15:58 UTC 2016
    Version     : 1.0
    Notes       :
  ----------------------------------------------------------------------*/  /*------------------------------------------------------------------------
    File        : From template TempTable - template for temp-table. 
    Author(s)   : <author>
    Created     : Wed Feb 03 16:15:58 UTC 2016
    Version     : 
    Notes       :
  ----------------------------------------------------------------------*/
  /* temp-table definition for ttProject */
  
  @com.openedge.t4bl.model(modeFile="platform:/resource/Xpense/appModel.t4bl", uuid="_iKkGIMpuEeWy0vdiWYuxeQ").
 				 
  DEFINE TEMP-TABLE ttProject
   NO-UNDO   BEFORE-TABLE Before_ttProject
     FIELD project_id AS INTEGER LABEL "Project ID" FORMAT "->,>>>,>>9" 
     FIELD customer_id AS INTEGER LABEL "Customer Id" FORMAT "->,>>>,>>9" 
     FIELD project_name AS CHARACTER LABEL "Project Name" FORMAT "x(70)" 
     FIELD start_date AS DATE LABEL "Start Date" FORMAT "99/99/9999" 
     FIELD due_date AS DATE LABEL "Due Date" FORMAT "99/99/9999" 
     FIELD Profit_Loss AS DECIMAL LABEL "Profit/Loss" FORMAT "->,>>>,>>9" DECIMALS 2 
     FIELD country_id AS INTEGER LABEL "Country Id" FORMAT "->,>>>,>>9" 
   INDEX iProjectId IS  PRIMARY UNIQUE     
      project_id ASCENDING
  .  		  /*------------------------------------------------------------------------
    File        : From template TempTable - template for temp-table. 
    Author(s)   : <author>
    Created     : Wed Feb 03 16:15:58 UTC 2016
    Version     : 
    Notes       :
  ----------------------------------------------------------------------*/
  /* temp-table definition for ttCost */
  
  @com.openedge.t4bl.model(modeFile="platform:/resource/Xpense/appModel.t4bl", uuid="_nQZ-kMpuEeWy0vdiWYuxeQ").
 				 
  DEFINE TEMP-TABLE ttCost
   NO-UNDO   BEFORE-TABLE Before_ttCost
     FIELD cost_id AS INTEGER LABEL "cost_id" COLUMN-LABEL "cost_id" FORMAT "->,>>>,>>9" 
     FIELD cost_type_id AS INTEGER LABEL "cost_type_id" COLUMN-LABEL "cost_type_id" FORMAT "->,>>>,>>9" 
     FIELD price AS INTEGER LABEL "price" COLUMN-LABEL "price" FORMAT "->,>>>,>>9" 
     FIELD currency_id AS INTEGER LABEL "currency_id" COLUMN-LABEL "currency_id" FORMAT "->,>>>,>>9" 
     FIELD cost_date AS DATE LABEL "cost_date" COLUMN-LABEL "cost_date" FORMAT "99/99/9999" 
     FIELD project_id AS INTEGER LABEL "project_id" COLUMN-LABEL "project_id" FORMAT "->,>>>,>>9" 
   INDEX icostId IS  PRIMARY UNIQUE     
      cost_id ASCENDING
   INDEX iCostTypeId     
      cost_type_id ASCENDING
   INDEX iProjectId     
      project_id ASCENDING
  .  		

  
 
  @com.openedge.t4bl.model(modeFile="platform:/resource/Xpense/appModel.t4bl", uuid="_hcfeXcm1EeWy0vdiWYuxeQ").
 				  
  DEFINE DATASET dsDashboardProject FOR ttProject, ttCost .
