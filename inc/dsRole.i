    
/*------------------------------------------------------------------------
    File        : From template DataSet - template for DataSet. 
    Author(s)   : <author>
    Created     : Tue Feb 02 15:14:31 UTC 2016
    Version     : 1.0
    Notes       :
  ----------------------------------------------------------------------*/  /*------------------------------------------------------------------------
    File        : From template TempTable - template for temp-table. 
    Author(s)   : <author>
    Created     : Tue Feb 02 15:14:31 UTC 2016
    Version     : 
    Notes       :
  ----------------------------------------------------------------------*/
  /* temp-table definition for ttRole */
  
  @com.openedge.t4bl.model(modeFile="platform:/resource/Xpense/appModel.t4bl", uuid="_nhXwsMjXEeWRnuGSLTwjTQ").
 				 
  DEFINE TEMP-TABLE ttRole
   NO-UNDO   BEFORE-TABLE Before_ttRole
     FIELD role_id AS INTEGER LABEL "Role Id" FORMAT "->,>>>,>>9" 
     FIELD role_name AS CHARACTER LABEL "Role Name" FORMAT "x(40)" 
     FIELD role_cost AS DECIMAL LABEL "Role Cost" FORMAT "->>,>>9.99" DECIMALS 2 
   INDEX iRoleid IS  PRIMARY UNIQUE     
      role_id ASCENDING
   INDEX iRoleName IS WORD-INDEX     
      role_name ASCENDING
  .  		

  
 
  @com.openedge.t4bl.model(modeFile="platform:/resource/Xpense/appModel.t4bl", uuid="_mBmnEMjXEeWRnuGSLTwjTQ").
 				  
  DEFINE DATASET dsRole FOR ttRole .
