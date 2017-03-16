    
/*------------------------------------------------------------------------
    File        : From template DataSet - template for DataSet. 
    Author(s)   : <author>
    Created     : Mon Jan 25 15:35:58 CET 2016
    Version     : 1.0
    Notes       :
  ----------------------------------------------------------------------*/  /*------------------------------------------------------------------------
    File        : From template TempTable - template for temp-table. 
    Author(s)   : <author>
    Created     : Mon Jan 25 15:35:58 CET 2016
    Version     : 
    Notes       :
  ----------------------------------------------------------------------*/
  /* temp-table definition for ttTeam */
  
  @com.openedge.t4bl.model(modeFile="platform:/resource/Xpense/appModel.t4bl", uuid="_FGx4IMNuEeW1DriuV5Hzbg").
 				 
  DEFINE TEMP-TABLE ttTeam
   NO-UNDO   BEFORE-TABLE Before_ttTeam
     FIELD team_id AS INTEGER LABEL "Team Id" FORMAT "->,>>>,>>9" 
     FIELD team_name AS CHARACTER LABEL "Team Name" FORMAT "x(40)" 
   INDEX iTeam_id IS  PRIMARY UNIQUE     
      team_id ASCENDING
   INDEX iTeam_name     
      team_name ASCENDING
  .  		

  
 
  @com.openedge.t4bl.model(modeFile="platform:/resource/Xpense/appModel.t4bl", uuid="_D4CNPsNuEeW1DriuV5Hzbg").
 				  
  DEFINE DATASET dsTeam FOR ttTeam .
