 
 /*------------------------------------------------------------------------
    File        : mainForm
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : tcoomans
    Created     : Thu Feb 04 17:06:47 CET 2016
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS gui.mainForm INHERITS Form: 
	
    DEFINE PRIVATE VARIABLE m_mainForm_Toolbars_Dock_Area_Top AS Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea NO-UNDO.
    DEFINE PRIVATE VARIABLE m_mainForm_Toolbars_Dock_Area_Right AS Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea NO-UNDO.
    DEFINE PRIVATE VARIABLE m_mainForm_Toolbars_Dock_Area_Left AS Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea NO-UNDO.
    DEFINE PRIVATE VARIABLE m_mainForm_Toolbars_Dock_Area_Bottom AS Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea NO-UNDO.
	DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraExplorerBar1 AS Infragistics.Win.UltraWinExplorerBar.UltraExplorerBar NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraTabbedMdiManager1 AS Infragistics.Win.UltraWinTabbedMdi.UltraTabbedMdiManager NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraToolbarsManager1 AS Infragistics.Win.UltraWinToolbars.UltraToolbarsManager NO-UNDO.

		
	CONSTRUCTOR PUBLIC mainForm (  ):
		
		
        SUPER().
        InitializeComponent().
        THIS-OBJECT:ComponentsCollection:ADD(THIS-OBJECT:components).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.

	END CONSTRUCTOR.

	METHOD PRIVATE VOID InitializeComponent(  ):
		
        /* NOTE: The following method is automatically generated.
        
        We strongly suggest that the contents of this method only be modified using the
        Visual Designer to avoid any incompatible modifications.
        
        Modifying the contents of this method using a code editor will invalidate any support for this file. */
        THIS-OBJECT:components = NEW System.ComponentModel.Container().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraExplorerBarGroup1 AS Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarGroup NO-UNDO.
        ultraExplorerBarGroup1 = NEW Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarGroup().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraExplorerBarItem1 AS Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarItem NO-UNDO.
        ultraExplorerBarItem1 = NEW Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarItem().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraExplorerBarItem2 AS Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarItem NO-UNDO.
        ultraExplorerBarItem2 = NEW Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarItem().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraExplorerBarItem7 AS Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarItem NO-UNDO.
        ultraExplorerBarItem7 = NEW Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarItem().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraExplorerBarItem8 AS Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarItem NO-UNDO.
        ultraExplorerBarItem8 = NEW Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarItem().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraExplorerBarItem10 AS Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarItem NO-UNDO.
        ultraExplorerBarItem10 = NEW Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarItem().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraExplorerBarItem12 AS Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarItem NO-UNDO.
        ultraExplorerBarItem12 = NEW Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarItem().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraExplorerBarItem13 AS Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarItem NO-UNDO.
        ultraExplorerBarItem13 = NEW Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarItem().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraExplorerBarGroup2 AS Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarGroup NO-UNDO.
        ultraExplorerBarGroup2 = NEW Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarGroup().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraExplorerBarItem11 AS Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarItem NO-UNDO.
        ultraExplorerBarItem11 = NEW Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarItem().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraExplorerBarItem3 AS Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarItem NO-UNDO.
        ultraExplorerBarItem3 = NEW Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarItem().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraExplorerBarItem6 AS Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarItem NO-UNDO.
        ultraExplorerBarItem6 = NEW Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarItem().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraExplorerBarItem9 AS Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarItem NO-UNDO.
        ultraExplorerBarItem9 = NEW Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarItem().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraExplorerBarGroup3 AS Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarGroup NO-UNDO.
        ultraExplorerBarGroup3 = NEW Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarGroup().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraExplorerBarItem4 AS Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarItem NO-UNDO.
        ultraExplorerBarItem4 = NEW Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarItem().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraExplorerBarItem5 AS Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarItem NO-UNDO.
        ultraExplorerBarItem5 = NEW Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarItem().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ribbonTab1 AS Infragistics.Win.UltraWinToolbars.RibbonTab NO-UNDO.
        ribbonTab1 = NEW Infragistics.Win.UltraWinToolbars.RibbonTab("ribbon1").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ribbonGroup1 AS Infragistics.Win.UltraWinToolbars.RibbonGroup NO-UNDO.
        ribbonGroup1 = NEW Infragistics.Win.UltraWinToolbars.RibbonGroup("ribbonGroup1").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool1 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool1 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Refreh").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool2 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool2 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Refreh").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance1 AS Infragistics.Win.Appearance NO-UNDO.
        appearance1 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE resources AS Progress.Util.ResourceManager NO-UNDO.
        resources = NEW Progress.Util.ResourceManager("gui.mainForm").
        THIS-OBJECT:ultraExplorerBar1 = NEW Infragistics.Win.UltraWinExplorerBar.UltraExplorerBar().
        THIS-OBJECT:ultraTabbedMdiManager1 = NEW Infragistics.Win.UltraWinTabbedMdi.UltraTabbedMdiManager(THIS-OBJECT:components).
        THIS-OBJECT:ultraToolbarsManager1 = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsManager(THIS-OBJECT:components).
        THIS-OBJECT:m_mainForm_Toolbars_Dock_Area_Left = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea().
        THIS-OBJECT:m_mainForm_Toolbars_Dock_Area_Right = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea().
        THIS-OBJECT:m_mainForm_Toolbars_Dock_Area_Top = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea().
        THIS-OBJECT:m_mainForm_Toolbars_Dock_Area_Bottom = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea().
        CAST(THIS-OBJECT:ultraExplorerBar1, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:ultraTabbedMdiManager1, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:ultraToolbarsManager1, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* ultraExplorerBar1 */
        /*  */
        THIS-OBJECT:ultraExplorerBar1:Dock = System.Windows.Forms.DockStyle:Left.
        ultraExplorerBarItem1:Key = "gui.teamMaintForm".
        ultraExplorerBarItem1:Text = "Team Maintenance".
        ultraExplorerBarItem2:Key = "gui.costTypeForm".
        ultraExplorerBarItem2:Text = "Cost Type Maintenance".
        ultraExplorerBarItem7:Key = "gui.TeamEmployeeMaintForm".
        ultraExplorerBarItem7:Text = "Team Maintenance".
        ultraExplorerBarItem8:Key = "gui.custMaintForm".
        ultraExplorerBarItem8:Text = "Customer Maintenance".
        ultraExplorerBarItem10:Key = "gui.projectProjectTimeCostForm".
        ultraExplorerBarItem10:Text = "Project Time and Cost Maintenance".
        ultraExplorerBarItem12:Key = "gui.currencyMaintForm".
        ultraExplorerBarItem12:Text = "Currency Maintenace".
        ultraExplorerBarItem13:Key = "gui.currencyRates.CurrencyRatesForm".
        ultraExplorerBarItem13:Text = "Currency Rates Maintenance".
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar0 AS Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarItem EXTENT 7 NO-UNDO.
        arrayvar0[1] = ultraExplorerBarItem1.
        arrayvar0[2] = ultraExplorerBarItem2.
        arrayvar0[3] = ultraExplorerBarItem7.
        arrayvar0[4] = ultraExplorerBarItem8.
        arrayvar0[5] = ultraExplorerBarItem10.
        arrayvar0[6] = ultraExplorerBarItem12.
        arrayvar0[7] = ultraExplorerBarItem13.
        ultraExplorerBarGroup1:Items:AddRange(arrayvar0).
        ultraExplorerBarGroup1:Text = "Data Entry".
        ultraExplorerBarItem11:Key = "gui.dashboard.dashboardForm".
        ultraExplorerBarItem11:Text = "Dashboard".
        ultraExplorerBarItem3:Key = "gui.customerProjectCompleteForm".
        ultraExplorerBarItem3:Text = "Customer Project Full ".
        ultraExplorerBarItem6:Key = "gui.teamForm".
        ultraExplorerBarItem6:Text = "Team Export".
        ultraExplorerBarItem9:Key = "gui.employeeProjectTimeForm".
        ultraExplorerBarItem9:Text = "Employee Project Time".
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar1 AS Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarItem EXTENT 4 NO-UNDO.
        arrayvar1[1] = ultraExplorerBarItem11.
        arrayvar1[2] = ultraExplorerBarItem3.
        arrayvar1[3] = ultraExplorerBarItem6.
        arrayvar1[4] = ultraExplorerBarItem9.
        ultraExplorerBarGroup2:Items:AddRange(arrayvar1).
        ultraExplorerBarGroup2:Text = "Reports".
        ultraExplorerBarItem4:Key = "gui.dynamicDataForm".
        ultraExplorerBarItem4:Text = "Dynamic Data Form".
        ultraExplorerBarItem5:Key = "gui.dropdownInGrid".
        ultraExplorerBarItem5:Text = "DropDown in Grid Sample".
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar2 AS Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarItem EXTENT 2 NO-UNDO.
        arrayvar2[1] = ultraExplorerBarItem4.
        arrayvar2[2] = ultraExplorerBarItem5.
        ultraExplorerBarGroup3:Items:AddRange(arrayvar2).
        ultraExplorerBarGroup3:Text = "Weirdo stuff".
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar3 AS Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarGroup EXTENT 3 NO-UNDO.
        arrayvar3[1] = ultraExplorerBarGroup1.
        arrayvar3[2] = ultraExplorerBarGroup2.
        arrayvar3[3] = ultraExplorerBarGroup3.
        THIS-OBJECT:ultraExplorerBar1:Groups:AddRange(arrayvar3).
        THIS-OBJECT:ultraExplorerBar1:Location = NEW System.Drawing.Point(8, 162).
        THIS-OBJECT:ultraExplorerBar1:Name = "ultraExplorerBar1".
        THIS-OBJECT:ultraExplorerBar1:Size = NEW System.Drawing.Size(175, 242).
        THIS-OBJECT:ultraExplorerBar1:Style = Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarStyle:OutlookNavigationPane.
        THIS-OBJECT:ultraExplorerBar1:TabIndex = 1.
        THIS-OBJECT:ultraExplorerBar1:ViewStyle = Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarViewStyle:Office2007.
        THIS-OBJECT:ultraExplorerBar1:ItemClick:Subscribe(THIS-OBJECT:ultraExplorerBar1_ItemClick).
        /*  */
        /* ultraTabbedMdiManager1 */
        /*  */
        THIS-OBJECT:ultraTabbedMdiManager1:MdiParent = THIS-OBJECT.
        THIS-OBJECT:ultraTabbedMdiManager1:ViewStyle = Infragistics.Win.UltraWinTabbedMdi.ViewStyle:Office2007.
        /*  */
        /* ultraToolbarsManager1 */
        /*  */
        THIS-OBJECT:ultraToolbarsManager1:DesignerFlags = 1.
        THIS-OBJECT:ultraToolbarsManager1:DockWithinContainer = THIS-OBJECT.
        THIS-OBJECT:ultraToolbarsManager1:DockWithinContainerBaseType = Progress.Util.TypeHelper:GetType("Progress.Windows.Form").
        ribbonTab1:Caption = "ribbon1".
        ribbonGroup1:Caption = "ribbonGroup1".
        buttonTool1:InstanceProps:PreferredSizeOnRibbon = Infragistics.Win.UltraWinToolbars.RibbonToolSize:Large.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar4 AS Infragistics.Win.UltraWinToolbars.ToolBase EXTENT 1 NO-UNDO.
        arrayvar4[1] = buttonTool1.
        ribbonGroup1:Tools:AddRange(arrayvar4).
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar5 AS Infragistics.Win.UltraWinToolbars.RibbonGroup EXTENT 1 NO-UNDO.
        arrayvar5[1] = ribbonGroup1.
        ribbonTab1:Groups:AddRange(arrayvar5).
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar6 AS Infragistics.Win.UltraWinToolbars.RibbonTab EXTENT 1 NO-UNDO.
        arrayvar6[1] = ribbonTab1.
        THIS-OBJECT:ultraToolbarsManager1:Ribbon:NonInheritedRibbonTabs:AddRange(arrayvar6).
        THIS-OBJECT:ultraToolbarsManager1:Ribbon:Visible = TRUE.
        appearance1:Image = CAST(resources:GetObject("appearance1.Image"), System.Object).
        buttonTool2:SharedPropsInternal:AppearancesLarge:Appearance = appearance1.
        buttonTool2:SharedPropsInternal:Caption = "Refreh".
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar7 AS Infragistics.Win.UltraWinToolbars.ToolBase EXTENT 1 NO-UNDO.
        arrayvar7[1] = buttonTool2.
        THIS-OBJECT:ultraToolbarsManager1:Tools:AddRange(arrayvar7).
        /*  */
        /* m_mainForm_Toolbars_Dock_Area_Left */
        /*  */
        THIS-OBJECT:m_mainForm_Toolbars_Dock_Area_Left:AccessibleRole = System.Windows.Forms.AccessibleRole:Grouping.
        THIS-OBJECT:m_mainForm_Toolbars_Dock_Area_Left:BackColor = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(191)), System.Convert:ToInt32(System.Convert:ToByte(219)), System.Convert:ToInt32(System.Convert:ToByte(255))).
        THIS-OBJECT:m_mainForm_Toolbars_Dock_Area_Left:DockedPosition = Infragistics.Win.UltraWinToolbars.DockedPosition:Left.
        THIS-OBJECT:m_mainForm_Toolbars_Dock_Area_Left:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:m_mainForm_Toolbars_Dock_Area_Left:InitialResizeAreaExtent = 8.
        THIS-OBJECT:m_mainForm_Toolbars_Dock_Area_Left:Location = NEW System.Drawing.Point(0, 162).
        THIS-OBJECT:m_mainForm_Toolbars_Dock_Area_Left:Name = "m_mainForm_Toolbars_Dock_Area_Left".
        THIS-OBJECT:m_mainForm_Toolbars_Dock_Area_Left:Size = NEW System.Drawing.Size(8, 242).
        THIS-OBJECT:m_mainForm_Toolbars_Dock_Area_Left:ToolbarsManager = THIS-OBJECT:ultraToolbarsManager1.
        /*  */
        /* m_mainForm_Toolbars_Dock_Area_Right */
        /*  */
        THIS-OBJECT:m_mainForm_Toolbars_Dock_Area_Right:AccessibleRole = System.Windows.Forms.AccessibleRole:Grouping.
        THIS-OBJECT:m_mainForm_Toolbars_Dock_Area_Right:BackColor = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(191)), System.Convert:ToInt32(System.Convert:ToByte(219)), System.Convert:ToInt32(System.Convert:ToByte(255))).
        THIS-OBJECT:m_mainForm_Toolbars_Dock_Area_Right:DockedPosition = Infragistics.Win.UltraWinToolbars.DockedPosition:Right.
        THIS-OBJECT:m_mainForm_Toolbars_Dock_Area_Right:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:m_mainForm_Toolbars_Dock_Area_Right:InitialResizeAreaExtent = 8.
        THIS-OBJECT:m_mainForm_Toolbars_Dock_Area_Right:Location = NEW System.Drawing.Point(550, 162).
        THIS-OBJECT:m_mainForm_Toolbars_Dock_Area_Right:Name = "m_mainForm_Toolbars_Dock_Area_Right".
        THIS-OBJECT:m_mainForm_Toolbars_Dock_Area_Right:Size = NEW System.Drawing.Size(8, 242).
        THIS-OBJECT:m_mainForm_Toolbars_Dock_Area_Right:ToolbarsManager = THIS-OBJECT:ultraToolbarsManager1.
        /*  */
        /* m_mainForm_Toolbars_Dock_Area_Top */
        /*  */
        THIS-OBJECT:m_mainForm_Toolbars_Dock_Area_Top:AccessibleRole = System.Windows.Forms.AccessibleRole:Grouping.
        THIS-OBJECT:m_mainForm_Toolbars_Dock_Area_Top:BackColor = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(191)), System.Convert:ToInt32(System.Convert:ToByte(219)), System.Convert:ToInt32(System.Convert:ToByte(255))).
        THIS-OBJECT:m_mainForm_Toolbars_Dock_Area_Top:DockedPosition = Infragistics.Win.UltraWinToolbars.DockedPosition:Top.
        THIS-OBJECT:m_mainForm_Toolbars_Dock_Area_Top:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:m_mainForm_Toolbars_Dock_Area_Top:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:m_mainForm_Toolbars_Dock_Area_Top:Name = "m_mainForm_Toolbars_Dock_Area_Top".
        THIS-OBJECT:m_mainForm_Toolbars_Dock_Area_Top:Size = NEW System.Drawing.Size(558, 162).
        THIS-OBJECT:m_mainForm_Toolbars_Dock_Area_Top:ToolbarsManager = THIS-OBJECT:ultraToolbarsManager1.
        /*  */
        /* m_mainForm_Toolbars_Dock_Area_Bottom */
        /*  */
        THIS-OBJECT:m_mainForm_Toolbars_Dock_Area_Bottom:AccessibleRole = System.Windows.Forms.AccessibleRole:Grouping.
        THIS-OBJECT:m_mainForm_Toolbars_Dock_Area_Bottom:BackColor = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(191)), System.Convert:ToInt32(System.Convert:ToByte(219)), System.Convert:ToInt32(System.Convert:ToByte(255))).
        THIS-OBJECT:m_mainForm_Toolbars_Dock_Area_Bottom:DockedPosition = Infragistics.Win.UltraWinToolbars.DockedPosition:Bottom.
        THIS-OBJECT:m_mainForm_Toolbars_Dock_Area_Bottom:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:m_mainForm_Toolbars_Dock_Area_Bottom:InitialResizeAreaExtent = 8.
        THIS-OBJECT:m_mainForm_Toolbars_Dock_Area_Bottom:Location = NEW System.Drawing.Point(0, 404).
        THIS-OBJECT:m_mainForm_Toolbars_Dock_Area_Bottom:Name = "m_mainForm_Toolbars_Dock_Area_Bottom".
        THIS-OBJECT:m_mainForm_Toolbars_Dock_Area_Bottom:Size = NEW System.Drawing.Size(558, 8).
        THIS-OBJECT:m_mainForm_Toolbars_Dock_Area_Bottom:ToolbarsManager = THIS-OBJECT:ultraToolbarsManager1.
        /*  */
        /* mainForm */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(558, 412).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:ultraExplorerBar1).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:m_mainForm_Toolbars_Dock_Area_Left).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:m_mainForm_Toolbars_Dock_Area_Right).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:m_mainForm_Toolbars_Dock_Area_Bottom).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:m_mainForm_Toolbars_Dock_Area_Top).
        THIS-OBJECT:IsMdiContainer = TRUE.
        THIS-OBJECT:Name = "mainForm".
        THIS-OBJECT:Text = "mainForm".
        CAST(THIS-OBJECT:ultraExplorerBar1, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:ultraTabbedMdiManager1, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:ultraToolbarsManager1, System.ComponentModel.ISupportInitialize):EndInit().
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
	METHOD PRIVATE VOID ultraExplorerBar1_ItemClick( INPUT sender AS System.Object, INPUT e AS Infragistics.Win.UltraWinExplorerBar.ItemEventArgs ):
		
		DEFINE VARIABLE objForm AS Progress.Windows.Form NO-UNDO.
		DEFINE VARIABLE cProgramToStart AS CHARACTER NO-UNDO.
		
		cProgramToStart = e:ITEM:Key.
		objForm = DYNAMIC-NEW cProgramToStart().
		objForm:MdiParent = THIS-OBJECT.
        objForm:Show().
	

	END METHOD.

	DESTRUCTOR PUBLIC mainForm ( ):

	END DESTRUCTOR.

END CLASS.