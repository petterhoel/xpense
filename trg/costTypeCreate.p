TRIGGER PROCEDURE FOR CREATE OF cost_type.

ASSIGN cost_type.cost_type_id = NEXT-VALUE(seqCostTypeId).
