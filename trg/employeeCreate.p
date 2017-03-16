TRIGGER PROCEDURE FOR CREATE OF employee.

ASSIGN employee.employee_id = NEXT-VALUE(seqEmployeeId).
