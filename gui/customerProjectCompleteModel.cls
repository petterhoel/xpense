 
 /*------------------------------------------------------------------------
    File        : customerProjectCompleteModel
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : tcoomans
    Created     : Tue Jan 26 15:27:39 CET 2016
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING gui.baseModel.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS gui.CustomerProjectCompleteModel INHERITS baseModel: 
 
    {inc/dsCustomerprojectComplete.i}
    DEFINE VARIABLE objCustomerProjectComplete AS app.customerProjectCompleteBE NO-UNDO.
	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC HANDLE getdsCustomerProjectComplete(  ):
		
		
		 objCustomerProjectComplete = NEW app.customerProjectCompleteBE().
		 /* get the data from the backend */
         objCustomerProjectComplete:getCustomerProjectComplete(INPUT DATASET dsFilter,
                                                               OUTPUT DATASET dsCustomerProjectComplete).
         /* Refresh the dataset */
         DATASET dsCustomerProjectComplete:HANDLE:TOP-NAV-QUERY(1):QUERY-OPEN ().
		
		RETURN DATASET dsCustomerProjectComplete:HANDLE.

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC HANDLE getdsCustomerProjectCompleteHandle(  ):

		RETURN DATASET dsCustomerProjectComplete:HANDLE.

	END METHOD.

END CLASS.