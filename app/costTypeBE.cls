 
 /*------------------------------------------------------------------------
    File        : costTypeBE
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : tcoomans
    Created     : Mon Jan 25 15:01:03 CET 2016
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS app.costTypeBE: 

{inc/dsCostType.i}
	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	CONSTRUCTOR PUBLIC costTypeBE (  ):
		SUPER ().
				
	END CONSTRUCTOR.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	METHOD PUBLIC VOID getCostType(OUTPUT DATASET dsCostType):
		
		DEFINE DATA-SOURCE srcCostType FOR cost_type.
		
		BUFFER ttCost_type:ATTACH-DATA-SOURCE (DATA-SOURCE srcCostType:handle).
		
		DATASET dsCostType:FILL().
		
		BUFFER ttCost_type:DETACH-DATA-SOURCE ().
        
	END METHOD.

END CLASS.