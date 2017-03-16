 
 /*------------------------------------------------------------------------
    File        : customerModel
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : Administrator
    Created     : Tue Jan 26 14:27:39 UTC 2016
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING gui.baseModel.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS gui.customerModel INHERITS baseModel: 
    
    {inc/dsCustomer.i}
  
    DEFINE VARIABLE objCustomer AS app.customerBE NO-UNDO.
    
    
    /* checks the selected row for the customer id so we can call this */
	DEFINE PUBLIC PROPERTY activeCustomerId AS INTEGER NO-UNDO 
	GET:
	IF AVAILABLE ttCustomer
	THEN RETURN ttCustomer.customer_id.
	END GET.    
	PRIVATE SET. 

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC HANDLE getCustomer( ):
		/* get the data from the backend */
/*		objCustomer = NEW app.customerBE ().                     */
/*		objCustomer:getCustomer(INPUT DATASET dsFilter,          */
/*                                OUTPUT DATASET dsCustomer).*/
         getData("app.customerBE","getCustomer",OUTPUT DATASET dsCustomer).  /* run this now so we are calling the data from the base model not directly from here */                         
        /* refresh the dataset */
        DATASET dsCustomer:HANDLE:TOP-NAV-QUERY(1):QUERY-OPEN ().                             
		
		RETURN DATASET dsCustomer:HANDLE.

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC HANDLE getCustomerHandle(  ):
		
		

		
		RETURN DATASET dsCustomer:HANDLE.

	END METHOD.
	
	
	/*------------------------------------------------------------------------------
            Purpose: Stndard method to begin editing tracking                     
            Notes:                                                                        
    ------------------------------------------------------------------------------*/

    METHOD PUBLIC VOID enableEdit(  ):
        TEMP-TABLE ttCustomer:TRACKING-CHANGES = YES.

    END METHOD.
    
    /*------------------------------------------------------------------------------
            Purpose: Stndard method to disable editing tracking                     
            Notes:                                                                        
    ------------------------------------------------------------------------------*/

    METHOD PUBLIC VOID disableEdit(  ):
        TEMP-TABLE ttCustomer:TRACKING-CHANGES = NO.

    END METHOD.
    
    /*------------------------------------------------------------------------------
            Purpose: User presse Create Row Button                                  
            Notes:  Insert an empty record in the temp-table                      
    ------------------------------------------------------------------------------*/

    METHOD PUBLIC VOID createRow(  ):
        enableEdit(). /* turns tracking changes on */
        CREATE ttCustomer.
        DATASET dsCustomer:TOP-NAV-QUERY():CREATE-RESULT-LIST-ENTRY(). /* creates a new entry point into the query */
        
        RETURN.

    END METHOD.
    
    
    /*------------------------------------------------------------------------------
            Purpose: User pressed delete button                         
            Notes:   Delete the current selected row                      
    ------------------------------------------------------------------------------*/

    METHOD PUBLIC VOID deleteRow(  ):
        enableEdit(). /* enable track changes */
        DELETE ttCustomer. 
        saveCustomer().
    END METHOD.
    
	/*------------------------------------------------------------------------------
            Purpose: User pressed Cancel Button                                     
            Notes:   Reject all changes and refresh the query                
    ------------------------------------------------------------------------------*/

    METHOD PUBLIC VOID CancelEdit(  ):
        disableEdit().
        DATASET dsCustomer:REJECT-CHANGES().
        DATASET dsCustomer:TOP-NAV-QUERY():query-open().     
        RETURN.

    END METHOD.

	

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC VOID saveCustomer(  ):
	    
	    disableEdit().
	    saveData(INPUT "app.customerBE",
	             INPUT "saveCustomer",
	             INPUT-OUTPUT DATASET dsCustomer).
	             
	                /* show errors dyanmic*/          
   /*     IF DATASET dsCustomer:ERROR 
        THEN DO:
           DEFINE VARIABLE hQuery AS HANDLE NO-UNDO.
           DEFINE VARIABLE hBuffer AS HANDLE NO-UNDO.
           CREATE QUERY hQuery.
           hBuffer = DATASET dsTeam:GET-BUFFER-HANDLE("ttTeam").
           hQuery:ADD-BUFFER(hBuffer).
           hQuery:QUERY-PREPARE("FOR EACH " + hBuffer:NAME).
           hQuery:QUERY-OPEN().
           hQuery:GET-FIRST().
             DO WHILE NOT hQuery:QUERY-OFF-END:

               IF hBuffer:ERROR THEN
               MESSAGE hBuffer:ERROR-STRING
                   VIEW-AS ALERT-BOX ERROR BUTTONS OK.
               hQuery:GET-NEXT().
             END.
           hQuery:QUERY-CLOSE().
           DELETE OBJECT hQuery.
           RETURN ERROR.
        END. 
        */
        /* show errors static*/    
        IF DATASET dsCustomer:ERROR 
        THEN DO:       
           MESSAGE "dataset error: " DATASET dsCustomer:ERROR SKIP
                   "temptable error: " TEMP-TABLE ttCustomer:ERROR         
           VIEW-AS ALERT-BOX.          
           FOR EACH ttCustomer:
               IF BUFFER ttCustomer:ERROR
               THEN MESSAGE BUFFER ttCustomer:ERROR-STRING
                    VIEW-AS ALERT-BOX ERROR.
           END.    
        END. 
		
		/* refresh the dataset */
        DATASET dsCustomer:HANDLE:TOP-NAV-QUERY(1):QUERY-OPEN ().
		
		RETURN.

	END METHOD.

END CLASS.