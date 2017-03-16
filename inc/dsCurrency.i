    
/*------------------------------------------------------------------------
    File        : From template DataSet - template for DataSet. 
    Author(s)   : <author>
    Created     : Mon Jan 25 14:29:27 GMT 2016
    Version     : 1.0
    Notes       :
  ----------------------------------------------------------------------*/  /*------------------------------------------------------------------------
    File        : From template TempTable - template for temp-table. 
    Author(s)   : <author>
    Created     : Mon Jan 25 14:29:27 GMT 2016
    Version     : 
    Notes       :
  ----------------------------------------------------------------------*/
  /* temp-table definition for ttCurrency */
  
  @com.openedge.t4bl.model(modeFile="platform:/resource/Xpense/appModel.t4bl", uuid="_419D4MNmEeWiMLihU8btpg").
 				 
  DEFINE TEMP-TABLE ttCurrency
   NO-UNDO   BEFORE-TABLE Before_ttCurrency
     FIELD currency_id AS INTEGER LABEL "Currency ID" FORMAT "->,>>>,>>9" 
     FIELD symbol AS CHARACTER LABEL "Symbol" FORMAT "x(3)" 
     FIELD currency_name AS CHARACTER LABEL "Currency" FORMAT "x(70)" 
   INDEX iCurrency IS  PRIMARY UNIQUE     
      currency_id ASCENDING
   INDEX iSymbol IS  UNIQUE     
      symbol ASCENDING
  .  		

  
 
  @com.openedge.t4bl.model(modeFile="platform:/resource/Xpense/appModel.t4bl", uuid="_pKhs0MNmEeWiMLihU8btpg").
 				  
  DEFINE DATASET dsCurrency FOR ttCurrency .
