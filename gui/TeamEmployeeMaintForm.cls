 
 /*------------------------------------------------------------------------
    File        : EmployeeMaintForm
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : Administrator
    Created     : Fri Jan 29 09:39:09 UTC 2016
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.
USING Infragistics.Win.UltraWinGrid.UltraGrid FROM ASSEMBLY.
USING Infragistics.Win.UltraWinGrid.ColumnsCollection FROM ASSEMBLY.
USING Infragistics.Win.ValueList FROM ASSEMBLY.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS gui.TeamEmployeeMaintForm INHERITS gui.baseForm: 
	
    DEFINE PRIVATE VARIABLE bsEmployees AS Progress.Data.BindingSource NO-UNDO.
    DEFINE PRIVATE VARIABLE bsTeam AS Progress.Data.BindingSource NO-UNDO.
    DEFINE PRIVATE VARIABLE btnEditMembers AS Infragistics.Win.Misc.UltraButton NO-UNDO.
    DEFINE PRIVATE VARIABLE btnFilter AS Infragistics.Win.Misc.UltraButton NO-UNDO.
    DEFINE PRIVATE VARIABLE btnSave AS Infragistics.Win.Misc.UltraButton NO-UNDO.
    DEFINE PRIVATE VARIABLE m_EmployeeMaintForm_Toolbars_Dock_Area_Top AS Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea NO-UNDO.
    DEFINE PRIVATE VARIABLE m_EmployeeMaintForm_Toolbars_Dock_Area_Right AS Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea NO-UNDO.
    DEFINE PRIVATE VARIABLE m_EmployeeMaintForm_Toolbars_Dock_Area_Left AS Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea NO-UNDO.
    DEFINE PRIVATE VARIABLE m_EmployeeMaintForm_Toolbars_Dock_Area_Bottom AS Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea NO-UNDO.
	DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE txtTeamName AS Infragistics.Win.UltraWinEditors.UltraTextEditor NO-UNDO.
    DEFINE PRIVATE VARIABLE txtTeamNameFilter AS Infragistics.Win.UltraWinEditors.UltraTextEditor NO-UNDO.
    DEFINE PRIVATE VARIABLE ugTeam AS Infragistics.Win.UltraWinGrid.UltraGrid NO-UNDO.
    DEFINE PRIVATE VARIABLE ugEmployees AS Infragistics.Win.UltraWinGrid.UltraGrid NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraLabel2 AS Infragistics.Win.Misc.UltraLabel NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraLabel1 AS Infragistics.Win.Misc.UltraLabel NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraLabel5 AS Infragistics.Win.Misc.UltraLabel NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraLabel4 AS Infragistics.Win.Misc.UltraLabel NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraLabel3 AS Infragistics.Win.Misc.UltraLabel NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraPanel2 AS Infragistics.Win.Misc.UltraPanel NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraSplitter2 AS Infragistics.Win.Misc.UltraSplitter NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraPanel1 AS Infragistics.Win.Misc.UltraPanel NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraTabPageControl1 AS Infragistics.Win.UltraWinTabControl.UltraTabPageControl NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraTabPageControl2 AS Infragistics.Win.UltraWinTabControl.UltraTabPageControl NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraTabSharedControlsPage1 AS Infragistics.Win.UltraWinTabControl.UltraTabSharedControlsPage NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraTabControl1 AS Infragistics.Win.UltraWinTabControl.UltraTabControl NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraSplitter1 AS Infragistics.Win.Misc.UltraSplitter NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraToolbarsManager1 AS Infragistics.Win.UltraWinToolbars.UltraToolbarsManager NO-UNDO.
    DEFINE PRIVATE VARIABLE EmployeeMaintForm_Fill_Panel AS Infragistics.Win.Misc.UltraPanel NO-UNDO.

    DEFINE PRIVATE VARIABLE unTeamId AS Infragistics.Win.UltraWinEditors.UltraNumericEditor NO-UNDO.
    DEFINE VARIABLE objTeam AS gui.teamModel NO-UNDO.
    DEFINE VARIABLE objEmployeesForTeam AS gui.employeesForTeamModel NO-UNDO.
    DEFINE VARIABLE objRole AS gui.roleModel NO-UNDO.
    DEFINE PRIVATE VARIABLE unTeamIDFilter AS Infragistics.Win.UltraWinEditors.UltraNumericEditor NO-UNDO.
    DEFINE PRIVATE VARIABLE employeeGridRow AS INTEGER INITIAL 0 NO-UNDO.

		
	CONSTRUCTOR PUBLIC TeamEmployeeMaintForm (  ):
		
		
        SUPER().
        InitializeComponent().
        
        enableTools("Init").
        
        objRole = NEW gui.roleModel().
        objTeam = NEW gui.teamModel().
        objEmployeesForTeam = NEW gui.employeesForTeamModel().
        
        bsTeam:HANDLE = objTeam:getTeam().

        bsEmployees:HANDLE = objEmployeesForTeam:getEmployeeHandle().

        updateEmployeeList(INPUT unTeamId:VALUE:ToString()).
        
        DEFINE VARIABLE objColumn AS ColumnsCollection NO-UNDO.
        DEFINE VARIABLE objValueList AS ValueList NO-UNDO.
    
        objValueList = NEW ValueList().
        objValueList:ValueListItems:Add(0, "Not Selected").
        objRole:getValueList(INPUT-OUTPUT objValueList).

        objColumn = ugEmployees:DisplayLayout:Bands["ttEmployee_team"]:Columns.
        objColumn["role_id"]:valuelist = objValueList.

             
        THIS-OBJECT:ComponentsCollection:ADD(THIS-OBJECT:components).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.

	END CONSTRUCTOR.


	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID btnEditMembers_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		
		DEFINE VARIABLE objAlocate AS gui.employeeAllocation.
		
		objAlocate = NEW gui.employeeAllocation(INPUT unTeamId:VALUE:ToString()).

        objAlocate:Visible=TRUE.
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID btnFilter_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		
		objTeam:clearFilter().
		
		IF txtTeamNameFilter:TEXT <> "" THEN

		  objTeam:addFilter(INPUT "team_name", INPUT "BEGINS", INPUT txtTeamNameFilter:TEXT).

        IF unTeamIDFilter:VALUE:ToString() <> "0" THEN
             objTeam:addFilter(INPUT "team_id", INPUT "EQ", INPUT unTeamIDFilter:VALUE:ToString()).
   
    
        objTeam:getTeam().

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID btnSave_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		
        objEmployeesForTeam:saveRowChanges().
        btnSave:ENABLED = FALSE.
        objEmployeesForTeam:getEmployee().
        IF employeeGridRow NE 0 THEN 
        DO:
            ugEmployees:Rows[employeeGridRow]:Activated = TRUE.
            employeeGridRow = 0.
        END.

	END METHOD.

	METHOD PRIVATE VOID InitializeComponent(  ):
		
        /* NOTE: The following method is automatically generated.
        
        We strongly suggest that the contents of this method only be modified using the
        Visual Designer to avoid any incompatible modifications.
        
        Modifying the contents of this method using a code editor will invalidate any support for this file. */
        THIS-OBJECT:components = NEW System.ComponentModel.Container().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE tableDesc1 AS Progress.Data.TableDesc NO-UNDO.
        tableDesc1 = NEW Progress.Data.TableDesc("ttTeam").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance1 AS Infragistics.Win.Appearance NO-UNDO.
        appearance1 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridBand1 AS Infragistics.Win.UltraWinGrid.UltraGridBand NO-UNDO.
        ultraGridBand1 = NEW Infragistics.Win.UltraWinGrid.UltraGridBand("ttEmployee_team", -1).
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn9 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn9 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("employee_id").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn10 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn10 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("team_id").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn11 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn11 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("employee_team_id").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn3 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn3 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("role_id").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn4 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn4 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("employee_cost").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn7 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn7 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("role_name").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn8 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn8 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("role_cost").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn1 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn1 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("employee_name").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn2 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn2 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("department_name").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance2 AS Infragistics.Win.Appearance NO-UNDO.
        appearance2 = NEW Infragistics.Win.Appearance().
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
        DEFINE VARIABLE tableDesc2 AS Progress.Data.TableDesc NO-UNDO.
        tableDesc2 = NEW Progress.Data.TableDesc("ttEmployee_team").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ribbonTab1 AS Infragistics.Win.UltraWinToolbars.RibbonTab NO-UNDO.
        ribbonTab1 = NEW Infragistics.Win.UltraWinToolbars.RibbonTab("ribbon1").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ribbonGroup1 AS Infragistics.Win.UltraWinToolbars.RibbonGroup NO-UNDO.
        ribbonGroup1 = NEW Infragistics.Win.UltraWinToolbars.RibbonGroup("ribbonGroup1").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool3 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool3 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("New").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool11 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool11 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Edit").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool5 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool5 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Delete").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool6 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool6 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Save").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool1 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool1 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Cancel").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool2 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool2 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("New").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance31 AS Infragistics.Win.Appearance NO-UNDO.
        appearance31 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE resources AS Progress.Util.ResourceManager NO-UNDO.
        resources = NEW Progress.Util.ResourceManager("gui.TeamEmployeeMaintForm").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance32 AS Infragistics.Win.Appearance NO-UNDO.
        appearance32 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool7 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool7 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Update").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool8 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool8 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Delete").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance33 AS Infragistics.Win.Appearance NO-UNDO.
        appearance33 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance34 AS Infragistics.Win.Appearance NO-UNDO.
        appearance34 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool9 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool9 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Save").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance35 AS Infragistics.Win.Appearance NO-UNDO.
        appearance35 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance36 AS Infragistics.Win.Appearance NO-UNDO.
        appearance36 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool10 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool10 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Cancel").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance37 AS Infragistics.Win.Appearance NO-UNDO.
        appearance37 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance38 AS Infragistics.Win.Appearance NO-UNDO.
        appearance38 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool12 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool12 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Edit").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance39 AS Infragistics.Win.Appearance NO-UNDO.
        appearance39 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance40 AS Infragistics.Win.Appearance NO-UNDO.
        appearance40 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance13 AS Infragistics.Win.Appearance NO-UNDO.
        appearance13 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridBand2 AS Infragistics.Win.UltraWinGrid.UltraGridBand NO-UNDO.
        ultraGridBand2 = NEW Infragistics.Win.UltraWinGrid.UltraGridBand("ttTeam", -1).
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn5 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn5 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("team_id").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn6 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn6 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("team_name").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance14 AS Infragistics.Win.Appearance NO-UNDO.
        appearance14 = NEW Infragistics.Win.Appearance().
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
        DEFINE VARIABLE appearance27 AS Infragistics.Win.Appearance NO-UNDO.
        appearance27 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraTab1 AS Infragistics.Win.UltraWinTabControl.UltraTab NO-UNDO.
        ultraTab1 = NEW Infragistics.Win.UltraWinTabControl.UltraTab().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance28 AS Infragistics.Win.Appearance NO-UNDO.
        appearance28 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance29 AS Infragistics.Win.Appearance NO-UNDO.
        appearance29 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraTab2 AS Infragistics.Win.UltraWinTabControl.UltraTab NO-UNDO.
        ultraTab2 = NEW Infragistics.Win.UltraWinTabControl.UltraTab().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance30 AS Infragistics.Win.Appearance NO-UNDO.
        appearance30 = NEW Infragistics.Win.Appearance().
        THIS-OBJECT:ultraTabPageControl1 = NEW Infragistics.Win.UltraWinTabControl.UltraTabPageControl().
        THIS-OBJECT:txtTeamName = NEW Infragistics.Win.UltraWinEditors.UltraTextEditor().
        THIS-OBJECT:bsTeam = NEW Progress.Data.BindingSource(THIS-OBJECT:components).
        THIS-OBJECT:unTeamId = NEW Infragistics.Win.UltraWinEditors.UltraNumericEditor().
        THIS-OBJECT:ultraLabel2 = NEW Infragistics.Win.Misc.UltraLabel().
        THIS-OBJECT:ultraLabel1 = NEW Infragistics.Win.Misc.UltraLabel().
        THIS-OBJECT:ultraTabPageControl2 = NEW Infragistics.Win.UltraWinTabControl.UltraTabPageControl().
        THIS-OBJECT:ugEmployees = NEW Infragistics.Win.UltraWinGrid.UltraGrid().
        THIS-OBJECT:bsEmployees = NEW Progress.Data.BindingSource(THIS-OBJECT:components).
        THIS-OBJECT:ultraPanel2 = NEW Infragistics.Win.Misc.UltraPanel().
        THIS-OBJECT:btnSave = NEW Infragistics.Win.Misc.UltraButton().
        THIS-OBJECT:btnEditMembers = NEW Infragistics.Win.Misc.UltraButton().
        THIS-OBJECT:ultraToolbarsManager1 = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsManager(THIS-OBJECT:components).
        THIS-OBJECT:EmployeeMaintForm_Fill_Panel = NEW Infragistics.Win.Misc.UltraPanel().
        THIS-OBJECT:ugTeam = NEW Infragistics.Win.UltraWinGrid.UltraGrid().
        THIS-OBJECT:ultraSplitter2 = NEW Infragistics.Win.Misc.UltraSplitter().
        THIS-OBJECT:ultraPanel1 = NEW Infragistics.Win.Misc.UltraPanel().
        THIS-OBJECT:unTeamIDFilter = NEW Infragistics.Win.UltraWinEditors.UltraNumericEditor().
        THIS-OBJECT:ultraLabel4 = NEW Infragistics.Win.Misc.UltraLabel().
        THIS-OBJECT:txtTeamNameFilter = NEW Infragistics.Win.UltraWinEditors.UltraTextEditor().
        THIS-OBJECT:btnFilter = NEW Infragistics.Win.Misc.UltraButton().
        THIS-OBJECT:ultraLabel5 = NEW Infragistics.Win.Misc.UltraLabel().
        THIS-OBJECT:ultraLabel3 = NEW Infragistics.Win.Misc.UltraLabel().
        THIS-OBJECT:ultraSplitter1 = NEW Infragistics.Win.Misc.UltraSplitter().
        THIS-OBJECT:ultraTabControl1 = NEW Infragistics.Win.UltraWinTabControl.UltraTabControl().
        THIS-OBJECT:ultraTabSharedControlsPage1 = NEW Infragistics.Win.UltraWinTabControl.UltraTabSharedControlsPage().
        THIS-OBJECT:m_EmployeeMaintForm_Toolbars_Dock_Area_Left = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea().
        THIS-OBJECT:m_EmployeeMaintForm_Toolbars_Dock_Area_Right = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea().
        THIS-OBJECT:m_EmployeeMaintForm_Toolbars_Dock_Area_Top = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea().
        THIS-OBJECT:m_EmployeeMaintForm_Toolbars_Dock_Area_Bottom = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea().
        THIS-OBJECT:ultraTabPageControl1:SuspendLayout().
        CAST(THIS-OBJECT:txtTeamName, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:bsTeam, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:unTeamId, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:ultraTabPageControl2:SuspendLayout().
        CAST(THIS-OBJECT:ugEmployees, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:bsEmployees, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:ultraPanel2:ClientArea:SuspendLayout().
        THIS-OBJECT:ultraPanel2:SuspendLayout().
        CAST(THIS-OBJECT:ultraToolbarsManager1, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:EmployeeMaintForm_Fill_Panel:ClientArea:SuspendLayout().
        THIS-OBJECT:EmployeeMaintForm_Fill_Panel:SuspendLayout().
        CAST(THIS-OBJECT:ugTeam, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:ultraPanel1:ClientArea:SuspendLayout().
        THIS-OBJECT:ultraPanel1:SuspendLayout().
        CAST(THIS-OBJECT:unTeamIDFilter, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:txtTeamNameFilter, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:ultraTabControl1, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:ultraTabControl1:SuspendLayout().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* ultraTabPageControl1 */
        /*  */
        THIS-OBJECT:ultraTabPageControl1:Controls:Add(THIS-OBJECT:txtTeamName).
        THIS-OBJECT:ultraTabPageControl1:Controls:Add(THIS-OBJECT:unTeamId).
        THIS-OBJECT:ultraTabPageControl1:Controls:Add(THIS-OBJECT:ultraLabel2).
        THIS-OBJECT:ultraTabPageControl1:Controls:Add(THIS-OBJECT:ultraLabel1).
        THIS-OBJECT:ultraTabPageControl1:Location = NEW System.Drawing.Point(2, 24).
        THIS-OBJECT:ultraTabPageControl1:Name = "ultraTabPageControl1".
        THIS-OBJECT:ultraTabPageControl1:Size = NEW System.Drawing.Size(641, 179).
        /*  */
        /* txtTeamName */
        /*  */
        THIS-OBJECT:txtTeamName:DataBindings:Add(NEW System.Windows.Forms.Binding("Value", THIS-OBJECT:bsTeam, "team_name", TRUE)).
        THIS-OBJECT:txtTeamName:Location = NEW System.Drawing.Point(96, 40).
        THIS-OBJECT:txtTeamName:Name = "txtTeamName".
        THIS-OBJECT:txtTeamName:Size = NEW System.Drawing.Size(215, 21).
        THIS-OBJECT:txtTeamName:TabIndex = 3.
        /*  */
        /* bsTeam */
        /*  */
        THIS-OBJECT:bsTeam:MaxDataGuess = 0.
        THIS-OBJECT:bsTeam:NoLOBs = FALSE.
        THIS-OBJECT:bsTeam:Position = 0.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar0 AS "Progress.Data.TableDesc[]" NO-UNDO.
        arrayvar0 = NEW "Progress.Data.TableDesc[]"(0).
        tableDesc1:ChildTables = arrayvar0.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar1 AS Progress.Data.ColumnPropDesc EXTENT 2 NO-UNDO.
        arrayvar1[1] = NEW Progress.Data.ColumnPropDesc("team_id", "Team Id", Progress.Data.DataType:INTEGER).
        arrayvar1[2] = NEW Progress.Data.ColumnPropDesc("team_name", "Team Name", Progress.Data.DataType:CHARACTER).
        tableDesc1:Columns = arrayvar1.
        THIS-OBJECT:bsTeam:TableSchema = tableDesc1.
        /*  */
        /* unTeamId */
        /*  */
        THIS-OBJECT:unTeamId:DataBindings:Add(NEW System.Windows.Forms.Binding("Value", THIS-OBJECT:bsTeam, "team_id", TRUE)).
        THIS-OBJECT:unTeamId:Enabled = FALSE.
        THIS-OBJECT:unTeamId:Location = NEW System.Drawing.Point(96, 10).
        THIS-OBJECT:unTeamId:Name = "unTeamId".
        THIS-OBJECT:unTeamId:PromptChar = ' '.
        THIS-OBJECT:unTeamId:Size = NEW System.Drawing.Size(97, 21).
        THIS-OBJECT:unTeamId:TabIndex = 2.
        /*  */
        /* ultraLabel2 */
        /*  */
        THIS-OBJECT:ultraLabel2:Location = NEW System.Drawing.Point(5, 44).
        THIS-OBJECT:ultraLabel2:Name = "ultraLabel2".
        THIS-OBJECT:ultraLabel2:Size = NEW System.Drawing.Size(100, 23).
        THIS-OBJECT:ultraLabel2:TabIndex = 1.
        THIS-OBJECT:ultraLabel2:Text = "Team Name".
        /*  */
        /* ultraLabel1 */
        /*  */
        THIS-OBJECT:ultraLabel1:Location = NEW System.Drawing.Point(7, 14).
        THIS-OBJECT:ultraLabel1:Name = "ultraLabel1".
        THIS-OBJECT:ultraLabel1:Size = NEW System.Drawing.Size(100, 23).
        THIS-OBJECT:ultraLabel1:TabIndex = 0.
        THIS-OBJECT:ultraLabel1:Text = "Team ID".
        /*  */
        /* ultraTabPageControl2 */
        /*  */
        THIS-OBJECT:ultraTabPageControl2:Controls:Add(THIS-OBJECT:ugEmployees).
        THIS-OBJECT:ultraTabPageControl2:Controls:Add(THIS-OBJECT:ultraPanel2).
        THIS-OBJECT:ultraTabPageControl2:Location = NEW System.Drawing.Point(-10000, -10000).
        THIS-OBJECT:ultraTabPageControl2:Name = "ultraTabPageControl2".
        THIS-OBJECT:ultraTabPageControl2:Size = NEW System.Drawing.Size(641, 179).
        /*  */
        /* ugEmployees */
        /*  */
        THIS-OBJECT:ugEmployees:DataSource = THIS-OBJECT:bsEmployees.
        appearance1:BackColor = System.Drawing.SystemColors:Window.
        appearance1:BorderColor = System.Drawing.SystemColors:InactiveCaption.
        THIS-OBJECT:ugEmployees:DisplayLayout:Appearance = appearance1.
        ultraGridColumn9:CellActivation = Infragistics.Win.UltraWinGrid.Activation:NoEdit.
        ultraGridColumn9:Header:VisiblePosition = 0.
        ultraGridColumn9:Hidden = TRUE.
        ultraGridColumn10:CellActivation = Infragistics.Win.UltraWinGrid.Activation:NoEdit.
        ultraGridColumn10:Header:VisiblePosition = 1.
        ultraGridColumn10:Hidden = TRUE.
        ultraGridColumn11:CellActivation = Infragistics.Win.UltraWinGrid.Activation:NoEdit.
        ultraGridColumn11:Header:VisiblePosition = 2.
        ultraGridColumn11:Hidden = TRUE.
        ultraGridColumn3:Header:Caption = "Role Name".
        ultraGridColumn3:Header:VisiblePosition = 6.
        ultraGridColumn4:CellActivation = Infragistics.Win.UltraWinGrid.Activation:NoEdit.
        ultraGridColumn4:Header:VisiblePosition = 5.
        ultraGridColumn7:CellActivation = Infragistics.Win.UltraWinGrid.Activation:NoEdit.
        ultraGridColumn7:Header:VisiblePosition = 7.
        ultraGridColumn7:Hidden = TRUE.
        ultraGridColumn8:CellActivation = Infragistics.Win.UltraWinGrid.Activation:NoEdit.
        ultraGridColumn8:Header:VisiblePosition = 8.
        ultraGridColumn1:CellActivation = Infragistics.Win.UltraWinGrid.Activation:NoEdit.
        ultraGridColumn1:Header:VisiblePosition = 3.
        ultraGridColumn2:CellActivation = Infragistics.Win.UltraWinGrid.Activation:NoEdit.
        ultraGridColumn2:Header:VisiblePosition = 4.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar2 AS System.Object EXTENT 9 NO-UNDO.
        arrayvar2[1] = ultraGridColumn9.
        arrayvar2[2] = ultraGridColumn10.
        arrayvar2[3] = ultraGridColumn11.
        arrayvar2[4] = ultraGridColumn3.
        arrayvar2[5] = ultraGridColumn4.
        arrayvar2[6] = ultraGridColumn7.
        arrayvar2[7] = ultraGridColumn8.
        arrayvar2[8] = ultraGridColumn1.
        arrayvar2[9] = ultraGridColumn2.
        ultraGridBand1:Columns:AddRange(arrayvar2).
        THIS-OBJECT:ugEmployees:DisplayLayout:BandsSerializer:Add(ultraGridBand1).
        THIS-OBJECT:ugEmployees:DisplayLayout:BorderStyle = Infragistics.Win.UIElementBorderStyle:Solid.
        THIS-OBJECT:ugEmployees:DisplayLayout:CaptionVisible = Infragistics.Win.DefaultableBoolean:False.
        appearance2:BackColor = System.Drawing.SystemColors:ActiveBorder.
        appearance2:BackColor2 = System.Drawing.SystemColors:ControlDark.
        appearance2:BackGradientStyle = Infragistics.Win.GradientStyle:Vertical.
        appearance2:BorderColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ugEmployees:DisplayLayout:GroupByBox:Appearance = appearance2.
        appearance3:ForeColor = System.Drawing.SystemColors:GrayText.
        THIS-OBJECT:ugEmployees:DisplayLayout:GroupByBox:BandLabelAppearance = appearance3.
        THIS-OBJECT:ugEmployees:DisplayLayout:GroupByBox:BorderStyle = Infragistics.Win.UIElementBorderStyle:Solid.
        appearance4:BackColor = System.Drawing.SystemColors:ControlLightLight.
        appearance4:BackColor2 = System.Drawing.SystemColors:Control.
        appearance4:BackGradientStyle = Infragistics.Win.GradientStyle:Horizontal.
        appearance4:ForeColor = System.Drawing.SystemColors:GrayText.
        THIS-OBJECT:ugEmployees:DisplayLayout:GroupByBox:PromptAppearance = appearance4.
        THIS-OBJECT:ugEmployees:DisplayLayout:MaxColScrollRegions = 1.
        THIS-OBJECT:ugEmployees:DisplayLayout:MaxRowScrollRegions = 1.
        appearance5:BackColor = System.Drawing.SystemColors:Window.
        appearance5:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:ugEmployees:DisplayLayout:Override:ActiveCellAppearance = appearance5.
        appearance6:BackColor = System.Drawing.SystemColors:Highlight.
        appearance6:ForeColor = System.Drawing.SystemColors:HighlightText.
        THIS-OBJECT:ugEmployees:DisplayLayout:Override:ActiveRowAppearance = appearance6.
        THIS-OBJECT:ugEmployees:DisplayLayout:Override:BorderStyleCell = Infragistics.Win.UIElementBorderStyle:Dotted.
        THIS-OBJECT:ugEmployees:DisplayLayout:Override:BorderStyleRow = Infragistics.Win.UIElementBorderStyle:Dotted.
        appearance7:BackColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ugEmployees:DisplayLayout:Override:CardAreaAppearance = appearance7.
        appearance8:BorderColor = System.Drawing.Color:Silver.
        appearance8:TextTrimming = Infragistics.Win.TextTrimming:EllipsisCharacter.
        THIS-OBJECT:ugEmployees:DisplayLayout:Override:CellAppearance = appearance8.
        THIS-OBJECT:ugEmployees:DisplayLayout:Override:CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction:EditAndSelectText.
        THIS-OBJECT:ugEmployees:DisplayLayout:Override:CellPadding = 0.
        appearance9:BackColor = System.Drawing.SystemColors:Control.
        appearance9:BackColor2 = System.Drawing.SystemColors:ControlDark.
        appearance9:BackGradientAlignment = Infragistics.Win.GradientAlignment:Element.
        appearance9:BackGradientStyle = Infragistics.Win.GradientStyle:Horizontal.
        appearance9:BorderColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ugEmployees:DisplayLayout:Override:GroupByRowAppearance = appearance9.
        appearance10:TextHAlignAsString = "Left".
        THIS-OBJECT:ugEmployees:DisplayLayout:Override:HeaderAppearance = appearance10.
        THIS-OBJECT:ugEmployees:DisplayLayout:Override:HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction:SortMulti.
        THIS-OBJECT:ugEmployees:DisplayLayout:Override:HeaderStyle = Infragistics.Win.HeaderStyle:WindowsXPCommand.
        appearance11:BackColor = System.Drawing.SystemColors:Window.
        appearance11:BorderColor = System.Drawing.Color:Silver.
        THIS-OBJECT:ugEmployees:DisplayLayout:Override:RowAppearance = appearance11.
        THIS-OBJECT:ugEmployees:DisplayLayout:Override:RowSelectors = Infragistics.Win.DefaultableBoolean:False.
        appearance12:BackColor = System.Drawing.SystemColors:ControlLight.
        THIS-OBJECT:ugEmployees:DisplayLayout:Override:TemplateAddRowAppearance = appearance12.
        THIS-OBJECT:ugEmployees:DisplayLayout:ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds:ScrollToFill.
        THIS-OBJECT:ugEmployees:DisplayLayout:ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle:Immediate.
        THIS-OBJECT:ugEmployees:DisplayLayout:ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand:OutlookGroupBy.
        THIS-OBJECT:ugEmployees:Dock = System.Windows.Forms.DockStyle:Fill.
        THIS-OBJECT:ugEmployees:Font = NEW System.Drawing.Font("Microsoft Sans Serif", Progress.Util.CastUtil:ToSingle(8.25), System.Drawing.FontStyle:Regular, System.Drawing.GraphicsUnit:Point, System.Convert:ToByte(0)).
        THIS-OBJECT:ugEmployees:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:ugEmployees:Name = "ugEmployees".
        THIS-OBJECT:ugEmployees:Size = NEW System.Drawing.Size(641, 141).
        THIS-OBJECT:ugEmployees:TabIndex = 0.
        THIS-OBJECT:ugEmployees:Text = "ugEmployees".
        THIS-OBJECT:ugEmployees:AfterEnterEditMode:Subscribe(THIS-OBJECT:ugEmployees_AfterEnterEditMode).
        THIS-OBJECT:ugEmployees:BeforeRowUpdate:Subscribe(THIS-OBJECT:ugEmployees_BeforeRowUpdate).
        /*  */
        /* bsEmployees */
        /*  */
        THIS-OBJECT:bsEmployees:MaxDataGuess = 0.
        THIS-OBJECT:bsEmployees:NoLOBs = FALSE.
        THIS-OBJECT:bsEmployees:Position = 0.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar3 AS "Progress.Data.TableDesc[]" NO-UNDO.
        arrayvar3 = NEW "Progress.Data.TableDesc[]"(0).
        tableDesc2:ChildTables = arrayvar3.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar4 AS Progress.Data.ColumnPropDesc EXTENT 9 NO-UNDO.
        arrayvar4[1] = NEW Progress.Data.ColumnPropDesc("employee_id", "Employee Id", Progress.Data.DataType:INTEGER).
        arrayvar4[2] = NEW Progress.Data.ColumnPropDesc("team_id", "Team Id", Progress.Data.DataType:INTEGER).
        arrayvar4[3] = NEW Progress.Data.ColumnPropDesc("employee_team_id", "Employee Team Id", Progress.Data.DataType:INTEGER).
        arrayvar4[4] = NEW Progress.Data.ColumnPropDesc("role_id", "Role Id", Progress.Data.DataType:INTEGER).
        arrayvar4[5] = NEW Progress.Data.ColumnPropDesc("employee_cost", "Employee Cost", Progress.Data.DataType:DECIMAL).
        arrayvar4[6] = NEW Progress.Data.ColumnPropDesc("role_name", "Role Name", Progress.Data.DataType:CHARACTER).
        arrayvar4[7] = NEW Progress.Data.ColumnPropDesc("role_cost", "Role Cost", Progress.Data.DataType:DECIMAL).
        arrayvar4[8] = NEW Progress.Data.ColumnPropDesc("employee_name", "Employee Name", Progress.Data.DataType:CHARACTER).
        arrayvar4[9] = NEW Progress.Data.ColumnPropDesc("department_name", "Department Name", Progress.Data.DataType:CHARACTER).
        tableDesc2:Columns = arrayvar4.
        THIS-OBJECT:bsEmployees:TableSchema = tableDesc2.
        /*  */
        /* ultraPanel2 */
        /*  */
        /*  */
        /* ultraPanel2.ClientArea */
        /*  */
        THIS-OBJECT:ultraPanel2:ClientArea:Controls:Add(THIS-OBJECT:btnSave).
        THIS-OBJECT:ultraPanel2:ClientArea:Controls:Add(THIS-OBJECT:btnEditMembers).
        THIS-OBJECT:ultraPanel2:Dock = System.Windows.Forms.DockStyle:Bottom.
        THIS-OBJECT:ultraPanel2:Location = NEW System.Drawing.Point(0, 141).
        THIS-OBJECT:ultraPanel2:Name = "ultraPanel2".
        THIS-OBJECT:ultraPanel2:Size = NEW System.Drawing.Size(641, 38).
        THIS-OBJECT:ultraPanel2:TabIndex = 1.
        /*  */
        /* btnSave */
        /*  */
        THIS-OBJECT:btnSave:Enabled = FALSE.
        THIS-OBJECT:btnSave:Location = NEW System.Drawing.Point(411, 9).
        THIS-OBJECT:btnSave:Name = "btnSave".
        THIS-OBJECT:btnSave:Size = NEW System.Drawing.Size(75, 23).
        THIS-OBJECT:btnSave:TabIndex = 1.
        THIS-OBJECT:btnSave:Text = "Save".
        THIS-OBJECT:btnSave:Click:Subscribe(THIS-OBJECT:btnSave_Click).
        /*  */
        /* btnEditMembers */
        /*  */
        DEFINE VARIABLE nestedvar0 AS System.Windows.Forms.AnchorStyles NO-UNDO.
        nestedvar0 = System.Windows.Forms.AnchorStyles:Bottom.
        THIS-OBJECT:btnEditMembers:Anchor = CAST(Progress.Util.EnumHelper:Or(nestedvar0, System.Windows.Forms.AnchorStyles:Right), System.Windows.Forms.AnchorStyles).
        THIS-OBJECT:btnEditMembers:Location = NEW System.Drawing.Point(500, 9).
        THIS-OBJECT:btnEditMembers:Name = "btnEditMembers".
        THIS-OBJECT:btnEditMembers:Size = NEW System.Drawing.Size(135, 23).
        THIS-OBJECT:btnEditMembers:TabIndex = 0.
        THIS-OBJECT:btnEditMembers:Text = "Select Employees".
        THIS-OBJECT:btnEditMembers:Click:Subscribe(THIS-OBJECT:btnEditMembers_Click).
        /*  */
        /* ultraToolbarsManager1 */
        /*  */
        THIS-OBJECT:ultraToolbarsManager1:AlwaysShowMenusExpanded = Infragistics.Win.DefaultableBoolean:False.
        THIS-OBJECT:ultraToolbarsManager1:DesignerFlags = 1.
        THIS-OBJECT:ultraToolbarsManager1:DockWithinContainer = THIS-OBJECT.
        THIS-OBJECT:ultraToolbarsManager1:DockWithinContainerBaseType = Progress.Util.TypeHelper:GetType("Progress.Windows.Form").
        ribbonTab1:Caption = "IO".
        ribbonGroup1:Caption = "Updates".
        buttonTool3:InstanceProps:PreferredSizeOnRibbon = Infragistics.Win.UltraWinToolbars.RibbonToolSize:Large.
        buttonTool11:InstanceProps:PreferredSizeOnRibbon = Infragistics.Win.UltraWinToolbars.RibbonToolSize:Large.
        buttonTool5:InstanceProps:PreferredSizeOnRibbon = Infragistics.Win.UltraWinToolbars.RibbonToolSize:Large.
        buttonTool6:InstanceProps:IsFirstInGroup = TRUE.
        buttonTool6:InstanceProps:PreferredSizeOnRibbon = Infragistics.Win.UltraWinToolbars.RibbonToolSize:Large.
        buttonTool1:InstanceProps:PreferredSizeOnRibbon = Infragistics.Win.UltraWinToolbars.RibbonToolSize:Large.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar5 AS Infragistics.Win.UltraWinToolbars.ToolBase EXTENT 5 NO-UNDO.
        arrayvar5[1] = buttonTool3.
        arrayvar5[2] = buttonTool11.
        arrayvar5[3] = buttonTool5.
        arrayvar5[4] = buttonTool6.
        arrayvar5[5] = buttonTool1.
        ribbonGroup1:Tools:AddRange(arrayvar5).
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar6 AS Infragistics.Win.UltraWinToolbars.RibbonGroup EXTENT 1 NO-UNDO.
        arrayvar6[1] = ribbonGroup1.
        ribbonTab1:Groups:AddRange(arrayvar6).
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar7 AS Infragistics.Win.UltraWinToolbars.RibbonTab EXTENT 1 NO-UNDO.
        arrayvar7[1] = ribbonTab1.
        THIS-OBJECT:ultraToolbarsManager1:Ribbon:NonInheritedRibbonTabs:AddRange(arrayvar7).
        THIS-OBJECT:ultraToolbarsManager1:Ribbon:Visible = TRUE.
        appearance31:Image = CAST(resources:GetObject("appearance31.Image"), System.Object).
        buttonTool2:SharedPropsInternal:AppearancesLarge:Appearance = appearance31.
        appearance32:Image = CAST(resources:GetObject("appearance32.Image"), System.Object).
        buttonTool2:SharedPropsInternal:AppearancesSmall:Appearance = appearance32.
        buttonTool2:SharedPropsInternal:Caption = "New".
        buttonTool2:SharedPropsInternal:Category = "tableio".
        buttonTool7:SharedPropsInternal:Caption = "Edit".
        buttonTool7:SharedPropsInternal:Category = "tableio".
        appearance33:Image = CAST(resources:GetObject("appearance33.Image"), System.Object).
        buttonTool8:SharedPropsInternal:AppearancesLarge:Appearance = appearance33.
        appearance34:Image = CAST(resources:GetObject("appearance34.Image"), System.Object).
        buttonTool8:SharedPropsInternal:AppearancesSmall:Appearance = appearance34.
        buttonTool8:SharedPropsInternal:Caption = "Delete".
        buttonTool8:SharedPropsInternal:Category = "tableio".
        appearance35:Image = CAST(resources:GetObject("appearance35.Image"), System.Object).
        buttonTool9:SharedPropsInternal:AppearancesLarge:Appearance = appearance35.
        appearance36:Image = CAST(resources:GetObject("appearance36.Image"), System.Object).
        buttonTool9:SharedPropsInternal:AppearancesSmall:Appearance = appearance36.
        buttonTool9:SharedPropsInternal:Caption = "Save".
        buttonTool9:SharedPropsInternal:Category = "tableio".
        appearance37:Image = CAST(resources:GetObject("appearance37.Image"), System.Object).
        buttonTool10:SharedPropsInternal:AppearancesLarge:Appearance = appearance37.
        appearance38:Image = CAST(resources:GetObject("appearance38.Image"), System.Object).
        buttonTool10:SharedPropsInternal:AppearancesSmall:Appearance = appearance38.
        buttonTool10:SharedPropsInternal:Caption = "Cancel".
        buttonTool10:SharedPropsInternal:Category = "tableio".
        appearance39:Image = CAST(resources:GetObject("appearance39.Image"), System.Object).
        buttonTool12:SharedPropsInternal:AppearancesLarge:Appearance = appearance39.
        appearance40:Image = CAST(resources:GetObject("appearance40.Image"), System.Object).
        buttonTool12:SharedPropsInternal:AppearancesSmall:Appearance = appearance40.
        buttonTool12:SharedPropsInternal:Caption = "Edit".
        buttonTool12:SharedPropsInternal:Category = "tableio".
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar8 AS Infragistics.Win.UltraWinToolbars.ToolBase EXTENT 6 NO-UNDO.
        arrayvar8[1] = buttonTool2.
        arrayvar8[2] = buttonTool7.
        arrayvar8[3] = buttonTool8.
        arrayvar8[4] = buttonTool9.
        arrayvar8[5] = buttonTool10.
        arrayvar8[6] = buttonTool12.
        THIS-OBJECT:ultraToolbarsManager1:Tools:AddRange(arrayvar8).
        THIS-OBJECT:ultraToolbarsManager1:ToolClick:Subscribe(THIS-OBJECT:ultraToolbarsManager1_ToolClick).
        /*  */
        /* EmployeeMaintForm_Fill_Panel */
        /*  */
        /*  */
        /* EmployeeMaintForm_Fill_Panel.ClientArea */
        /*  */
        THIS-OBJECT:EmployeeMaintForm_Fill_Panel:ClientArea:Controls:Add(THIS-OBJECT:ugTeam).
        THIS-OBJECT:EmployeeMaintForm_Fill_Panel:ClientArea:Controls:Add(THIS-OBJECT:ultraSplitter2).
        THIS-OBJECT:EmployeeMaintForm_Fill_Panel:ClientArea:Controls:Add(THIS-OBJECT:ultraPanel1).
        THIS-OBJECT:EmployeeMaintForm_Fill_Panel:ClientArea:Controls:Add(THIS-OBJECT:ultraSplitter1).
        THIS-OBJECT:EmployeeMaintForm_Fill_Panel:ClientArea:Controls:Add(THIS-OBJECT:ultraTabControl1).
        THIS-OBJECT:EmployeeMaintForm_Fill_Panel:Cursor = System.Windows.Forms.Cursors:Default.
        THIS-OBJECT:EmployeeMaintForm_Fill_Panel:Dock = System.Windows.Forms.DockStyle:Fill.
        THIS-OBJECT:EmployeeMaintForm_Fill_Panel:Location = NEW System.Drawing.Point(4, 148).
        THIS-OBJECT:EmployeeMaintForm_Fill_Panel:Name = "EmployeeMaintForm_Fill_Panel".
        THIS-OBJECT:EmployeeMaintForm_Fill_Panel:Size = NEW System.Drawing.Size(645, 542).
        THIS-OBJECT:EmployeeMaintForm_Fill_Panel:TabIndex = 0.
        /*  */
        /* ugTeam */
        /*  */
        THIS-OBJECT:ugTeam:DataSource = THIS-OBJECT:bsTeam.
        appearance13:BackColor = System.Drawing.Color:White.
        THIS-OBJECT:ugTeam:DisplayLayout:Appearance = appearance13.
        THIS-OBJECT:ugTeam:DisplayLayout:AutoFitStyle = Infragistics.Win.UltraWinGrid.AutoFitStyle:ExtendLastColumn.
        ultraGridColumn5:CellActivation = Infragistics.Win.UltraWinGrid.Activation:NoEdit.
        ultraGridColumn5:Header:VisiblePosition = 0.
        ultraGridColumn6:Header:VisiblePosition = 1.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar9 AS System.Object EXTENT 2 NO-UNDO.
        arrayvar9[1] = ultraGridColumn5.
        arrayvar9[2] = ultraGridColumn6.
        ultraGridBand2:Columns:AddRange(arrayvar9).
        THIS-OBJECT:ugTeam:DisplayLayout:BandsSerializer:Add(ultraGridBand2).
        THIS-OBJECT:ugTeam:DisplayLayout:BorderStyle = Infragistics.Win.UIElementBorderStyle:Solid.
        THIS-OBJECT:ugTeam:DisplayLayout:CaptionVisible = Infragistics.Win.DefaultableBoolean:False.
        appearance14:BackColor = System.Drawing.SystemColors:ActiveBorder.
        appearance14:BackColor2 = System.Drawing.SystemColors:ControlDark.
        appearance14:BackGradientStyle = Infragistics.Win.GradientStyle:Vertical.
        appearance14:BorderColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ugTeam:DisplayLayout:GroupByBox:Appearance = appearance14.
        appearance15:ForeColor = System.Drawing.SystemColors:GrayText.
        THIS-OBJECT:ugTeam:DisplayLayout:GroupByBox:BandLabelAppearance = appearance15.
        THIS-OBJECT:ugTeam:DisplayLayout:GroupByBox:BorderStyle = Infragistics.Win.UIElementBorderStyle:Solid.
        appearance16:BackColor = System.Drawing.SystemColors:ControlLightLight.
        appearance16:BackColor2 = System.Drawing.SystemColors:Control.
        appearance16:BackGradientStyle = Infragistics.Win.GradientStyle:Horizontal.
        appearance16:ForeColor = System.Drawing.SystemColors:GrayText.
        THIS-OBJECT:ugTeam:DisplayLayout:GroupByBox:PromptAppearance = appearance16.
        THIS-OBJECT:ugTeam:DisplayLayout:MaxColScrollRegions = 1.
        THIS-OBJECT:ugTeam:DisplayLayout:MaxRowScrollRegions = 1.
        appearance17:BackColor = System.Drawing.SystemColors:Window.
        appearance17:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:ugTeam:DisplayLayout:Override:ActiveCellAppearance = appearance17.
        appearance18:BackColor = System.Drawing.SystemColors:Highlight.
        appearance18:ForeColor = System.Drawing.SystemColors:HighlightText.
        THIS-OBJECT:ugTeam:DisplayLayout:Override:ActiveRowAppearance = appearance18.
        THIS-OBJECT:ugTeam:DisplayLayout:Override:AllowAddNew = Infragistics.Win.UltraWinGrid.AllowAddNew:No.
        THIS-OBJECT:ugTeam:DisplayLayout:Override:AllowDelete = Infragistics.Win.DefaultableBoolean:False.
        THIS-OBJECT:ugTeam:DisplayLayout:Override:AllowGroupBy = Infragistics.Win.DefaultableBoolean:True.
        THIS-OBJECT:ugTeam:DisplayLayout:Override:AllowUpdate = Infragistics.Win.DefaultableBoolean:False.
        THIS-OBJECT:ugTeam:DisplayLayout:Override:BorderStyleCell = Infragistics.Win.UIElementBorderStyle:None.
        THIS-OBJECT:ugTeam:DisplayLayout:Override:BorderStyleRow = Infragistics.Win.UIElementBorderStyle:Dotted.
        appearance19:BackColor = System.Drawing.Color:Transparent.
        THIS-OBJECT:ugTeam:DisplayLayout:Override:CardAreaAppearance = appearance19.
        appearance20:BorderColor = System.Drawing.Color:Silver.
        appearance20:TextTrimming = Infragistics.Win.TextTrimming:EllipsisCharacter.
        THIS-OBJECT:ugTeam:DisplayLayout:Override:CellAppearance = appearance20.
        THIS-OBJECT:ugTeam:DisplayLayout:Override:CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction:RowSelect.
        THIS-OBJECT:ugTeam:DisplayLayout:Override:CellPadding = 3.
        appearance21:BackColor = System.Drawing.SystemColors:Control.
        appearance21:BackColor2 = System.Drawing.SystemColors:ControlDark.
        appearance21:BackGradientAlignment = Infragistics.Win.GradientAlignment:Element.
        appearance21:BackGradientStyle = Infragistics.Win.GradientStyle:Horizontal.
        appearance21:BorderColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ugTeam:DisplayLayout:Override:GroupByRowAppearance = appearance21.
        appearance22:TextHAlignAsString = "Left".
        THIS-OBJECT:ugTeam:DisplayLayout:Override:HeaderAppearance = appearance22.
        THIS-OBJECT:ugTeam:DisplayLayout:Override:HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction:SortMulti.
        THIS-OBJECT:ugTeam:DisplayLayout:Override:HeaderStyle = Infragistics.Win.HeaderStyle:WindowsXPCommand.
        appearance23:BackColor = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(224)), System.Convert:ToInt32(System.Convert:ToByte(224)), System.Convert:ToInt32(System.Convert:ToByte(224))).
        THIS-OBJECT:ugTeam:DisplayLayout:Override:RowAlternateAppearance = appearance23.
        appearance24:BorderColor = System.Drawing.Color:LightGray.
        appearance24:TextVAlignAsString = "Middle".
        THIS-OBJECT:ugTeam:DisplayLayout:Override:RowAppearance = appearance24.
        THIS-OBJECT:ugTeam:DisplayLayout:Override:RowSelectorHeaderStyle = Infragistics.Win.UltraWinGrid.RowSelectorHeaderStyle:ColumnChooserButton.
        THIS-OBJECT:ugTeam:DisplayLayout:Override:RowSelectors = Infragistics.Win.DefaultableBoolean:True.
        appearance25:BackColor = System.Drawing.Color:LightSteelBlue.
        appearance25:BorderColor = System.Drawing.Color:Black.
        appearance25:ForeColor = System.Drawing.Color:Black.
        THIS-OBJECT:ugTeam:DisplayLayout:Override:SelectedRowAppearance = appearance25.
        THIS-OBJECT:ugTeam:DisplayLayout:Override:SelectTypeCell = Infragistics.Win.UltraWinGrid.SelectType:None.
        THIS-OBJECT:ugTeam:DisplayLayout:Override:SelectTypeCol = Infragistics.Win.UltraWinGrid.SelectType:None.
        THIS-OBJECT:ugTeam:DisplayLayout:Override:SelectTypeGroupByRow = Infragistics.Win.UltraWinGrid.SelectType:None.
        THIS-OBJECT:ugTeam:DisplayLayout:Override:SelectTypeRow = Infragistics.Win.UltraWinGrid.SelectType:Extended.
        appearance26:BackColor = System.Drawing.SystemColors:ControlLight.
        THIS-OBJECT:ugTeam:DisplayLayout:Override:TemplateAddRowAppearance = appearance26.
        THIS-OBJECT:ugTeam:DisplayLayout:RowConnectorStyle = Infragistics.Win.UltraWinGrid.RowConnectorStyle:None.
        THIS-OBJECT:ugTeam:DisplayLayout:ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds:ScrollToFill.
        THIS-OBJECT:ugTeam:DisplayLayout:ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle:Immediate.
        THIS-OBJECT:ugTeam:DisplayLayout:TabNavigation = Infragistics.Win.UltraWinGrid.TabNavigation:NextControlOnLastCell.
        THIS-OBJECT:ugTeam:DisplayLayout:ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand:OutlookGroupBy.
        THIS-OBJECT:ugTeam:Dock = System.Windows.Forms.DockStyle:Fill.
        THIS-OBJECT:ugTeam:Font = NEW System.Drawing.Font("Microsoft Sans Serif", Progress.Util.CastUtil:ToSingle(8.25), System.Drawing.FontStyle:Regular, System.Drawing.GraphicsUnit:Point, System.Convert:ToByte(0)).
        THIS-OBJECT:ugTeam:Location = NEW System.Drawing.Point(0, 6).
        THIS-OBJECT:ugTeam:Name = "ugTeam".
        THIS-OBJECT:ugTeam:Size = NEW System.Drawing.Size(645, 321).
        THIS-OBJECT:ugTeam:TabIndex = 0.
        THIS-OBJECT:ugTeam:Text = "ugTeam".
        THIS-OBJECT:ugTeam:ClickCell:Subscribe(THIS-OBJECT:ugTeam_ClickCell).
        /*  */
        /* ultraSplitter2 */
        /*  */
        THIS-OBJECT:ultraSplitter2:BackColor = System.Drawing.SystemColors:ActiveCaptionText.
        THIS-OBJECT:ultraSplitter2:Dock = System.Windows.Forms.DockStyle:Top.
        THIS-OBJECT:ultraSplitter2:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:ultraSplitter2:Name = "ultraSplitter2".
        THIS-OBJECT:ultraSplitter2:RestoreExtent = 57.
        THIS-OBJECT:ultraSplitter2:Size = NEW System.Drawing.Size(645, 6).
        THIS-OBJECT:ultraSplitter2:TabIndex = 4.
        /*  */
        /* ultraPanel1 */
        /*  */
        /*  */
        /* ultraPanel1.ClientArea */
        /*  */
        THIS-OBJECT:ultraPanel1:ClientArea:Controls:Add(THIS-OBJECT:unTeamIDFilter).
        THIS-OBJECT:ultraPanel1:ClientArea:Controls:Add(THIS-OBJECT:ultraLabel4).
        THIS-OBJECT:ultraPanel1:ClientArea:Controls:Add(THIS-OBJECT:txtTeamNameFilter).
        THIS-OBJECT:ultraPanel1:ClientArea:Controls:Add(THIS-OBJECT:btnFilter).
        THIS-OBJECT:ultraPanel1:ClientArea:Controls:Add(THIS-OBJECT:ultraLabel5).
        THIS-OBJECT:ultraPanel1:ClientArea:Controls:Add(THIS-OBJECT:ultraLabel3).
        THIS-OBJECT:ultraPanel1:Dock = System.Windows.Forms.DockStyle:Top.
        THIS-OBJECT:ultraPanel1:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:ultraPanel1:Name = "ultraPanel1".
        THIS-OBJECT:ultraPanel1:Size = NEW System.Drawing.Size(645, 0).
        THIS-OBJECT:ultraPanel1:TabIndex = 3.
        /*  */
        /* unTeamIDFilter */
        /*  */
        THIS-OBJECT:unTeamIDFilter:Location = NEW System.Drawing.Point(59, 24).
        THIS-OBJECT:unTeamIDFilter:Name = "unTeamIDFilter".
        THIS-OBJECT:unTeamIDFilter:PromptChar = ' '.
        THIS-OBJECT:unTeamIDFilter:Size = NEW System.Drawing.Size(84, 21).
        THIS-OBJECT:unTeamIDFilter:TabIndex = 3.
        THIS-OBJECT:unTeamIDFilter:ValueChanged:Subscribe(THIS-OBJECT:unTeamIDFilter_ValueChanged).
        /*  */
        /* ultraLabel4 */
        /*  */
        THIS-OBJECT:ultraLabel4:Location = NEW System.Drawing.Point(9, 28).
        THIS-OBJECT:ultraLabel4:Name = "ultraLabel4".
        THIS-OBJECT:ultraLabel4:Size = NEW System.Drawing.Size(91, 23).
        THIS-OBJECT:ultraLabel4:TabIndex = 1.
        THIS-OBJECT:ultraLabel4:Text = "Team Id".
        /*  */
        /* txtTeamNameFilter */
        /*  */
        THIS-OBJECT:txtTeamNameFilter:Location = NEW System.Drawing.Point(227, 24).
        THIS-OBJECT:txtTeamNameFilter:Name = "txtTeamNameFilter".
        THIS-OBJECT:txtTeamNameFilter:Size = NEW System.Drawing.Size(261, 21).
        THIS-OBJECT:txtTeamNameFilter:TabIndex = 2.
        /*  */
        /* btnFilter */
        /*  */
        THIS-OBJECT:btnFilter:Location = NEW System.Drawing.Point(543, 23).
        THIS-OBJECT:btnFilter:Name = "btnFilter".
        THIS-OBJECT:btnFilter:Size = NEW System.Drawing.Size(75, 23).
        THIS-OBJECT:btnFilter:TabIndex = 5.
        THIS-OBJECT:btnFilter:Text = "Filter".
        THIS-OBJECT:btnFilter:Click:Subscribe(THIS-OBJECT:btnFilter_Click).
        /*  */
        /* ultraLabel5 */
        /*  */
        THIS-OBJECT:ultraLabel5:Location = NEW System.Drawing.Point(149, 28).
        THIS-OBJECT:ultraLabel5:Name = "ultraLabel5".
        THIS-OBJECT:ultraLabel5:Size = NEW System.Drawing.Size(100, 23).
        THIS-OBJECT:ultraLabel5:TabIndex = 4.
        THIS-OBJECT:ultraLabel5:Text = "Team Name".
        /*  */
        /* ultraLabel3 */
        /*  */
        appearance27:ForeColor = System.Drawing.Color:Blue.
        THIS-OBJECT:ultraLabel3:Appearance = appearance27.
        THIS-OBJECT:ultraLabel3:Font = NEW System.Drawing.Font("Microsoft Sans Serif", Progress.Util.CastUtil:ToSingle(9), System.Drawing.FontStyle:Bold, System.Drawing.GraphicsUnit:Point, System.Convert:ToByte(0)).
        THIS-OBJECT:ultraLabel3:Location = NEW System.Drawing.Point(7, 6).
        THIS-OBJECT:ultraLabel3:Name = "ultraLabel3".
        THIS-OBJECT:ultraLabel3:Size = NEW System.Drawing.Size(100, 26).
        THIS-OBJECT:ultraLabel3:TabIndex = 0.
        THIS-OBJECT:ultraLabel3:Text = "Filters".
        /*  */
        /* ultraSplitter1 */
        /*  */
        THIS-OBJECT:ultraSplitter1:BackColor = System.Drawing.SystemColors:ActiveCaptionText.
        THIS-OBJECT:ultraSplitter1:Dock = System.Windows.Forms.DockStyle:Bottom.
        THIS-OBJECT:ultraSplitter1:Location = NEW System.Drawing.Point(0, 327).
        THIS-OBJECT:ultraSplitter1:Name = "ultraSplitter1".
        THIS-OBJECT:ultraSplitter1:RestoreExtent = 113.
        THIS-OBJECT:ultraSplitter1:Size = NEW System.Drawing.Size(645, 10).
        THIS-OBJECT:ultraSplitter1:TabIndex = 1.
        /*  */
        /* ultraTabControl1 */
        /*  */
        THIS-OBJECT:ultraTabControl1:Controls:Add(THIS-OBJECT:ultraTabSharedControlsPage1).
        THIS-OBJECT:ultraTabControl1:Controls:Add(THIS-OBJECT:ultraTabPageControl1).
        THIS-OBJECT:ultraTabControl1:Controls:Add(THIS-OBJECT:ultraTabPageControl2).
        THIS-OBJECT:ultraTabControl1:Dock = System.Windows.Forms.DockStyle:Bottom.
        THIS-OBJECT:ultraTabControl1:Location = NEW System.Drawing.Point(0, 337).
        THIS-OBJECT:ultraTabControl1:Name = "ultraTabControl1".
        THIS-OBJECT:ultraTabControl1:SharedControlsPage = THIS-OBJECT:ultraTabSharedControlsPage1.
        THIS-OBJECT:ultraTabControl1:Size = NEW System.Drawing.Size(645, 205).
        THIS-OBJECT:ultraTabControl1:TabIndex = 2.
        appearance28:BackColor = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(192)), System.Convert:ToInt32(System.Convert:ToByte(192)), System.Convert:ToInt32(System.Convert:ToByte(255))).
        ultraTab1:ActiveAppearance = appearance28.
        appearance29:BackColor = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(192)), System.Convert:ToInt32(System.Convert:ToByte(192)), System.Convert:ToInt32(System.Convert:ToByte(255))).
        ultraTab1:Appearance = appearance29.
        ultraTab1:Key = "Main".
        ultraTab1:TabPage = THIS-OBJECT:ultraTabPageControl1.
        ultraTab1:Text = "Main".
        appearance30:BackColor = System.Drawing.Color:Silver.
        ultraTab2:Appearance = appearance30.
        ultraTab2:Key = "Members".
        ultraTab2:TabPage = THIS-OBJECT:ultraTabPageControl2.
        ultraTab2:Text = "Members".
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar10 AS Infragistics.Win.UltraWinTabControl.UltraTab EXTENT 2 NO-UNDO.
        arrayvar10[1] = ultraTab1.
        arrayvar10[2] = ultraTab2.
        THIS-OBJECT:ultraTabControl1:Tabs:AddRange(arrayvar10).
        /*  */
        /* ultraTabSharedControlsPage1 */
        /*  */
        THIS-OBJECT:ultraTabSharedControlsPage1:Location = NEW System.Drawing.Point(-10000, -10000).
        THIS-OBJECT:ultraTabSharedControlsPage1:Name = "ultraTabSharedControlsPage1".
        THIS-OBJECT:ultraTabSharedControlsPage1:Size = NEW System.Drawing.Size(641, 179).
        /*  */
        /* m_EmployeeMaintForm_Toolbars_Dock_Area_Left */
        /*  */
        THIS-OBJECT:m_EmployeeMaintForm_Toolbars_Dock_Area_Left:AccessibleRole = System.Windows.Forms.AccessibleRole:Grouping.
        THIS-OBJECT:m_EmployeeMaintForm_Toolbars_Dock_Area_Left:BackColor = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(191)), System.Convert:ToInt32(System.Convert:ToByte(219)), System.Convert:ToInt32(System.Convert:ToByte(255))).
        THIS-OBJECT:m_EmployeeMaintForm_Toolbars_Dock_Area_Left:DockedPosition = Infragistics.Win.UltraWinToolbars.DockedPosition:Left.
        THIS-OBJECT:m_EmployeeMaintForm_Toolbars_Dock_Area_Left:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:m_EmployeeMaintForm_Toolbars_Dock_Area_Left:InitialResizeAreaExtent = 4.
        THIS-OBJECT:m_EmployeeMaintForm_Toolbars_Dock_Area_Left:Location = NEW System.Drawing.Point(0, 148).
        THIS-OBJECT:m_EmployeeMaintForm_Toolbars_Dock_Area_Left:Name = "m_EmployeeMaintForm_Toolbars_Dock_Area_Left".
        THIS-OBJECT:m_EmployeeMaintForm_Toolbars_Dock_Area_Left:Size = NEW System.Drawing.Size(4, 542).
        THIS-OBJECT:m_EmployeeMaintForm_Toolbars_Dock_Area_Left:ToolbarsManager = THIS-OBJECT:ultraToolbarsManager1.
        /*  */
        /* m_EmployeeMaintForm_Toolbars_Dock_Area_Right */
        /*  */
        THIS-OBJECT:m_EmployeeMaintForm_Toolbars_Dock_Area_Right:AccessibleRole = System.Windows.Forms.AccessibleRole:Grouping.
        THIS-OBJECT:m_EmployeeMaintForm_Toolbars_Dock_Area_Right:BackColor = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(191)), System.Convert:ToInt32(System.Convert:ToByte(219)), System.Convert:ToInt32(System.Convert:ToByte(255))).
        THIS-OBJECT:m_EmployeeMaintForm_Toolbars_Dock_Area_Right:DockedPosition = Infragistics.Win.UltraWinToolbars.DockedPosition:Right.
        THIS-OBJECT:m_EmployeeMaintForm_Toolbars_Dock_Area_Right:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:m_EmployeeMaintForm_Toolbars_Dock_Area_Right:InitialResizeAreaExtent = 4.
        THIS-OBJECT:m_EmployeeMaintForm_Toolbars_Dock_Area_Right:Location = NEW System.Drawing.Point(649, 148).
        THIS-OBJECT:m_EmployeeMaintForm_Toolbars_Dock_Area_Right:Name = "m_EmployeeMaintForm_Toolbars_Dock_Area_Right".
        THIS-OBJECT:m_EmployeeMaintForm_Toolbars_Dock_Area_Right:Size = NEW System.Drawing.Size(4, 542).
        THIS-OBJECT:m_EmployeeMaintForm_Toolbars_Dock_Area_Right:ToolbarsManager = THIS-OBJECT:ultraToolbarsManager1.
        /*  */
        /* m_EmployeeMaintForm_Toolbars_Dock_Area_Top */
        /*  */
        THIS-OBJECT:m_EmployeeMaintForm_Toolbars_Dock_Area_Top:AccessibleRole = System.Windows.Forms.AccessibleRole:Grouping.
        THIS-OBJECT:m_EmployeeMaintForm_Toolbars_Dock_Area_Top:BackColor = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(191)), System.Convert:ToInt32(System.Convert:ToByte(219)), System.Convert:ToInt32(System.Convert:ToByte(255))).
        THIS-OBJECT:m_EmployeeMaintForm_Toolbars_Dock_Area_Top:DockedPosition = Infragistics.Win.UltraWinToolbars.DockedPosition:Top.
        THIS-OBJECT:m_EmployeeMaintForm_Toolbars_Dock_Area_Top:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:m_EmployeeMaintForm_Toolbars_Dock_Area_Top:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:m_EmployeeMaintForm_Toolbars_Dock_Area_Top:Name = "m_EmployeeMaintForm_Toolbars_Dock_Area_Top".
        THIS-OBJECT:m_EmployeeMaintForm_Toolbars_Dock_Area_Top:Size = NEW System.Drawing.Size(653, 148).
        THIS-OBJECT:m_EmployeeMaintForm_Toolbars_Dock_Area_Top:ToolbarsManager = THIS-OBJECT:ultraToolbarsManager1.
        /*  */
        /* m_EmployeeMaintForm_Toolbars_Dock_Area_Bottom */
        /*  */
        THIS-OBJECT:m_EmployeeMaintForm_Toolbars_Dock_Area_Bottom:AccessibleRole = System.Windows.Forms.AccessibleRole:Grouping.
        THIS-OBJECT:m_EmployeeMaintForm_Toolbars_Dock_Area_Bottom:BackColor = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(191)), System.Convert:ToInt32(System.Convert:ToByte(219)), System.Convert:ToInt32(System.Convert:ToByte(255))).
        THIS-OBJECT:m_EmployeeMaintForm_Toolbars_Dock_Area_Bottom:DockedPosition = Infragistics.Win.UltraWinToolbars.DockedPosition:Bottom.
        THIS-OBJECT:m_EmployeeMaintForm_Toolbars_Dock_Area_Bottom:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:m_EmployeeMaintForm_Toolbars_Dock_Area_Bottom:InitialResizeAreaExtent = 4.
        THIS-OBJECT:m_EmployeeMaintForm_Toolbars_Dock_Area_Bottom:Location = NEW System.Drawing.Point(0, 690).
        THIS-OBJECT:m_EmployeeMaintForm_Toolbars_Dock_Area_Bottom:Name = "m_EmployeeMaintForm_Toolbars_Dock_Area_Bottom".
        THIS-OBJECT:m_EmployeeMaintForm_Toolbars_Dock_Area_Bottom:Size = NEW System.Drawing.Size(653, 4).
        THIS-OBJECT:m_EmployeeMaintForm_Toolbars_Dock_Area_Bottom:ToolbarsManager = THIS-OBJECT:ultraToolbarsManager1.
        /*  */
        /* TeamEmployeeMaintForm */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(653, 694).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:EmployeeMaintForm_Fill_Panel).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:m_EmployeeMaintForm_Toolbars_Dock_Area_Left).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:m_EmployeeMaintForm_Toolbars_Dock_Area_Right).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:m_EmployeeMaintForm_Toolbars_Dock_Area_Bottom).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:m_EmployeeMaintForm_Toolbars_Dock_Area_Top).
        THIS-OBJECT:Name = "TeamEmployeeMaintForm".
        THIS-OBJECT:Text = "EmployeeMaintForm".
        THIS-OBJECT:Activated:Subscribe(THIS-OBJECT:TeamEmployeeMaintForm_Activated).
        THIS-OBJECT:ultraTabPageControl1:ResumeLayout(FALSE).
        THIS-OBJECT:ultraTabPageControl1:PerformLayout().
        CAST(THIS-OBJECT:txtTeamName, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:bsTeam, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:unTeamId, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:ultraTabPageControl2:ResumeLayout(FALSE).
        CAST(THIS-OBJECT:ugEmployees, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:bsEmployees, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:ultraPanel2:ClientArea:ResumeLayout(FALSE).
        THIS-OBJECT:ultraPanel2:ResumeLayout(FALSE).
        CAST(THIS-OBJECT:ultraToolbarsManager1, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:EmployeeMaintForm_Fill_Panel:ClientArea:ResumeLayout(FALSE).
        THIS-OBJECT:EmployeeMaintForm_Fill_Panel:ResumeLayout(FALSE).
        CAST(THIS-OBJECT:ugTeam, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:ultraPanel1:ClientArea:ResumeLayout(FALSE).
        THIS-OBJECT:ultraPanel1:ClientArea:PerformLayout().
        THIS-OBJECT:ultraPanel1:ResumeLayout(FALSE).
        CAST(THIS-OBJECT:unTeamIDFilter, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:txtTeamNameFilter, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:ultraTabControl1, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:ultraTabControl1:ResumeLayout(FALSE).
        THIS-OBJECT:ResumeLayout(FALSE).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
	END METHOD.


	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID TeamEmployeeMaintForm_Activated( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		
        updateEmployeeList(INPUT unTeamId:VALUE:ToString()).

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID ugEmployees_AfterEnterEditMode( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		
        objEmployeesForTeam:enableEdit().
        btnSave:ENABLED = TRUE.
        employeeGridRow = ugEmployees:ActiveRow:Index.
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID ugEmployees_BeforeRowUpdate( INPUT sender AS System.Object, INPUT e AS Infragistics.Win.UltraWinGrid.CancelableRowEventArgs ):
		
        bsEmployees:Assign().

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID ugTeam_ClickCell( INPUT sender AS System.Object, INPUT e AS Infragistics.Win.UltraWinGrid.ClickCellEventArgs ):

        updateEmployeeList(INPUT e:Cell:Row:GetCellValue("team_id"):ToString()).

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID ultraToolbarsManager1_ToolClick( INPUT sender AS System.Object, INPUT e AS Infragistics.Win.UltraWinToolbars.ToolClickEventArgs ):
	
/*        enableTools(e:Tool:Key).	*/
		CASE e:Tool:Key:
    		WHEN "New"
    		THEN DO:
    		    bsTeam:AddNew().
                objTeam:createRow().
    		END.
    		
            WHEN "Edit"
            THEN DO:
                objTeam:enableEdit().              
            END.
            
            WHEN "Delete"
            THEN DO:
                DEFINE VARIABLE lChoice AS LOGICAL NO-UNDO.
                MESSAGE SUBSTITUTE("Are you sure you want to delete &1", QUOTER(txtTeamName:TEXT))
                    VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO SET lChoice.
                IF lChoice THEN
                DO:
                    objTeam:deleteRow().
                    THIS-OBJECT:ugTeam:Selected:Rows:Clear().
                END.
            END.
            
            WHEN "Save"
            THEN DO:
                txtTeamName:DataBindings["Value"]:WriteValue().
               bsTeam:ASSIGN().
               
                objTeam:saveTeam().
                THIS-OBJECT:ugTeam:Selected:Rows:Clear().
/*                objTeam:getEmployee().*/
            END.
            
            WHEN "Cancel"
            THEN DO:
                objTeam:CancelEdit().
                THIS-OBJECT:ugTeam:Selected:Rows:Clear().
            END.
            
		END CASE.

      enableTools(e:Tool:Key).  
      IF e:Tool:Key EQ "New" OR
         e:Tool:Key EQ "Edit" THEN
      DO:
          THIS-OBJECT:ultraTabControl1:Tabs["Main"]:Selected = TRUE.
        THIS-OBJECT:ActiveControl = txtTeamName.
      END.

	END METHOD.
	
	
    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID enableTools(INPUT ipcAction AS CHARACTER):
        CASE ipcAction:
        WHEN "New" OR WHEN "Edit"
        THEN DO:
            THIS-OBJECT:ultraToolbarsManager1:Tools:Item["New"]:SharedPropsInternal:Enabled = FALSE.
            THIS-OBJECT:ultraToolbarsManager1:Tools:Item["Edit"]:SharedPropsInternal:Enabled = FALSE.
            THIS-OBJECT:ultraToolbarsManager1:Tools:Item["Delete"]:SharedPropsInternal:Enabled = FALSE.
            THIS-OBJECT:ultraToolbarsManager1:Tools:Item["Save"]:SharedPropsInternal:Enabled = TRUE.
            THIS-OBJECT:ultraToolbarsManager1:Tools:Item["Cancel"]:SharedPropsInternal:Enabled = TRUE.
            THIS-OBJECT:txtTeamName:Enabled = TRUE.
            THIS-OBJECT:ugTeam:Enabled = FALSE.
        END.
        WHEN "Save" OR WHEN "Cancel" OR WHEN "Init"
        THEN DO:
            THIS-OBJECT:ultraToolbarsManager1:Tools:Item["New"]:SharedPropsInternal:Enabled = TRUE.
            THIS-OBJECT:ultraToolbarsManager1:Tools:Item["Edit"]:SharedPropsInternal:Enabled = TRUE.
            THIS-OBJECT:ultraToolbarsManager1:Tools:Item["Delete"]:SharedPropsInternal:Enabled = TRUE.
            THIS-OBJECT:ultraToolbarsManager1:Tools:Item["Save"]:SharedPropsInternal:Enabled = FALSE.
            THIS-OBJECT:ultraToolbarsManager1:Tools:Item["Cancel"]:SharedPropsInternal:Enabled = FALSE.
            THIS-OBJECT:txtTeamName:Enabled = FALSE.
             THIS-OBJECT:ugTeam:Enabled = TRUE.
        END.
    END CASE.
    
    END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID unTeamIDFilter_ValueChanged( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		
		RETURN.

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC VOID updateEmployeeList(INPUT team_id AS CHARACTER  ):
        objEmployeesForTeam:setFilter(INPUT "team_id", INPUT "EQ", INPUT  team_id).
        objEmployeesForTeam:getEmployee().


	END METHOD.

	DESTRUCTOR PUBLIC TeamEmployeeMaintForm ( ):

	END DESTRUCTOR.

END CLASS.