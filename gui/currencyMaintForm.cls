 
 /*------------------------------------------------------------------------
    File        : currencyMaintForm
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : petter
    Created     : Fri Jan 29 09:39:47 GMT 2016
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS gui.currencyMaintForm INHERITS gui.baseForm: 
	
    DEFINE PRIVATE VARIABLE bsCurrency AS Progress.Data.BindingSource NO-UNDO.
    DEFINE PRIVATE VARIABLE currencyNameEditor AS Infragistics.Win.UltraWinEditors.UltraTextEditor NO-UNDO.
    DEFINE PRIVATE VARIABLE currencySymbolEditor AS Infragistics.Win.UltraWinEditors.UltraTextEditor NO-UNDO.
    DEFINE PRIVATE VARIABLE currencySymbolLabel AS Infragistics.Win.Misc.UltraLabel NO-UNDO.
    DEFINE PRIVATE VARIABLE m_currencyMaintForm_Toolbars_Dock_Area_Top AS Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea NO-UNDO.
    DEFINE PRIVATE VARIABLE m_currencyMaintForm_Toolbars_Dock_Area_Right AS Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea NO-UNDO.
    DEFINE PRIVATE VARIABLE m_currencyMaintForm_Toolbars_Dock_Area_Left AS Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea NO-UNDO.
    DEFINE PRIVATE VARIABLE m_currencyMaintForm_Toolbars_Dock_Area_Bottom AS Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea NO-UNDO.
	DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE currencyNameLabel AS Infragistics.Win.Misc.UltraLabel NO-UNDO.
    DEFINE PRIVATE VARIABLE currencyIdLabel AS Infragistics.Win.Misc.UltraLabel NO-UNDO.
    DEFINE PRIVATE VARIABLE toolbarsManager AS Infragistics.Win.UltraWinToolbars.UltraToolbarsManager NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraGrid1 AS Infragistics.Win.UltraWinGrid.UltraGrid NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraNumericEditor1 AS Infragistics.Win.UltraWinEditors.UltraNumericEditor NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraTabPageControl1 AS Infragistics.Win.UltraWinTabControl.UltraTabPageControl NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraTabSharedControlsPage1 AS Infragistics.Win.UltraWinTabControl.UltraTabSharedControlsPage NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraTabControl1 AS Infragistics.Win.UltraWinTabControl.UltraTabControl NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraSplitter1 AS Infragistics.Win.Misc.UltraSplitter NO-UNDO.
    DEFINE PRIVATE VARIABLE currencyMaintForm_Fill_Panel AS Infragistics.Win.Misc.UltraPanel NO-UNDO.

    DEFINE PRIVATE VARIABLE objCurrency AS gui.currencyModel NO-UNDO. 
		
	CONSTRUCTOR PUBLIC currencyMaintForm ( ):
		
		
        SUPER().
        InitializeComponent().
        
        
        enableTools(INPUT "Init").
        /* Launch the backend class */   
        objCurrency = NEW gui.currencyModel().
        /* bind the dataset to the bindingsource */
        bsCurrency:HANDLE = objCurrency:getCurrencyHandle().


        /* get the data from the backend */
        objCurrency:getCurrency().
    
      
              
      
      
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
        DEFINE VARIABLE tableDesc1 AS Progress.Data.TableDesc NO-UNDO.
        tableDesc1 = NEW Progress.Data.TableDesc("ttCurrency").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ribbonTab1 AS Infragistics.Win.UltraWinToolbars.RibbonTab NO-UNDO.
        ribbonTab1 = NEW Infragistics.Win.UltraWinToolbars.RibbonTab("Maintenance tools").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ribbonGroup1 AS Infragistics.Win.UltraWinToolbars.RibbonGroup NO-UNDO.
        ribbonGroup1 = NEW Infragistics.Win.UltraWinToolbars.RibbonGroup("MaintGroup").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool1 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool1 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("New").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool2 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool2 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Edit").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool3 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool3 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Delete").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool4 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool4 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Save").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool5 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool5 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Cancel").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool6 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool6 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("New").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance13 AS Infragistics.Win.Appearance NO-UNDO.
        appearance13 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE resources AS Progress.Util.ResourceManager NO-UNDO.
        resources = NEW Progress.Util.ResourceManager("gui.currencyMaintForm").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool7 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool7 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Edit").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance14 AS Infragistics.Win.Appearance NO-UNDO.
        appearance14 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool8 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool8 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Delete").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance15 AS Infragistics.Win.Appearance NO-UNDO.
        appearance15 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool9 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool9 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Save").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance16 AS Infragistics.Win.Appearance NO-UNDO.
        appearance16 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool10 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool10 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Cancel").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance17 AS Infragistics.Win.Appearance NO-UNDO.
        appearance17 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance1 AS Infragistics.Win.Appearance NO-UNDO.
        appearance1 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridBand1 AS Infragistics.Win.UltraWinGrid.UltraGridBand NO-UNDO.
        ultraGridBand1 = NEW Infragistics.Win.UltraWinGrid.UltraGridBand("ttCurrency", -1).
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn1 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn1 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("currency_id").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn2 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn2 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("symbol").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn3 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn3 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("currency_name").
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
        DEFINE VARIABLE ultraTab1 AS Infragistics.Win.UltraWinTabControl.UltraTab NO-UNDO.
        ultraTab1 = NEW Infragistics.Win.UltraWinTabControl.UltraTab().
        THIS-OBJECT:ultraTabPageControl1 = NEW Infragistics.Win.UltraWinTabControl.UltraTabPageControl().
        THIS-OBJECT:currencySymbolLabel = NEW Infragistics.Win.Misc.UltraLabel().
        THIS-OBJECT:currencySymbolEditor = NEW Infragistics.Win.UltraWinEditors.UltraTextEditor().
        THIS-OBJECT:bsCurrency = NEW Progress.Data.BindingSource(THIS-OBJECT:components).
        THIS-OBJECT:currencyIdLabel = NEW Infragistics.Win.Misc.UltraLabel().
        THIS-OBJECT:currencyNameLabel = NEW Infragistics.Win.Misc.UltraLabel().
        THIS-OBJECT:ultraNumericEditor1 = NEW Infragistics.Win.UltraWinEditors.UltraNumericEditor().
        THIS-OBJECT:currencyNameEditor = NEW Infragistics.Win.UltraWinEditors.UltraTextEditor().
        THIS-OBJECT:toolbarsManager = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsManager(THIS-OBJECT:components).
        THIS-OBJECT:currencyMaintForm_Fill_Panel = NEW Infragistics.Win.Misc.UltraPanel().
        THIS-OBJECT:ultraGrid1 = NEW Infragistics.Win.UltraWinGrid.UltraGrid().
        THIS-OBJECT:ultraSplitter1 = NEW Infragistics.Win.Misc.UltraSplitter().
        THIS-OBJECT:ultraTabControl1 = NEW Infragistics.Win.UltraWinTabControl.UltraTabControl().
        THIS-OBJECT:ultraTabSharedControlsPage1 = NEW Infragistics.Win.UltraWinTabControl.UltraTabSharedControlsPage().
        THIS-OBJECT:m_currencyMaintForm_Toolbars_Dock_Area_Left = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea().
        THIS-OBJECT:m_currencyMaintForm_Toolbars_Dock_Area_Right = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea().
        THIS-OBJECT:m_currencyMaintForm_Toolbars_Dock_Area_Top = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea().
        THIS-OBJECT:m_currencyMaintForm_Toolbars_Dock_Area_Bottom = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea().
        THIS-OBJECT:ultraTabPageControl1:SuspendLayout().
        CAST(THIS-OBJECT:currencySymbolEditor, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:bsCurrency, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:ultraNumericEditor1, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:currencyNameEditor, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:toolbarsManager, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:currencyMaintForm_Fill_Panel:ClientArea:SuspendLayout().
        THIS-OBJECT:currencyMaintForm_Fill_Panel:SuspendLayout().
        CAST(THIS-OBJECT:ultraGrid1, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:ultraTabControl1, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:ultraTabControl1:SuspendLayout().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* ultraTabPageControl1 */
        /*  */
        THIS-OBJECT:ultraTabPageControl1:Controls:Add(THIS-OBJECT:currencySymbolLabel).
        THIS-OBJECT:ultraTabPageControl1:Controls:Add(THIS-OBJECT:currencySymbolEditor).
        THIS-OBJECT:ultraTabPageControl1:Controls:Add(THIS-OBJECT:currencyIdLabel).
        THIS-OBJECT:ultraTabPageControl1:Controls:Add(THIS-OBJECT:currencyNameLabel).
        THIS-OBJECT:ultraTabPageControl1:Controls:Add(THIS-OBJECT:ultraNumericEditor1).
        THIS-OBJECT:ultraTabPageControl1:Controls:Add(THIS-OBJECT:currencyNameEditor).
        THIS-OBJECT:ultraTabPageControl1:Location = NEW System.Drawing.Point(1, 25).
        THIS-OBJECT:ultraTabPageControl1:Name = "ultraTabPageControl1".
        THIS-OBJECT:ultraTabPageControl1:Size = NEW System.Drawing.Size(880, 78).
        /*  */
        /* currencySymbolLabel */
        /*  */
        THIS-OBJECT:currencySymbolLabel:Location = NEW System.Drawing.Point(42, 10).
        THIS-OBJECT:currencySymbolLabel:Name = "currencySymbolLabel".
        THIS-OBJECT:currencySymbolLabel:Size = NEW System.Drawing.Size(106, 23).
        THIS-OBJECT:currencySymbolLabel:TabIndex = 5.
        THIS-OBJECT:currencySymbolLabel:Text = "Currency Symbol:".
        /*  */
        /* currencySymbolEditor */
        /*  */
        THIS-OBJECT:currencySymbolEditor:AcceptsTab = TRUE.
        THIS-OBJECT:currencySymbolEditor:DataBindings:Add(NEW System.Windows.Forms.Binding("Text", THIS-OBJECT:bsCurrency, "symbol", TRUE)).
        THIS-OBJECT:currencySymbolEditor:Location = NEW System.Drawing.Point(154, 9).
        THIS-OBJECT:currencySymbolEditor:Name = "currencySymbolEditor".
        THIS-OBJECT:currencySymbolEditor:Size = NEW System.Drawing.Size(62, 25).
        THIS-OBJECT:currencySymbolEditor:TabIndex = 4.
        /*  */
        /* bsCurrency */
        /*  */
        THIS-OBJECT:bsCurrency:MaxDataGuess = 0.
        THIS-OBJECT:bsCurrency:NoLOBs = FALSE.
        THIS-OBJECT:bsCurrency:Position = 0.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar0 AS "Progress.Data.TableDesc[]" NO-UNDO.
        arrayvar0 = NEW "Progress.Data.TableDesc[]"(0).
        tableDesc1:ChildTables = arrayvar0.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar1 AS Progress.Data.ColumnPropDesc EXTENT 3 NO-UNDO.
        arrayvar1[1] = NEW Progress.Data.ColumnPropDesc("currency_id", "Currency ID", Progress.Data.DataType:INTEGER).
        arrayvar1[2] = NEW Progress.Data.ColumnPropDesc("symbol", "Symbol", Progress.Data.DataType:CHARACTER).
        arrayvar1[3] = NEW Progress.Data.ColumnPropDesc("currency_name", "Currency", Progress.Data.DataType:CHARACTER).
        tableDesc1:Columns = arrayvar1.
        THIS-OBJECT:bsCurrency:TableSchema = tableDesc1.
        /*  */
        /* currencyIdLabel */
        /*  */
        THIS-OBJECT:currencyIdLabel:Location = NEW System.Drawing.Point(323, 39).
        THIS-OBJECT:currencyIdLabel:Name = "currencyIdLabel".
        THIS-OBJECT:currencyIdLabel:Size = NEW System.Drawing.Size(76, 23).
        THIS-OBJECT:currencyIdLabel:TabIndex = 3.
        THIS-OBJECT:currencyIdLabel:Text = "Currency id:".
        /*  */
        /* currencyNameLabel */
        /*  */
        THIS-OBJECT:currencyNameLabel:Location = NEW System.Drawing.Point(42, 39).
        THIS-OBJECT:currencyNameLabel:Name = "currencyNameLabel".
        THIS-OBJECT:currencyNameLabel:Size = NEW System.Drawing.Size(106, 23).
        THIS-OBJECT:currencyNameLabel:TabIndex = 2.
        THIS-OBJECT:currencyNameLabel:Text = "Currency name: ".
        /*  */
        /* ultraNumericEditor1 */
        /*  */
        THIS-OBJECT:ultraNumericEditor1:Enabled = FALSE.
        THIS-OBJECT:ultraNumericEditor1:Location = NEW System.Drawing.Point(409, 38).
        THIS-OBJECT:ultraNumericEditor1:Name = "ultraNumericEditor1".
        THIS-OBJECT:ultraNumericEditor1:PromptChar = ' '.
        THIS-OBJECT:ultraNumericEditor1:Size = NEW System.Drawing.Size(75, 25).
        THIS-OBJECT:ultraNumericEditor1:TabIndex = 1.
        /*  */
        /* currencyNameEditor */
        /*  */
        THIS-OBJECT:currencyNameEditor:DataBindings:Add(NEW System.Windows.Forms.Binding("Text", THIS-OBJECT:bsCurrency, "currency_name", TRUE)).
        THIS-OBJECT:currencyNameEditor:Location = NEW System.Drawing.Point(154, 38).
        THIS-OBJECT:currencyNameEditor:Name = "currencyNameEditor".
        THIS-OBJECT:currencyNameEditor:Size = NEW System.Drawing.Size(141, 25).
        THIS-OBJECT:currencyNameEditor:TabIndex = 0.
        THIS-OBJECT:currencyNameEditor:ValueChanged:Subscribe(THIS-OBJECT:ultraTextEditor1_ValueChanged).
        /*  */
        /* toolbarsManager */
        /*  */
        THIS-OBJECT:toolbarsManager:DesignerFlags = 1.
        THIS-OBJECT:toolbarsManager:DockWithinContainer = THIS-OBJECT.
        THIS-OBJECT:toolbarsManager:DockWithinContainerBaseType = Progress.Util.TypeHelper:GetType("gui.baseForm").
        ribbonTab1:Caption = "Maintenance Tools".
        ribbonGroup1:Caption = "MaintGroup".
        buttonTool1:InstanceProps:PreferredSizeOnRibbon = Infragistics.Win.UltraWinToolbars.RibbonToolSize:Large.
        buttonTool2:InstanceProps:PreferredSizeOnRibbon = Infragistics.Win.UltraWinToolbars.RibbonToolSize:Large.
        buttonTool3:InstanceProps:PreferredSizeOnRibbon = Infragistics.Win.UltraWinToolbars.RibbonToolSize:Large.
        buttonTool4:InstanceProps:IsFirstInGroup = TRUE.
        buttonTool4:InstanceProps:PreferredSizeOnRibbon = Infragistics.Win.UltraWinToolbars.RibbonToolSize:Large.
        buttonTool5:InstanceProps:PreferredSizeOnRibbon = Infragistics.Win.UltraWinToolbars.RibbonToolSize:Large.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar2 AS Infragistics.Win.UltraWinToolbars.ToolBase EXTENT 5 NO-UNDO.
        arrayvar2[1] = buttonTool1.
        arrayvar2[2] = buttonTool2.
        arrayvar2[3] = buttonTool3.
        arrayvar2[4] = buttonTool4.
        arrayvar2[5] = buttonTool5.
        ribbonGroup1:Tools:AddRange(arrayvar2).
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar3 AS Infragistics.Win.UltraWinToolbars.RibbonGroup EXTENT 1 NO-UNDO.
        arrayvar3[1] = ribbonGroup1.
        ribbonTab1:Groups:AddRange(arrayvar3).
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar4 AS Infragistics.Win.UltraWinToolbars.RibbonTab EXTENT 1 NO-UNDO.
        arrayvar4[1] = ribbonTab1.
        THIS-OBJECT:toolbarsManager:Ribbon:NonInheritedRibbonTabs:AddRange(arrayvar4).
        THIS-OBJECT:toolbarsManager:Ribbon:Visible = TRUE.
        THIS-OBJECT:toolbarsManager:ShowFullMenusDelay = 500.
        appearance13:Image = CAST(resources:GetObject("appearance13.Image"), System.Object).
        buttonTool6:SharedPropsInternal:AppearancesLarge:Appearance = appearance13.
        buttonTool6:SharedPropsInternal:Caption = "New".
        buttonTool6:SharedPropsInternal:Category = "tableio".
        appearance14:Image = CAST(resources:GetObject("appearance14.Image"), System.Object).
        buttonTool7:SharedPropsInternal:AppearancesLarge:Appearance = appearance14.
        buttonTool7:SharedPropsInternal:Caption = "Edit".
        buttonTool7:SharedPropsInternal:Category = "tableio".
        appearance15:Image = CAST(resources:GetObject("appearance15.Image"), System.Object).
        buttonTool8:SharedPropsInternal:AppearancesLarge:Appearance = appearance15.
        buttonTool8:SharedPropsInternal:Caption = "Delete".
        buttonTool8:SharedPropsInternal:Category = "tableio".
        appearance16:Image = CAST(resources:GetObject("appearance16.Image"), System.Object).
        buttonTool9:SharedPropsInternal:AppearancesLarge:Appearance = appearance16.
        buttonTool9:SharedPropsInternal:Caption = "Save".
        buttonTool9:SharedPropsInternal:Category = "tableio".
        appearance17:Image = CAST(resources:GetObject("appearance17.Image"), System.Object).
        buttonTool10:SharedPropsInternal:AppearancesLarge:Appearance = appearance17.
        buttonTool10:SharedPropsInternal:Caption = "Cancel".
        buttonTool10:SharedPropsInternal:Category = "tableio".
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar5 AS Infragistics.Win.UltraWinToolbars.ToolBase EXTENT 5 NO-UNDO.
        arrayvar5[1] = buttonTool6.
        arrayvar5[2] = buttonTool7.
        arrayvar5[3] = buttonTool8.
        arrayvar5[4] = buttonTool9.
        arrayvar5[5] = buttonTool10.
        THIS-OBJECT:toolbarsManager:Tools:AddRange(arrayvar5).
        THIS-OBJECT:toolbarsManager:ToolClick:Subscribe(THIS-OBJECT:ultraToolbarsManager1_ToolClick).
        /*  */
        /* currencyMaintForm_Fill_Panel */
        /*  */
        /*  */
        /* currencyMaintForm_Fill_Panel.ClientArea */
        /*  */
        THIS-OBJECT:currencyMaintForm_Fill_Panel:ClientArea:Controls:Add(THIS-OBJECT:ultraGrid1).
        THIS-OBJECT:currencyMaintForm_Fill_Panel:ClientArea:Controls:Add(THIS-OBJECT:ultraSplitter1).
        THIS-OBJECT:currencyMaintForm_Fill_Panel:ClientArea:Controls:Add(THIS-OBJECT:ultraTabControl1).
        THIS-OBJECT:currencyMaintForm_Fill_Panel:Cursor = System.Windows.Forms.Cursors:Default.
        THIS-OBJECT:currencyMaintForm_Fill_Panel:Dock = System.Windows.Forms.DockStyle:Fill.
        THIS-OBJECT:currencyMaintForm_Fill_Panel:Location = NEW System.Drawing.Point(8, 162).
        THIS-OBJECT:currencyMaintForm_Fill_Panel:Name = "currencyMaintForm_Fill_Panel".
        THIS-OBJECT:currencyMaintForm_Fill_Panel:Size = NEW System.Drawing.Size(884, 330).
        THIS-OBJECT:currencyMaintForm_Fill_Panel:TabIndex = 0.
        /*  */
        /* ultraGrid1 */
        /*  */
        THIS-OBJECT:ultraGrid1:DataSource = THIS-OBJECT:bsCurrency.
        appearance1:BackColor = System.Drawing.SystemColors:Window.
        appearance1:BorderColor = System.Drawing.SystemColors:InactiveCaption.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Appearance = appearance1.
        ultraGridColumn1:Header:VisiblePosition = 0.
        ultraGridColumn2:Header:VisiblePosition = 1.
        ultraGridColumn3:Header:VisiblePosition = 2.
        ultraGridColumn3:Width = 259.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar6 AS System.Object EXTENT 3 NO-UNDO.
        arrayvar6[1] = ultraGridColumn1.
        arrayvar6[2] = ultraGridColumn2.
        arrayvar6[3] = ultraGridColumn3.
        ultraGridBand1:Columns:AddRange(arrayvar6).
        THIS-OBJECT:ultraGrid1:DisplayLayout:BandsSerializer:Add(ultraGridBand1).
        THIS-OBJECT:ultraGrid1:DisplayLayout:BorderStyle = Infragistics.Win.UIElementBorderStyle:Solid.
        THIS-OBJECT:ultraGrid1:DisplayLayout:CaptionVisible = Infragistics.Win.DefaultableBoolean:False.
        appearance2:BackColor = System.Drawing.SystemColors:ActiveBorder.
        appearance2:BackColor2 = System.Drawing.SystemColors:ControlDark.
        appearance2:BackGradientStyle = Infragistics.Win.GradientStyle:Vertical.
        appearance2:BorderColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ultraGrid1:DisplayLayout:GroupByBox:Appearance = appearance2.
        appearance3:ForeColor = System.Drawing.SystemColors:GrayText.
        THIS-OBJECT:ultraGrid1:DisplayLayout:GroupByBox:BandLabelAppearance = appearance3.
        THIS-OBJECT:ultraGrid1:DisplayLayout:GroupByBox:BorderStyle = Infragistics.Win.UIElementBorderStyle:Solid.
        appearance4:BackColor = System.Drawing.SystemColors:ControlLightLight.
        appearance4:BackColor2 = System.Drawing.SystemColors:Control.
        appearance4:BackGradientStyle = Infragistics.Win.GradientStyle:Horizontal.
        appearance4:ForeColor = System.Drawing.SystemColors:GrayText.
        THIS-OBJECT:ultraGrid1:DisplayLayout:GroupByBox:PromptAppearance = appearance4.
        THIS-OBJECT:ultraGrid1:DisplayLayout:MaxColScrollRegions = 1.
        THIS-OBJECT:ultraGrid1:DisplayLayout:MaxRowScrollRegions = 1.
        appearance5:BackColor = System.Drawing.SystemColors:Window.
        appearance5:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:ActiveCellAppearance = appearance5.
        appearance6:BackColor = System.Drawing.SystemColors:Highlight.
        appearance6:ForeColor = System.Drawing.SystemColors:HighlightText.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:ActiveRowAppearance = appearance6.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:BorderStyleCell = Infragistics.Win.UIElementBorderStyle:Dotted.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:BorderStyleRow = Infragistics.Win.UIElementBorderStyle:Dotted.
        appearance7:BackColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:CardAreaAppearance = appearance7.
        appearance8:BorderColor = System.Drawing.Color:Silver.
        appearance8:TextTrimming = Infragistics.Win.TextTrimming:EllipsisCharacter.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:CellAppearance = appearance8.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction:EditAndSelectText.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:CellPadding = 0.
        appearance9:BackColor = System.Drawing.SystemColors:Control.
        appearance9:BackColor2 = System.Drawing.SystemColors:ControlDark.
        appearance9:BackGradientAlignment = Infragistics.Win.GradientAlignment:Element.
        appearance9:BackGradientStyle = Infragistics.Win.GradientStyle:Horizontal.
        appearance9:BorderColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:GroupByRowAppearance = appearance9.
        appearance10:TextHAlignAsString = "Left".
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:HeaderAppearance = appearance10.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction:SortMulti.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:HeaderStyle = Infragistics.Win.HeaderStyle:WindowsXPCommand.
        appearance11:BackColor = System.Drawing.SystemColors:Window.
        appearance11:BorderColor = System.Drawing.Color:Silver.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:RowAppearance = appearance11.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:RowSelectors = Infragistics.Win.DefaultableBoolean:False.
        appearance12:BackColor = System.Drawing.SystemColors:ControlLight.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:TemplateAddRowAppearance = appearance12.
        THIS-OBJECT:ultraGrid1:DisplayLayout:ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds:ScrollToFill.
        THIS-OBJECT:ultraGrid1:DisplayLayout:ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle:Immediate.
        THIS-OBJECT:ultraGrid1:DisplayLayout:ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand:OutlookGroupBy.
        THIS-OBJECT:ultraGrid1:Dock = System.Windows.Forms.DockStyle:Top.
        THIS-OBJECT:ultraGrid1:Font = NEW System.Drawing.Font("Gill Sans MT", Progress.Util.CastUtil:ToSingle(10), System.Drawing.FontStyle:Regular, System.Drawing.GraphicsUnit:Point, System.Convert:ToByte(0)).
        THIS-OBJECT:ultraGrid1:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:ultraGrid1:Name = "ultraGrid1".
        THIS-OBJECT:ultraGrid1:Size = NEW System.Drawing.Size(884, 218).
        THIS-OBJECT:ultraGrid1:TabIndex = 6.
        THIS-OBJECT:ultraGrid1:Text = "ultraGrid1".
        /*  */
        /* ultraSplitter1 */
        /*  */
        THIS-OBJECT:ultraSplitter1:BackColor = System.Drawing.Color:DarkSeaGreen.
        THIS-OBJECT:ultraSplitter1:Dock = System.Windows.Forms.DockStyle:Bottom.
        THIS-OBJECT:ultraSplitter1:Location = NEW System.Drawing.Point(0, 218).
        THIS-OBJECT:ultraSplitter1:Name = "ultraSplitter1".
        THIS-OBJECT:ultraSplitter1:RestoreExtent = 0.
        THIS-OBJECT:ultraSplitter1:Size = NEW System.Drawing.Size(884, 6).
        THIS-OBJECT:ultraSplitter1:TabIndex = 1.
        /*  */
        /* ultraTabControl1 */
        /*  */
        THIS-OBJECT:ultraTabControl1:Controls:Add(THIS-OBJECT:ultraTabSharedControlsPage1).
        THIS-OBJECT:ultraTabControl1:Controls:Add(THIS-OBJECT:ultraTabPageControl1).
        THIS-OBJECT:ultraTabControl1:Dock = System.Windows.Forms.DockStyle:Bottom.
        THIS-OBJECT:ultraTabControl1:Location = NEW System.Drawing.Point(0, 224).
        THIS-OBJECT:ultraTabControl1:Name = "ultraTabControl1".
        THIS-OBJECT:ultraTabControl1:SharedControlsPage = THIS-OBJECT:ultraTabSharedControlsPage1.
        THIS-OBJECT:ultraTabControl1:Size = NEW System.Drawing.Size(884, 106).
        THIS-OBJECT:ultraTabControl1:TabIndex = 5.
        ultraTab1:TabPage = THIS-OBJECT:ultraTabPageControl1.
        ultraTab1:Text = "Main".
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar7 AS Infragistics.Win.UltraWinTabControl.UltraTab EXTENT 1 NO-UNDO.
        arrayvar7[1] = ultraTab1.
        THIS-OBJECT:ultraTabControl1:Tabs:AddRange(arrayvar7).
        /*  */
        /* ultraTabSharedControlsPage1 */
        /*  */
        THIS-OBJECT:ultraTabSharedControlsPage1:Location = NEW System.Drawing.Point(-10000, -10000).
        THIS-OBJECT:ultraTabSharedControlsPage1:Name = "ultraTabSharedControlsPage1".
        THIS-OBJECT:ultraTabSharedControlsPage1:Size = NEW System.Drawing.Size(880, 78).
        /*  */
        /* m_currencyMaintForm_Toolbars_Dock_Area_Left */
        /*  */
        THIS-OBJECT:m_currencyMaintForm_Toolbars_Dock_Area_Left:AccessibleRole = System.Windows.Forms.AccessibleRole:Grouping.
        THIS-OBJECT:m_currencyMaintForm_Toolbars_Dock_Area_Left:BackColor = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(191)), System.Convert:ToInt32(System.Convert:ToByte(219)), System.Convert:ToInt32(System.Convert:ToByte(255))).
        THIS-OBJECT:m_currencyMaintForm_Toolbars_Dock_Area_Left:DockedPosition = Infragistics.Win.UltraWinToolbars.DockedPosition:Left.
        THIS-OBJECT:m_currencyMaintForm_Toolbars_Dock_Area_Left:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:m_currencyMaintForm_Toolbars_Dock_Area_Left:InitialResizeAreaExtent = 8.
        THIS-OBJECT:m_currencyMaintForm_Toolbars_Dock_Area_Left:Location = NEW System.Drawing.Point(0, 162).
        THIS-OBJECT:m_currencyMaintForm_Toolbars_Dock_Area_Left:Name = "m_currencyMaintForm_Toolbars_Dock_Area_Left".
        THIS-OBJECT:m_currencyMaintForm_Toolbars_Dock_Area_Left:Size = NEW System.Drawing.Size(8, 330).
        THIS-OBJECT:m_currencyMaintForm_Toolbars_Dock_Area_Left:ToolbarsManager = THIS-OBJECT:toolbarsManager.
        /*  */
        /* m_currencyMaintForm_Toolbars_Dock_Area_Right */
        /*  */
        THIS-OBJECT:m_currencyMaintForm_Toolbars_Dock_Area_Right:AccessibleRole = System.Windows.Forms.AccessibleRole:Grouping.
        THIS-OBJECT:m_currencyMaintForm_Toolbars_Dock_Area_Right:BackColor = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(191)), System.Convert:ToInt32(System.Convert:ToByte(219)), System.Convert:ToInt32(System.Convert:ToByte(255))).
        THIS-OBJECT:m_currencyMaintForm_Toolbars_Dock_Area_Right:DockedPosition = Infragistics.Win.UltraWinToolbars.DockedPosition:Right.
        THIS-OBJECT:m_currencyMaintForm_Toolbars_Dock_Area_Right:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:m_currencyMaintForm_Toolbars_Dock_Area_Right:InitialResizeAreaExtent = 8.
        THIS-OBJECT:m_currencyMaintForm_Toolbars_Dock_Area_Right:Location = NEW System.Drawing.Point(892, 162).
        THIS-OBJECT:m_currencyMaintForm_Toolbars_Dock_Area_Right:Name = "m_currencyMaintForm_Toolbars_Dock_Area_Right".
        THIS-OBJECT:m_currencyMaintForm_Toolbars_Dock_Area_Right:Size = NEW System.Drawing.Size(8, 330).
        THIS-OBJECT:m_currencyMaintForm_Toolbars_Dock_Area_Right:ToolbarsManager = THIS-OBJECT:toolbarsManager.
        /*  */
        /* m_currencyMaintForm_Toolbars_Dock_Area_Top */
        /*  */
        THIS-OBJECT:m_currencyMaintForm_Toolbars_Dock_Area_Top:AccessibleRole = System.Windows.Forms.AccessibleRole:Grouping.
        THIS-OBJECT:m_currencyMaintForm_Toolbars_Dock_Area_Top:BackColor = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(191)), System.Convert:ToInt32(System.Convert:ToByte(219)), System.Convert:ToInt32(System.Convert:ToByte(255))).
        THIS-OBJECT:m_currencyMaintForm_Toolbars_Dock_Area_Top:DockedPosition = Infragistics.Win.UltraWinToolbars.DockedPosition:Top.
        THIS-OBJECT:m_currencyMaintForm_Toolbars_Dock_Area_Top:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:m_currencyMaintForm_Toolbars_Dock_Area_Top:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:m_currencyMaintForm_Toolbars_Dock_Area_Top:Name = "m_currencyMaintForm_Toolbars_Dock_Area_Top".
        THIS-OBJECT:m_currencyMaintForm_Toolbars_Dock_Area_Top:Size = NEW System.Drawing.Size(900, 162).
        THIS-OBJECT:m_currencyMaintForm_Toolbars_Dock_Area_Top:ToolbarsManager = THIS-OBJECT:toolbarsManager.
        /*  */
        /* m_currencyMaintForm_Toolbars_Dock_Area_Bottom */
        /*  */
        THIS-OBJECT:m_currencyMaintForm_Toolbars_Dock_Area_Bottom:AccessibleRole = System.Windows.Forms.AccessibleRole:Grouping.
        THIS-OBJECT:m_currencyMaintForm_Toolbars_Dock_Area_Bottom:BackColor = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(191)), System.Convert:ToInt32(System.Convert:ToByte(219)), System.Convert:ToInt32(System.Convert:ToByte(255))).
        THIS-OBJECT:m_currencyMaintForm_Toolbars_Dock_Area_Bottom:DockedPosition = Infragistics.Win.UltraWinToolbars.DockedPosition:Bottom.
        THIS-OBJECT:m_currencyMaintForm_Toolbars_Dock_Area_Bottom:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:m_currencyMaintForm_Toolbars_Dock_Area_Bottom:InitialResizeAreaExtent = 8.
        THIS-OBJECT:m_currencyMaintForm_Toolbars_Dock_Area_Bottom:Location = NEW System.Drawing.Point(0, 492).
        THIS-OBJECT:m_currencyMaintForm_Toolbars_Dock_Area_Bottom:Name = "m_currencyMaintForm_Toolbars_Dock_Area_Bottom".
        THIS-OBJECT:m_currencyMaintForm_Toolbars_Dock_Area_Bottom:Size = NEW System.Drawing.Size(900, 8).
        THIS-OBJECT:m_currencyMaintForm_Toolbars_Dock_Area_Bottom:ToolbarsManager = THIS-OBJECT:toolbarsManager.
        /*  */
        /* currencyMaintForm */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(900, 500).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:currencyMaintForm_Fill_Panel).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:m_currencyMaintForm_Toolbars_Dock_Area_Left).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:m_currencyMaintForm_Toolbars_Dock_Area_Right).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:m_currencyMaintForm_Toolbars_Dock_Area_Bottom).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:m_currencyMaintForm_Toolbars_Dock_Area_Top).
        THIS-OBJECT:Name = "currencyMaintForm".
        THIS-OBJECT:Text = "Currency Maintenance".
        THIS-OBJECT:ultraTabPageControl1:ResumeLayout(FALSE).
        THIS-OBJECT:ultraTabPageControl1:PerformLayout().
        CAST(THIS-OBJECT:currencySymbolEditor, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:bsCurrency, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:ultraNumericEditor1, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:currencyNameEditor, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:toolbarsManager, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:currencyMaintForm_Fill_Panel:ClientArea:ResumeLayout(FALSE).
        THIS-OBJECT:currencyMaintForm_Fill_Panel:ResumeLayout(FALSE).
        CAST(THIS-OBJECT:ultraGrid1, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:ultraTabControl1, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:ultraTabControl1:ResumeLayout(FALSE).
        THIS-OBJECT:ResumeLayout(FALSE).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
	END METHOD.

    METHOD PUBLIC VOID enableTools(INPUT ipcAction AS CHARACTER):
        CASE ipcAction:
            WHEN "New" OR 
            WHEN "Edit"
            THEN 
                DO:
                    THIS-OBJECT:toolbarsManager:Tools:Item["New"]:SharedPropsInternal:Enabled = FALSE.
                    THIS-OBJECT:toolbarsManager:Tools:Item["Edit"]:SharedPropsInternal:Enabled = FALSE.
                    THIS-OBJECT:toolbarsManager:Tools:Item["Delete"]:SharedPropsInternal:Enabled = FALSE.
                    THIS-OBJECT:toolbarsManager:Tools:Item["Save"]:SharedPropsInternal:Enabled = TRUE.
                    THIS-OBJECT:toolbarsManager:Tools:Item["Cancel"]:SharedPropsInternal:Enabled = TRUE.
                    THIS-OBJECT:ultraTabPageControl1:enabled = TRUE. 
                    THIS-OBJECT:ultraGrid1:enabled = FALSE. 
                END.
            WHEN "Save" OR 
            WHEN "Cancel" OR 
            WHEN "Init"
            THEN 
                DO:
                    THIS-OBJECT:toolbarsManager:Tools:Item["New"]:SharedPropsInternal:Enabled = TRUE.
                    THIS-OBJECT:toolbarsManager:Tools:Item["Edit"]:SharedPropsInternal:Enabled = TRUE.
                    THIS-OBJECT:toolbarsManager:Tools:Item["Delete"]:SharedPropsInternal:Enabled = TRUE.
                    THIS-OBJECT:toolbarsManager:Tools:Item["Save"]:SharedPropsInternal:Enabled = FALSE.
                    THIS-OBJECT:toolbarsManager:Tools:Item["Cancel"]:SharedPropsInternal:Enabled = FALSE.
                    THIS-OBJECT:ultraTabPageControl1:enabled = FALSE. 
                    THIS-OBJECT:ultraGrid1:enabled = TRUE. 
                END.
        END CASE.
        RETURN.
    END METHOD.



	@VisualDesigner.
	METHOD PRIVATE VOID ultraTextEditor1_ValueChanged( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		
		RETURN.

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID ultraToolbarsManager1_ToolClick( INPUT sender AS System.Object, INPUT e AS Infragistics.Win.UltraWinToolbars.ToolClickEventArgs ):
		
		
		// action code
		CASE e:Tool:Key:
            WHEN "New"
                THEN DO:
            bsCurrency:AddNew().
                    objCurrency:createRow().
                END. 
                
                WHEN "Edit"
                THEN DO:
                    objCurrency:enableEdit().                   
                END. 
                       
                WHEN "Delete"
                THEN DO:
                    DEFINE VARIABLE lChoice AS LOGICAL NO-UNDO. 
                    MESSAGE "Are you sure? "
                    VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO SET lChoice.
                    IF lChoice THEN 
                    DO:
                        THIS-OBJECT:ultraGrid1:Selected:Rows:Clear().
                        objCurrency:deleteRow().
                    END.
                END.  
                      
                WHEN "Save"
                THEN DO:                  
                    currencyNameEditor:DataBindings["Text"]:WriteValue().
                    currencySymbolEditor:DataBindings["Text"]:WriteValue().
                    bsCurrency:assign().
                    objCurrency:disableEdit().
                    objCurrency:saveCurrency().                    
                    THIS-OBJECT:ultraGrid1:Selected:Rows:Clear().
                END.  
                      
                WHEN "Cancel"
            THEN DO: 
                    objCurrency:cancelEdit().
                END.        
        END CASE.   


        
        // sync widget code
        enableTools(INPUT e:Tool:Key).
        
        // set active control code
        IF e:Tool:Key EQ "New" OR
           e:Tool:Key EQ "Edit"
           THEN DO:
            THIS-OBJECT:ActiveControl = currencySymbolEditor.
            END. 

	END METHOD.

	DESTRUCTOR PUBLIC currencyMaintForm ( ):

	END DESTRUCTOR.

END CLASS.