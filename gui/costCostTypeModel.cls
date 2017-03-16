 
 /*------------------------------------------------------------------------
    File        : costCostTypeModel
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : petter
    Created     : Wed Feb 03 09:45:02 GMT 2016
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING gui.baseModel.

BLOCK-LEVEL ON ERROR UNDO, THROW.


CLASS gui.costCostTypeModel INHERITS baseModel: 
    {inc/dsCostCostType.i}
    METHOD PUBLIC VOID getCostCostType(  ):
    
        getData(INPUT "app.costCostTypeBE",
            INPUT "getCostCostType",
            OUTPUT DATASET dsCostCostType). 
    
    // REFRESH the dataset        
        DATASET dsCostCostType:HANDLE:TOP-NAV-QUERY(1):QUERY-OPEN ().        

    END METHOD.
END CLASS.