 
/*------------------------------------------------------------------------
   File        : projectBE
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

CLASS app.projectBE: 
    {inc/dsFilter.i}
    {inc/dsProject.i}



    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
		
    CONSTRUCTOR PUBLIC projectBE (  ):
        SUPER ().

    /*if we use the below the first customer will be displayed on the screen at launch. we have added a button to do this*/		
    /*		getCustomer(OUTPUT DATASET dsProject).*/
    /*		FOR EACH ttCustomer:                   */
    /*		    DISPLAY ttCustomer.                */
    /*		    END.                               */
		
    END CONSTRUCTOR.


    /*------------------------------------------------------------------------------
     Purpose: gets the customer data and outputs it in the dataset
     Notes:
    ------------------------------------------------------------------------------*/

    METHOD PUBLIC VOID getProject(INPUT DATASET dsFilter,
        OUTPUT DATASET dsProject):
				
        DEFINE VARIABLE cWhere AS CHARACTER NO-UNDO.
		
        /* empty the dataset ready to use */
        DATASET dsProject:EMPTY-DATASET ().
        		
        /* create the filter query */
        FOR EACH ttFilter:
            
            /* if the query is blank then its a where, if not its a where and an and */
            ASSIGN cWhere = IF cWhere = ""
              THEN SUBSTITUTE("WHERE &1 &2 &3",ttFilter.filter_name,ttFilter.filter_operator,bufferHelper:getFormattedDataType(BUFFER ttProject:handle,ttFilter.filter_name,ttFilter.filter_value))
              ELSE cWhere + SUBSTITUTE("AND &1 &2 &3",ttFilter.filter_name,ttFilter.filter_operator,bufferHelper:getFormattedDataType(BUFFER ttProject:handle,ttFilter.filter_name,ttFilter.filter_value)) .        
        
        END. /* each ttFilter */
        
        
        
        /* use query to fill country name in the customer table */
        DEFINE QUERY qProject FOR project.
        QUERY qProject:QUERY-PREPARE(SUBSTITUTE("for each project no-lock &1",cWhere)).
        /* the &1 is replaced by cWhere. cWhere is populated from the button in the form which replaces &1 with the country_id, &2 with =, &3 with the value */                                
        
        
        /* define data sources */
        DEFINE DATA-SOURCE srcProject FOR QUERY qProject. /* datasource set to the wuery rather than the table */                                    
       
        

        /* define call back to listen to after_row_fill events */
/*        BUFFER ttProject:SET-CALLBACK ("after-row-fill","ttProjectAfterRowFill",THIS-OBJECT). /* after a row of data is filled run the method (ttProjectAfterRowFill) in this class. here it gets the team name */*/
        
                       
        BUFFER ttProject:ATTACH-DATA-SOURCE (DATA-SOURCE srcProject:handle).
        
        
        DATASET dsProject:FILL (). /* fills the dataset using the buffers set above */
        
        BUFFER ttProject:DETACH-DATA-SOURCE ().
        
		    
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
/*        DATASET dsProject:FILL().                                                                                                                          */
        /*      DATASET dsProject:FILL-MODE = "empty".  */
        /*      DATASET dsProject:FILL-MODE = "replace".*/
        /*      DATASET dsProject:FILL-MODE = "merge".  */     
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
            DATASET dsProject:FILL().
            
            BUFFER ttCustomer:DETACH-DATA-SOURCE ().       
    */		
    END METHOD.

END CLASS.