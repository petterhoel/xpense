 
 /*------------------------------------------------------------------------
    File        : myBE
    Syntax      : 
    Author(s)   : tcoomans
    Created     : Wed Feb 03 13:04:45 CET 2016
    Notes       : 
  ----------------------------------------------------------------------*/
  
@program FILE(name="myBE.cls", module="AppServer").
@openapi.openedge.export FILE(type="REST", executionMode="singleton", useReturnValue="false", writeDataSetBeforeImage="false").
@progress.service.resource FILE(name="myBE", URI="/myBE", schemaName="dscustomer", schemaFile="Xpense/app/mybe.i").

USING Progress.Lang.*.
USING OpenEdge.BusinessLogic.BusinessEntity.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS app.myBE INHERITS BusinessEntity:
	/*------------------------------------------------------------------------------
			Purpose:                                                                      
			Notes:                                                                        
	------------------------------------------------------------------------------*/
	
	{"app\mybe.i"}
	
	DEFINE TEMP-TABLE ttCostMonth NO-UNDO
	FIELD customer_id AS INTEGER
	FIELD cost_month AS INTEGER
	FIELD cost AS DECIMAL
	INDEX idx1 customer_id cost_month.
	
	DEFINE DATASET dsCostMonth FOR ttCostMonth. 
	
	
	
	DEFINE DATA-SOURCE srccustomer FOR Xpense.customer.
	
    
	/*------------------------------------------------------------------------------
            Purpose:                                                                      
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    CONSTRUCTOR PUBLIC myBE():
    	
    	DEFINE VAR hDataSourceArray AS HANDLE NO-UNDO EXTENT 1.
        DEFINE VAR cSkipListArray AS CHAR NO-UNDO EXTENT 1.
        
        SUPER (DATASET dscustomer:HANDLE).
        
        /* Data Source for each table in dataset. Should be in table order as defined 
     	   in DataSet */     
     	hDataSourceArray[1] =  DATA-SOURCE srccustomer:HANDLE.
     	
     	     	
     	/* Skip-list entry for each table in dataset. Should be in temp-table order 
           as defined in DataSet */
        /* Each skip-list entry is a comma-separated list of field names, to be
 	       ignored in create stmt */
     	    
     	cSkipListArray[1] = "".
     	
     	
     	THIS-OBJECT:ProDataSource = hDataSourceArray.
        THIS-OBJECT:SkipList = cSkipListArray.
     	        
    END CONSTRUCTOR.
    	
	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC VOID afterRowFillCustomer(INPUT DATASET dscustomer):
	    
	    ASSIGN ttcustomer.price = RANDOM(1,500).
		
		RETURN.

	END METHOD.

    /*------------------------------------------------------------------------------
            Purpose:  Get one or more records, based on a filter string                                                                     
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="false").
    @progress.service.resourceMapping(type="REST", operation="read", URI="?filter=~{filter~}", alias="", mediaType="application/json"). 
    METHOD PUBLIC VOID ReadmyBE(
    		INPUT filter AS CHARACTER, 
    		OUTPUT DATASET dsCostMonth):
    	
    	FOR EACH customer NO-LOCK 
    	  WHERE customer_id = 1,
    	  EACH project NO-LOCK
    	    WHERE project.customer_id = customer.customer_id,
    	    EACH cost NO-LOCK
    	      WHERE cost.project_id EQ project.project_id:
    	          
    	  FIND FIRST ttCostMonth
    	  WHERE ttCostMonth.customer_id = customer.customer_id
    	    AND ttCostMonth.cost_month = month(cost.cost_date) NO-ERROR.
    	  IF NOT AVAILABLE ttCostMonth
    	  THEN DO:
    	    CREATE ttCostMonth.
    	    ASSIGN ttCostMonth.customer_id = customer.customer_id
    	           ttCostMonth.cost_month = MONTH(cost.cost_date).             
    	  END.        
    	  ASSIGN ttCostMonth.cost = ttCostMonth.cost + cost.price.
    	  
    	END.         
    	
    	
    	/*
    	BUFFER ttCustomer:SET-CALLBACK ("after-row-fill","afterRowFillCustomer").
    	
    	SUPER:ReadData(filter).
    	     */ 
    END METHOD.
	  
    /*------------------------------------------------------------------------------
            Purpose: Create one or more new records                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/  
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="false").
    @progress.service.resourceMapping(type="REST", operation="create", URI="", alias="", mediaType="application/json").
    METHOD PUBLIC VOID CreatemyBE(INPUT-OUTPUT DATASET dscustomer):    		
    	       
        SUPER:CreateData(DATASET dscustomer BY-REFERENCE).        
    END METHOD.    
	
    /*------------------------------------------------------------------------------
            Purpose:  Update one or more records                                                                  
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="false").
    @progress.service.resourceMapping(type="REST", operation="update", URI="", alias="", mediaType="application/json").
    METHOD PUBLIC VOID UpdatemyBE(INPUT-OUTPUT DATASET dscustomer):    		
	
        SUPER:UpdateData(DATASET dscustomer BY-REFERENCE).          
    END METHOD.
	
    /*------------------------------------------------------------------------------
            Purpose:    Delete a record                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="false").
    @progress.service.resourceMapping(type="REST", operation="delete", URI="", alias="", mediaType="application/json").
    METHOD PUBLIC VOID DeletemyBE(INPUT-OUTPUT DATASET dscustomer):     		       
	
        SUPER:DeleteData(DATASET dscustomer BY-REFERENCE).
    END METHOD.
	 
    
END CLASS.
