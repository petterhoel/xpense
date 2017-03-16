DEFINE VARIABLE hDataset AS HANDLE NO-UNDO.

DEFINE VARIABLE obj AS app.dynamicDataBE NO-UNDO.
obj = NEW app.dynamicDataBE().
obj:getData(INPUT "customer",INPUT "", INPUT "where customer_id = 3", OUTPUT DATASET-HANDLE hDataSet ).


 hDataset:WRITE-XML("file","c:\test.xml",YES).