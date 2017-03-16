
 /*------------------------------------------------------------------------
    File        : myBE
    Purpose		:
    Syntax      : 
    Description :
    Author(s)   : tcoomans
    Created     : Wed Feb 03 13:04:45 CET 2016
    Notes       : 
  ----------------------------------------------------------------------*/
  
  /* ***************************  Definitions  ************************** */
  
  /* ********************  Preprocessor Definitions  ******************** */
  
  /* ***************************  Main Block  *************************** */
  
  /** Dynamically generated schema file **/
   
@openapi.openedge.entity.primarykey (fields="customer_id").
	
DEFINE TEMP-TABLE ttcustomer BEFORE-TABLE bttcustomer
FIELD customer_id AS INTEGER INITIAL "0" LABEL "Customer Id"
FIELD customer_name AS CHARACTER LABEL "Customer Name"
FIELD address AS CHARACTER LABEL "Address"
FIELD country_id AS INTEGER INITIAL "0" LABEL "Country Id"
FIELD phone_number AS CHARACTER LABEL "Phone Number"
FIELD registration_date AS DATE LABEL "Registration Date"
FIELD price AS DECIMAL
INDEX customerId IS  PRIMARY  UNIQUE  customer_id  ASCENDING 
INDEX iCustomerName  customer_name  ASCENDING . 


DEFINE DATASET dscustomer FOR ttcustomer.