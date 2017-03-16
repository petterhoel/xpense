 
 /*------------------------------------------------------------------------
    File        : countryModel
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : Administrator
    Created     : Tue Jan 26 14:29:15 UTC 2016
    Notes       : 
  ----------------------------------------------------------------------*/


BLOCK-LEVEL ON ERROR UNDO, THROW.

USING gui.baseModel FROM PROPATH.

CLASS gui.countryModel INHERITS baseModel: 
    
    {inc/dsCountry.i}
            
    DEFINE VARIABLE objCountry AS app.countryBE NO-UNDO.
    
	/*------------------------------------------------------------------------------
	 Purpose:  Gets the countryBE class
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC HANDLE getCountry(  ):
	    
        /* Initializes the back end class.*/
        
        objCountry = NEW app.countryBE().
        objCountry:getCountry(INPUT DATASET dsFilter, OUTPUT DATASET dsCountry).
        
        DATASET dsCountry:HANDLE:TOP-NAV-QUERY(1):QUERY-OPEN ().
	
		RETURN DATASET dsCountry:HANDLE.

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:  Returns the handle to the form.
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC HANDLE getCountryHandle(  ):
				
		RETURN DATASET dsCountry:HANDLE.

	END METHOD.

END CLASS.