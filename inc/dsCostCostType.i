    
/*------------------------------------------------------------------------
    File        : From template DataSet - template for DataSet. 
    Author(s)   : <author>
    Created     : Wed Feb 03 09:19:55 GMT 2016
    Version     : 1.0
    Notes       :
  ----------------------------------------------------------------------*/  /*------------------------------------------------------------------------
    File        : From template TempTable - template for temp-table. 
    Author(s)   : <author>
    Created     : Wed Feb 03 09:19:55 GMT 2016
    Version     : 
    Notes       :
  ----------------------------------------------------------------------*/
  /* temp-table definition for ttCost */
  
  @com.openedge.t4bl.model(modeFile="platform:/resource/Xpense/appModel.t4bl", uuid="_gr_c4MpOEeWcp6mTCCpomA").
 				 
  DEFINE TEMP-TABLE ttCost
   NO-UNDO   BEFORE-TABLE Before_ttCcost
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
  .  		  /*------------------------------------------------------------------------
    File        : From template TempTable - template for temp-table. 
    Author(s)   : <author>
    Created     : Wed Feb 03 09:19:55 GMT 2016
    Version     : 
    Notes       :
  ----------------------------------------------------------------------*/
  /* temp-table definition for ecost_type */
  
  @com.openedge.t4bl.model(modeFile="platform:/resource/Xpense/appModel.t4bl", uuid="_hT1gAMpOEeWcp6mTCCpomA").
 				 
  DEFINE TEMP-TABLE ecost_type
   NO-UNDO   BEFORE-TABLE Before_ttCost_type
     FIELD cost_type_id AS INTEGER LABEL "cost_type_id" COLUMN-LABEL "cost_type_id" FORMAT "->,>>>,>>9" 
     FIELD cost_type_name AS CHARACTER LABEL "cost_type_name" COLUMN-LABEL "cost_type_name" FORMAT "x(40)" 
   INDEX iCostTypeId IS  PRIMARY UNIQUE     
      cost_type_id ASCENDING
  .  		

  
 
  @com.openedge.t4bl.model(modeFile="platform:/resource/Xpense/appModel.t4bl", uuid="_eiZTIMpOEeWcp6mTCCpomA").
 				  
  DEFINE DATASET dsCostCostType FOR ttCost, ecost_type
	  DATA-RELATION drCostCostType FOR ttCost, ecost_type
		RELATION-FIELDS (cost_type_id,cost_type_id)    .
