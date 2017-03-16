    
/*------------------------------------------------------------------------
    File        : From template DataSet - template for DataSet. 
    Author(s)   : <author>
    Created     : Thu Feb 04 16:46:27 UTC 2016
    Version     : 1.0
    Notes       :
  ----------------------------------------------------------------------*/  /*------------------------------------------------------------------------
    File        : From template TempTable - template for temp-table. 
    Author(s)   : <author>
    Created     : Thu Feb 04 16:46:27 UTC 2016
    Version     : 
    Notes       :
  ----------------------------------------------------------------------*/
  /* temp-table definition for ttCountry */
  
  @com.openedge.t4bl.model(modeFile="platform:/resource/Xpense/appModel.t4bl", uuid="_iX-5EMpYEeWy0vdiWYuxeQ").
 				 
  DEFINE TEMP-TABLE ttCountry
   NO-UNDO   BEFORE-TABLE Before_ttCountry
     FIELD country_id AS INTEGER LABEL "Country ID" FORMAT "->,>>>,>>9" 
     FIELD country_name AS CHARACTER LABEL "Country Name" FORMAT "x(40)" 
     FIELD Profit_Loss AS DECIMAL LABEL "Profit/Loss" FORMAT "->,>>>,>>9" DECIMALS 2 
   INDEX iCountryId IS  PRIMARY UNIQUE     
      country_id ASCENDING
   INDEX iCountryName     
      country_name ASCENDING
  .  		  /*------------------------------------------------------------------------
    File        : From template TempTable - template for temp-table. 
    Author(s)   : <author>
    Created     : Thu Feb 04 16:46:27 UTC 2016
    Version     : 
    Notes       :
  ----------------------------------------------------------------------*/
  /* temp-table definition for ttCost */
  
  @com.openedge.t4bl.model(modeFile="platform:/resource/Xpense/appModel.t4bl", uuid="_9SCdAMpeEeWy0vdiWYuxeQ").
 				 
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

  
 
  @com.openedge.t4bl.model(modeFile="platform:/resource/Xpense/appModel.t4bl", uuid="_kN_8rcm1EeWy0vdiWYuxeQ").
 				  
  DEFINE DATASET dsDashboardCountry FOR ttCountry, ttCost .
