 
 /*------------------------------------------------------------------------
    File        : projectProjectTimeCostForm
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : petter
    Created     : Mon Feb 01 13:42:57 GMT 2016
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING gui.baseForm.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS gui.projectProjectTimeCostForm INHERITS baseForm: 
	
    DEFINE PRIVATE VARIABLE bsProjectProjectTime AS Progress.Data.BindingSource NO-UNDO.
    DEFINE PRIVATE VARIABLE BtnCostDateFilter         AS Infragistics.Win.Misc.UltraButton NO-UNDO.
    DEFINE PRIVATE VARIABLE btnSave AS Infragistics.Win.Misc.UltraButton NO-UNDO.
    DEFINE PRIVATE VARIABLE calendarStopDate          AS Infragistics.Win.UltraWinSchedule.UltraCalendarCombo NO-UNDO.
    DEFINE PRIVATE VARIABLE calendarStartDate         AS Infragistics.Win.UltraWinSchedule.UltraCalendarCombo NO-UNDO.
	DEFINE PRIVATE VARIABLE components                AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE costGrid AS Infragistics.Win.UltraWinGrid.UltraGrid NO-UNDO.
    DEFINE PRIVATE VARIABLE CustomerEditor            AS Infragistics.Win.UltraWinEditors.UltraTextEditor NO-UNDO.
    DEFINE PRIVATE VARIABLE filterStartDate           AS Infragistics.Win.UltraWinSchedule.UltraCalendarCombo NO-UNDO.
    DEFINE PRIVATE VARIABLE filterStopDate            AS Infragistics.Win.UltraWinSchedule.UltraCalendarCombo NO-UNDO.
    DEFINE PRIVATE VARIABLE LabelDueDate              AS Infragistics.Win.Misc.UltraLabel NO-UNDO.
    DEFINE PRIVATE VARIABLE LabelCustomer             AS Infragistics.Win.Misc.UltraLabel NO-UNDO.
    DEFINE PRIVATE VARIABLE labelProjectDescription   AS Infragistics.Win.Misc.UltraLabel NO-UNDO.
    DEFINE PRIVATE VARIABLE labelProjectName          AS Infragistics.Win.Misc.UltraLabel NO-UNDO.
    DEFINE PRIVATE VARIABLE LabelTeam                 AS Infragistics.Win.Misc.UltraLabel NO-UNDO.
    DEFINE PRIVATE VARIABLE LabelStartDate            AS Infragistics.Win.Misc.UltraLabel NO-UNDO.
    DEFINE PRIVATE VARIABLE objProjectProjectTimeCost AS gui.projectProjectTimeCostModel NO-UNDO. 
    DEFINE PRIVATE VARIABLE objCostCostType           AS gui.costCostTypeModel NO-UNDO.
    DEFINE PRIVATE VARIABLE projectDescriptionEditor  AS Infragistics.Win.UltraWinEditors.UltraTextEditor NO-UNDO.
    DEFINE PRIVATE VARIABLE projectTimeGrid AS Infragistics.Win.UltraWinGrid.UltraGrid NO-UNDO.
    DEFINE PRIVATE VARIABLE teamEditor                AS Infragistics.Win.UltraWinEditors.UltraTextEditor NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraChart1 AS Infragistics.Win.UltraWinChart.UltraChart NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraGrid1                AS Infragistics.Win.UltraWinGrid.UltraGrid NO-UNDO.
		
	CONSTRUCTOR PUBLIC projectProjectTimeCostForm (  ):
		
		
        SUPER().
        InitializeComponent().
        
        objProjectProjectTimeCost = NEW gui.projectProjectTimeCostModel().
        bsProjectProjectTime:HANDLE = objProjectProjectTimeCost:getProjectProjectTimeCostHandle().
        
        objProjectProjectTimeCost:getProjectProjectTimeCost().
        objProjectProjectTimeCost:enableEdit().
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.

	END CONSTRUCTOR.


	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID BtnCostDateFilter_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		DEFINE VARIABLE cStartDate AS CHARACTER NO-UNDO. 		
		DEFINE VARIABLE cStopdate  AS CHARACTER NO-UNDO.
        DEFINE VARIABLE dtStopDate AS DATETIME  NO-UNDO.
         
        cStartDate = filterStartDate:VALUE.
        
        // inclusive stop date
        dtStopDate = DATETIME(STRING(filterStopDate:VALUE)).       
        dtStopDate = ADD-INTERVAL(dtStopDate, 1, 'day').
        dtStopDate = ADD-INTERVAL(dtStopDate, -1, 'milliseconds').
        cStopdate = STRING(dtStopDate).
 
		objProjectProjectTimeCost:setFilter("project_time",
		                                    "start_date_time",
		                                    ">=",
		                                    cStartDate).
		objProjectProjectTimeCost:addFilter("project_time",
		                                    "stop_date_time",
		                                    "<=", 
                                            cStopdate).
		objProjectProjectTimeCost:getProjectProjectTimeCost().

	END METHOD.


	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID btnSave_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
	            
        bsProjectProjectTime:assign().
        objProjectProjectTimeCost:disableEdit().
        objProjectProjectTimeCost:saveProjectProjectTimeCost().

	END METHOD.



	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID calendarStartDate_Leave( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):

		calendarStartDate:DataBindings["Text"]:WriteValue().

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID calendarStopDate_Leave( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		
		calendarStartDate:DataBindings["Text"]:WriteValue().

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID costGrid_AfterCellUpdate( INPUT sender AS System.Object, INPUT e AS Infragistics.Win.UltraWinGrid.CellEventArgs ):
/*        MESSAGE "cell " objProjectProjectTimeCost:activeCost*/
/*            VIEW-AS ALERT-BOX.                              */
/*		RETURN.                                                   */

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID costGrid_AfterRowActivate( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
/*		MESSAGE objProjectProjectTimeCost:activeCost*/
/*        VIEW-AS ALERT-BOX.                    */
/*		RETURN.                                     */

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID costGrid_BeforeRowUpdate( INPUT sender AS System.Object, INPUT e AS Infragistics.Win.UltraWinGrid.CancelableRowEventArgs ):
		
        bsProjectProjectTime:assign(). // not doing it

	END METHOD.



	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID CustomerEditor_Leave( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		
		CustomerEditor:DataBindings["Text"]:WriteValue().

	END METHOD.

	METHOD PRIVATE VOID InitializeComponent(  ):
		
        /* NOTE: The following method is automatically generated.
        
        We strongly suggest that the contents of this method only be modified using the
        Visual Designer to avoid any incompatible modifications.
        
        Modifying the contents of this method using a code editor will invalidate any support for this file. */
        THIS-OBJECT:components = NEW System.ComponentModel.Container().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE tableDesc1 AS Progress.Data.TableDesc NO-UNDO.
        tableDesc1 = NEW Progress.Data.TableDesc("ttProject").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE tableDesc2 AS Progress.Data.TableDesc NO-UNDO.
        tableDesc2 = NEW Progress.Data.TableDesc("ttCost").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE tableDesc3 AS Progress.Data.TableDesc NO-UNDO.
        tableDesc3 = NEW Progress.Data.TableDesc("ttProject_time").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance1 AS Infragistics.Win.Appearance NO-UNDO.
        appearance1 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance2 AS Infragistics.Win.Appearance NO-UNDO.
        appearance2 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridBand1 AS Infragistics.Win.UltraWinGrid.UltraGridBand NO-UNDO.
        ultraGridBand1 = NEW Infragistics.Win.UltraWinGrid.UltraGridBand("ttProject", -1).
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn1 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn1 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("project_id").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn2 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn2 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("customer_id").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn3 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn3 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("project_name", -1, ?, 0, Infragistics.Win.UltraWinGrid.SortIndicator:Descending, FALSE).
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn4 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn4 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("start_date").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn5 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn5 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("due_date").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn6 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn6 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("team_id").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn7 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn7 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("project_description").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn8 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn8 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("customer_name").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn9 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn9 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("team_name").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn10 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn10 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("ttCost").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn11 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn11 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("ttProject_time").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridBand2 AS Infragistics.Win.UltraWinGrid.UltraGridBand NO-UNDO.
        ultraGridBand2 = NEW Infragistics.Win.UltraWinGrid.UltraGridBand("ttCost", 0).
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn12 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn12 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("cost_id").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn13 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn13 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("cost_type_id").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn14 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn14 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("price").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn15 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn15 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("currency_id").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn16 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn16 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("cost_date").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn17 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn17 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("project_id").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn18 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn18 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("cost_type_name").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn19 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn19 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("currency_name").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridBand3 AS Infragistics.Win.UltraWinGrid.UltraGridBand NO-UNDO.
        ultraGridBand3 = NEW Infragistics.Win.UltraWinGrid.UltraGridBand("ttProject_time", 0).
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn20 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn20 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("project_time_id").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn21 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn21 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("project_id").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn22 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn22 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("employee_id", -1, ?, 0, Infragistics.Win.UltraWinGrid.SortIndicator:Descending, FALSE).
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn23 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn23 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("start_date_time").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn24 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn24 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("stop_date_time").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn25 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn25 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("comment").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn26 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn26 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("employee_name").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance3 AS Infragistics.Win.Appearance NO-UNDO.
        appearance3 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance4 AS Infragistics.Win.Appearance NO-UNDO.
        appearance4 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance5 AS Infragistics.Win.Appearance NO-UNDO.
        appearance5 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance6 AS Infragistics.Win.Appearance NO-UNDO.
        appearance6 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance7 AS Infragistics.Win.Appearance NO-UNDO.
        appearance7 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance8 AS Infragistics.Win.Appearance NO-UNDO.
        appearance8 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance9 AS Infragistics.Win.Appearance NO-UNDO.
        appearance9 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance10 AS Infragistics.Win.Appearance NO-UNDO.
        appearance10 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance11 AS Infragistics.Win.Appearance NO-UNDO.
        appearance11 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance12 AS Infragistics.Win.Appearance NO-UNDO.
        appearance12 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance13 AS Infragistics.Win.Appearance NO-UNDO.
        appearance13 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE dateButton1 AS Infragistics.Win.UltraWinSchedule.CalendarCombo.DateButton NO-UNDO.
        dateButton1 = NEW Infragistics.Win.UltraWinSchedule.CalendarCombo.DateButton().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE dateButton2 AS Infragistics.Win.UltraWinSchedule.CalendarCombo.DateButton NO-UNDO.
        dateButton2 = NEW Infragistics.Win.UltraWinSchedule.CalendarCombo.DateButton().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance14 AS Infragistics.Win.Appearance NO-UNDO.
        appearance14 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridBand4 AS Infragistics.Win.UltraWinGrid.UltraGridBand NO-UNDO.
        ultraGridBand4 = NEW Infragistics.Win.UltraWinGrid.UltraGridBand("ttCost", -1).
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn92 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn92 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("cost_id").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn93 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn93 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("cost_type_id").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn94 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn94 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("price", -1, ?, 0, Infragistics.Win.UltraWinGrid.SortIndicator:Ascending, FALSE).
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn95 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn95 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("currency_id").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn96 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn96 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("cost_date").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn97 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn97 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("project_id").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn98 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn98 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("cost_type_name").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn99 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn99 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("currency_name").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance15 AS Infragistics.Win.Appearance NO-UNDO.
        appearance15 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance16 AS Infragistics.Win.Appearance NO-UNDO.
        appearance16 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance17 AS Infragistics.Win.Appearance NO-UNDO.
        appearance17 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance18 AS Infragistics.Win.Appearance NO-UNDO.
        appearance18 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance19 AS Infragistics.Win.Appearance NO-UNDO.
        appearance19 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance20 AS Infragistics.Win.Appearance NO-UNDO.
        appearance20 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance21 AS Infragistics.Win.Appearance NO-UNDO.
        appearance21 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance22 AS Infragistics.Win.Appearance NO-UNDO.
        appearance22 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance23 AS Infragistics.Win.Appearance NO-UNDO.
        appearance23 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance24 AS Infragistics.Win.Appearance NO-UNDO.
        appearance24 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance25 AS Infragistics.Win.Appearance NO-UNDO.
        appearance25 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance26 AS Infragistics.Win.Appearance NO-UNDO.
        appearance26 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridBand5 AS Infragistics.Win.UltraWinGrid.UltraGridBand NO-UNDO.
        ultraGridBand5 = NEW Infragistics.Win.UltraWinGrid.UltraGridBand("ttProject_time", -1).
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn86 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn86 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("project_time_id").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn27 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn27 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("project_id").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn87 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn87 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("employee_id").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn88 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn88 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("start_date_time").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn89 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn89 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("stop_date_time").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn90 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn90 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("comment", -1, ?, 0, Infragistics.Win.UltraWinGrid.SortIndicator:Ascending, FALSE).
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn91 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn91 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("employee_name").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance27 AS Infragistics.Win.Appearance NO-UNDO.
        appearance27 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance28 AS Infragistics.Win.Appearance NO-UNDO.
        appearance28 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance29 AS Infragistics.Win.Appearance NO-UNDO.
        appearance29 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance30 AS Infragistics.Win.Appearance NO-UNDO.
        appearance30 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance31 AS Infragistics.Win.Appearance NO-UNDO.
        appearance31 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance32 AS Infragistics.Win.Appearance NO-UNDO.
        appearance32 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance33 AS Infragistics.Win.Appearance NO-UNDO.
        appearance33 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance34 AS Infragistics.Win.Appearance NO-UNDO.
        appearance34 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance35 AS Infragistics.Win.Appearance NO-UNDO.
        appearance35 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance36 AS Infragistics.Win.Appearance NO-UNDO.
        appearance36 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance37 AS Infragistics.Win.Appearance NO-UNDO.
        appearance37 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE dateButton3 AS Infragistics.Win.UltraWinSchedule.CalendarCombo.DateButton NO-UNDO.
        dateButton3 = NEW Infragistics.Win.UltraWinSchedule.CalendarCombo.DateButton().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE dateButton4 AS Infragistics.Win.UltraWinSchedule.CalendarCombo.DateButton NO-UNDO.
        dateButton4 = NEW Infragistics.Win.UltraWinSchedule.CalendarCombo.DateButton().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE paintElement1 AS Infragistics.UltraChart.Resources.Appearance.PaintElement NO-UNDO.
        paintElement1 = NEW Infragistics.UltraChart.Resources.Appearance.PaintElement().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE gradientEffect1 AS Infragistics.UltraChart.Resources.Appearance.GradientEffect NO-UNDO.
        gradientEffect1 = NEW Infragistics.UltraChart.Resources.Appearance.GradientEffect().
        THIS-OBJECT:bsProjectProjectTime = NEW Progress.Data.BindingSource(THIS-OBJECT:components).
        THIS-OBJECT:labelProjectName = NEW Infragistics.Win.Misc.UltraLabel().
        THIS-OBJECT:projectDescriptionEditor = NEW Infragistics.Win.UltraWinEditors.UltraTextEditor().
        THIS-OBJECT:ultraGrid1 = NEW Infragistics.Win.UltraWinGrid.UltraGrid().
        THIS-OBJECT:labelProjectDescription = NEW Infragistics.Win.Misc.UltraLabel().
        THIS-OBJECT:CustomerEditor = NEW Infragistics.Win.UltraWinEditors.UltraTextEditor().
        THIS-OBJECT:calendarStartDate = NEW Infragistics.Win.UltraWinSchedule.UltraCalendarCombo().
        THIS-OBJECT:calendarStopDate = NEW Infragistics.Win.UltraWinSchedule.UltraCalendarCombo().
        THIS-OBJECT:teamEditor = NEW Infragistics.Win.UltraWinEditors.UltraTextEditor().
        THIS-OBJECT:LabelStartDate = NEW Infragistics.Win.Misc.UltraLabel().
        THIS-OBJECT:LabelTeam = NEW Infragistics.Win.Misc.UltraLabel().
        THIS-OBJECT:LabelDueDate = NEW Infragistics.Win.Misc.UltraLabel().
        THIS-OBJECT:LabelCustomer = NEW Infragistics.Win.Misc.UltraLabel().
        THIS-OBJECT:costGrid = NEW Infragistics.Win.UltraWinGrid.UltraGrid().
        THIS-OBJECT:projectTimeGrid = NEW Infragistics.Win.UltraWinGrid.UltraGrid().
        THIS-OBJECT:filterStartDate = NEW Infragistics.Win.UltraWinSchedule.UltraCalendarCombo().
        THIS-OBJECT:filterStopDate = NEW Infragistics.Win.UltraWinSchedule.UltraCalendarCombo().
        THIS-OBJECT:BtnCostDateFilter = NEW Infragistics.Win.Misc.UltraButton().
        THIS-OBJECT:btnSave = NEW Infragistics.Win.Misc.UltraButton().
        THIS-OBJECT:ultraChart1 = NEW Infragistics.Win.UltraWinChart.UltraChart().
        CAST(THIS-OBJECT:bsProjectProjectTime, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:projectDescriptionEditor, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:ultraGrid1, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:CustomerEditor, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:calendarStartDate, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:calendarStopDate, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:teamEditor, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:costGrid, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:projectTimeGrid, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:filterStartDate, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:filterStopDate, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:ultraChart1, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* bsProjectProjectTime */
        /*  */
        THIS-OBJECT:bsProjectProjectTime:AutoUpdate = TRUE.
        THIS-OBJECT:bsProjectProjectTime:MaxDataGuess = 0.
        THIS-OBJECT:bsProjectProjectTime:NoLOBs = FALSE.
        THIS-OBJECT:bsProjectProjectTime:Position = 0.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar0 AS "Progress.Data.TableDesc[]" NO-UNDO.
        arrayvar0 = NEW "Progress.Data.TableDesc[]"(0).
        tableDesc2:ChildTables = arrayvar0.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar1 AS Progress.Data.ColumnPropDesc EXTENT 8 NO-UNDO.
        arrayvar1[1] = NEW Progress.Data.ColumnPropDesc("cost_id", "cost_id", Progress.Data.DataType:INTEGER).
        arrayvar1[2] = NEW Progress.Data.ColumnPropDesc("cost_type_id", "cost_type_id", Progress.Data.DataType:INTEGER).
        arrayvar1[3] = NEW Progress.Data.ColumnPropDesc("price", "price", Progress.Data.DataType:INTEGER).
        arrayvar1[4] = NEW Progress.Data.ColumnPropDesc("currency_id", "currency_id", Progress.Data.DataType:INTEGER).
        arrayvar1[5] = NEW Progress.Data.ColumnPropDesc("cost_date", "cost_date", Progress.Data.DataType:DATE).
        arrayvar1[6] = NEW Progress.Data.ColumnPropDesc("project_id", "project_id", Progress.Data.DataType:INTEGER).
        arrayvar1[7] = NEW Progress.Data.ColumnPropDesc("cost_type_name", "cost_type_name", Progress.Data.DataType:CHARACTER).
        arrayvar1[8] = NEW Progress.Data.ColumnPropDesc("currency_name", "Currency", Progress.Data.DataType:CHARACTER).
        tableDesc2:Columns = arrayvar1.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar2 AS "Progress.Data.TableDesc[]" NO-UNDO.
        arrayvar2 = NEW "Progress.Data.TableDesc[]"(0).
        tableDesc3:ChildTables = arrayvar2.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar3 AS Progress.Data.ColumnPropDesc EXTENT 7 NO-UNDO.
        arrayvar3[1] = NEW Progress.Data.ColumnPropDesc("project_time_id", "Project Time Id", Progress.Data.DataType:INTEGER).
        arrayvar3[2] = NEW Progress.Data.ColumnPropDesc("project_id", "Project Id", Progress.Data.DataType:INTEGER).
        arrayvar3[3] = NEW Progress.Data.ColumnPropDesc("employee_id", "Employee Id", Progress.Data.DataType:INTEGER).
        arrayvar3[4] = NEW Progress.Data.ColumnPropDesc("start_date_time", "Start", Progress.Data.DataType:DATETIME).
        arrayvar3[5] = NEW Progress.Data.ColumnPropDesc("stop_date_time", "Stop", Progress.Data.DataType:DATETIME).
        arrayvar3[6] = NEW Progress.Data.ColumnPropDesc("comment", "Comment", Progress.Data.DataType:CHARACTER).
        arrayvar3[7] = NEW Progress.Data.ColumnPropDesc("employee_name", "Employee Name", Progress.Data.DataType:CHARACTER).
        tableDesc3:Columns = arrayvar3.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar4 AS Progress.Data.TableDesc EXTENT 2 NO-UNDO.
        arrayvar4[1] = tableDesc2.
        arrayvar4[2] = tableDesc3.
        tableDesc1:ChildTables = arrayvar4.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar5 AS Progress.Data.ColumnPropDesc EXTENT 9 NO-UNDO.
        arrayvar5[1] = NEW Progress.Data.ColumnPropDesc("project_id", "Project Id", Progress.Data.DataType:INTEGER).
        arrayvar5[2] = NEW Progress.Data.ColumnPropDesc("customer_id", "Customer Id", Progress.Data.DataType:INTEGER).
        arrayvar5[3] = NEW Progress.Data.ColumnPropDesc("project_name", "Project Name", Progress.Data.DataType:CHARACTER).
        arrayvar5[4] = NEW Progress.Data.ColumnPropDesc("start_date", "Start Date", Progress.Data.DataType:DATE).
        arrayvar5[5] = NEW Progress.Data.ColumnPropDesc("due_date", "Due Date", Progress.Data.DataType:DATE).
        arrayvar5[6] = NEW Progress.Data.ColumnPropDesc("team_id", "Team Id", Progress.Data.DataType:INTEGER).
        arrayvar5[7] = NEW Progress.Data.ColumnPropDesc("project_description", "Project Description", Progress.Data.DataType:CHARACTER).
        arrayvar5[8] = NEW Progress.Data.ColumnPropDesc("customer_name", "Customer Name", Progress.Data.DataType:CHARACTER).
        arrayvar5[9] = NEW Progress.Data.ColumnPropDesc("team_name", "Team Name", Progress.Data.DataType:CHARACTER).
        tableDesc1:Columns = arrayvar5.
        THIS-OBJECT:bsProjectProjectTime:TableSchema = tableDesc1.
        /*  */
        /* labelProjectName */
        /*  */
        appearance1:TextHAlignAsString = "Center".
        THIS-OBJECT:labelProjectName:Appearance = appearance1.
        THIS-OBJECT:labelProjectName:DataBindings:Add(NEW System.Windows.Forms.Binding("Text", THIS-OBJECT:bsProjectProjectTime, "project_name", TRUE)).
        THIS-OBJECT:labelProjectName:Dock = System.Windows.Forms.DockStyle:Top.
        THIS-OBJECT:labelProjectName:Font = NEW System.Drawing.Font("Microsoft Sans Serif", Progress.Util.CastUtil:ToSingle(20), System.Drawing.FontStyle:Regular, System.Drawing.GraphicsUnit:Point, System.Convert:ToByte(0)).
        THIS-OBJECT:labelProjectName:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:labelProjectName:Name = "labelProjectName".
        THIS-OBJECT:labelProjectName:Size = NEW System.Drawing.Size(1099, 40).
        THIS-OBJECT:labelProjectName:TabIndex = 0.
        THIS-OBJECT:labelProjectName:Text = "project name".
        THIS-OBJECT:labelProjectName:Visible = FALSE.
        /*  */
        /* projectDescriptionEditor */
        /*  */
        THIS-OBJECT:projectDescriptionEditor:DataBindings:Add(NEW System.Windows.Forms.Binding("Text", THIS-OBJECT:bsProjectProjectTime, "project_description", TRUE)).
        THIS-OBJECT:projectDescriptionEditor:Location = NEW System.Drawing.Point(416, 46).
        THIS-OBJECT:projectDescriptionEditor:Multiline = TRUE.
        THIS-OBJECT:projectDescriptionEditor:Name = "projectDescriptionEditor".
        THIS-OBJECT:projectDescriptionEditor:Size = NEW System.Drawing.Size(539, 113).
        THIS-OBJECT:projectDescriptionEditor:TabIndex = 1.
        THIS-OBJECT:projectDescriptionEditor:Leave:Subscribe(THIS-OBJECT:projectDescriptionEditor_Leave).
        /*  */
        /* ultraGrid1 */
        /*  */
        THIS-OBJECT:ultraGrid1:DataSource = THIS-OBJECT:bsProjectProjectTime.
        appearance2:BackColor = System.Drawing.SystemColors:Window.
        appearance2:BorderColor = System.Drawing.SystemColors:InactiveCaption.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Appearance = appearance2.
        ultraGridColumn1:Header:VisiblePosition = 0.
        ultraGridColumn2:Header:VisiblePosition = 1.
        ultraGridColumn3:Header:VisiblePosition = 2.
        ultraGridColumn4:Header:VisiblePosition = 3.
        ultraGridColumn5:Header:VisiblePosition = 4.
        ultraGridColumn6:Header:VisiblePosition = 5.
        ultraGridColumn7:Header:VisiblePosition = 6.
        ultraGridColumn8:Header:VisiblePosition = 7.
        ultraGridColumn9:Header:VisiblePosition = 8.
        ultraGridColumn10:Header:VisiblePosition = 9.
        ultraGridColumn11:Header:VisiblePosition = 10.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar6 AS System.Object EXTENT 11 NO-UNDO.
        arrayvar6[1] = ultraGridColumn1.
        arrayvar6[2] = ultraGridColumn2.
        arrayvar6[3] = ultraGridColumn3.
        arrayvar6[4] = ultraGridColumn4.
        arrayvar6[5] = ultraGridColumn5.
        arrayvar6[6] = ultraGridColumn6.
        arrayvar6[7] = ultraGridColumn7.
        arrayvar6[8] = ultraGridColumn8.
        arrayvar6[9] = ultraGridColumn9.
        arrayvar6[10] = ultraGridColumn10.
        arrayvar6[11] = ultraGridColumn11.
        ultraGridBand1:Columns:AddRange(arrayvar6).
        ultraGridColumn12:Header:VisiblePosition = 0.
        ultraGridColumn13:Header:VisiblePosition = 1.
        ultraGridColumn14:Header:VisiblePosition = 2.
        ultraGridColumn15:Header:VisiblePosition = 3.
        ultraGridColumn16:Header:VisiblePosition = 4.
        ultraGridColumn17:Header:VisiblePosition = 5.
        ultraGridColumn18:Header:VisiblePosition = 6.
        ultraGridColumn19:Header:VisiblePosition = 7.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar7 AS System.Object EXTENT 8 NO-UNDO.
        arrayvar7[1] = ultraGridColumn12.
        arrayvar7[2] = ultraGridColumn13.
        arrayvar7[3] = ultraGridColumn14.
        arrayvar7[4] = ultraGridColumn15.
        arrayvar7[5] = ultraGridColumn16.
        arrayvar7[6] = ultraGridColumn17.
        arrayvar7[7] = ultraGridColumn18.
        arrayvar7[8] = ultraGridColumn19.
        ultraGridBand2:Columns:AddRange(arrayvar7).
        ultraGridColumn20:Header:VisiblePosition = 0.
        ultraGridColumn21:Header:VisiblePosition = 1.
        ultraGridColumn22:Header:VisiblePosition = 2.
        ultraGridColumn23:Header:VisiblePosition = 3.
        ultraGridColumn24:Header:VisiblePosition = 4.
        ultraGridColumn25:Header:VisiblePosition = 5.
        ultraGridColumn26:Header:VisiblePosition = 6.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar8 AS System.Object EXTENT 7 NO-UNDO.
        arrayvar8[1] = ultraGridColumn20.
        arrayvar8[2] = ultraGridColumn21.
        arrayvar8[3] = ultraGridColumn22.
        arrayvar8[4] = ultraGridColumn23.
        arrayvar8[5] = ultraGridColumn24.
        arrayvar8[6] = ultraGridColumn25.
        arrayvar8[7] = ultraGridColumn26.
        ultraGridBand3:Columns:AddRange(arrayvar8).
        THIS-OBJECT:ultraGrid1:DisplayLayout:BandsSerializer:Add(ultraGridBand1).
        THIS-OBJECT:ultraGrid1:DisplayLayout:BandsSerializer:Add(ultraGridBand2).
        THIS-OBJECT:ultraGrid1:DisplayLayout:BandsSerializer:Add(ultraGridBand3).
        THIS-OBJECT:ultraGrid1:DisplayLayout:BorderStyle = Infragistics.Win.UIElementBorderStyle:Solid.
        THIS-OBJECT:ultraGrid1:DisplayLayout:CaptionVisible = Infragistics.Win.DefaultableBoolean:False.
        appearance3:BackColor = System.Drawing.SystemColors:ActiveBorder.
        appearance3:BackColor2 = System.Drawing.SystemColors:ControlDark.
        appearance3:BackGradientStyle = Infragistics.Win.GradientStyle:Vertical.
        appearance3:BorderColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ultraGrid1:DisplayLayout:GroupByBox:Appearance = appearance3.
        appearance4:ForeColor = System.Drawing.SystemColors:GrayText.
        THIS-OBJECT:ultraGrid1:DisplayLayout:GroupByBox:BandLabelAppearance = appearance4.
        THIS-OBJECT:ultraGrid1:DisplayLayout:GroupByBox:BorderStyle = Infragistics.Win.UIElementBorderStyle:Solid.
        appearance5:BackColor = System.Drawing.SystemColors:ControlLightLight.
        appearance5:BackColor2 = System.Drawing.SystemColors:Control.
        appearance5:BackGradientStyle = Infragistics.Win.GradientStyle:Horizontal.
        appearance5:ForeColor = System.Drawing.SystemColors:GrayText.
        THIS-OBJECT:ultraGrid1:DisplayLayout:GroupByBox:PromptAppearance = appearance5.
        THIS-OBJECT:ultraGrid1:DisplayLayout:MaxColScrollRegions = 1.
        THIS-OBJECT:ultraGrid1:DisplayLayout:MaxRowScrollRegions = 1.
        appearance6:BackColor = System.Drawing.SystemColors:Window.
        appearance6:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:ActiveCellAppearance = appearance6.
        appearance7:BackColor = System.Drawing.SystemColors:Highlight.
        appearance7:ForeColor = System.Drawing.SystemColors:HighlightText.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:ActiveRowAppearance = appearance7.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:BorderStyleCell = Infragistics.Win.UIElementBorderStyle:Dotted.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:BorderStyleRow = Infragistics.Win.UIElementBorderStyle:Dotted.
        appearance8:BackColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:CardAreaAppearance = appearance8.
        appearance9:BorderColor = System.Drawing.Color:Silver.
        appearance9:TextTrimming = Infragistics.Win.TextTrimming:EllipsisCharacter.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:CellAppearance = appearance9.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction:EditAndSelectText.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:CellPadding = 0.
        appearance10:BackColor = System.Drawing.SystemColors:Control.
        appearance10:BackColor2 = System.Drawing.SystemColors:ControlDark.
        appearance10:BackGradientAlignment = Infragistics.Win.GradientAlignment:Element.
        appearance10:BackGradientStyle = Infragistics.Win.GradientStyle:Horizontal.
        appearance10:BorderColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:GroupByRowAppearance = appearance10.
        appearance11:TextHAlignAsString = "Left".
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:HeaderAppearance = appearance11.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction:SortMulti.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:HeaderStyle = Infragistics.Win.HeaderStyle:WindowsXPCommand.
        appearance12:BackColor = System.Drawing.SystemColors:Window.
        appearance12:BorderColor = System.Drawing.Color:Silver.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:RowAppearance = appearance12.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:RowSelectors = Infragistics.Win.DefaultableBoolean:False.
        appearance13:BackColor = System.Drawing.SystemColors:ControlLight.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:TemplateAddRowAppearance = appearance13.
        THIS-OBJECT:ultraGrid1:DisplayLayout:ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds:ScrollToFill.
        THIS-OBJECT:ultraGrid1:DisplayLayout:ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle:Immediate.
        THIS-OBJECT:ultraGrid1:DisplayLayout:ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand:OutlookGroupBy.
        THIS-OBJECT:ultraGrid1:Font = NEW System.Drawing.Font("Microsoft Sans Serif", Progress.Util.CastUtil:ToSingle(10), System.Drawing.FontStyle:Regular, System.Drawing.GraphicsUnit:Point, System.Convert:ToByte(0)).
        THIS-OBJECT:ultraGrid1:Location = NEW System.Drawing.Point(18, 426).
        THIS-OBJECT:ultraGrid1:Name = "ultraGrid1".
        THIS-OBJECT:ultraGrid1:Size = NEW System.Drawing.Size(937, 209).
        THIS-OBJECT:ultraGrid1:TabIndex = 2.
        THIS-OBJECT:ultraGrid1:Text = "ultraGrid1".
        /*  */
        /* labelProjectDescription */
        /*  */
        THIS-OBJECT:labelProjectDescription:AutoSize = TRUE.
        THIS-OBJECT:labelProjectDescription:BorderStyleOuter = Infragistics.Win.UIElementBorderStyle:Dotted.
        THIS-OBJECT:labelProjectDescription:Font = NEW System.Drawing.Font("Microsoft Sans Serif", Progress.Util.CastUtil:ToSingle(10), System.Drawing.FontStyle:Regular, System.Drawing.GraphicsUnit:Point, System.Convert:ToByte(0)).
        THIS-OBJECT:labelProjectDescription:Location = NEW System.Drawing.Point(426, 31).
        THIS-OBJECT:labelProjectDescription:Name = "labelProjectDescription".
        THIS-OBJECT:labelProjectDescription:Size = NEW System.Drawing.Size(122, 19).
        THIS-OBJECT:labelProjectDescription:TabIndex = 3.
        THIS-OBJECT:labelProjectDescription:Text = "Project Description".
        /*  */
        /* CustomerEditor */
        /*  */
        THIS-OBJECT:CustomerEditor:DataBindings:Add(NEW System.Windows.Forms.Binding("Text", THIS-OBJECT:bsProjectProjectTime, "customer_name", TRUE)).
        THIS-OBJECT:CustomerEditor:Location = NEW System.Drawing.Point(110, 133).
        THIS-OBJECT:CustomerEditor:Name = "CustomerEditor".
        THIS-OBJECT:CustomerEditor:Size = NEW System.Drawing.Size(278, 21).
        THIS-OBJECT:CustomerEditor:TabIndex = 4.
        THIS-OBJECT:CustomerEditor:Leave:Subscribe(THIS-OBJECT:CustomerEditor_Leave).
        /*  */
        /* calendarStartDate */
        /*  */
        THIS-OBJECT:calendarStartDate:DataBindings:Add(NEW System.Windows.Forms.Binding("Text", THIS-OBJECT:bsProjectProjectTime, "start_date", TRUE)).
        THIS-OBJECT:calendarStartDate:DateButtons:Add(dateButton1).
        THIS-OBJECT:calendarStartDate:Location = NEW System.Drawing.Point(110, 46).
        THIS-OBJECT:calendarStartDate:Name = "calendarStartDate".
        THIS-OBJECT:calendarStartDate:NonAutoSizeHeight = 22.
        THIS-OBJECT:calendarStartDate:Size = NEW System.Drawing.Size(121, 21).
        THIS-OBJECT:calendarStartDate:TabIndex = 5.
        THIS-OBJECT:calendarStartDate:Leave:Subscribe(THIS-OBJECT:calendarStartDate_Leave).
        /*  */
        /* calendarStopDate */
        /*  */
        THIS-OBJECT:calendarStopDate:DataBindings:Add(NEW System.Windows.Forms.Binding("Text", THIS-OBJECT:bsProjectProjectTime, "due_date", TRUE)).
        THIS-OBJECT:calendarStopDate:DateButtons:Add(dateButton2).
        THIS-OBJECT:calendarStopDate:Location = NEW System.Drawing.Point(110, 74).
        THIS-OBJECT:calendarStopDate:Name = "calendarStopDate".
        THIS-OBJECT:calendarStopDate:NonAutoSizeHeight = 22.
        THIS-OBJECT:calendarStopDate:Size = NEW System.Drawing.Size(121, 21).
        THIS-OBJECT:calendarStopDate:TabIndex = 6.
        THIS-OBJECT:calendarStopDate:Leave:Subscribe(THIS-OBJECT:calendarStopDate_Leave).
        /*  */
        /* teamEditor */
        /*  */
        THIS-OBJECT:teamEditor:DataBindings:Add(NEW System.Windows.Forms.Binding("Text", THIS-OBJECT:bsProjectProjectTime, "team_name", TRUE)).
        THIS-OBJECT:teamEditor:Location = NEW System.Drawing.Point(110, 102).
        THIS-OBJECT:teamEditor:Name = "teamEditor".
        THIS-OBJECT:teamEditor:Size = NEW System.Drawing.Size(278, 21).
        THIS-OBJECT:teamEditor:TabIndex = 7.
        THIS-OBJECT:teamEditor:Leave:Subscribe(THIS-OBJECT:teamEditor_Leave).
        /*  */
        /* LabelStartDate */
        /*  */
        THIS-OBJECT:LabelStartDate:AutoSize = TRUE.
        THIS-OBJECT:LabelStartDate:Location = NEW System.Drawing.Point(39, 49).
        THIS-OBJECT:LabelStartDate:Name = "LabelStartDate".
        THIS-OBJECT:LabelStartDate:Size = NEW System.Drawing.Size(58, 14).
        THIS-OBJECT:LabelStartDate:TabIndex = 8.
        THIS-OBJECT:LabelStartDate:Text = "Start Date:".
        THIS-OBJECT:LabelStartDate:Visible = FALSE.
        /*  */
        /* LabelTeam */
        /*  */
        THIS-OBJECT:LabelTeam:AutoSize = TRUE.
        THIS-OBJECT:LabelTeam:Location = NEW System.Drawing.Point(39, 106).
        THIS-OBJECT:LabelTeam:Name = "LabelTeam".
        THIS-OBJECT:LabelTeam:Size = NEW System.Drawing.Size(36, 14).
        THIS-OBJECT:LabelTeam:TabIndex = 9.
        THIS-OBJECT:LabelTeam:Text = "Team:".
        THIS-OBJECT:LabelTeam:Visible = FALSE.
        /*  */
        /* LabelDueDate */
        /*  */
        THIS-OBJECT:LabelDueDate:AutoSize = TRUE.
        THIS-OBJECT:LabelDueDate:Location = NEW System.Drawing.Point(39, 76).
        THIS-OBJECT:LabelDueDate:Name = "LabelDueDate".
        THIS-OBJECT:LabelDueDate:Size = NEW System.Drawing.Size(55, 14).
        THIS-OBJECT:LabelDueDate:TabIndex = 10.
        THIS-OBJECT:LabelDueDate:Text = "Due Date:".
        /*  */
        /* LabelCustomer */
        /*  */
        THIS-OBJECT:LabelCustomer:AutoSize = TRUE.
        THIS-OBJECT:LabelCustomer:Location = NEW System.Drawing.Point(39, 137).
        THIS-OBJECT:LabelCustomer:Name = "LabelCustomer".
        THIS-OBJECT:LabelCustomer:Size = NEW System.Drawing.Size(56, 14).
        THIS-OBJECT:LabelCustomer:TabIndex = 11.
        THIS-OBJECT:LabelCustomer:Text = "Customer: ".
        /*  */
        /* costGrid */
        /*  */
        THIS-OBJECT:costGrid:DataMember = "ttCost".
        THIS-OBJECT:costGrid:DataSource = THIS-OBJECT:bsProjectProjectTime.
        appearance14:BackColor = System.Drawing.SystemColors:Window.
        appearance14:BorderColor = System.Drawing.SystemColors:InactiveCaption.
        THIS-OBJECT:costGrid:DisplayLayout:Appearance = appearance14.
        THIS-OBJECT:costGrid:DisplayLayout:AutoFitStyle = Infragistics.Win.UltraWinGrid.AutoFitStyle:ExtendLastColumn.
        ultraGridColumn92:Header:VisiblePosition = 0.
        ultraGridColumn92:Hidden = TRUE.
        ultraGridColumn93:Header:VisiblePosition = 1.
        ultraGridColumn93:Hidden = TRUE.
        ultraGridColumn94:Header:VisiblePosition = 4.
        ultraGridColumn94:Width = 84.
        ultraGridColumn95:Header:VisiblePosition = 5.
        ultraGridColumn95:Hidden = TRUE.
        ultraGridColumn96:Header:VisiblePosition = 3.
        ultraGridColumn96:Width = 81.
        ultraGridColumn97:Header:VisiblePosition = 6.
        ultraGridColumn97:Hidden = TRUE.
        ultraGridColumn98:Header:VisiblePosition = 2.
        ultraGridColumn98:Width = 113.
        ultraGridColumn99:Header:VisiblePosition = 7.
        ultraGridColumn99:Width = 83.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar9 AS System.Object EXTENT 8 NO-UNDO.
        arrayvar9[1] = ultraGridColumn92.
        arrayvar9[2] = ultraGridColumn93.
        arrayvar9[3] = ultraGridColumn94.
        arrayvar9[4] = ultraGridColumn95.
        arrayvar9[5] = ultraGridColumn96.
        arrayvar9[6] = ultraGridColumn97.
        arrayvar9[7] = ultraGridColumn98.
        arrayvar9[8] = ultraGridColumn99.
        ultraGridBand4:Columns:AddRange(arrayvar9).
        THIS-OBJECT:costGrid:DisplayLayout:BandsSerializer:Add(ultraGridBand4).
        THIS-OBJECT:costGrid:DisplayLayout:BorderStyle = Infragistics.Win.UIElementBorderStyle:Solid.
        THIS-OBJECT:costGrid:DisplayLayout:CaptionVisible = Infragistics.Win.DefaultableBoolean:False.
        appearance15:BackColor = System.Drawing.SystemColors:ActiveBorder.
        appearance15:BackColor2 = System.Drawing.SystemColors:ControlDark.
        appearance15:BackGradientStyle = Infragistics.Win.GradientStyle:Vertical.
        appearance15:BorderColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:costGrid:DisplayLayout:GroupByBox:Appearance = appearance15.
        appearance16:ForeColor = System.Drawing.SystemColors:GrayText.
        THIS-OBJECT:costGrid:DisplayLayout:GroupByBox:BandLabelAppearance = appearance16.
        THIS-OBJECT:costGrid:DisplayLayout:GroupByBox:BorderStyle = Infragistics.Win.UIElementBorderStyle:Solid.
        appearance17:BackColor = System.Drawing.SystemColors:ControlLightLight.
        appearance17:BackColor2 = System.Drawing.SystemColors:Control.
        appearance17:BackGradientStyle = Infragistics.Win.GradientStyle:Horizontal.
        appearance17:ForeColor = System.Drawing.SystemColors:GrayText.
        THIS-OBJECT:costGrid:DisplayLayout:GroupByBox:PromptAppearance = appearance17.
        THIS-OBJECT:costGrid:DisplayLayout:MaxColScrollRegions = 1.
        THIS-OBJECT:costGrid:DisplayLayout:MaxRowScrollRegions = 1.
        appearance18:BackColor = System.Drawing.SystemColors:Window.
        appearance18:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:costGrid:DisplayLayout:Override:ActiveCellAppearance = appearance18.
        appearance19:BackColor = System.Drawing.SystemColors:Highlight.
        appearance19:ForeColor = System.Drawing.SystemColors:HighlightText.
        THIS-OBJECT:costGrid:DisplayLayout:Override:ActiveRowAppearance = appearance19.
        THIS-OBJECT:costGrid:DisplayLayout:Override:BorderStyleCell = Infragistics.Win.UIElementBorderStyle:Dotted.
        THIS-OBJECT:costGrid:DisplayLayout:Override:BorderStyleRow = Infragistics.Win.UIElementBorderStyle:Dotted.
        appearance20:BackColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:costGrid:DisplayLayout:Override:CardAreaAppearance = appearance20.
        appearance21:BorderColor = System.Drawing.Color:Silver.
        appearance21:TextTrimming = Infragistics.Win.TextTrimming:EllipsisCharacter.
        THIS-OBJECT:costGrid:DisplayLayout:Override:CellAppearance = appearance21.
        THIS-OBJECT:costGrid:DisplayLayout:Override:CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction:EditAndSelectText.
        THIS-OBJECT:costGrid:DisplayLayout:Override:CellPadding = 0.
        appearance22:BackColor = System.Drawing.SystemColors:Control.
        appearance22:BackColor2 = System.Drawing.SystemColors:ControlDark.
        appearance22:BackGradientAlignment = Infragistics.Win.GradientAlignment:Element.
        appearance22:BackGradientStyle = Infragistics.Win.GradientStyle:Horizontal.
        appearance22:BorderColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:costGrid:DisplayLayout:Override:GroupByRowAppearance = appearance22.
        appearance23:TextHAlignAsString = "Left".
        THIS-OBJECT:costGrid:DisplayLayout:Override:HeaderAppearance = appearance23.
        THIS-OBJECT:costGrid:DisplayLayout:Override:HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction:SortMulti.
        THIS-OBJECT:costGrid:DisplayLayout:Override:HeaderStyle = Infragistics.Win.HeaderStyle:WindowsXPCommand.
        appearance24:BackColor = System.Drawing.SystemColors:Window.
        appearance24:BorderColor = System.Drawing.Color:Silver.
        THIS-OBJECT:costGrid:DisplayLayout:Override:RowAppearance = appearance24.
        THIS-OBJECT:costGrid:DisplayLayout:Override:RowSelectors = Infragistics.Win.DefaultableBoolean:False.
        appearance25:BackColor = System.Drawing.SystemColors:ControlLight.
        THIS-OBJECT:costGrid:DisplayLayout:Override:TemplateAddRowAppearance = appearance25.
        THIS-OBJECT:costGrid:DisplayLayout:ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds:ScrollToFill.
        THIS-OBJECT:costGrid:DisplayLayout:ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle:Immediate.
        THIS-OBJECT:costGrid:Font = NEW System.Drawing.Font("Microsoft Sans Serif", Progress.Util.CastUtil:ToSingle(10), System.Drawing.FontStyle:Regular, System.Drawing.GraphicsUnit:Point, System.Convert:ToByte(0)).
        THIS-OBJECT:costGrid:Location = NEW System.Drawing.Point(24, 181).
        THIS-OBJECT:costGrid:Name = "costGrid".
        THIS-OBJECT:costGrid:Size = NEW System.Drawing.Size(364, 197).
        THIS-OBJECT:costGrid:TabIndex = 12.
        THIS-OBJECT:costGrid:Text = "costGrid".
        THIS-OBJECT:costGrid:AfterCellUpdate:Subscribe(THIS-OBJECT:costGrid_AfterCellUpdate).
        THIS-OBJECT:costGrid:AfterRowActivate:Subscribe(THIS-OBJECT:costGrid_AfterRowActivate).
        THIS-OBJECT:costGrid:BeforeRowUpdate:Subscribe(THIS-OBJECT:costGrid_BeforeRowUpdate).
        /*  */
        /* projectTimeGrid */
        /*  */
        THIS-OBJECT:projectTimeGrid:DataMember = "ttProject_time".
        THIS-OBJECT:projectTimeGrid:DataSource = THIS-OBJECT:bsProjectProjectTime.
        appearance26:BackColor = System.Drawing.SystemColors:Window.
        appearance26:BorderColor = System.Drawing.SystemColors:InactiveCaption.
        THIS-OBJECT:projectTimeGrid:DisplayLayout:Appearance = appearance26.
        THIS-OBJECT:projectTimeGrid:DisplayLayout:AutoFitStyle = Infragistics.Win.UltraWinGrid.AutoFitStyle:ExtendLastColumn.
        ultraGridColumn86:Header:VisiblePosition = 0.
        ultraGridColumn86:Hidden = TRUE.
        ultraGridColumn27:Header:VisiblePosition = 1.
        ultraGridColumn27:Hidden = TRUE.
        ultraGridColumn87:Header:VisiblePosition = 2.
        ultraGridColumn87:Hidden = TRUE.
        ultraGridColumn88:Header:VisiblePosition = 3.
        ultraGridColumn88:Width = 84.
        ultraGridColumn89:Header:VisiblePosition = 4.
        ultraGridColumn89:Width = 83.
        ultraGridColumn90:Header:VisiblePosition = 6.
        ultraGridColumn90:Width = 230.
        ultraGridColumn91:Header:VisiblePosition = 5.
        ultraGridColumn91:Width = 140.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar10 AS System.Object EXTENT 7 NO-UNDO.
        arrayvar10[1] = ultraGridColumn86.
        arrayvar10[2] = ultraGridColumn27.
        arrayvar10[3] = ultraGridColumn87.
        arrayvar10[4] = ultraGridColumn88.
        arrayvar10[5] = ultraGridColumn89.
        arrayvar10[6] = ultraGridColumn90.
        arrayvar10[7] = ultraGridColumn91.
        ultraGridBand5:Columns:AddRange(arrayvar10).
        THIS-OBJECT:projectTimeGrid:DisplayLayout:BandsSerializer:Add(ultraGridBand5).
        THIS-OBJECT:projectTimeGrid:DisplayLayout:BorderStyle = Infragistics.Win.UIElementBorderStyle:Solid.
        THIS-OBJECT:projectTimeGrid:DisplayLayout:CaptionVisible = Infragistics.Win.DefaultableBoolean:False.
        appearance27:BackColor = System.Drawing.SystemColors:ActiveBorder.
        appearance27:BackColor2 = System.Drawing.SystemColors:ControlDark.
        appearance27:BackGradientStyle = Infragistics.Win.GradientStyle:Vertical.
        appearance27:BorderColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:projectTimeGrid:DisplayLayout:GroupByBox:Appearance = appearance27.
        appearance28:ForeColor = System.Drawing.SystemColors:GrayText.
        THIS-OBJECT:projectTimeGrid:DisplayLayout:GroupByBox:BandLabelAppearance = appearance28.
        THIS-OBJECT:projectTimeGrid:DisplayLayout:GroupByBox:BorderStyle = Infragistics.Win.UIElementBorderStyle:Solid.
        appearance29:BackColor = System.Drawing.SystemColors:ControlLightLight.
        appearance29:BackColor2 = System.Drawing.SystemColors:Control.
        appearance29:BackGradientStyle = Infragistics.Win.GradientStyle:Horizontal.
        appearance29:ForeColor = System.Drawing.SystemColors:GrayText.
        THIS-OBJECT:projectTimeGrid:DisplayLayout:GroupByBox:PromptAppearance = appearance29.
        THIS-OBJECT:projectTimeGrid:DisplayLayout:MaxColScrollRegions = 1.
        THIS-OBJECT:projectTimeGrid:DisplayLayout:MaxRowScrollRegions = 1.
        appearance30:BackColor = System.Drawing.SystemColors:Window.
        appearance30:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:projectTimeGrid:DisplayLayout:Override:ActiveCellAppearance = appearance30.
        appearance31:BackColor = System.Drawing.SystemColors:Highlight.
        appearance31:ForeColor = System.Drawing.SystemColors:HighlightText.
        THIS-OBJECT:projectTimeGrid:DisplayLayout:Override:ActiveRowAppearance = appearance31.
        THIS-OBJECT:projectTimeGrid:DisplayLayout:Override:BorderStyleCell = Infragistics.Win.UIElementBorderStyle:Dotted.
        THIS-OBJECT:projectTimeGrid:DisplayLayout:Override:BorderStyleRow = Infragistics.Win.UIElementBorderStyle:Dotted.
        appearance32:BackColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:projectTimeGrid:DisplayLayout:Override:CardAreaAppearance = appearance32.
        appearance33:BorderColor = System.Drawing.Color:Silver.
        appearance33:TextTrimming = Infragistics.Win.TextTrimming:EllipsisCharacter.
        THIS-OBJECT:projectTimeGrid:DisplayLayout:Override:CellAppearance = appearance33.
        THIS-OBJECT:projectTimeGrid:DisplayLayout:Override:CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction:EditAndSelectText.
        THIS-OBJECT:projectTimeGrid:DisplayLayout:Override:CellPadding = 0.
        appearance34:BackColor = System.Drawing.SystemColors:Control.
        appearance34:BackColor2 = System.Drawing.SystemColors:ControlDark.
        appearance34:BackGradientAlignment = Infragistics.Win.GradientAlignment:Element.
        appearance34:BackGradientStyle = Infragistics.Win.GradientStyle:Horizontal.
        appearance34:BorderColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:projectTimeGrid:DisplayLayout:Override:GroupByRowAppearance = appearance34.
        appearance35:TextHAlignAsString = "Left".
        THIS-OBJECT:projectTimeGrid:DisplayLayout:Override:HeaderAppearance = appearance35.
        THIS-OBJECT:projectTimeGrid:DisplayLayout:Override:HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction:SortMulti.
        THIS-OBJECT:projectTimeGrid:DisplayLayout:Override:HeaderStyle = Infragistics.Win.HeaderStyle:WindowsXPCommand.
        appearance36:BackColor = System.Drawing.SystemColors:Window.
        appearance36:BorderColor = System.Drawing.Color:Silver.
        THIS-OBJECT:projectTimeGrid:DisplayLayout:Override:RowAppearance = appearance36.
        THIS-OBJECT:projectTimeGrid:DisplayLayout:Override:RowSelectors = Infragistics.Win.DefaultableBoolean:False.
        appearance37:BackColor = System.Drawing.SystemColors:ControlLight.
        THIS-OBJECT:projectTimeGrid:DisplayLayout:Override:TemplateAddRowAppearance = appearance37.
        THIS-OBJECT:projectTimeGrid:DisplayLayout:ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds:ScrollToFill.
        THIS-OBJECT:projectTimeGrid:DisplayLayout:ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle:Immediate.
        THIS-OBJECT:projectTimeGrid:Font = NEW System.Drawing.Font("Microsoft Sans Serif", Progress.Util.CastUtil:ToSingle(10), System.Drawing.FontStyle:Regular, System.Drawing.GraphicsUnit:Point, System.Convert:ToByte(0)).
        THIS-OBJECT:projectTimeGrid:Location = NEW System.Drawing.Point(416, 181).
        THIS-OBJECT:projectTimeGrid:Name = "projectTimeGrid".
        THIS-OBJECT:projectTimeGrid:Size = NEW System.Drawing.Size(539, 197).
        THIS-OBJECT:projectTimeGrid:TabIndex = 13.
        THIS-OBJECT:projectTimeGrid:Text = "projectTimeGrid".
        /*  */
        /* filterStartDate */
        /*  */
        THIS-OBJECT:filterStartDate:DateButtons:Add(dateButton3).
        THIS-OBJECT:filterStartDate:Location = NEW System.Drawing.Point(416, 384).
        THIS-OBJECT:filterStartDate:Name = "filterStartDate".
        THIS-OBJECT:filterStartDate:NonAutoSizeHeight = 22.
        THIS-OBJECT:filterStartDate:Size = NEW System.Drawing.Size(121, 21).
        THIS-OBJECT:filterStartDate:TabIndex = 14.
        /*  */
        /* filterStopDate */
        /*  */
        THIS-OBJECT:filterStopDate:DateButtons:Add(dateButton4).
        THIS-OBJECT:filterStopDate:Location = NEW System.Drawing.Point(543, 384).
        THIS-OBJECT:filterStopDate:Name = "filterStopDate".
        THIS-OBJECT:filterStopDate:NonAutoSizeHeight = 22.
        THIS-OBJECT:filterStopDate:Size = NEW System.Drawing.Size(121, 21).
        THIS-OBJECT:filterStopDate:TabIndex = 15.
        /*  */
        /* BtnCostDateFilter */
        /*  */
        THIS-OBJECT:BtnCostDateFilter:Location = NEW System.Drawing.Point(694, 384).
        THIS-OBJECT:BtnCostDateFilter:Name = "BtnCostDateFilter".
        THIS-OBJECT:BtnCostDateFilter:Size = NEW System.Drawing.Size(86, 23).
        THIS-OBJECT:BtnCostDateFilter:TabIndex = 16.
        THIS-OBJECT:BtnCostDateFilter:Text = "Filter Dates".
        THIS-OBJECT:BtnCostDateFilter:Click:Subscribe(THIS-OBJECT:BtnCostDateFilter_Click).
        /*  */
        /* btnSave */
        /*  */
        THIS-OBJECT:btnSave:Location = NEW System.Drawing.Point(846, 384).
        THIS-OBJECT:btnSave:Name = "btnSave".
        THIS-OBJECT:btnSave:Size = NEW System.Drawing.Size(109, 36).
        THIS-OBJECT:btnSave:TabIndex = 17.
        THIS-OBJECT:btnSave:Text = "Save Changes".
        THIS-OBJECT:btnSave:Click:Subscribe(THIS-OBJECT:btnSave_Click).
        /* 
        'UltraChart' properties's serialization: Since 'ChartType' changes the way axes look,
        'ChartType' must be persisted ahead of any Axes change made in design time.
         */
        THIS-OBJECT:ultraChart1:ChartType = Infragistics.UltraChart.Shared.Styles.ChartType:AreaChart.
        /*  */
        /* ultraChart1 */
        /*  */
        THIS-OBJECT:ultraChart1:Axis:BackColor = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(255)), System.Convert:ToInt32(System.Convert:ToByte(248)), System.Convert:ToInt32(System.Convert:ToByte(220))).
        paintElement1:ElementType = Infragistics.UltraChart.Shared.Styles.PaintElementType:None.
        paintElement1:Fill = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(255)), System.Convert:ToInt32(System.Convert:ToByte(248)), System.Convert:ToInt32(System.Convert:ToByte(220))).
        THIS-OBJECT:ultraChart1:Axis:PE = paintElement1.
        THIS-OBJECT:ultraChart1:Axis:X:Labels:Font = NEW System.Drawing.Font("Verdana", Progress.Util.CastUtil:ToSingle(7)).
        THIS-OBJECT:ultraChart1:Axis:X:Labels:FontColor = System.Drawing.Color:DimGray.
        THIS-OBJECT:ultraChart1:Axis:X:Labels:HorizontalAlign = System.Drawing.StringAlignment:Near.
        THIS-OBJECT:ultraChart1:Axis:X:Labels:ItemFormatString = "Month".
        THIS-OBJECT:ultraChart1:Axis:X:Labels:Layout:Behavior = Infragistics.UltraChart.Shared.Styles.AxisLabelLayoutBehaviors:Auto.
        THIS-OBJECT:ultraChart1:Axis:X:Labels:Orientation = Infragistics.UltraChart.Shared.Styles.TextOrientation:VerticalLeftFacing.
        THIS-OBJECT:ultraChart1:Axis:X:Labels:SeriesLabels:Font = NEW System.Drawing.Font("Verdana", Progress.Util.CastUtil:ToSingle(7)).
        THIS-OBJECT:ultraChart1:Axis:X:Labels:SeriesLabels:FontColor = System.Drawing.Color:DimGray.
        THIS-OBJECT:ultraChart1:Axis:X:Labels:SeriesLabels:FormatString = "".
        THIS-OBJECT:ultraChart1:Axis:X:Labels:SeriesLabels:HorizontalAlign = System.Drawing.StringAlignment:Near.
        THIS-OBJECT:ultraChart1:Axis:X:Labels:SeriesLabels:Layout:Behavior = Infragistics.UltraChart.Shared.Styles.AxisLabelLayoutBehaviors:Auto.
        THIS-OBJECT:ultraChart1:Axis:X:Labels:SeriesLabels:Orientation = Infragistics.UltraChart.Shared.Styles.TextOrientation:VerticalLeftFacing.
        THIS-OBJECT:ultraChart1:Axis:X:Labels:SeriesLabels:VerticalAlign = System.Drawing.StringAlignment:Center.
        THIS-OBJECT:ultraChart1:Axis:X:Labels:SeriesLabels:Visible = TRUE.
        THIS-OBJECT:ultraChart1:Axis:X:Labels:VerticalAlign = System.Drawing.StringAlignment:Center.
        THIS-OBJECT:ultraChart1:Axis:X:Labels:Visible = TRUE.
        THIS-OBJECT:ultraChart1:Axis:X:LineThickness = 1.
        THIS-OBJECT:ultraChart1:Axis:X:MajorGridLines:AlphaLevel = System.Convert:ToByte(255).
        THIS-OBJECT:ultraChart1:Axis:X:MajorGridLines:Color = System.Drawing.Color:Gainsboro.
        THIS-OBJECT:ultraChart1:Axis:X:MajorGridLines:DrawStyle = Infragistics.UltraChart.Shared.Styles.LineDrawStyle:Dot.
        THIS-OBJECT:ultraChart1:Axis:X:MajorGridLines:Visible = TRUE.
        THIS-OBJECT:ultraChart1:Axis:X:Margin:Far:Value = Progress.Util.CastUtil:ToDouble("15564202").
        THIS-OBJECT:ultraChart1:Axis:X:Margin:Near:Value = Progress.Util.CastUtil:ToDouble("15564202").
        THIS-OBJECT:ultraChart1:Axis:X:MinorGridLines:AlphaLevel = System.Convert:ToByte(255).
        THIS-OBJECT:ultraChart1:Axis:X:MinorGridLines:Color = System.Drawing.Color:LightGray.
        THIS-OBJECT:ultraChart1:Axis:X:MinorGridLines:DrawStyle = Infragistics.UltraChart.Shared.Styles.LineDrawStyle:Dot.
        THIS-OBJECT:ultraChart1:Axis:X:MinorGridLines:Visible = TRUE.
        THIS-OBJECT:ultraChart1:Axis:X:TickmarkStyle = Infragistics.UltraChart.Shared.Styles.AxisTickStyle:Smart.
        THIS-OBJECT:ultraChart1:Axis:X:Visible = TRUE.
        THIS-OBJECT:ultraChart1:Axis:X2:Labels:Font = NEW System.Drawing.Font("Verdana", Progress.Util.CastUtil:ToSingle(7)).
        THIS-OBJECT:ultraChart1:Axis:X2:Labels:FontColor = System.Drawing.Color:Gray.
        THIS-OBJECT:ultraChart1:Axis:X2:Labels:HorizontalAlign = System.Drawing.StringAlignment:Far.
        THIS-OBJECT:ultraChart1:Axis:X2:Labels:ItemFormatString = "<ITEM_LABEL>".
        THIS-OBJECT:ultraChart1:Axis:X2:Labels:Layout:Behavior = Infragistics.UltraChart.Shared.Styles.AxisLabelLayoutBehaviors:Auto.
        THIS-OBJECT:ultraChart1:Axis:X2:Labels:Orientation = Infragistics.UltraChart.Shared.Styles.TextOrientation:VerticalLeftFacing.
        THIS-OBJECT:ultraChart1:Axis:X2:Labels:SeriesLabels:Font = NEW System.Drawing.Font("Verdana", Progress.Util.CastUtil:ToSingle(7)).
        THIS-OBJECT:ultraChart1:Axis:X2:Labels:SeriesLabels:FontColor = System.Drawing.Color:Gray.
        THIS-OBJECT:ultraChart1:Axis:X2:Labels:SeriesLabels:FormatString = "".
        THIS-OBJECT:ultraChart1:Axis:X2:Labels:SeriesLabels:HorizontalAlign = System.Drawing.StringAlignment:Far.
        THIS-OBJECT:ultraChart1:Axis:X2:Labels:SeriesLabels:Layout:Behavior = Infragistics.UltraChart.Shared.Styles.AxisLabelLayoutBehaviors:Auto.
        THIS-OBJECT:ultraChart1:Axis:X2:Labels:SeriesLabels:Orientation = Infragistics.UltraChart.Shared.Styles.TextOrientation:VerticalLeftFacing.
        THIS-OBJECT:ultraChart1:Axis:X2:Labels:SeriesLabels:VerticalAlign = System.Drawing.StringAlignment:Center.
        THIS-OBJECT:ultraChart1:Axis:X2:Labels:SeriesLabels:Visible = TRUE.
        THIS-OBJECT:ultraChart1:Axis:X2:Labels:VerticalAlign = System.Drawing.StringAlignment:Center.
        THIS-OBJECT:ultraChart1:Axis:X2:Labels:Visible = FALSE.
        THIS-OBJECT:ultraChart1:Axis:X2:LineThickness = 1.
        THIS-OBJECT:ultraChart1:Axis:X2:MajorGridLines:AlphaLevel = System.Convert:ToByte(255).
        THIS-OBJECT:ultraChart1:Axis:X2:MajorGridLines:Color = System.Drawing.Color:Gainsboro.
        THIS-OBJECT:ultraChart1:Axis:X2:MajorGridLines:DrawStyle = Infragistics.UltraChart.Shared.Styles.LineDrawStyle:Dot.
        THIS-OBJECT:ultraChart1:Axis:X2:MajorGridLines:Visible = TRUE.
        THIS-OBJECT:ultraChart1:Axis:X2:MinorGridLines:AlphaLevel = System.Convert:ToByte(255).
        THIS-OBJECT:ultraChart1:Axis:X2:MinorGridLines:Color = System.Drawing.Color:LightGray.
        THIS-OBJECT:ultraChart1:Axis:X2:MinorGridLines:DrawStyle = Infragistics.UltraChart.Shared.Styles.LineDrawStyle:Dot.
        THIS-OBJECT:ultraChart1:Axis:X2:MinorGridLines:Visible = FALSE.
        THIS-OBJECT:ultraChart1:Axis:X2:TickmarkStyle = Infragistics.UltraChart.Shared.Styles.AxisTickStyle:Smart.
        THIS-OBJECT:ultraChart1:Axis:X2:Visible = FALSE.
        THIS-OBJECT:ultraChart1:Axis:Y:Extent = 28.
        THIS-OBJECT:ultraChart1:Axis:Y:Labels:Font = NEW System.Drawing.Font("Verdana", Progress.Util.CastUtil:ToSingle(7)).
        THIS-OBJECT:ultraChart1:Axis:Y:Labels:FontColor = System.Drawing.Color:DimGray.
        THIS-OBJECT:ultraChart1:Axis:Y:Labels:HorizontalAlign = System.Drawing.StringAlignment:Far.
        THIS-OBJECT:ultraChart1:Axis:Y:Labels:ItemFormatString = "<DATA_VALUE:00.##>".
        THIS-OBJECT:ultraChart1:Axis:Y:Labels:Layout:Behavior = Infragistics.UltraChart.Shared.Styles.AxisLabelLayoutBehaviors:Auto.
        THIS-OBJECT:ultraChart1:Axis:Y:Labels:Orientation = Infragistics.UltraChart.Shared.Styles.TextOrientation:Horizontal.
        THIS-OBJECT:ultraChart1:Axis:Y:Labels:SeriesLabels:Font = NEW System.Drawing.Font("Verdana", Progress.Util.CastUtil:ToSingle(7)).
        THIS-OBJECT:ultraChart1:Axis:Y:Labels:SeriesLabels:FontColor = System.Drawing.Color:DimGray.
        THIS-OBJECT:ultraChart1:Axis:Y:Labels:SeriesLabels:FormatString = "".
        THIS-OBJECT:ultraChart1:Axis:Y:Labels:SeriesLabels:HorizontalAlign = System.Drawing.StringAlignment:Far.
        THIS-OBJECT:ultraChart1:Axis:Y:Labels:SeriesLabels:Layout:Behavior = Infragistics.UltraChart.Shared.Styles.AxisLabelLayoutBehaviors:Auto.
        THIS-OBJECT:ultraChart1:Axis:Y:Labels:SeriesLabels:Orientation = Infragistics.UltraChart.Shared.Styles.TextOrientation:Horizontal.
        THIS-OBJECT:ultraChart1:Axis:Y:Labels:SeriesLabels:VerticalAlign = System.Drawing.StringAlignment:Center.
        THIS-OBJECT:ultraChart1:Axis:Y:Labels:SeriesLabels:Visible = TRUE.
        THIS-OBJECT:ultraChart1:Axis:Y:Labels:VerticalAlign = System.Drawing.StringAlignment:Center.
        THIS-OBJECT:ultraChart1:Axis:Y:Labels:Visible = TRUE.
        THIS-OBJECT:ultraChart1:Axis:Y:LineThickness = 1.
        THIS-OBJECT:ultraChart1:Axis:Y:MajorGridLines:AlphaLevel = System.Convert:ToByte(255).
        THIS-OBJECT:ultraChart1:Axis:Y:MajorGridLines:Color = System.Drawing.Color:Gainsboro.
        THIS-OBJECT:ultraChart1:Axis:Y:MajorGridLines:DrawStyle = Infragistics.UltraChart.Shared.Styles.LineDrawStyle:Dot.
        THIS-OBJECT:ultraChart1:Axis:Y:MajorGridLines:Visible = TRUE.
        THIS-OBJECT:ultraChart1:Axis:Y:Margin:Near:Value = Progress.Util.CastUtil:ToDouble("36363636").
        THIS-OBJECT:ultraChart1:Axis:Y:MinorGridLines:AlphaLevel = System.Convert:ToByte(255).
        THIS-OBJECT:ultraChart1:Axis:Y:MinorGridLines:Color = System.Drawing.Color:LightGray.
        THIS-OBJECT:ultraChart1:Axis:Y:MinorGridLines:DrawStyle = Infragistics.UltraChart.Shared.Styles.LineDrawStyle:Dot.
        THIS-OBJECT:ultraChart1:Axis:Y:MinorGridLines:Visible = FALSE.
        THIS-OBJECT:ultraChart1:Axis:Y:TickmarkInterval = Progress.Util.CastUtil:ToDouble("40").
        THIS-OBJECT:ultraChart1:Axis:Y:TickmarkStyle = Infragistics.UltraChart.Shared.Styles.AxisTickStyle:Smart.
        THIS-OBJECT:ultraChart1:Axis:Y:Visible = TRUE.
        THIS-OBJECT:ultraChart1:Axis:Y2:Labels:Font = NEW System.Drawing.Font("Verdana", Progress.Util.CastUtil:ToSingle(7)).
        THIS-OBJECT:ultraChart1:Axis:Y2:Labels:FontColor = System.Drawing.Color:Gray.
        THIS-OBJECT:ultraChart1:Axis:Y2:Labels:HorizontalAlign = System.Drawing.StringAlignment:Near.
        THIS-OBJECT:ultraChart1:Axis:Y2:Labels:ItemFormatString = "<DATA_VALUE:00.##>".
        THIS-OBJECT:ultraChart1:Axis:Y2:Labels:Layout:Behavior = Infragistics.UltraChart.Shared.Styles.AxisLabelLayoutBehaviors:Auto.
        THIS-OBJECT:ultraChart1:Axis:Y2:Labels:Orientation = Infragistics.UltraChart.Shared.Styles.TextOrientation:Horizontal.
        THIS-OBJECT:ultraChart1:Axis:Y2:Labels:SeriesLabels:Font = NEW System.Drawing.Font("Verdana", Progress.Util.CastUtil:ToSingle(7)).
        THIS-OBJECT:ultraChart1:Axis:Y2:Labels:SeriesLabels:FontColor = System.Drawing.Color:Gray.
        THIS-OBJECT:ultraChart1:Axis:Y2:Labels:SeriesLabels:FormatString = "".
        THIS-OBJECT:ultraChart1:Axis:Y2:Labels:SeriesLabels:HorizontalAlign = System.Drawing.StringAlignment:Near.
        THIS-OBJECT:ultraChart1:Axis:Y2:Labels:SeriesLabels:Layout:Behavior = Infragistics.UltraChart.Shared.Styles.AxisLabelLayoutBehaviors:Auto.
        THIS-OBJECT:ultraChart1:Axis:Y2:Labels:SeriesLabels:Orientation = Infragistics.UltraChart.Shared.Styles.TextOrientation:Horizontal.
        THIS-OBJECT:ultraChart1:Axis:Y2:Labels:SeriesLabels:VerticalAlign = System.Drawing.StringAlignment:Center.
        THIS-OBJECT:ultraChart1:Axis:Y2:Labels:SeriesLabels:Visible = TRUE.
        THIS-OBJECT:ultraChart1:Axis:Y2:Labels:VerticalAlign = System.Drawing.StringAlignment:Center.
        THIS-OBJECT:ultraChart1:Axis:Y2:Labels:Visible = FALSE.
        THIS-OBJECT:ultraChart1:Axis:Y2:LineThickness = 1.
        THIS-OBJECT:ultraChart1:Axis:Y2:MajorGridLines:AlphaLevel = System.Convert:ToByte(255).
        THIS-OBJECT:ultraChart1:Axis:Y2:MajorGridLines:Color = System.Drawing.Color:Gainsboro.
        THIS-OBJECT:ultraChart1:Axis:Y2:MajorGridLines:DrawStyle = Infragistics.UltraChart.Shared.Styles.LineDrawStyle:Dot.
        THIS-OBJECT:ultraChart1:Axis:Y2:MajorGridLines:Visible = TRUE.
        THIS-OBJECT:ultraChart1:Axis:Y2:MinorGridLines:AlphaLevel = System.Convert:ToByte(255).
        THIS-OBJECT:ultraChart1:Axis:Y2:MinorGridLines:Color = System.Drawing.Color:LightGray.
        THIS-OBJECT:ultraChart1:Axis:Y2:MinorGridLines:DrawStyle = Infragistics.UltraChart.Shared.Styles.LineDrawStyle:Dot.
        THIS-OBJECT:ultraChart1:Axis:Y2:MinorGridLines:Visible = FALSE.
        THIS-OBJECT:ultraChart1:Axis:Y2:TickmarkInterval = Progress.Util.CastUtil:ToDouble("40").
        THIS-OBJECT:ultraChart1:Axis:Y2:TickmarkStyle = Infragistics.UltraChart.Shared.Styles.AxisTickStyle:Smart.
        THIS-OBJECT:ultraChart1:Axis:Y2:Visible = FALSE.
        THIS-OBJECT:ultraChart1:Axis:Z:Labels:Font = NEW System.Drawing.Font("Verdana", Progress.Util.CastUtil:ToSingle(7)).
        THIS-OBJECT:ultraChart1:Axis:Z:Labels:FontColor = System.Drawing.Color:DimGray.
        THIS-OBJECT:ultraChart1:Axis:Z:Labels:HorizontalAlign = System.Drawing.StringAlignment:Near.
        THIS-OBJECT:ultraChart1:Axis:Z:Labels:ItemFormatString = "".
        THIS-OBJECT:ultraChart1:Axis:Z:Labels:Layout:Behavior = Infragistics.UltraChart.Shared.Styles.AxisLabelLayoutBehaviors:Auto.
        THIS-OBJECT:ultraChart1:Axis:Z:Labels:Orientation = Infragistics.UltraChart.Shared.Styles.TextOrientation:Horizontal.
        THIS-OBJECT:ultraChart1:Axis:Z:Labels:SeriesLabels:Font = NEW System.Drawing.Font("Verdana", Progress.Util.CastUtil:ToSingle(7)).
        THIS-OBJECT:ultraChart1:Axis:Z:Labels:SeriesLabels:FontColor = System.Drawing.Color:DimGray.
        THIS-OBJECT:ultraChart1:Axis:Z:Labels:SeriesLabels:HorizontalAlign = System.Drawing.StringAlignment:Near.
        THIS-OBJECT:ultraChart1:Axis:Z:Labels:SeriesLabels:Layout:Behavior = Infragistics.UltraChart.Shared.Styles.AxisLabelLayoutBehaviors:Auto.
        THIS-OBJECT:ultraChart1:Axis:Z:Labels:SeriesLabels:Orientation = Infragistics.UltraChart.Shared.Styles.TextOrientation:Horizontal.
        THIS-OBJECT:ultraChart1:Axis:Z:Labels:SeriesLabels:VerticalAlign = System.Drawing.StringAlignment:Center.
        THIS-OBJECT:ultraChart1:Axis:Z:Labels:SeriesLabels:Visible = TRUE.
        THIS-OBJECT:ultraChart1:Axis:Z:Labels:VerticalAlign = System.Drawing.StringAlignment:Center.
        THIS-OBJECT:ultraChart1:Axis:Z:Labels:Visible = FALSE.
        THIS-OBJECT:ultraChart1:Axis:Z:LineThickness = 1.
        THIS-OBJECT:ultraChart1:Axis:Z:MajorGridLines:AlphaLevel = System.Convert:ToByte(255).
        THIS-OBJECT:ultraChart1:Axis:Z:MajorGridLines:Color = System.Drawing.Color:Gainsboro.
        THIS-OBJECT:ultraChart1:Axis:Z:MajorGridLines:DrawStyle = Infragistics.UltraChart.Shared.Styles.LineDrawStyle:Dot.
        THIS-OBJECT:ultraChart1:Axis:Z:MajorGridLines:Visible = TRUE.
        THIS-OBJECT:ultraChart1:Axis:Z:MinorGridLines:AlphaLevel = System.Convert:ToByte(255).
        THIS-OBJECT:ultraChart1:Axis:Z:MinorGridLines:Color = System.Drawing.Color:LightGray.
        THIS-OBJECT:ultraChart1:Axis:Z:MinorGridLines:DrawStyle = Infragistics.UltraChart.Shared.Styles.LineDrawStyle:Dot.
        THIS-OBJECT:ultraChart1:Axis:Z:MinorGridLines:Visible = FALSE.
        THIS-OBJECT:ultraChart1:Axis:Z:TickmarkStyle = Infragistics.UltraChart.Shared.Styles.AxisTickStyle:Smart.
        THIS-OBJECT:ultraChart1:Axis:Z:Visible = FALSE.
        THIS-OBJECT:ultraChart1:Axis:Z2:Labels:Font = NEW System.Drawing.Font("Verdana", Progress.Util.CastUtil:ToSingle(7)).
        THIS-OBJECT:ultraChart1:Axis:Z2:Labels:FontColor = System.Drawing.Color:Gray.
        THIS-OBJECT:ultraChart1:Axis:Z2:Labels:HorizontalAlign = System.Drawing.StringAlignment:Near.
        THIS-OBJECT:ultraChart1:Axis:Z2:Labels:ItemFormatString = "".
        THIS-OBJECT:ultraChart1:Axis:Z2:Labels:Layout:Behavior = Infragistics.UltraChart.Shared.Styles.AxisLabelLayoutBehaviors:Auto.
        THIS-OBJECT:ultraChart1:Axis:Z2:Labels:Orientation = Infragistics.UltraChart.Shared.Styles.TextOrientation:Horizontal.
        THIS-OBJECT:ultraChart1:Axis:Z2:Labels:SeriesLabels:Font = NEW System.Drawing.Font("Verdana", Progress.Util.CastUtil:ToSingle(7)).
        THIS-OBJECT:ultraChart1:Axis:Z2:Labels:SeriesLabels:FontColor = System.Drawing.Color:Gray.
        THIS-OBJECT:ultraChart1:Axis:Z2:Labels:SeriesLabels:HorizontalAlign = System.Drawing.StringAlignment:Near.
        THIS-OBJECT:ultraChart1:Axis:Z2:Labels:SeriesLabels:Layout:Behavior = Infragistics.UltraChart.Shared.Styles.AxisLabelLayoutBehaviors:Auto.
        THIS-OBJECT:ultraChart1:Axis:Z2:Labels:SeriesLabels:Orientation = Infragistics.UltraChart.Shared.Styles.TextOrientation:Horizontal.
        THIS-OBJECT:ultraChart1:Axis:Z2:Labels:SeriesLabels:VerticalAlign = System.Drawing.StringAlignment:Center.
        THIS-OBJECT:ultraChart1:Axis:Z2:Labels:SeriesLabels:Visible = TRUE.
        THIS-OBJECT:ultraChart1:Axis:Z2:Labels:VerticalAlign = System.Drawing.StringAlignment:Center.
        THIS-OBJECT:ultraChart1:Axis:Z2:Labels:Visible = FALSE.
        THIS-OBJECT:ultraChart1:Axis:Z2:LineThickness = 1.
        THIS-OBJECT:ultraChart1:Axis:Z2:MajorGridLines:AlphaLevel = System.Convert:ToByte(255).
        THIS-OBJECT:ultraChart1:Axis:Z2:MajorGridLines:Color = System.Drawing.Color:Gainsboro.
        THIS-OBJECT:ultraChart1:Axis:Z2:MajorGridLines:DrawStyle = Infragistics.UltraChart.Shared.Styles.LineDrawStyle:Dot.
        THIS-OBJECT:ultraChart1:Axis:Z2:MajorGridLines:Visible = TRUE.
        THIS-OBJECT:ultraChart1:Axis:Z2:MinorGridLines:AlphaLevel = System.Convert:ToByte(255).
        THIS-OBJECT:ultraChart1:Axis:Z2:MinorGridLines:Color = System.Drawing.Color:LightGray.
        THIS-OBJECT:ultraChart1:Axis:Z2:MinorGridLines:DrawStyle = Infragistics.UltraChart.Shared.Styles.LineDrawStyle:Dot.
        THIS-OBJECT:ultraChart1:Axis:Z2:MinorGridLines:Visible = FALSE.
        THIS-OBJECT:ultraChart1:Axis:Z2:TickmarkStyle = Infragistics.UltraChart.Shared.Styles.AxisTickStyle:Smart.
        THIS-OBJECT:ultraChart1:Axis:Z2:Visible = FALSE.
        THIS-OBJECT:ultraChart1:BackgroundImageLayout = System.Windows.Forms.ImageLayout:Center.
        THIS-OBJECT:ultraChart1:ColorModel:AlphaLevel = System.Convert:ToByte(150).
        THIS-OBJECT:ultraChart1:ColorModel:ColorBegin = System.Drawing.Color:Pink.
        THIS-OBJECT:ultraChart1:ColorModel:ColorEnd = System.Drawing.Color:DarkRed.
        THIS-OBJECT:ultraChart1:ColorModel:ModelStyle = Infragistics.UltraChart.Shared.Styles.ColorModels:CustomLinear.
        THIS-OBJECT:ultraChart1:Data:DataMember = "ttCost".
        THIS-OBJECT:ultraChart1:DataMember = "ttCost".
        THIS-OBJECT:ultraChart1:DataSource = THIS-OBJECT:bsProjectProjectTime.
        THIS-OBJECT:ultraChart1:Effects:Effects:Add(gradientEffect1).
        THIS-OBJECT:ultraChart1:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:ultraChart1:Name = "ultraChart1".
        THIS-OBJECT:ultraChart1:Size = NEW System.Drawing.Size(400, 300).
        THIS-OBJECT:ultraChart1:TabIndex = 0.
        THIS-OBJECT:ultraChart1:TitleTop:Text = "Cost per month".
        THIS-OBJECT:ultraChart1:Tooltips:HighlightFillColor = System.Drawing.Color:DimGray.
        THIS-OBJECT:ultraChart1:Tooltips:HighlightOutlineColor = System.Drawing.Color:DarkGray.
        /*  */
        /* projectProjectTimeCostForm */
        /*  */
        THIS-OBJECT:AutoSize = TRUE.
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(1099, 622).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:btnSave).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:BtnCostDateFilter).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:filterStopDate).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:filterStartDate).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:projectTimeGrid).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:costGrid).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:LabelCustomer).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:LabelDueDate).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:LabelTeam).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:LabelStartDate).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:teamEditor).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:calendarStopDate).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:calendarStartDate).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:CustomerEditor).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:labelProjectDescription).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:ultraGrid1).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:projectDescriptionEditor).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:labelProjectName).
        THIS-OBJECT:DataBindings:Add(NEW System.Windows.Forms.Binding("Text", THIS-OBJECT:bsProjectProjectTime, "project_description", TRUE)).
        THIS-OBJECT:Name = "projectProjectTimeCostForm".
        THIS-OBJECT:Text = "Project overview and maintenance".
        CAST(THIS-OBJECT:bsProjectProjectTime, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:projectDescriptionEditor, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:ultraGrid1, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:CustomerEditor, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:calendarStartDate, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:calendarStopDate, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:teamEditor, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:costGrid, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:projectTimeGrid, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:filterStartDate, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:filterStopDate, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:ultraChart1, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:ResumeLayout(FALSE).
        THIS-OBJECT:PerformLayout().
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
	END METHOD.


    @VisualDesigner.
	METHOD PRIVATE VOID projectDescriptionEditor_Leave( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):

        projectDescriptionEditor:DataBindings["Text"]:WriteValue().

	END METHOD.



	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID teamEditor_Leave( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		
		teamEditor:DataBindings["Text"]:WriteValue().

	END METHOD.






	DESTRUCTOR PUBLIC projectProjectTimeCostForm ( ):

	END DESTRUCTOR.

END CLASS.