 
/*------------------------------------------------------------------------
   File        : customerBE
   Purpose     : 
   Syntax      : 
   Description : 
   Author(s)   : Administrator
   Created     : Mon Jan 25 14:15:09 UTC 2016
   Notes       : 
 ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING common.*. /* need this to set the propath as to where to find dataTypeHelper which is a static class */


BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS app.customerBE: 
    {inc/dsFilter.i}
    {inc/dsCustomer.i}



    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
		
    CONSTRUCTOR PUBLIC customerBE (  ):
        SUPER ().

    /*if we use the below the first customer will be displayed on the screen at launch. we have added a button to do this*/		
    /*		getCustomer(OUTPUT DATASET dsCustomer).*/
    /*		FOR EACH ttCustomer:                   */
    /*		    DISPLAY ttCustomer.                */
    /*		    END.                               */
		
    END CONSTRUCTOR.


    /*------------------------------------------------------------------------------
     Purpose: gets the customer data and outputs it in the dataset
     Notes:
    ------------------------------------------------------------------------------*/

    METHOD PUBLIC VOID getCustomer(INPUT DATASET dsFilter,
        OUTPUT DATASET dsCustomer):
				
        DEFINE VARIABLE cWhere AS CHARACTER NO-UNDO.
		
        /* empty the dataset ready to use */
        DATASET dsCustomer:EMPTY-DATASET ().
        		
        /* create the filter query */
        FOR EACH ttFilter:
            
            /* if the query is blank then its a where, if not its a where and an and */
            ASSIGN cWhere = IF cWhere = ""
              THEN SUBSTITUTE("WHERE &1 &2 &3",ttFilter.filter_name,ttFilter.filter_operator,bufferHelper:getFormattedDataType(BUFFER ttCustomer:handle,ttFilter.filter_name,ttFilter.filter_value))
              ELSE cWhere + SUBSTITUTE("AND &1 &2 &3",ttFilter.filter_name,ttFilter.filter_operator,bufferHelper:getFormattedDataType(BUFFER ttCustomer:handle,ttFilter.filter_name,ttFilter.filter_value)) .        
        
        END. /* each ttFilter */
        
        
        
        /* use query to fill country name in the customer table */
        DEFINE QUERY qCustomer FOR customer, country.
        QUERY qCustomer:QUERY-PREPARE(SUBSTITUTE("for each customer no-lock &1,
                                                  first country 
                                                  where country.country_id = customer.country_id no-lock",cWhere)).
        /* the &1 is replaced by cWhere. cWhere is populated from the button in the form which replaces &1 with the country_id, &2 with =, &3 with the value */                                
        
        
        /* define data sources */
        DEFINE DATA-SOURCE srcCustomer FOR QUERY qCustomer. /* datasource set to the wuery rather than the table */                                    
       
        

        /* define call back to listen to after_row_fill events */
/*        BUFFER ttProject:SET-CALLBACK ("after-row-fill","ttProjectAfterRowFill",THIS-OBJECT). /* after a row of data is filled run the method (ttProjectAfterRowFill) in this class. here it gets the team name */*/
        
                       
        BUFFER ttCustomer:ATTACH-DATA-SOURCE (DATA-SOURCE srcCustomer:handle).
        
        
        DATASET dsCustomer:FILL (). /* fills the dataset using the buffers set above */
        
        BUFFER ttCustomer:DETACH-DATA-SOURCE ().
        
		    
            /* if the query is blank then its a where, if not its a where and an and */
/*            ASSIGN                                                                                                              */
/*                cWhere = IF cWhere = ""                                                                                         */
/*		      THEN SUBSTITUTE("WHERE &1 &2 &3",ttFilter.filter_name,ttFilter.filter_operator,QUOTER(ttFilter.filter_value))           */
/*		      ELSE cWhere + SUBSTITUTE("AND &1 &2 &3",ttFilter.filter_name,ttFilter.filter_operator,QUOTER(ttFilter.filter_value)) .		*/
/*		                                                                                                                                */
/*        END. /* each ttFilter */                                                                                                */
/*		                                                                                                                                */
		
        /* Static code */
/*        DEFINE QUERY qCustomer FOR customer.                                                                               */
/*        DEFINE DATA-SOURCE scrCustomer FOR QUERY qCustomer.                                                                */
/*		                                                                                                                           */
/*        QUERY qCustomer:QUERY-PREPARE(SUBSTITUTE("FOR EACH customer no-lock &1",cWhere)). /* &1 is substituted by cWhere */*/
		
        /*		MESSAGE SUBSTITUTE("FOR EACH customer no-lock &1",cWhere)*/
        /*		VIEW-AS ALERT-BOX.                                       */
		
/*        BUFFER ttCustomer:ATTACH-DATA-SOURCE (DATA-SOURCE scrCustomer:handle). /* sets the buffer for the temptable and sets the handle to the datasource */*/
/*        DATASET dsCustomer:FILL().                                                                                                                          */
        /*      DATASET dsCustomer:FILL-MODE = "empty".  */
        /*      DATASET dsCustomer:FILL-MODE = "replace".*/
        /*      DATASET dsCustomer:FILL-MODE = "merge".  */     
/*        BUFFER ttCustomer:DETACH-DATA-SOURCE (). /* you dont need to stay attached (stops multiple attachments) */*/

    /* Dynamic */
    /*      
            DEFINE VARIABLE cTableName  AS CHARACTER INITIAL "Team" NO-UNDO.
            DEFINE VARIABLE hBuffer     AS HANDLE NO-UNDO. 
            DEFINE VARIABLE hQuery      AS HANDLE NO-UNDO. 
            DEFINE VARIABLE hDataSource AS HANDLE NO-UNDO.
            
            CREATE BUFFER hBuffer FOR TABLE cTableName.
            
            CREATE QUERY hQuery.
            hQuery:ADD-BUFFER (hBuffer).
            
            CREATE DATA-SOURCE hDataSource.
            hDataSource:QUERY = hQuery.
            
            hQuery:QUERY-PREPARE(SUBSTITUTE("FOR EACH &1 no-lock &2",cTableName,cWhere)).
            
            BUFFER ttCustomer:ATTACH-DATA-SOURCE (hDataSource).
            DATASET dsCustomer:FILL().
            
            BUFFER ttCustomer:DETACH-DATA-SOURCE ().       
    */		
    END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/

    METHOD PUBLIC VOID saveCustomer( INPUT-OUTPUT DATASET dsCustomer ):
	    
        /* Runs the validation when starting the save */
        validateCustomer(INPUT-OUTPUT DATASET dsCustomer).
        IF DATASET dsCustomer:ERROR
        THEN RETURN.
        
        DEFINE QUERY qCustomer FOR customer.
        DEFINE DATA-SOURCE srcCustomer FOR QUERY qCustomer.
        DEFINE VARIABLE lResult AS LOGICAL NO-UNDO.
	    
        QUERY qCustomer:QUERY-PREPARE(SUBSTITUTE("for each customer no-lock")).
	    
	    
        BUFFER ttCustomer:ATTACH-DATA-SOURCE (DATA-SOURCE srcCustomer:handle).
	    
        FOR EACH before_ttCustomer:
            /* can do the below */
            /* BUFFER before_ttCustomer:SAVE-ROW-CHANGES (1,"customer_id").*/
            /* BUFFER before_ttCustomer:ACCEPT-ROW-CHANGES ().             */ /* accept the changes and remove the before data */

            /* best to do this for error handling though */
            lResult = BUFFER before_ttCustomer:SAVE-ROW-CHANGES (1,"customer_id").
            IF lResult
                THEN
                BUFFER before_ttCustomer:ACCEPT-ROW-CHANGES ().
            
            
        END.
	     
        BUFFER ttCustomer:DETACH-DATA-SOURCE ().
		

    END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC VOID validateCustomer( INPUT-OUTPUT DATASET dsCustomer ):
		
		FOR EACH ttCustomer:
            
            IF ttCustomer.customer_name = ""
            THEN ASSIGN BUFFER ttCustomer:ERROR-STRING = "The Customer name can not be empty"
                        BUFFER ttCustomer:ERROR = TRUE
                        TEMP-TABLE ttCustomer:ERROR = TRUE
                        DATASET dsCustomer:ERROR = TRUE.
            
            IF ttCustomer.country_id = ?
            THEN ASSIGN BUFFER ttCustomer:ERROR-STRING = "You must select a Country"
                        BUFFER ttCustomer:ERROR = TRUE
                        TEMP-TABLE ttCustomer:ERROR = TRUE
                        DATASET dsCustomer:ERROR = TRUE.
            
        END.
		
		RETURN.

	END METHOD.

END CLASS.