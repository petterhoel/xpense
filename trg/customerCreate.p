TRIGGER PROCEDURE FOR CREATE OF customer.

ASSIGN customer.customer_id = NEXT-VALUE(seqCustomerId).
