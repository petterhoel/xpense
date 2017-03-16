    
/*------------------------------------------------------------------------
    File        : From template DataSet - template for DataSet. 
    Author(s)   : <author>
    Created     : Tue Feb 02 14:44:40 UTC 2016
    Version     : 1.0
    Notes       :
  ----------------------------------------------------------------------*/  /*------------------------------------------------------------------------
    File        : From template TempTable - template for temp-table. 
    Author(s)   : <author>
    Created     : Tue Feb 02 14:44:40 UTC 2016
    Version     : 
    Notes       :
  ----------------------------------------------------------------------*/
  /* temp-table definition for ttcurrency_rates */
  
  @com.openedge.t4bl.model(modeFile="platform:/resource/Xpense/appModel.t4bl", uuid="_Z-zygMj2EeWmKYXu4sqarA").
 				 
  DEFINE TEMP-TABLE ttcurrency_rates
   NO-UNDO   BEFORE-TABLE Before_ttcurrency_rates
     FIELD currency_rates_id AS INTEGER LABEL "currency rates ID" FORMAT "->,>>>,>>9" 
     FIELD currency_rates_amount AS INTEGER COLUMN-LABEL "Currency rates amount" FORMAT "->,>>>,>>9" 
     FIELD cuerrency_rates_date AS DATE COLUMN-LABEL "Currency rates date" FORMAT "99/99/99" 
     FIELD currency_id AS INTEGER LABEL "Currency id" FORMAT "->,>>>,>>9" 
   INDEX iCurrencyRatesId IS  PRIMARY     
      currency_rates_id ASCENDING
  .  		  /*------------------------------------------------------------------------
    File        : From template TempTable - template for temp-table. 
    Author(s)   : <author>
    Created     : Tue Feb 02 14:44:40 UTC 2016
    Version     : 
    Notes       :
  ----------------------------------------------------------------------*/
  /* temp-table definition for ttcurrency */
  
  @com.openedge.t4bl.model(modeFile="platform:/resource/Xpense/appModel.t4bl", uuid="_dVJcMMj2EeWmKYXu4sqarA").
 				 
  DEFINE TEMP-TABLE ttcurrency
   NO-UNDO   BEFORE-TABLE Before_ttcurrency
     FIELD currency_id AS INTEGER LABEL "Currency ID" FORMAT "->,>>>,>>9" 
     FIELD symbol AS CHARACTER LABEL "Symbol" FORMAT "x(3)" 
     FIELD currency_name AS CHARACTER LABEL "Currency" FORMAT "x(70)" 
   INDEX iCurrencyId IS  PRIMARY UNIQUE     
      currency_id ASCENDING
   INDEX iSymbol IS  UNIQUE     
      symbol ASCENDING
  .  		

  
 
  @com.openedge.t4bl.model(modeFile="platform:/resource/Xpense/appModel.t4bl", uuid="_4-p9kMjwEeWUZJaossApvA").
 				  
  DEFINE DATASET dsCurrencyRates FOR ttcurrency_rates, ttcurrency
	  DATA-RELATION Relationship FOR ttcurrency, ttcurrency_rates
		RELATION-FIELDS (currency_id,currency_id)    .
