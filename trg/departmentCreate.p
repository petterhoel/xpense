TRIGGER PROCEDURE FOR CREATE OF department.

ASSIGN department.department_id = NEXT-VALUE(seqDepartmentId).
