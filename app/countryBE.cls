 
 /*------------------------------------------------------------------------
    File        : countryBE
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : Administrator
    Created     : Mon Jan 25 14:01:05 UTC 2016
    Notes       : 
  ----------------------------------------------------------------------*/


BLOCK-LEVEL ON ERROR UNDO, THROW.

USING app.countryBE FROM PROPATH.


CLASS app.countryBE: 

{inc/dsCountry.i}
{inc/dsFilter.i}

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
		
	CONSTRUCTOR PUBLIC countryBE (  ):
		SUPER ().
		
	END CONSTRUCTOR.


    /*------------------------------------------------------------------------------
	 Purpose: Retrieves all Countries and returns the dataset it is contained in.
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC VOID getCountry(INPUT DATASET dsFilter, OUTPUT DATASET dsCountry):
        
/* Static Code */

      DEFINE VARIABLE cQueryWhereString AS CHARACTER NO-UNDO.                                                                                                  
                                                                                                                                                               
      FOR EACH ttFilter.                                                                                                                                       
            IF cQueryWhereString = "" THEN                                                                                                                     
                  DO:                                                                                                                                          
                        ASSIGN cQueryWhereString = SUBSTITUTE("WHERE &1 &2 &3", ttFilter.filter_name, ttFilter.filter_operator, QUOTER(ttFilter.filter_value)).
                    END.                                                                                                                                       
              ELSE                                                                                                                                             
                    DO:                                                                                                                                        
                        ASSIGN cQueryWhereString = SUBSTITUTE("AND &1 &2 &3", ttFilter.filter_name, ttFilter.filter_operator, QUOTER(ttFilter.filter_value)).  
                    END.                                                                                                                                       
        END.

/*      DEFINE QUERY qCountry FOR country.                                                                                                                       */
/*		DEFINE DATA-SOURCE srcCountry FOR QUERY qCountry.                                                                                                        */
                                                                                                                                                 
/*                                                                                                                                                               */
/*        QUERY qCountry:QUERY-PREPARE (SUBSTITUTE("FOR EACH country NO-LOCK &1", cQueryWhereString)).                                                           */
        
/* Dynamic Code */

        DEFINE VARIABLE hBuffer AS HANDLE NO-UNDO.
        DEFINE VARIABLE hQuery AS HANDLE NO-UNDO.
        DEFINE VARIABLE hDataSource AS HANDLE NO-UNDO.
        
        CREATE BUFFER hBuffer FOR TABLE "country".
        CREATE QUERY hQuery.
        CREATE DATA-SOURCE hDataSource.
        
        hQuery:ADD-BUFFER (hBuffer).
        
        hDataSource:QUERY = hQuery.
        
        hQuery:QUERY-PREPARE(SUBSTITUTE ("FOR EACH country NO-LOCK &1", cQueryWhereString)).
                        
		BUFFER ttCountry:ATTACH-DATA-SOURCE (hDataSource).
		
		DATASET dsCountry:EMPTY-DATASET ().
		DATASET dsCountry:FILL().
		
		BUFFER ttCountry:DETACH-DATA-SOURCE ().

	END METHOD.

END CLASS.