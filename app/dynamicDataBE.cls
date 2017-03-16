 
 /*------------------------------------------------------------------------
    File        : dynamicDataBE
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : tcoomans
    Created     : Thu Feb 04 11:51:33 CET 2016
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OpenEdge.Net.HTTP.Filter.Payload.HtmlBodyWriter FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS app.dynamicDataBE: 

DEFINE VARIABLE hDataset AS HANDLE NO-UNDO.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC VOID getData(INPUT ipcTable AS CHARACTER,
	                           INPUT ipcFieldList AS CHARACTER,
	                           INPUT ipcWhere AS CHARACTER,
	                           OUTPUT DATASET-HANDLE hDataset):

            DEFINE VARIABLE i AS INTEGER NO-UNDO.
            DEFINE VARIABLE hBufferField AS HANDLE NO-UNDO.
            DEFINE VARIABLE hBuffer AS HANDLE NO-UNDO.
            DEFINE VARIABLE httBuffer AS HANDLE NO-UNDO.
            DEFINE VARIABLE hTempTable AS HANDLE NO-UNDO.
            DEFINE VARIABLE hDataSource AS HANDLE NO-UNDO.
            DEFINE VARIABLE hQuery AS HANDLE NO-UNDO.
            
            
            CREATE BUFFER hBuffer FOR TABLE ipcTable.  

            CREATE TEMP-TABLE hTempTable.
            /* define temptable schema */
            IF ipcFieldList = ""
            THEN DO:
                /* all fields */
                 hTempTable:CREATE-LIKE (hBuffer).
            END.
            ELSE DO:    
                /* fields from fieldlist */ 
                DO i = 1 TO NUM-ENTRIES(ipcFieldList):
                    hBufferField = hBuffer:BUFFER-FIELD (ENTRY(i,ipcFieldList)).
                     hTempTable:ADD-LIKE-FIELD (ENTRY(i,ipcFieldList),hBufferField).
                END.
            END.

            hTempTable:TEMP-TABLE-PREPARE (SUBSTITUTE("tt&1",ipcTable)).
            /* get bufferhandle from temptable */
            httBuffer = hTempTable:DEFAULT-BUFFER-HANDLE.
            
            /* create dataset */
            CREATE DATASET hDataset.
            hDataset:SET-BUFFERS (hTempTable).
            
            /* create query */
            CREATE QUERY hQuery.
            hQuery:SET-BUFFERS (hBuffer).
            hQuery:QUERY-PREPARE (SUBSTITUTE("for each &1 no-lock &2",ipcTable,ipcWhere)).
            
            /* create datasource */
            CREATE DATA-SOURCE hDataSource.
            
            /* without query */
/*            hDataSource:ADD-SOURCE-BUFFER(hBuffer,hBuffer:BUFFER-FIELD (1):name).*/
            hDataSource:QUERY = hQuery.
                  
            /* attach and fill */      
            httBuffer:ATTACH-DATA-SOURCE (hDataSource,"","",ipcFieldList).
            
            hDataSet:fill().
            
            httBuffer:DETACH-DATA-SOURCE ().
            
           
       


	END METHOD.

END CLASS.