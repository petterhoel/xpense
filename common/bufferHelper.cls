 
 /*------------------------------------------------------------------------
    File        : dataTypeHelper
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : tcoomans
    Created     : Thu Jan 28 10:29:38 CET 2016
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS common.bufferHelper: 

    METHOD PUBLIC STATIC CHARACTER getFormattedDataType(INPUT bufferHandle AS HANDLE,
                                                        INPUT bufferField AS CHARACTER,
                                                        INPUT fieldValue AS CHARACTER):

       CASE bufferHandle:BUFFER-FIELD(bufferField):DATA-TYPE:
         WHEN "integer" THEN
           RETURN fieldValue.
         WHEN "character" THEN
           RETURN QUOTER(fieldValue).
         OTHERWISE
           RETURN QUOTER(fieldValue).
        END CASE.  

    END METHOD.


END CLASS.