    
/*------------------------------------------------------------------------
    File        : From template DataSet - template for DataSet. 
    Author(s)   : <author>
    Created     : Tue Jan 26 10:11:35 CET 2016
    Version     : 1.0
    Notes       :
  ----------------------------------------------------------------------*/  /*------------------------------------------------------------------------
    File        : From template TempTable - template for temp-table. 
    Author(s)   : <author>
    Created     : Tue Jan 26 10:11:35 CET 2016
    Version     : 
    Notes       :
  ----------------------------------------------------------------------*/
  /* temp-table definition for ttCost_type */
  
  @com.openedge.t4bl.model(modeFile="platform:/resource/Xpense/appModel.t4bl", uuid="_vCAZIMQMEeWXsKxK20tpzQ").
 				 
  DEFINE TEMP-TABLE ttCost_type
   NO-UNDO   BEFORE-TABLE Before_ttCost_type
     FIELD cost_type_id AS INTEGER COLUMN-LABEL "cost_type_id" FORMAT "->,>>>,>>9" 
     FIELD cost_type_name AS CHARACTER COLUMN-LABEL "cost_type_name" FORMAT "x(40)" 
   INDEX icot_tyoe_id IS  PRIMARY UNIQUE     
      cost_type_id ASCENDING
   INDEX icost_type_name     
      cost_type_name ASCENDING
  .  		

  
 
  @com.openedge.t4bl.model(modeFile="platform:/resource/Xpense/appModel.t4bl", uuid="_sn7jYMQMEeWXsKxK20tpzQ").
 				  
  DEFINE DATASET dsCostType FOR ttCost_type .
