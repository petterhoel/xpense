TRIGGER PROCEDURE FOR CREATE OF currency_rates.

ASSIGN currency_rates.currency_rates_id = NEXT-VALUE(seqCurrencyRatesId).
