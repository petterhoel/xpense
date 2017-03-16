 
 /*------------------------------------------------------------------------
    File        : projectModel
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

CLASS gui.projectModel INHERITS baseModel: 
    
    {inc/dsProject.i}
  
    DEFINE VARIABLE objProject AS app.projectBE NO-UNDO.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC HANDLE getProject( ):
		/* get the data from the backend */
/*		objProject = NEW app.projectBE ().                     */
/*		objProject:getCustomer(INPUT DATASET dsFilter,          */
/*                                OUTPUT DATASET dsCustomer).*/
         getData("app.projectBE","getProject",OUTPUT DATASET dsProject).  /* run this now so we are calling the data from the base model not directly from here */                         
        /* refresh the dataset */
        DATASET dsProject:HANDLE:TOP-NAV-QUERY(1):QUERY-OPEN ().                             
		
		RETURN DATASET dsProject:HANDLE.

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC HANDLE getProjectHandle(  ):
		
		

		
		RETURN DATASET dsProject:HANDLE.

	END METHOD.
	
    

	

END CLASS.