 
 /*------------------------------------------------------------------------
    File        : employeeProjectTime
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : Administrator
    Created     : Wed Jan 27 14:27:07 UTC 2016
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.
USING common.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS gui.employeeProjectTimeForm INHERITS Form: 
	
    DEFINE PRIVATE VARIABLE bsCombo AS Progress.Data.BindingSource NO-UNDO.
    DEFINE PRIVATE VARIABLE bsEmployeeProjectTime AS Progress.Data.BindingSource NO-UNDO.
    DEFINE PRIVATE VARIABLE btnExcel AS Infragistics.Win.Misc.UltraButton NO-UNDO.
    DEFINE PRIVATE VARIABLE btnFilter AS Infragistics.Win.Misc.UltraButton NO-UNDO.
	DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE lblPrjName AS Infragistics.Win.Misc.UltraLabel NO-UNDO.
    DEFINE PRIVATE VARIABLE txtEmployeeName AS Infragistics.Win.UltraWinEditors.UltraTextEditor NO-UNDO.
    DEFINE PRIVATE VARIABLE lblEmpName AS Infragistics.Win.Misc.UltraLabel NO-UNDO.
    DEFINE PRIVATE VARIABLE txtProjectName AS Infragistics.Win.UltraWinEditors.UltraTextEditor NO-UNDO.
    DEFINE PRIVATE VARIABLE ucDepartment AS Infragistics.Win.UltraWinGrid.UltraCombo NO-UNDO.
    DEFINE PRIVATE VARIABLE ugEmployeeProjectTime AS Infragistics.Win.UltraWinGrid.UltraGrid NO-UNDO.
    DEFINE PRIVATE VARIABLE ugExcelExporter AS Infragistics.Win.UltraWinGrid.ExcelExport.UltraGridExcelExporter NO-UNDO.

    DEFINE VARIABLE objDepartment AS gui.departmentModel NO-UNDO.
    DEFINE VARIABLE objEmployeeProjectTime AS gui.employeeProjectTimeModel NO-UNDO.

		
	CONSTRUCTOR PUBLIC employeeProjectTimeForm (  ):
		
		
        SUPER().
        InitializeComponent().

        objDepartment = NEW gui.departmentModel().
        bsCombo:HANDLE = objDepartment:getDepartmentHandleAndData().
                
        objEmployeeProjectTime = NEW gui.employeeProjectTimeModel().
/*        bsEmployeeProjectTime:HANDLE = objEmployeeProjectTime:getEmployeeProjectTimeHandle().*/
        bsEmployeeProjectTime:HANDLE = objEmployeeProjectTime:getEmployeeProjectTimeHandleAndData().
        
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
	METHOD PRIVATE VOID btnExcel_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		DEFINE VARIABLE cFileName AS CHARACTER INITIAL "test.xlsx" NO-UNDO.
		
		ugExcelExporter:Export(ugEmployeeProjectTime,cFileName).
		System.Diagnostics.Process:start(cFilename). 
		RETURN.

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID btnFilter_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
	    
	    objEmployeeProjectTime:clearFilter().
        IF txtEmployeeName:TEXT <> "" THEN
            objEmployeeProjectTime:addFilter(INPUT "employee_name", INPUT "BEGINS", INPUT txtEmployeeName:TEXT).
        IF txtProjectName:TEXT <> "" THEN
            objEmployeeProjectTime:addFilter(INPUT "project_name", INPUT "BEGINS", INPUT txtProjectName:TEXT).
        
        IF ucDepartment:SelectedText NE "" THEN
            objEmployeeProjectTime:addFilter(INPUT "department_id", INPUT "EQ", INPUT ucDepartment:VALUE:ToString()).
		
		objEmployeeProjectTime:getEmployeeProjectTime().

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
        tableDesc2 = NEW Progress.Data.TableDesc("ttProject_time").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance1 AS Infragistics.Win.Appearance NO-UNDO.
        appearance1 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridBand1 AS Infragistics.Win.UltraWinGrid.UltraGridBand NO-UNDO.
        ultraGridBand1 = NEW Infragistics.Win.UltraWinGrid.UltraGridBand("ttEmployee", -1).
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn2 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn2 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("employee_name").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn1 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn1 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("department_name").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn4 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn4 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("ttProject_time").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridBand2 AS Infragistics.Win.UltraWinGrid.UltraGridBand NO-UNDO.
        ultraGridBand2 = NEW Infragistics.Win.UltraWinGrid.UltraGridBand("ttProject_time", 0).
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn8 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn8 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("start_date_time").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn9 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn9 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("stop_date_time").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn10 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn10 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("comment").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn11 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn11 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("project_name").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn12 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn12 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("role_name").
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
        DEFINE VARIABLE ultraGridBand3 AS Infragistics.Win.UltraWinGrid.UltraGridBand NO-UNDO.
        ultraGridBand3 = NEW Infragistics.Win.UltraWinGrid.UltraGridBand("ttDepartment", -1).
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn3 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn3 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("department_ID").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn5 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn5 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("department_name").
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
        DEFINE VARIABLE tableDesc3 AS Progress.Data.TableDesc NO-UNDO.
        tableDesc3 = NEW Progress.Data.TableDesc("ttDepartment").
        THIS-OBJECT:bsEmployeeProjectTime = NEW Progress.Data.BindingSource(THIS-OBJECT:components).
        THIS-OBJECT:ugEmployeeProjectTime = NEW Infragistics.Win.UltraWinGrid.UltraGrid().
        THIS-OBJECT:btnFilter = NEW Infragistics.Win.Misc.UltraButton().
        THIS-OBJECT:lblEmpName = NEW Infragistics.Win.Misc.UltraLabel().
        THIS-OBJECT:txtEmployeeName = NEW Infragistics.Win.UltraWinEditors.UltraTextEditor().
        THIS-OBJECT:lblPrjName = NEW Infragistics.Win.Misc.UltraLabel().
        THIS-OBJECT:txtProjectName = NEW Infragistics.Win.UltraWinEditors.UltraTextEditor().
        THIS-OBJECT:btnExcel = NEW Infragistics.Win.Misc.UltraButton().
        THIS-OBJECT:ugExcelExporter = NEW Infragistics.Win.UltraWinGrid.ExcelExport.UltraGridExcelExporter(THIS-OBJECT:components).
        THIS-OBJECT:ucDepartment = NEW Infragistics.Win.UltraWinGrid.UltraCombo().
        THIS-OBJECT:bsCombo = NEW Progress.Data.BindingSource(THIS-OBJECT:components).
        CAST(THIS-OBJECT:bsEmployeeProjectTime, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:ugEmployeeProjectTime, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:txtEmployeeName, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:txtProjectName, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:ucDepartment, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:bsCombo, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* bsEmployeeProjectTime */
        /*  */
        THIS-OBJECT:bsEmployeeProjectTime:MaxDataGuess = 0.
        THIS-OBJECT:bsEmployeeProjectTime:NoLOBs = FALSE.
        THIS-OBJECT:bsEmployeeProjectTime:Position = 0.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar0 AS "Progress.Data.TableDesc[]" NO-UNDO.
        arrayvar0 = NEW "Progress.Data.TableDesc[]"(0).
        tableDesc2:ChildTables = arrayvar0.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar1 AS Progress.Data.ColumnPropDesc EXTENT 5 NO-UNDO.
        arrayvar1[1] = NEW Progress.Data.ColumnPropDesc("start_date_time", "Start", Progress.Data.DataType:DATETIME).
        arrayvar1[2] = NEW Progress.Data.ColumnPropDesc("stop_date_time", "Stop", Progress.Data.DataType:DATETIME).
        arrayvar1[3] = NEW Progress.Data.ColumnPropDesc("comment", "Comment", Progress.Data.DataType:CHARACTER).
        arrayvar1[4] = NEW Progress.Data.ColumnPropDesc("project_name", "Project Name", Progress.Data.DataType:CHARACTER).
        arrayvar1[5] = NEW Progress.Data.ColumnPropDesc("role_name", "Role Name", Progress.Data.DataType:CHARACTER).
        tableDesc2:Columns = arrayvar1.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar2 AS Progress.Data.TableDesc EXTENT 1 NO-UNDO.
        arrayvar2[1] = tableDesc2.
        tableDesc1:ChildTables = arrayvar2.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar3 AS Progress.Data.ColumnPropDesc EXTENT 2 NO-UNDO.
        arrayvar3[1] = NEW Progress.Data.ColumnPropDesc("employee_name", "Employee Name", Progress.Data.DataType:CHARACTER).
        arrayvar3[2] = NEW Progress.Data.ColumnPropDesc("department_name", "Department Name", Progress.Data.DataType:CHARACTER).
        tableDesc1:Columns = arrayvar3.
        THIS-OBJECT:bsEmployeeProjectTime:TableSchema = tableDesc1.
        /*  */
        /* ugEmployeeProjectTime */
        /*  */
        DEFINE VARIABLE nestedvar0 AS System.Windows.Forms.AnchorStyles NO-UNDO.
        nestedvar0 = CAST(Progress.Util.EnumHelper:Or(CAST(Progress.Util.EnumHelper:Or(System.Windows.Forms.AnchorStyles:Top, System.Windows.Forms.AnchorStyles:Bottom), System.Windows.Forms.AnchorStyles), System.Windows.Forms.AnchorStyles:Left), System.Windows.Forms.AnchorStyles).
        THIS-OBJECT:ugEmployeeProjectTime:Anchor = CAST(Progress.Util.EnumHelper:Or(nestedvar0, System.Windows.Forms.AnchorStyles:Right), System.Windows.Forms.AnchorStyles).
        THIS-OBJECT:ugEmployeeProjectTime:DataSource = THIS-OBJECT:bsEmployeeProjectTime.
        appearance1:BackColor = System.Drawing.SystemColors:Window.
        appearance1:BorderColor = System.Drawing.SystemColors:InactiveCaption.
        THIS-OBJECT:ugEmployeeProjectTime:DisplayLayout:Appearance = appearance1.
        ultraGridColumn2:Header:VisiblePosition = 0.
        ultraGridColumn1:Header:VisiblePosition = 1.
        ultraGridColumn4:Header:VisiblePosition = 2.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar4 AS System.Object EXTENT 3 NO-UNDO.
        arrayvar4[1] = ultraGridColumn2.
        arrayvar4[2] = ultraGridColumn1.
        arrayvar4[3] = ultraGridColumn4.
        ultraGridBand1:Columns:AddRange(arrayvar4).
        ultraGridColumn8:Header:VisiblePosition = 1.
        ultraGridColumn9:Header:VisiblePosition = 2.
        ultraGridColumn10:Header:VisiblePosition = 4.
        ultraGridColumn11:Header:VisiblePosition = 0.
        ultraGridColumn12:Header:VisiblePosition = 3.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar5 AS System.Object EXTENT 5 NO-UNDO.
        arrayvar5[1] = ultraGridColumn8.
        arrayvar5[2] = ultraGridColumn9.
        arrayvar5[3] = ultraGridColumn10.
        arrayvar5[4] = ultraGridColumn11.
        arrayvar5[5] = ultraGridColumn12.
        ultraGridBand2:Columns:AddRange(arrayvar5).
        THIS-OBJECT:ugEmployeeProjectTime:DisplayLayout:BandsSerializer:Add(ultraGridBand1).
        THIS-OBJECT:ugEmployeeProjectTime:DisplayLayout:BandsSerializer:Add(ultraGridBand2).
        THIS-OBJECT:ugEmployeeProjectTime:DisplayLayout:BorderStyle = Infragistics.Win.UIElementBorderStyle:Solid.
        THIS-OBJECT:ugEmployeeProjectTime:DisplayLayout:CaptionVisible = Infragistics.Win.DefaultableBoolean:False.
        appearance2:BackColor = System.Drawing.SystemColors:ActiveBorder.
        appearance2:BackColor2 = System.Drawing.SystemColors:ControlDark.
        appearance2:BackGradientStyle = Infragistics.Win.GradientStyle:Vertical.
        appearance2:BorderColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ugEmployeeProjectTime:DisplayLayout:GroupByBox:Appearance = appearance2.
        appearance3:ForeColor = System.Drawing.SystemColors:GrayText.
        THIS-OBJECT:ugEmployeeProjectTime:DisplayLayout:GroupByBox:BandLabelAppearance = appearance3.
        THIS-OBJECT:ugEmployeeProjectTime:DisplayLayout:GroupByBox:BorderStyle = Infragistics.Win.UIElementBorderStyle:Solid.
        appearance4:BackColor = System.Drawing.SystemColors:ControlLightLight.
        appearance4:BackColor2 = System.Drawing.SystemColors:Control.
        appearance4:BackGradientStyle = Infragistics.Win.GradientStyle:Horizontal.
        appearance4:ForeColor = System.Drawing.SystemColors:GrayText.
        THIS-OBJECT:ugEmployeeProjectTime:DisplayLayout:GroupByBox:PromptAppearance = appearance4.
        THIS-OBJECT:ugEmployeeProjectTime:DisplayLayout:MaxColScrollRegions = 1.
        THIS-OBJECT:ugEmployeeProjectTime:DisplayLayout:MaxRowScrollRegions = 1.
        appearance5:BackColor = System.Drawing.SystemColors:Window.
        appearance5:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:ugEmployeeProjectTime:DisplayLayout:Override:ActiveCellAppearance = appearance5.
        appearance6:BackColor = System.Drawing.SystemColors:Highlight.
        appearance6:ForeColor = System.Drawing.SystemColors:HighlightText.
        THIS-OBJECT:ugEmployeeProjectTime:DisplayLayout:Override:ActiveRowAppearance = appearance6.
        THIS-OBJECT:ugEmployeeProjectTime:DisplayLayout:Override:BorderStyleCell = Infragistics.Win.UIElementBorderStyle:Dotted.
        THIS-OBJECT:ugEmployeeProjectTime:DisplayLayout:Override:BorderStyleRow = Infragistics.Win.UIElementBorderStyle:Dotted.
        appearance7:BackColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ugEmployeeProjectTime:DisplayLayout:Override:CardAreaAppearance = appearance7.
        appearance8:BorderColor = System.Drawing.Color:Silver.
        appearance8:TextTrimming = Infragistics.Win.TextTrimming:EllipsisCharacter.
        THIS-OBJECT:ugEmployeeProjectTime:DisplayLayout:Override:CellAppearance = appearance8.
        THIS-OBJECT:ugEmployeeProjectTime:DisplayLayout:Override:CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction:EditAndSelectText.
        THIS-OBJECT:ugEmployeeProjectTime:DisplayLayout:Override:CellPadding = 0.
        appearance9:BackColor = System.Drawing.SystemColors:Control.
        appearance9:BackColor2 = System.Drawing.SystemColors:ControlDark.
        appearance9:BackGradientAlignment = Infragistics.Win.GradientAlignment:Element.
        appearance9:BackGradientStyle = Infragistics.Win.GradientStyle:Horizontal.
        appearance9:BorderColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ugEmployeeProjectTime:DisplayLayout:Override:GroupByRowAppearance = appearance9.
        appearance10:TextHAlignAsString = "Left".
        THIS-OBJECT:ugEmployeeProjectTime:DisplayLayout:Override:HeaderAppearance = appearance10.
        THIS-OBJECT:ugEmployeeProjectTime:DisplayLayout:Override:HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction:SortMulti.
        THIS-OBJECT:ugEmployeeProjectTime:DisplayLayout:Override:HeaderStyle = Infragistics.Win.HeaderStyle:WindowsXPCommand.
        appearance11:BackColor = System.Drawing.SystemColors:Window.
        appearance11:BorderColor = System.Drawing.Color:Silver.
        THIS-OBJECT:ugEmployeeProjectTime:DisplayLayout:Override:RowAppearance = appearance11.
        THIS-OBJECT:ugEmployeeProjectTime:DisplayLayout:Override:RowSelectors = Infragistics.Win.DefaultableBoolean:False.
        appearance12:BackColor = System.Drawing.SystemColors:ControlLight.
        THIS-OBJECT:ugEmployeeProjectTime:DisplayLayout:Override:TemplateAddRowAppearance = appearance12.
        THIS-OBJECT:ugEmployeeProjectTime:DisplayLayout:ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds:ScrollToFill.
        THIS-OBJECT:ugEmployeeProjectTime:DisplayLayout:ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle:Immediate.
        THIS-OBJECT:ugEmployeeProjectTime:DisplayLayout:ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand:OutlookGroupBy.
        THIS-OBJECT:ugEmployeeProjectTime:Font = NEW System.Drawing.Font("Microsoft Sans Serif", Progress.Util.CastUtil:ToSingle(8.25), System.Drawing.FontStyle:Regular, System.Drawing.GraphicsUnit:Point, System.Convert:ToByte(0)).
        THIS-OBJECT:ugEmployeeProjectTime:Location = NEW System.Drawing.Point(4, 83).
        THIS-OBJECT:ugEmployeeProjectTime:Name = "ugEmployeeProjectTime".
        THIS-OBJECT:ugEmployeeProjectTime:Size = NEW System.Drawing.Size(493, 201).
        THIS-OBJECT:ugEmployeeProjectTime:TabIndex = 0.
        THIS-OBJECT:ugEmployeeProjectTime:Text = "ultraGrid1".
        /*  */
        /* btnFilter */
        /*  */
        DEFINE VARIABLE nestedvar1 AS System.Windows.Forms.AnchorStyles NO-UNDO.
        nestedvar1 = System.Windows.Forms.AnchorStyles:Top.
        THIS-OBJECT:btnFilter:Anchor = CAST(Progress.Util.EnumHelper:Or(nestedvar1, System.Windows.Forms.AnchorStyles:Right), System.Windows.Forms.AnchorStyles).
        THIS-OBJECT:btnFilter:Location = NEW System.Drawing.Point(422, 12).
        THIS-OBJECT:btnFilter:Name = "btnFilter".
        THIS-OBJECT:btnFilter:Size = NEW System.Drawing.Size(75, 23).
        THIS-OBJECT:btnFilter:TabIndex = 1.
        THIS-OBJECT:btnFilter:Text = "Filter".
        THIS-OBJECT:btnFilter:Click:Subscribe(THIS-OBJECT:btnFilter_Click).
        /*  */
        /* lblEmpName */
        /*  */
        THIS-OBJECT:lblEmpName:Location = NEW System.Drawing.Point(12, 17).
        THIS-OBJECT:lblEmpName:Name = "lblEmpName".
        THIS-OBJECT:lblEmpName:Size = NEW System.Drawing.Size(100, 23).
        THIS-OBJECT:lblEmpName:TabIndex = 2.
        THIS-OBJECT:lblEmpName:Text = "Employee Name".
        /*  */
        /* txtEmployeeName */
        /*  */
        THIS-OBJECT:txtEmployeeName:Location = NEW System.Drawing.Point(103, 13).
        THIS-OBJECT:txtEmployeeName:Name = "txtEmployeeName".
        THIS-OBJECT:txtEmployeeName:Size = NEW System.Drawing.Size(100, 21).
        THIS-OBJECT:txtEmployeeName:TabIndex = 3.
        /*  */
        /* lblPrjName */
        /*  */
        THIS-OBJECT:lblPrjName:Location = NEW System.Drawing.Point(13, 47).
        THIS-OBJECT:lblPrjName:Name = "lblPrjName".
        THIS-OBJECT:lblPrjName:Size = NEW System.Drawing.Size(100, 23).
        THIS-OBJECT:lblPrjName:TabIndex = 4.
        THIS-OBJECT:lblPrjName:Text = "Project Name".
        /*  */
        /* txtProjectName */
        /*  */
        THIS-OBJECT:txtProjectName:Location = NEW System.Drawing.Point(103, 47).
        THIS-OBJECT:txtProjectName:Name = "txtProjectName".
        THIS-OBJECT:txtProjectName:Size = NEW System.Drawing.Size(100, 21).
        THIS-OBJECT:txtProjectName:TabIndex = 5.
        /*  */
        /* btnExcel */
        /*  */
        THIS-OBJECT:btnExcel:Location = NEW System.Drawing.Point(422, 42).
        THIS-OBJECT:btnExcel:Name = "btnExcel".
        THIS-OBJECT:btnExcel:Size = NEW System.Drawing.Size(75, 23).
        THIS-OBJECT:btnExcel:TabIndex = 6.
        THIS-OBJECT:btnExcel:Text = "Excel".
        THIS-OBJECT:btnExcel:Click:Subscribe(THIS-OBJECT:btnExcel_Click).
        /*  */
        /* ucDepartment */
        /*  */
        THIS-OBJECT:ucDepartment:AllowNull = Infragistics.Win.DefaultableBoolean:True.
        THIS-OBJECT:ucDepartment:DataSource = THIS-OBJECT:bsCombo.
        appearance13:BackColor = System.Drawing.SystemColors:Window.
        appearance13:BorderColor = System.Drawing.SystemColors:InactiveCaption.
        THIS-OBJECT:ucDepartment:DisplayLayout:Appearance = appearance13.
        ultraGridColumn3:Header:VisiblePosition = 0.
        ultraGridColumn3:Hidden = TRUE.
        ultraGridColumn5:Header:VisiblePosition = 1.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar6 AS System.Object EXTENT 2 NO-UNDO.
        arrayvar6[1] = ultraGridColumn3.
        arrayvar6[2] = ultraGridColumn5.
        ultraGridBand3:Columns:AddRange(arrayvar6).
        THIS-OBJECT:ucDepartment:DisplayLayout:BandsSerializer:Add(ultraGridBand3).
        THIS-OBJECT:ucDepartment:DisplayLayout:BorderStyle = Infragistics.Win.UIElementBorderStyle:Solid.
        THIS-OBJECT:ucDepartment:DisplayLayout:CaptionVisible = Infragistics.Win.DefaultableBoolean:False.
        appearance14:BackColor = System.Drawing.SystemColors:ActiveBorder.
        appearance14:BackColor2 = System.Drawing.SystemColors:ControlDark.
        appearance14:BackGradientStyle = Infragistics.Win.GradientStyle:Vertical.
        appearance14:BorderColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ucDepartment:DisplayLayout:GroupByBox:Appearance = appearance14.
        appearance15:ForeColor = System.Drawing.SystemColors:GrayText.
        THIS-OBJECT:ucDepartment:DisplayLayout:GroupByBox:BandLabelAppearance = appearance15.
        THIS-OBJECT:ucDepartment:DisplayLayout:GroupByBox:BorderStyle = Infragistics.Win.UIElementBorderStyle:Solid.
        appearance16:BackColor = System.Drawing.SystemColors:ControlLightLight.
        appearance16:BackColor2 = System.Drawing.SystemColors:Control.
        appearance16:BackGradientStyle = Infragistics.Win.GradientStyle:Horizontal.
        appearance16:ForeColor = System.Drawing.SystemColors:GrayText.
        THIS-OBJECT:ucDepartment:DisplayLayout:GroupByBox:PromptAppearance = appearance16.
        THIS-OBJECT:ucDepartment:DisplayLayout:MaxColScrollRegions = 1.
        THIS-OBJECT:ucDepartment:DisplayLayout:MaxRowScrollRegions = 1.
        appearance17:BackColor = System.Drawing.SystemColors:Window.
        appearance17:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:ucDepartment:DisplayLayout:Override:ActiveCellAppearance = appearance17.
        appearance18:BackColor = System.Drawing.SystemColors:Highlight.
        appearance18:ForeColor = System.Drawing.SystemColors:HighlightText.
        THIS-OBJECT:ucDepartment:DisplayLayout:Override:ActiveRowAppearance = appearance18.
        THIS-OBJECT:ucDepartment:DisplayLayout:Override:BorderStyleCell = Infragistics.Win.UIElementBorderStyle:Dotted.
        THIS-OBJECT:ucDepartment:DisplayLayout:Override:BorderStyleRow = Infragistics.Win.UIElementBorderStyle:Dotted.
        appearance19:BackColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ucDepartment:DisplayLayout:Override:CardAreaAppearance = appearance19.
        appearance20:BorderColor = System.Drawing.Color:Silver.
        appearance20:TextTrimming = Infragistics.Win.TextTrimming:EllipsisCharacter.
        THIS-OBJECT:ucDepartment:DisplayLayout:Override:CellAppearance = appearance20.
        THIS-OBJECT:ucDepartment:DisplayLayout:Override:CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction:EditAndSelectText.
        THIS-OBJECT:ucDepartment:DisplayLayout:Override:CellPadding = 0.
        appearance21:BackColor = System.Drawing.SystemColors:Control.
        appearance21:BackColor2 = System.Drawing.SystemColors:ControlDark.
        appearance21:BackGradientAlignment = Infragistics.Win.GradientAlignment:Element.
        appearance21:BackGradientStyle = Infragistics.Win.GradientStyle:Horizontal.
        appearance21:BorderColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ucDepartment:DisplayLayout:Override:GroupByRowAppearance = appearance21.
        appearance22:TextHAlignAsString = "Left".
        THIS-OBJECT:ucDepartment:DisplayLayout:Override:HeaderAppearance = appearance22.
        THIS-OBJECT:ucDepartment:DisplayLayout:Override:HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction:SortMulti.
        THIS-OBJECT:ucDepartment:DisplayLayout:Override:HeaderStyle = Infragistics.Win.HeaderStyle:WindowsXPCommand.
        appearance23:BackColor = System.Drawing.SystemColors:Window.
        appearance23:BorderColor = System.Drawing.Color:Silver.
        THIS-OBJECT:ucDepartment:DisplayLayout:Override:RowAppearance = appearance23.
        THIS-OBJECT:ucDepartment:DisplayLayout:Override:RowSelectors = Infragistics.Win.DefaultableBoolean:False.
        appearance24:BackColor = System.Drawing.SystemColors:ControlLight.
        THIS-OBJECT:ucDepartment:DisplayLayout:Override:TemplateAddRowAppearance = appearance24.
        THIS-OBJECT:ucDepartment:DisplayLayout:ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds:ScrollToFill.
        THIS-OBJECT:ucDepartment:DisplayLayout:ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle:Immediate.
        THIS-OBJECT:ucDepartment:DisplayLayout:ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand:OutlookGroupBy.
        THIS-OBJECT:ucDepartment:DisplayMember = "department_name".
        THIS-OBJECT:ucDepartment:Location = NEW System.Drawing.Point(316, 13).
        THIS-OBJECT:ucDepartment:Name = "ucDepartment".
        THIS-OBJECT:ucDepartment:Size = NEW System.Drawing.Size(100, 22).
        THIS-OBJECT:ucDepartment:TabIndex = 7.
        THIS-OBJECT:ucDepartment:ValueMember = "department_ID".
        THIS-OBJECT:ucDepartment:InitializeLayout:Subscribe(THIS-OBJECT:ultraCombo1_InitializeLayout).
        /*  */
        /* bsCombo */
        /*  */
        THIS-OBJECT:bsCombo:AllowEdit = FALSE.
        THIS-OBJECT:bsCombo:AllowNew = FALSE.
        THIS-OBJECT:bsCombo:AllowRemove = FALSE.
        THIS-OBJECT:bsCombo:MaxDataGuess = 0.
        THIS-OBJECT:bsCombo:NoLOBs = FALSE.
        THIS-OBJECT:bsCombo:Position = 0.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar7 AS "Progress.Data.TableDesc[]" NO-UNDO.
        arrayvar7 = NEW "Progress.Data.TableDesc[]"(0).
        tableDesc3:ChildTables = arrayvar7.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar8 AS Progress.Data.ColumnPropDesc EXTENT 2 NO-UNDO.
        arrayvar8[1] = NEW Progress.Data.ColumnPropDesc("department_ID", "Department ID", Progress.Data.DataType:INTEGER).
        arrayvar8[2] = NEW Progress.Data.ColumnPropDesc("department_name", "Department Name", Progress.Data.DataType:CHARACTER).
        tableDesc3:Columns = arrayvar8.
        THIS-OBJECT:bsCombo:TableSchema = tableDesc3.
        /*  */
        /* employeeProjectTimeForm */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(501, 287).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:ucDepartment).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:btnExcel).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:txtProjectName).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:lblPrjName).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:txtEmployeeName).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:lblEmpName).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:btnFilter).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:ugEmployeeProjectTime).
        THIS-OBJECT:Name = "employeeProjectTimeForm".
        THIS-OBJECT:Text = "employeeProjectTime".
        CAST(THIS-OBJECT:bsEmployeeProjectTime, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:ugEmployeeProjectTime, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:txtEmployeeName, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:txtProjectName, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:ucDepartment, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:bsCombo, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:ResumeLayout(FALSE).
        THIS-OBJECT:PerformLayout().
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID ultraCombo1_InitializeLayout( INPUT sender AS System.Object, INPUT e AS Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs ):
		
		RETURN.

	END METHOD.

	DESTRUCTOR PUBLIC employeeProjectTimeForm ( ):

	END DESTRUCTOR.

END CLASS.