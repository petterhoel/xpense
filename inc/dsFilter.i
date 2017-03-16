    
/*------------------------------------------------------------------------
    File        : From template DataSet - template for DataSet. 
    Author(s)   : <author>
    Created     : Tue Feb 02 09:18:30 GMT 2016
    Version     : 1.0
    Notes       :
  ----------------------------------------------------------------------*/  /*------------------------------------------------------------------------
    File        : From template TempTable - template for temp-table. 
    Author(s)   : <author>
    Created     : Tue Feb 02 09:18:30 GMT 2016
    Version     : 
    Notes       :
  ----------------------------------------------------------------------*/
  /* temp-table definition for ttFilter */
  
  @com.openedge.t4bl.model(modeFile="platform:/resource/Xpense/appModel.t4bl", uuid="_AA30YMQVEeW-AZT3CWKAuA").
 				 
  DEFINE {1} TEMP-TABLE ttFilter
   NO-UNDO  
     FIELD table_to_filter AS CHARACTER LABEL "Table to Filter" FORMAT "X(8)" 
     FIELD filter_name AS CHARACTER LABEL "Filter Name" FORMAT "X(8)" 
     FIELD filter_operator AS CHARACTER LABEL "Filter Operator" FORMAT "X(8)" 
     FIELD filter_value AS CHARACTER LABEL "Filter Value" FORMAT "X(70)" 
  .
 
  @com.openedge.t4bl.model(modeFile="platform:/resource/Xpense/appModel.t4bl", uuid="_-l5EIMQUEeW-AZT3CWKAuA").
 				  
  DEFINE {1} DATASET dsFilter FOR ttFilter .
