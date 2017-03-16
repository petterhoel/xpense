    
/*------------------------------------------------------------------------
    File        : From template DataSet - template for DataSet. 
    Author(s)   : <author>
    Created     : Wed Jan 27 15:54:02 CET 2016
    Version     : 1.0
    Notes       :
  ----------------------------------------------------------------------*/  /*------------------------------------------------------------------------
    File        : From template TempTable - template for temp-table. 
    Author(s)   : <author>
    Created     : Wed Jan 27 15:54:02 CET 2016
    Version     : 
    Notes       :
  ----------------------------------------------------------------------*/
  /* temp-table definition for ttCustomer */
  
  @com.openedge.t4bl.model(modeFile="platform:/resource/Xpense/appModel.t4bl", uuid="_qjZ-cMTeEeWQJb7eYZbXFg").
 				 
  DEFINE TEMP-TABLE ttCustomer
   NO-UNDO   BEFORE-TABLE Before_ttCustomer
     FIELD customer_id AS INTEGER LABEL "Customer Id" FORMAT "->,>>>,>>9" 
     FIELD customer_name AS CHARACTER LABEL "Customer Name" FORMAT "x(40)" 
     FIELD address AS CHARACTER LABEL "Address" FORMAT "x(70)" 
     FIELD country_id AS INTEGER LABEL "Country Id" FORMAT "->,>>>,>>9" 
     FIELD phone_number AS CHARACTER LABEL "Phone Number" FORMAT "x(20)" 
     FIELD registration_date AS DATE LABEL "Registration Date" FORMAT "99/99/9999" 
     FIELD country_name AS CHARACTER LABEL "Country Name" FORMAT "x(40)" 
   INDEX customer_id IS  PRIMARY UNIQUE     
      customer_id ASCENDING
   INDEX customer_name IS WORD-INDEX     
      customer_name ASCENDING
  .  		  /*------------------------------------------------------------------------
    File        : From template TempTable - template for temp-table. 
    Author(s)   : <author>
    Created     : Wed Jan 27 15:54:02 CET 2016
    Version     : 
    Notes       :
  ----------------------------------------------------------------------*/
  /* temp-table definition for ttProject */
  
  @com.openedge.t4bl.model(modeFile="platform:/resource/Xpense/appModel.t4bl", uuid="_5VVnEMTxEeWQJb7eYZbXFg").
 				 
  DEFINE TEMP-TABLE ttProject
   NO-UNDO   BEFORE-TABLE Before_ttProject
     FIELD project_id AS INTEGER LABEL "Project Id" FORMAT "->,>>>,>>9" 
     FIELD customer_id AS INTEGER LABEL "Customer Id" FORMAT "->,>>>,>>9" 
     FIELD project_name AS CHARACTER LABEL "Project Name" FORMAT "x(70)" 
     FIELD start_date AS DATE LABEL "Start Date" FORMAT "99/99/9999" 
     FIELD due_date AS DATE LABEL "Due Date" FORMAT "99/99/9999" 
     FIELD team_id AS INTEGER LABEL "Team Id" FORMAT "->,>>>,>>9" 
     FIELD project_description AS CHARACTER LABEL "Project Description" FORMAT "x(70)" 
     FIELD team_name AS CHARACTER LABEL "Team Name" FORMAT "x(40)" 
   INDEX iProjectId IS  PRIMARY UNIQUE     
      project_id ASCENDING
   INDEX iCustomerId     
      customer_id ASCENDING
  .  		  /*------------------------------------------------------------------------
    File        : From template TempTable - template for temp-table. 
    Author(s)   : <author>
    Created     : Wed Jan 27 15:54:02 CET 2016
    Version     : 
    Notes       :
  ----------------------------------------------------------------------*/
  /* temp-table definition for ttCost */
  
  @com.openedge.t4bl.model(modeFile="platform:/resource/Xpense/appModel.t4bl", uuid="_JxBWYMTyEeWQJb7eYZbXFg").
 				 
  DEFINE TEMP-TABLE ttCost
   NO-UNDO   BEFORE-TABLE Before_ttCost
     FIELD cost_id AS INTEGER LABEL "Cost Id" COLUMN-LABEL "cost_id" FORMAT "->,>>>,>>9" 
     FIELD cost_type_id AS INTEGER LABEL "Cost Type Id" COLUMN-LABEL "cost_type_id" FORMAT "->,>>>,>>9" 
     FIELD price AS DECIMAL LABEL "Price" FORMAT "->,>>>,>>9.99" 
     FIELD currency_id AS INTEGER LABEL "Currency Id" COLUMN-LABEL "currency_id" FORMAT "->,>>>,>>9" 
     FIELD cost_date AS DATE LABEL "Date" COLUMN-LABEL "cost_date" FORMAT "99/99/99" 
     FIELD project_id AS INTEGER LABEL "Project id" COLUMN-LABEL "project_id" FORMAT "->,>>>,>>9" 
     FIELD symbol AS CHARACTER LABEL "Symbol" FORMAT "x(3)" 
     FIELD cost_type_name AS CHARACTER LABEL "Cost Type Name" COLUMN-LABEL "cost_type_name" FORMAT "x(40)" 
   INDEX icostId IS  PRIMARY UNIQUE     
      cost_id ASCENDING
   INDEX iCostTypeId     
      cost_type_id ASCENDING
   INDEX iProjectId     
      project_id ASCENDING
  .  		  /*------------------------------------------------------------------------
    File        : From template TempTable - template for temp-table. 
    Author(s)   : <author>
    Created     : Wed Jan 27 15:54:02 CET 2016
    Version     : 
    Notes       :
  ----------------------------------------------------------------------*/
  /* temp-table definition for ttProject_time */
  
  @com.openedge.t4bl.model(modeFile="platform:/resource/Xpense/appModel.t4bl", uuid="_SA7-IMTyEeWQJb7eYZbXFg").
 				 
  DEFINE TEMP-TABLE ttProject_time
   NO-UNDO   BEFORE-TABLE Before_ttProject_time
     FIELD project_time_id AS INTEGER LABEL "Project Time Id" FORMAT "->,>>>,>>9" 
     FIELD project_id AS INTEGER LABEL "Project id" FORMAT "->,>>>,>>9" 
     FIELD employee_id AS INTEGER LABEL "Employee Id" FORMAT "->,>>>,>>9" 
     FIELD start_date_time AS DATETIME LABEL "Start" FORMAT "99/99/9999 HH:MM:SS" 
     FIELD stop_date_time AS DATETIME LABEL "Stop" FORMAT "99/99/9999 HH:MM:SS" 
     FIELD comment AS CHARACTER LABEL "Comment" FORMAT "x(70)" 
     FIELD employee_name AS CHARACTER LABEL "Employee Name" FORMAT "x(40)" 
   INDEX iProjectTimeId IS  PRIMARY UNIQUE     
      project_time_id ASCENDING
   INDEX iEmployeeId     
      employee_id ASCENDING
   INDEX iProjectId     
      project_id ASCENDING
   INDEX iStartDateTime     
      start_date_time ASCENDING
  .  		

  
 
  @com.openedge.t4bl.model(modeFile="platform:/resource/Xpense/appModel.t4bl", uuid="_oXlnIMTeEeWQJb7eYZbXFg").
 				  
  DEFINE DATASET dsCustomerProjectComplete FOR ttCustomer, ttProject, ttCost, ttProject_time
	  DATA-RELATION drCustomerProject FOR ttCustomer, ttProject
		RELATION-FIELDS (customer_id,customer_id)   
	  DATA-RELATION drProjectCost FOR ttProject, ttCost
		RELATION-FIELDS (project_id,project_id)   
	  DATA-RELATION drProjectProjectTime FOR ttProject, ttProject_time
		RELATION-FIELDS (project_id,project_id)    .
