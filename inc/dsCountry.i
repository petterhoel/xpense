    
/*------------------------------------------------------------------------
    File        : From template DataSet - template for DataSet. 
    Author(s)   : <author>
    Created     : Tue Jan 26 10:18:49 UTC 2016
    Version     : 1.0
    Notes       :
  ----------------------------------------------------------------------*/  /*------------------------------------------------------------------------
    File        : From template TempTable - template for temp-table. 
    Author(s)   : <author>
    Created     : Tue Jan 26 10:18:49 UTC 2016
    Version     : 
    Notes       :
  ----------------------------------------------------------------------*/
  /* temp-table definition for ttCountry */
  
  @com.openedge.t4bl.model(modeFile="platform:/resource/Xpense/appModel.t4bl", uuid="_G_xqwMQWEeWvBZrPPRLEHw").
 				 
  DEFINE TEMP-TABLE ttCountry
   NO-UNDO   BEFORE-TABLE Before_ttCountry
     FIELD country_id AS INTEGER LABEL "Country Id" FORMAT "->,>>>,>>9" 
     FIELD country_name AS CHARACTER LABEL "Country Name" FORMAT "x(40)" 
     FIELD country_flag AS blob
   INDEX iCountry_id IS  PRIMARY UNIQUE     
      country_id ASCENDING
   INDEX iCountry_name     
      country_name ASCENDING
  .  		
  
 
  @com.openedge.t4bl.model(modeFile="platform:/resource/Xpense/appModel.t4bl", uuid="_FwsX0MNuEeWQa6UUt5CSJA").
 				  
  DEFINE DATASET dsCountry FOR ttCountry .
