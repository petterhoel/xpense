TRIGGER PROCEDURE FOR CREATE OF currency.

ASSIGN currency.currency_id = NEXT-VALUE(seqCurrencyId).
