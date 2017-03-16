TRIGGER PROCEDURE FOR CREATE OF country.

ASSIGN country.country_id = NEXT-VALUE(seqCountryId).
