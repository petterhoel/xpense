    
/*------------------------------------------------------------------------
    File        : From template DataSet - template for DataSet. 
    Author(s)   : <author>
    Created     : Mon Jan 25 14:33:52 UTC 2016
    Version     : 1.0
    Notes       :
  ----------------------------------------------------------------------*/  /*------------------------------------------------------------------------
    File        : From template TempTable - template for temp-table. 
    Author(s)   : <author>
    Created     : Mon Jan 25 14:33:52 UTC 2016
    Version     : 
    Notes       :
  ----------------------------------------------------------------------*/
  /* temp-table definition for ttCustomer */
  
  @com.openedge.t4bl.model(modeFile="platform:/resource/Xpense/appModel.t4bl", uuid="_UD4UIMNvEeW8fOE1QK0w1A").
 				 
  DEFINE TEMP-TABLE ttCustomer
   NO-UNDO   BEFORE-TABLE Before_ttCustomer
     FIELD customer_id AS INTEGER LABEL "Customer Id" FORMAT "->,>>>,>>9" 
     FIELD customer_name AS CHARACTER LABEL "Customer Name" FORMAT "x(40)" 
     FIELD address AS CHARACTER LABEL "Address" FORMAT "x(70)" 
     FIELD country_id AS INTEGER LABEL "Country Id" FORMAT "->,>>>,>>9" 
     FIELD phone_number AS CHARACTER LABEL "Phone Number" FORMAT "x(20)" 
     FIELD registration_date AS DATE LABEL "Registration Date" FORMAT "99/99/9999" 
   INDEX customer_id IS  PRIMARY UNIQUE     
      customer_id ASCENDING
   INDEX customer_name IS WORD-INDEX     
      customer_name ASCENDING
  .  		

  
 
  @com.openedge.t4bl.model(modeFile="platform:/resource/Xpense/appModel.t4bl", uuid="_M0hxgMNvEeW8fOE1QK0w1A").
 				  
  DEFINE DATASET dsCustomer FOR ttCustomer .
