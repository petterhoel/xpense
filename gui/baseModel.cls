 
 /*------------------------------------------------------------------------
    File        : baseModel
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : tcoomans
    Created     : Tue Jan 26 15:09:59 CET 2016
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS gui.baseModel: 

    {inc/dsFilter.i PROTECTED}
     
    DEFINE VARIABLE hAppServer AS HANDLE    NO-UNDO. 
   
	/*------------------------------------------------------------------------------
	 Purpose: Adds a filter record to the filterset
	 Notes:
	------------------------------------------------------------------------------*/
	METHOD PUBLIC VOID addFilter(INPUT filterName AS CHARACTER,
                                 INPUT filterOperator AS CHARACTER,
                                 INPUT filterValue AS CHARACTER):
	
	     CREATE ttFilter.
         ASSIGN ttFilter.filter_name     = filterName
                ttFilter.filter_operator = filterOperator
                ttFilter.filter_value    = filterValue.
		
	END METHOD.

    /*------------------------------------------------------------------------------
     Purpose: Adds a filter record to the filterset
     Notes: With extra parameter for table
    ------------------------------------------------------------------------------*/	
	METHOD PUBLIC VOID addFilter(INPUT tableToFilter AS CHARACTER,
	                             INPUT filterName AS CHARACTER,
                                 INPUT filterOperator AS CHARACTER,
                                 INPUT filterValue AS CHARACTER):
    
        CREATE ttFilter.
        ASSIGN 
            ttFilter.table_to_filter = tableToFilter
            ttFilter.filter_name     = filterName
            ttFilter.filter_operator = filterOperator
            ttFilter.filter_value    = filterValue.
        
    END METHOD.
	

	/*------------------------------------------------------------------------------
	 Purpose: This clears the filter
	 Notes:
	------------------------------------------------------------------------------*/
	METHOD PUBLIC VOID clearFilter(  ):
		
		DATASET dsFilter:EMPTY-DATASET().

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC VOID exportData(INPUT fileLocation AS CHARACTER,
	                              INPUT exportType AS CHARACTER,
	                              INPUT hDataset   AS HANDLE):

	    CASE exportType:
    	    WHEN "json"
    	    THEN hDataset:WRITE-JSON("file",SUBSTITUTE("&1/&2.&3",fileLocation,hDataset:NAME,exportType),TRUE).   
    	    WHEN "xml"
    	    THEN hDataset:WRITE-XML("file",SUBSTITUTE("&1/&2.&3",fileLocation,hDataset:NAME,exportType),TRUE).      
        END CASE.

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose: This clears the filter first and then adds one filter record
	 Notes:
	------------------------------------------------------------------------------*/
	METHOD PUBLIC VOID setFilter(INPUT filterName AS CHARACTER,
	                             INPUT filterOperator AS CHARACTER,
	                             INPUT filterValue AS CHARACTER):
		
		clearFilter().
		addFilter(INPUT filterName,
                  INPUT filterOperator,
                  INPUT filterValue).

	END METHOD.
	
	METHOD PUBLIC VOID setFilter(INPUT tableToFilter AS CHARACTER,
                                 INPUT filterName AS CHARACTER,
                                 INPUT filterOperator AS CHARACTER,
                                 INPUT filterValue AS CHARACTER):
        
        clearFilter().
        addFilter(INPUT tableToFilter,
                  INPUT filterName,
                  INPUT filterOperator,
                  INPUT filterValue).

    END METHOD.


    METHOD PROTECTED VOID getData(INPUT ipcClassName AS CHARACTER,
                                   INPUT ipcMethodName AS CHARACTER, 
                                   OUTPUT DATASET-HANDLE dsResult): 

        DEFINE VARIABLE hAppServer AS HANDLE NO-UNDO. 
/*        CREATE SERVER hAppServer.                              */
/*        hAppServer:CONNECT ("-URL http://127.0.0.1:8810/apsv").*/
        hAppServer = SESSION:HANDLE.
        RUN app/getApi.p ON hAppServer (INPUT ipcClassName,
                         INPUT ipcMethodName,
                         INPUT DATASET  dsFilter,
                         OUTPUT DATASET-HANDLE dsResult). 
        
    END METHOD. 
  
  
    
    METHOD PROTECTED VOID saveData(INPUT ipcClassName AS CHARACTER,
                                   INPUT ipcMethodName AS CHARACTER, 
                                   INPUT-OUTPUT DATASET-HANDLE dsResult): 
        DEFINE VARIABLE hAppServer AS HANDLE NO-UNDO. 
/*        CREATE SERVER hAppServer.                              */
/*        hAppServer:CONNECT ("-URL http://127.0.0.1:8810/apsv").*/
        hAppServer = SESSION:HANDLE. 
        RUN app/saveApi.p ON hAppServer (INPUT ipcClassName,
                                         INPUT ipcMethodName,
                                         INPUT-OUTPUT DATASET-HANDLE dsResult).     
        
    END METHOD. 


END CLASS.