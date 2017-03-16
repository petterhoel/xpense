
/*------------------------------------------------------------------------
    File        : getApi.p
    Purpose     : 

    Syntax      :

    Description : Api to expose dataset get functionality

    Author(s)   : 
    Created     : Thu Jan 28 13:20:36 CET 2016
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */
DEFINE INPUT  PARAMETER ipcClassName AS CHARACTER NO-UNDO.
DEFINE INPUT  PARAMETER ipcMethodName AS CHARACTER NO-UNDO.
DEFINE INPUT  PARAMETER DATASET-HANDLE dsFilter.
DEFINE OUTPUT PARAMETER DATASET-HANDLE dsResult.

  DEFINE VARIABLE objClass AS Progress.Lang.Object NO-UNDO.

  /* instantiate class */
  objClass = DYNAMIC-NEW ipcClassName ().
   
  /* invoke method in the class */ 
  DYNAMIC-INVOKE(objClass,
                 ipcMethodName,
                 INPUT DATASET-HANDLE dsFilter,
                 OUTPUT DATASET-HANDLE dsResult).

