 
 /*------------------------------------------------------------------------
    File        : employeeAllocation
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : Administrator
    Created     : Mon Feb 01 15:27:52 UTC 2016
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.
USING Infragistics.Win.UltraWinGrid.UltraGrid FROM ASSEMBLY.
USING Infragistics.Win.UltraWinGrid.ColumnsCollection FROM ASSEMBLY.
USING Infragistics.Win.ValueList FROM ASSEMBLY.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS gui.employeeAllocation INHERITS Form: 
	
    DEFINE PRIVATE VARIABLE bsEmployees AS Progress.Data.BindingSource NO-UNDO.
    DEFINE PRIVATE VARIABLE bsTeamEmployees AS Progress.Data.BindingSource NO-UNDO.
    DEFINE PRIVATE VARIABLE btnSave AS Infragistics.Win.Misc.UltraButton NO-UNDO.
    DEFINE PRIVATE VARIABLE btnRemove AS Infragistics.Win.Misc.UltraButton NO-UNDO.
    DEFINE PRIVATE VARIABLE btnAdd AS Infragistics.Win.Misc.UltraButton NO-UNDO.
	DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE ugEmployeeTeam AS Infragistics.Win.UltraWinGrid.UltraGrid NO-UNDO.
    DEFINE PRIVATE VARIABLE ugEmployee AS Infragistics.Win.UltraWinGrid.UltraGrid NO-UNDO.
    DEFINE VARIABLE objEmployeesForTeam AS gui.employeesForTeamModel NO-UNDO.
    DEFINE VARIABLE objEmployees AS gui.employeeModel NO-UNDO.
    DEFINE VARIABLE objRole AS gui.roleModel NO-UNDO.
    DEFINE VARIABLE teamid AS INTEGER NO-UNDO.	

    	
	CONSTRUCTOR PUBLIC employeeAllocation (INPUT team_id AS CHARACTER):
		
		
        SUPER().
        InitializeComponent().
        
        teamid=INTEGER(team_id).
        
        objRole = NEW gui.roleModel().
        objEmployees = NEW gui.employeeModel().
        objEmployeesForTeam = NEW gui.employeesForTeamModel().
        
        
        objEmployeesForTeam:setFilter(INPUT "team_id", INPUT "EQ", INPUT team_id).
        
        bsTeamEmployees:HANDLE = objEmployeesForTeam:getEmployeeHandleAndData().
        
        getFilteredEmployeeList().
    
        DEFINE VARIABLE objColumn AS ColumnsCollection NO-UNDO.
        DEFINE VARIABLE objValueList AS ValueList NO-UNDO.
    
        objValueList = NEW ValueList().
        objValueList:ValueListItems:Add(0, "Not Selected").
        objRole:getValueList(INPUT-OUTPUT objValueList).

        objColumn = ugEmployeeTeam:DisplayLayout:Bands["ttEmployee_team"]:Columns.
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

	METHOD PUBLIC VOID addEmployeeToTeam(  ):
		
        IF ugEmployee:ActiveRow <> ? THEN                                                                                               
        DO:
                bsTeamEmployees:AddNew().
                objEmployeesForTeam:createNewEmployeeTeam(
                            INPUT teamid,
                            INPUT INTEGER(ugEmployee:ActiveRow:GetCellValue("employee_id"):ToString()),
                            INPUT ugEmployee:ActiveRow:GetCellValue("employee_name"):ToString(),
                            INPUT ugEmployee:ActiveRow:GetCellValue("department_name"):ToString()).

                            
                getFilteredEmployeeList().
        END.
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID btnAdd_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):

        addEmployeeToTeam().

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID btnRemove_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
        removeEmployeeFromTeam().
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID btnSave_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		
		objEmployeesForTeam:saveRowChanges().
		objEmployees:saveRowChanges().
        THIS-OBJECT:VISIBLE = FALSE.
        THIS-OBJECT:CLOSE().
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC VOID getFilteredEmployeeList(  ):
        DEFINE VARIABLE rowCnt AS INTEGER NO-UNDO.

        objEmployees:clearFilter().
        DO rowCnt = 0 TO ugEmployeeTeam:Rows:Count - 1 :
            objEmployees:addFilter(INPUT "employee_id", INPUT "NE", INPUT STRING (ugEmployeeTeam:Rows[rowCnt]:GetCellValue("employee_id"))).

        END.
        
/*        objEmployeesForTeam:getFilterForEmployeeExcluding(INPUT-OUTPUT objEmployees).*/
        bsEmployees:HANDLE = objEmployees:getEmployeeHandleAndData().
	END METHOD.

	METHOD PRIVATE VOID InitializeComponent(  ):
		
        /* NOTE: The following method is automatically generated.
        
        We strongly suggest that the contents of this method only be modified using the
        Visual Designer to avoid any incompatible modifications.
        
        Modifying the contents of this method using a code editor will invalidate any support for this file. */
        THIS-OBJECT:components = NEW System.ComponentModel.Container().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE tableDesc1 AS Progress.Data.TableDesc NO-UNDO.
        tableDesc1 = NEW Progress.Data.TableDesc("ttEmployee").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE tableDesc2 AS Progress.Data.TableDesc NO-UNDO.
        tableDesc2 = NEW Progress.Data.TableDesc("ttEmployee_team").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance1 AS Infragistics.Win.Appearance NO-UNDO.
        appearance1 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridBand1 AS Infragistics.Win.UltraWinGrid.UltraGridBand NO-UNDO.
        ultraGridBand1 = NEW Infragistics.Win.UltraWinGrid.UltraGridBand("ttEmployee", -1).
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn1 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn1 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("employee_id").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn2 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn2 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("employee_name").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn3 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn3 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("department_name").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn4 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn4 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("department_id").
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
        DEFINE VARIABLE appearance13 AS Infragistics.Win.Appearance NO-UNDO.
        appearance13 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridBand2 AS Infragistics.Win.UltraWinGrid.UltraGridBand NO-UNDO.
        ultraGridBand2 = NEW Infragistics.Win.UltraWinGrid.UltraGridBand("ttEmployee_team", -1).
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn5 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn5 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("employee_id").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn6 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn6 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("team_id").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn7 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn7 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("employee_team_id").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn8 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn8 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("role_id").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn9 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn9 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("employee_cost").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn10 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn10 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("role_name").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn11 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn11 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("role_cost").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn12 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn12 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("employee_name").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn13 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn13 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("department_name").
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
        THIS-OBJECT:bsEmployees = NEW Progress.Data.BindingSource(THIS-OBJECT:components).
        THIS-OBJECT:bsTeamEmployees = NEW Progress.Data.BindingSource(THIS-OBJECT:components).
        THIS-OBJECT:ugEmployee = NEW Infragistics.Win.UltraWinGrid.UltraGrid().
        THIS-OBJECT:ugEmployeeTeam = NEW Infragistics.Win.UltraWinGrid.UltraGrid().
        THIS-OBJECT:btnAdd = NEW Infragistics.Win.Misc.UltraButton().
        THIS-OBJECT:btnRemove = NEW Infragistics.Win.Misc.UltraButton().
        THIS-OBJECT:btnSave = NEW Infragistics.Win.Misc.UltraButton().
        CAST(THIS-OBJECT:bsEmployees, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:bsTeamEmployees, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:ugEmployee, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:ugEmployeeTeam, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* bsEmployees */
        /*  */
        THIS-OBJECT:bsEmployees:MaxDataGuess = 0.
        THIS-OBJECT:bsEmployees:NoLOBs = FALSE.
        THIS-OBJECT:bsEmployees:Position = 0.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar0 AS "Progress.Data.TableDesc[]" NO-UNDO.
        arrayvar0 = NEW "Progress.Data.TableDesc[]"(0).
        tableDesc1:ChildTables = arrayvar0.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar1 AS Progress.Data.ColumnPropDesc EXTENT 4 NO-UNDO.
        arrayvar1[1] = NEW Progress.Data.ColumnPropDesc("employee_id", "Employee ID", Progress.Data.DataType:INTEGER).
        arrayvar1[2] = NEW Progress.Data.ColumnPropDesc("employee_name", "Employee Name", Progress.Data.DataType:CHARACTER).
        arrayvar1[3] = NEW Progress.Data.ColumnPropDesc("department_name", "Department Name", Progress.Data.DataType:CHARACTER).
        arrayvar1[4] = NEW Progress.Data.ColumnPropDesc("department_id", "Department ID", Progress.Data.DataType:INTEGER).
        tableDesc1:Columns = arrayvar1.
        THIS-OBJECT:bsEmployees:TableSchema = tableDesc1.
        /*  */
        /* bsTeamEmployees */
        /*  */
        THIS-OBJECT:bsTeamEmployees:MaxDataGuess = 0.
        THIS-OBJECT:bsTeamEmployees:NoLOBs = FALSE.
        THIS-OBJECT:bsTeamEmployees:Position = 0.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar2 AS "Progress.Data.TableDesc[]" NO-UNDO.
        arrayvar2 = NEW "Progress.Data.TableDesc[]"(0).
        tableDesc2:ChildTables = arrayvar2.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar3 AS Progress.Data.ColumnPropDesc EXTENT 9 NO-UNDO.
        arrayvar3[1] = NEW Progress.Data.ColumnPropDesc("employee_id", "Employee Id", Progress.Data.DataType:INTEGER).
        arrayvar3[2] = NEW Progress.Data.ColumnPropDesc("team_id", "Team Id", Progress.Data.DataType:INTEGER).
        arrayvar3[3] = NEW Progress.Data.ColumnPropDesc("employee_team_id", "Employee Team Id", Progress.Data.DataType:INTEGER).
        arrayvar3[4] = NEW Progress.Data.ColumnPropDesc("role_id", "Role Id", Progress.Data.DataType:INTEGER).
        arrayvar3[5] = NEW Progress.Data.ColumnPropDesc("employee_cost", "Employee Cost", Progress.Data.DataType:DECIMAL).
        arrayvar3[6] = NEW Progress.Data.ColumnPropDesc("role_name", "Role Name", Progress.Data.DataType:CHARACTER).
        arrayvar3[7] = NEW Progress.Data.ColumnPropDesc("role_cost", "Role Cost", Progress.Data.DataType:DECIMAL).
        arrayvar3[8] = NEW Progress.Data.ColumnPropDesc("employee_name", "Employee Name", Progress.Data.DataType:CHARACTER).
        arrayvar3[9] = NEW Progress.Data.ColumnPropDesc("department_name", "Department Name", Progress.Data.DataType:CHARACTER).
        tableDesc2:Columns = arrayvar3.
        THIS-OBJECT:bsTeamEmployees:TableSchema = tableDesc2.
        /*  */
        /* ugEmployee */
        /*  */
        THIS-OBJECT:ugEmployee:DataSource = THIS-OBJECT:bsEmployees.
        appearance1:BackColor = System.Drawing.SystemColors:Window.
        appearance1:BorderColor = System.Drawing.SystemColors:InactiveCaption.
        THIS-OBJECT:ugEmployee:DisplayLayout:Appearance = appearance1.
        THIS-OBJECT:ugEmployee:DisplayLayout:AutoFitStyle = Infragistics.Win.UltraWinGrid.AutoFitStyle:ExtendLastColumn.
        ultraGridColumn1:CellActivation = Infragistics.Win.UltraWinGrid.Activation:NoEdit.
        ultraGridColumn1:Header:VisiblePosition = 0.
        ultraGridColumn1:Hidden = TRUE.
        ultraGridColumn2:CellActivation = Infragistics.Win.UltraWinGrid.Activation:NoEdit.
        ultraGridColumn2:Header:VisiblePosition = 1.
        ultraGridColumn3:CellActivation = Infragistics.Win.UltraWinGrid.Activation:NoEdit.
        ultraGridColumn3:Header:VisiblePosition = 2.
        ultraGridColumn4:CellActivation = Infragistics.Win.UltraWinGrid.Activation:NoEdit.
        ultraGridColumn4:Header:VisiblePosition = 3.
        ultraGridColumn4:Hidden = TRUE.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar4 AS System.Object EXTENT 4 NO-UNDO.
        arrayvar4[1] = ultraGridColumn1.
        arrayvar4[2] = ultraGridColumn2.
        arrayvar4[3] = ultraGridColumn3.
        arrayvar4[4] = ultraGridColumn4.
        ultraGridBand1:Columns:AddRange(arrayvar4).
        THIS-OBJECT:ugEmployee:DisplayLayout:BandsSerializer:Add(ultraGridBand1).
        THIS-OBJECT:ugEmployee:DisplayLayout:BorderStyle = Infragistics.Win.UIElementBorderStyle:Solid.
        THIS-OBJECT:ugEmployee:DisplayLayout:CaptionVisible = Infragistics.Win.DefaultableBoolean:False.
        appearance2:BackColor = System.Drawing.SystemColors:ActiveBorder.
        appearance2:BackColor2 = System.Drawing.SystemColors:ControlDark.
        appearance2:BackGradientStyle = Infragistics.Win.GradientStyle:Vertical.
        appearance2:BorderColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ugEmployee:DisplayLayout:GroupByBox:Appearance = appearance2.
        appearance3:ForeColor = System.Drawing.SystemColors:GrayText.
        THIS-OBJECT:ugEmployee:DisplayLayout:GroupByBox:BandLabelAppearance = appearance3.
        THIS-OBJECT:ugEmployee:DisplayLayout:GroupByBox:BorderStyle = Infragistics.Win.UIElementBorderStyle:Solid.
        appearance4:BackColor = System.Drawing.SystemColors:ControlLightLight.
        appearance4:BackColor2 = System.Drawing.SystemColors:Control.
        appearance4:BackGradientStyle = Infragistics.Win.GradientStyle:Horizontal.
        appearance4:ForeColor = System.Drawing.SystemColors:GrayText.
        THIS-OBJECT:ugEmployee:DisplayLayout:GroupByBox:PromptAppearance = appearance4.
        THIS-OBJECT:ugEmployee:DisplayLayout:MaxColScrollRegions = 1.
        THIS-OBJECT:ugEmployee:DisplayLayout:MaxRowScrollRegions = 1.
        appearance5:BackColor = System.Drawing.SystemColors:Window.
        appearance5:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:ugEmployee:DisplayLayout:Override:ActiveCellAppearance = appearance5.
        appearance6:BackColor = System.Drawing.SystemColors:Highlight.
        appearance6:ForeColor = System.Drawing.SystemColors:HighlightText.
        THIS-OBJECT:ugEmployee:DisplayLayout:Override:ActiveRowAppearance = appearance6.
        THIS-OBJECT:ugEmployee:DisplayLayout:Override:BorderStyleCell = Infragistics.Win.UIElementBorderStyle:Dotted.
        THIS-OBJECT:ugEmployee:DisplayLayout:Override:BorderStyleRow = Infragistics.Win.UIElementBorderStyle:Dotted.
        appearance7:BackColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ugEmployee:DisplayLayout:Override:CardAreaAppearance = appearance7.
        appearance8:BorderColor = System.Drawing.Color:Silver.
        appearance8:TextTrimming = Infragistics.Win.TextTrimming:EllipsisCharacter.
        THIS-OBJECT:ugEmployee:DisplayLayout:Override:CellAppearance = appearance8.
        THIS-OBJECT:ugEmployee:DisplayLayout:Override:CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction:EditAndSelectText.
        THIS-OBJECT:ugEmployee:DisplayLayout:Override:CellPadding = 0.
        appearance9:BackColor = System.Drawing.SystemColors:Control.
        appearance9:BackColor2 = System.Drawing.SystemColors:ControlDark.
        appearance9:BackGradientAlignment = Infragistics.Win.GradientAlignment:Element.
        appearance9:BackGradientStyle = Infragistics.Win.GradientStyle:Horizontal.
        appearance9:BorderColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ugEmployee:DisplayLayout:Override:GroupByRowAppearance = appearance9.
        appearance10:TextHAlignAsString = "Left".
        THIS-OBJECT:ugEmployee:DisplayLayout:Override:HeaderAppearance = appearance10.
        THIS-OBJECT:ugEmployee:DisplayLayout:Override:HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction:SortMulti.
        THIS-OBJECT:ugEmployee:DisplayLayout:Override:HeaderStyle = Infragistics.Win.HeaderStyle:WindowsXPCommand.
        appearance11:BackColor = System.Drawing.SystemColors:Window.
        appearance11:BorderColor = System.Drawing.Color:Silver.
        THIS-OBJECT:ugEmployee:DisplayLayout:Override:RowAppearance = appearance11.
        THIS-OBJECT:ugEmployee:DisplayLayout:Override:RowSelectorHeaderStyle = Infragistics.Win.UltraWinGrid.RowSelectorHeaderStyle:ColumnChooserButton.
        THIS-OBJECT:ugEmployee:DisplayLayout:Override:RowSelectors = Infragistics.Win.DefaultableBoolean:True.
        THIS-OBJECT:ugEmployee:DisplayLayout:Override:SelectTypeCell = Infragistics.Win.UltraWinGrid.SelectType:None.
        THIS-OBJECT:ugEmployee:DisplayLayout:Override:SelectTypeRow = Infragistics.Win.UltraWinGrid.SelectType:Single.
        appearance12:BackColor = System.Drawing.SystemColors:ControlLight.
        THIS-OBJECT:ugEmployee:DisplayLayout:Override:TemplateAddRowAppearance = appearance12.
        THIS-OBJECT:ugEmployee:DisplayLayout:ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds:ScrollToFill.
        THIS-OBJECT:ugEmployee:DisplayLayout:ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle:Immediate.
        THIS-OBJECT:ugEmployee:DisplayLayout:ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand:OutlookGroupBy.
        THIS-OBJECT:ugEmployee:Font = NEW System.Drawing.Font("Microsoft Sans Serif", Progress.Util.CastUtil:ToSingle(8.25), System.Drawing.FontStyle:Regular, System.Drawing.GraphicsUnit:Point, System.Convert:ToByte(0)).
        THIS-OBJECT:ugEmployee:Location = NEW System.Drawing.Point(13, 13).
        THIS-OBJECT:ugEmployee:Name = "ugEmployee".
        THIS-OBJECT:ugEmployee:Size = NEW System.Drawing.Size(327, 403).
        THIS-OBJECT:ugEmployee:TabIndex = 0.
        THIS-OBJECT:ugEmployee:Text = "ultraGrid1".
        THIS-OBJECT:ugEmployee:DoubleClickRow:Subscribe(THIS-OBJECT:ugEmployee_DoubleClickRow).
        /*  */
        /* ugEmployeeTeam */
        /*  */
        THIS-OBJECT:ugEmployeeTeam:DataSource = THIS-OBJECT:bsTeamEmployees.
        appearance13:BackColor = System.Drawing.SystemColors:Window.
        appearance13:BorderColor = System.Drawing.SystemColors:InactiveCaption.
        THIS-OBJECT:ugEmployeeTeam:DisplayLayout:Appearance = appearance13.
        THIS-OBJECT:ugEmployeeTeam:DisplayLayout:AutoFitStyle = Infragistics.Win.UltraWinGrid.AutoFitStyle:ExtendLastColumn.
        ultraGridColumn5:CellActivation = Infragistics.Win.UltraWinGrid.Activation:NoEdit.
        ultraGridColumn5:Header:VisiblePosition = 0.
        ultraGridColumn5:Hidden = TRUE.
        ultraGridColumn6:CellActivation = Infragistics.Win.UltraWinGrid.Activation:NoEdit.
        ultraGridColumn6:Header:VisiblePosition = 1.
        ultraGridColumn6:Hidden = TRUE.
        ultraGridColumn7:CellActivation = Infragistics.Win.UltraWinGrid.Activation:NoEdit.
        ultraGridColumn7:Header:VisiblePosition = 2.
        ultraGridColumn7:Hidden = TRUE.
        ultraGridColumn8:Header:Caption = "Role Name".
        ultraGridColumn8:Header:VisiblePosition = 3.
        ultraGridColumn9:CellActivation = Infragistics.Win.UltraWinGrid.Activation:NoEdit.
        ultraGridColumn9:Header:VisiblePosition = 6.
        ultraGridColumn9:Hidden = TRUE.
        ultraGridColumn10:CellActivation = Infragistics.Win.UltraWinGrid.Activation:NoEdit.
        ultraGridColumn10:Header:VisiblePosition = 4.
        ultraGridColumn10:Hidden = TRUE.
        ultraGridColumn11:CellActivation = Infragistics.Win.UltraWinGrid.Activation:NoEdit.
        ultraGridColumn11:Header:VisiblePosition = 5.
        ultraGridColumn11:Hidden = TRUE.
        ultraGridColumn12:CellActivation = Infragistics.Win.UltraWinGrid.Activation:NoEdit.
        ultraGridColumn12:Header:VisiblePosition = 7.
        ultraGridColumn13:CellActivation = Infragistics.Win.UltraWinGrid.Activation:NoEdit.
        ultraGridColumn13:Header:VisiblePosition = 8.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar5 AS System.Object EXTENT 9 NO-UNDO.
        arrayvar5[1] = ultraGridColumn5.
        arrayvar5[2] = ultraGridColumn6.
        arrayvar5[3] = ultraGridColumn7.
        arrayvar5[4] = ultraGridColumn8.
        arrayvar5[5] = ultraGridColumn9.
        arrayvar5[6] = ultraGridColumn10.
        arrayvar5[7] = ultraGridColumn11.
        arrayvar5[8] = ultraGridColumn12.
        arrayvar5[9] = ultraGridColumn13.
        ultraGridBand2:Columns:AddRange(arrayvar5).
        THIS-OBJECT:ugEmployeeTeam:DisplayLayout:BandsSerializer:Add(ultraGridBand2).
        THIS-OBJECT:ugEmployeeTeam:DisplayLayout:BorderStyle = Infragistics.Win.UIElementBorderStyle:Solid.
        THIS-OBJECT:ugEmployeeTeam:DisplayLayout:CaptionVisible = Infragistics.Win.DefaultableBoolean:False.
        appearance14:BackColor = System.Drawing.SystemColors:ActiveBorder.
        appearance14:BackColor2 = System.Drawing.SystemColors:ControlDark.
        appearance14:BackGradientStyle = Infragistics.Win.GradientStyle:Vertical.
        appearance14:BorderColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ugEmployeeTeam:DisplayLayout:GroupByBox:Appearance = appearance14.
        appearance15:ForeColor = System.Drawing.SystemColors:GrayText.
        THIS-OBJECT:ugEmployeeTeam:DisplayLayout:GroupByBox:BandLabelAppearance = appearance15.
        THIS-OBJECT:ugEmployeeTeam:DisplayLayout:GroupByBox:BorderStyle = Infragistics.Win.UIElementBorderStyle:Solid.
        appearance16:BackColor = System.Drawing.SystemColors:ControlLightLight.
        appearance16:BackColor2 = System.Drawing.SystemColors:Control.
        appearance16:BackGradientStyle = Infragistics.Win.GradientStyle:Horizontal.
        appearance16:ForeColor = System.Drawing.SystemColors:GrayText.
        THIS-OBJECT:ugEmployeeTeam:DisplayLayout:GroupByBox:PromptAppearance = appearance16.
        THIS-OBJECT:ugEmployeeTeam:DisplayLayout:MaxColScrollRegions = 1.
        THIS-OBJECT:ugEmployeeTeam:DisplayLayout:MaxRowScrollRegions = 1.
        appearance17:BackColor = System.Drawing.SystemColors:Window.
        appearance17:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:ugEmployeeTeam:DisplayLayout:Override:ActiveCellAppearance = appearance17.
        appearance18:BackColor = System.Drawing.SystemColors:Highlight.
        appearance18:ForeColor = System.Drawing.SystemColors:HighlightText.
        THIS-OBJECT:ugEmployeeTeam:DisplayLayout:Override:ActiveRowAppearance = appearance18.
        THIS-OBJECT:ugEmployeeTeam:DisplayLayout:Override:AllowUpdate = Infragistics.Win.DefaultableBoolean:True.
        THIS-OBJECT:ugEmployeeTeam:DisplayLayout:Override:BorderStyleCell = Infragistics.Win.UIElementBorderStyle:Dotted.
        THIS-OBJECT:ugEmployeeTeam:DisplayLayout:Override:BorderStyleRow = Infragistics.Win.UIElementBorderStyle:Dotted.
        appearance19:BackColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ugEmployeeTeam:DisplayLayout:Override:CardAreaAppearance = appearance19.
        appearance20:BorderColor = System.Drawing.Color:Silver.
        appearance20:TextTrimming = Infragistics.Win.TextTrimming:EllipsisCharacter.
        THIS-OBJECT:ugEmployeeTeam:DisplayLayout:Override:CellAppearance = appearance20.
        THIS-OBJECT:ugEmployeeTeam:DisplayLayout:Override:CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction:EditAndSelectText.
        THIS-OBJECT:ugEmployeeTeam:DisplayLayout:Override:CellPadding = 0.
        appearance21:BackColor = System.Drawing.SystemColors:Control.
        appearance21:BackColor2 = System.Drawing.SystemColors:ControlDark.
        appearance21:BackGradientAlignment = Infragistics.Win.GradientAlignment:Element.
        appearance21:BackGradientStyle = Infragistics.Win.GradientStyle:Horizontal.
        appearance21:BorderColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ugEmployeeTeam:DisplayLayout:Override:GroupByRowAppearance = appearance21.
        appearance22:TextHAlignAsString = "Left".
        THIS-OBJECT:ugEmployeeTeam:DisplayLayout:Override:HeaderAppearance = appearance22.
        THIS-OBJECT:ugEmployeeTeam:DisplayLayout:Override:HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction:SortMulti.
        THIS-OBJECT:ugEmployeeTeam:DisplayLayout:Override:HeaderStyle = Infragistics.Win.HeaderStyle:WindowsXPCommand.
        appearance23:BackColor = System.Drawing.SystemColors:Window.
        appearance23:BorderColor = System.Drawing.Color:Silver.
        THIS-OBJECT:ugEmployeeTeam:DisplayLayout:Override:RowAppearance = appearance23.
        THIS-OBJECT:ugEmployeeTeam:DisplayLayout:Override:RowSelectorHeaderStyle = Infragistics.Win.UltraWinGrid.RowSelectorHeaderStyle:ColumnChooserButton.
        THIS-OBJECT:ugEmployeeTeam:DisplayLayout:Override:RowSelectors = Infragistics.Win.DefaultableBoolean:True.
        THIS-OBJECT:ugEmployeeTeam:DisplayLayout:Override:SelectTypeCell = Infragistics.Win.UltraWinGrid.SelectType:None.
        appearance24:BackColor = System.Drawing.SystemColors:ControlLight.
        THIS-OBJECT:ugEmployeeTeam:DisplayLayout:Override:TemplateAddRowAppearance = appearance24.
        THIS-OBJECT:ugEmployeeTeam:DisplayLayout:ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds:ScrollToFill.
        THIS-OBJECT:ugEmployeeTeam:DisplayLayout:ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle:Immediate.
        THIS-OBJECT:ugEmployeeTeam:DisplayLayout:ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand:OutlookGroupBy.
        THIS-OBJECT:ugEmployeeTeam:Font = NEW System.Drawing.Font("Microsoft Sans Serif", Progress.Util.CastUtil:ToSingle(8.25), System.Drawing.FontStyle:Regular, System.Drawing.GraphicsUnit:Point, System.Convert:ToByte(0)).
        THIS-OBJECT:ugEmployeeTeam:Location = NEW System.Drawing.Point(427, 13).
        THIS-OBJECT:ugEmployeeTeam:Name = "ugEmployeeTeam".
        THIS-OBJECT:ugEmployeeTeam:Size = NEW System.Drawing.Size(418, 403).
        THIS-OBJECT:ugEmployeeTeam:TabIndex = 1.
        THIS-OBJECT:ugEmployeeTeam:Text = "ultraGrid2".
        THIS-OBJECT:ugEmployeeTeam:AfterEnterEditMode:Subscribe(THIS-OBJECT:ugEmployeeTeam_AfterEnterEditMode).
        THIS-OBJECT:ugEmployeeTeam:BeforeRowUpdate:Subscribe(THIS-OBJECT:ugEmployeeTeam_BeforeRowUpdate).
        THIS-OBJECT:ugEmployeeTeam:DoubleClickRow:Subscribe(THIS-OBJECT:ugEmployeeTeam_DoubleClickRow).
        /*  */
        /* btnAdd */
        /*  */
        THIS-OBJECT:btnAdd:Location = NEW System.Drawing.Point(346, 115).
        THIS-OBJECT:btnAdd:Name = "btnAdd".
        THIS-OBJECT:btnAdd:Size = NEW System.Drawing.Size(75, 23).
        THIS-OBJECT:btnAdd:TabIndex = 2.
        THIS-OBJECT:btnAdd:Text = ">>".
        THIS-OBJECT:btnAdd:Click:Subscribe(THIS-OBJECT:btnAdd_Click).
        /*  */
        /* btnRemove */
        /*  */
        THIS-OBJECT:btnRemove:Location = NEW System.Drawing.Point(346, 155).
        THIS-OBJECT:btnRemove:Name = "btnRemove".
        THIS-OBJECT:btnRemove:Size = NEW System.Drawing.Size(75, 23).
        THIS-OBJECT:btnRemove:TabIndex = 3.
        THIS-OBJECT:btnRemove:Text = "<<".
        THIS-OBJECT:btnRemove:Click:Subscribe(THIS-OBJECT:btnRemove_Click).
        /*  */
        /* btnSave */
        /*  */
        THIS-OBJECT:btnSave:Location = NEW System.Drawing.Point(346, 194).
        THIS-OBJECT:btnSave:Name = "btnSave".
        THIS-OBJECT:btnSave:Size = NEW System.Drawing.Size(75, 23).
        THIS-OBJECT:btnSave:TabIndex = 4.
        THIS-OBJECT:btnSave:Text = "Save".
        THIS-OBJECT:btnSave:Click:Subscribe(THIS-OBJECT:btnSave_Click).
        /*  */
        /* employeeAllocation */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(853, 439).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:btnSave).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:btnRemove).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:btnAdd).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:ugEmployeeTeam).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:ugEmployee).
        THIS-OBJECT:Name = "employeeAllocation".
        THIS-OBJECT:Text = "employeeAllocation".
        CAST(THIS-OBJECT:bsEmployees, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:bsTeamEmployees, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:ugEmployee, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:ugEmployeeTeam, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:ResumeLayout(FALSE).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC VOID removeEmployeeFromTeam(  ):
		
        IF ugEmployeeTeam:ActiveRow <> ? THEN
        DO:
            objEmployeesForTeam:deleteRow().
            THIS-OBJECT:ugEmployeeTeam:Selected:Rows:Clear().
/*            THIS-OBJECT:ugEmployeeTeam:ActiveRow:Delete(FALSE).*/

            objEmployeesForTeam:refreshData().
            

            getFilteredEmployeeList().
        END.

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID ugEmployee_DoubleClickRow( INPUT sender AS System.Object, INPUT e AS Infragistics.Win.UltraWinGrid.DoubleClickRowEventArgs ):
		
        addEmployeeToTeam().

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID ugEmployeeTeam_AfterEnterEditMode( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):

		objEmployeesForTeam:enableEdit().

	END METHOD.


	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID ugEmployeeTeam_BeforeRowUpdate( INPUT sender AS System.Object, INPUT e AS Infragistics.Win.UltraWinGrid.CancelableRowEventArgs ):
		
		bsTeamEmployees:Assign().

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID ugEmployeeTeam_DoubleClickRow( INPUT sender AS System.Object, INPUT e AS Infragistics.Win.UltraWinGrid.DoubleClickRowEventArgs ):
		
        removeEmployeeFromTeam().

	END METHOD.

	DESTRUCTOR PUBLIC employeeAllocation ( ):

	END DESTRUCTOR.

END CLASS.