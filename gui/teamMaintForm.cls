 
 /*------------------------------------------------------------------------
    File        : teamMaintForm
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : tcoomans
    Created     : Fri Jan 29 10:39:45 CET 2016
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.
USING Infragistics.Win.UltraWinToolbars.TextBoxTool FROM ASSEMBLY.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS gui.teamMaintForm INHERITS gui.baseForm: 
	
    DEFINE PRIVATE VARIABLE bsTeam AS Progress.Data.BindingSource NO-UNDO.
    DEFINE PRIVATE VARIABLE fiTeamName AS Infragistics.Win.UltraWinEditors.UltraTextEditor NO-UNDO.
    DEFINE PRIVATE VARIABLE fiTeamId AS Infragistics.Win.UltraWinEditors.UltraNumericEditor NO-UNDO.
    DEFINE PRIVATE VARIABLE m_teamMaintForm_Toolbars_Dock_Area_Top AS Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea NO-UNDO.
    DEFINE PRIVATE VARIABLE m_teamMaintForm_Toolbars_Dock_Area_Right AS Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea NO-UNDO.
    DEFINE PRIVATE VARIABLE m_teamMaintForm_Toolbars_Dock_Area_Left AS Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea NO-UNDO.
    DEFINE PRIVATE VARIABLE m_teamMaintForm_Toolbars_Dock_Area_Bottom AS Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea NO-UNDO.
	DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraGrid1 AS Infragistics.Win.UltraWinGrid.UltraGrid NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraLabel2 AS Infragistics.Win.Misc.UltraLabel NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraLabel1 AS Infragistics.Win.Misc.UltraLabel NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraSplitter1 AS Infragistics.Win.Misc.UltraSplitter NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraTabPageControl1 AS Infragistics.Win.UltraWinTabControl.UltraTabPageControl NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraTabSharedControlsPage1 AS Infragistics.Win.UltraWinTabControl.UltraTabSharedControlsPage NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraTabControl1 AS Infragistics.Win.UltraWinTabControl.UltraTabControl NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraToolbarsManager1 AS Infragistics.Win.UltraWinToolbars.UltraToolbarsManager NO-UNDO.
    DEFINE PRIVATE VARIABLE teamMaintForm_Fill_Panel AS Infragistics.Win.Misc.UltraPanel NO-UNDO.

    DEFINE VARIABLE objTeam AS gui.teamModel NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraValidator1 AS Infragistics.Win.Misc.UltraValidator NO-UNDO.
		
	CONSTRUCTOR PUBLIC teamMaintForm (  ):
				
        SUPER().
        InitializeComponent().
         
        enableTools(INPUT "Init").
        
        objTeam = NEW gui.teamModel().
        bsTeam:HANDLE = objTeam:getTeam().
       
        THIS-OBJECT:ComponentsCollection:ADD(THIS-OBJECT:components).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.

	END CONSTRUCTOR.
	

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID enableTools(INPUT ipcAction AS CHARACTER):
        
        CASE ipcAction:
            WHEN "New" OR WHEN "Update"
            THEN DO:
                THIS-OBJECT:ultraToolbarsManager1:Tools:Item["New"]:SharedPropsInternal:Enabled    = FALSE.
                THIS-OBJECT:ultraToolbarsManager1:Tools:Item["Update"]:SharedPropsInternal:Enabled = FALSE.
                THIS-OBJECT:ultraToolbarsManager1:Tools:Item["Delete"]:SharedPropsInternal:Enabled = FALSE.
                THIS-OBJECT:ultraToolbarsManager1:Tools:Item["Save"]:SharedPropsInternal:Enabled   = TRUE.
                THIS-OBJECT:ultraToolbarsManager1:Tools:Item["Cancel"]:SharedPropsInternal:Enabled = TRUE.   
                THIS-OBJECT:ultraTabPageControl1:ENABLED = TRUE.
                THIS-OBJECT:ultraGrid1:Enabled = FALSE.
            END. 
            WHEN "Save" OR WHEN "Cancel" OR WHEN "Init"
            THEN DO:
                THIS-OBJECT:ultraToolbarsManager1:Tools:Item["New"]:SharedPropsInternal:Enabled    = TRUE.
                THIS-OBJECT:ultraToolbarsManager1:Tools:Item["Update"]:SharedPropsInternal:Enabled = TRUE.
                THIS-OBJECT:ultraToolbarsManager1:Tools:Item["Delete"]:SharedPropsInternal:Enabled = TRUE.
                THIS-OBJECT:ultraToolbarsManager1:Tools:Item["Save"]:SharedPropsInternal:Enabled   = FALSE.
                THIS-OBJECT:ultraToolbarsManager1:Tools:Item["Cancel"]:SharedPropsInternal:Enabled = FALSE.   
                THIS-OBJECT:ultraTabPageControl1:ENABLED = FALSE.
                THIS-OBJECT:ultraGrid1:Enabled = TRUE.
            END.    
        END CASE.

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
        DEFINE VARIABLE appearance2 AS Infragistics.Win.Appearance NO-UNDO.
        appearance2 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ribbonTab1 AS Infragistics.Win.UltraWinToolbars.RibbonTab NO-UNDO.
        ribbonTab1 = NEW Infragistics.Win.UltraWinToolbars.RibbonTab("ribbon1").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ribbonGroup1 AS Infragistics.Win.UltraWinToolbars.RibbonGroup NO-UNDO.
        ribbonGroup1 = NEW Infragistics.Win.UltraWinToolbars.RibbonGroup("ribbonGroup1").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool1 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool1 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("New").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool2 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool2 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Update").
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
        DEFINE VARIABLE appearance15 AS Infragistics.Win.Appearance NO-UNDO.
        appearance15 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE resources AS Progress.Util.ResourceManager NO-UNDO.
        resources = NEW Progress.Util.ResourceManager("gui.teamMaintForm").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance16 AS Infragistics.Win.Appearance NO-UNDO.
        appearance16 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool7 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool7 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Update").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance17 AS Infragistics.Win.Appearance NO-UNDO.
        appearance17 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance18 AS Infragistics.Win.Appearance NO-UNDO.
        appearance18 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool8 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool8 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Delete").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance19 AS Infragistics.Win.Appearance NO-UNDO.
        appearance19 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance20 AS Infragistics.Win.Appearance NO-UNDO.
        appearance20 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool9 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool9 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Save").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance21 AS Infragistics.Win.Appearance NO-UNDO.
        appearance21 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance22 AS Infragistics.Win.Appearance NO-UNDO.
        appearance22 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool10 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool10 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Cancel").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance23 AS Infragistics.Win.Appearance NO-UNDO.
        appearance23 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance24 AS Infragistics.Win.Appearance NO-UNDO.
        appearance24 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE textBoxTool2 AS Infragistics.Win.UltraWinToolbars.TextBoxTool NO-UNDO.
        textBoxTool2 = NEW Infragistics.Win.UltraWinToolbars.TextBoxTool("mytext").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance3 AS Infragistics.Win.Appearance NO-UNDO.
        appearance3 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridBand1 AS Infragistics.Win.UltraWinGrid.UltraGridBand NO-UNDO.
        ultraGridBand1 = NEW Infragistics.Win.UltraWinGrid.UltraGridBand("ttTeam", -1).
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn1 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn1 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("team_id", -1, ?, 0, Infragistics.Win.UltraWinGrid.SortIndicator:Ascending, FALSE).
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn2 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn2 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("team_name").
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
        DEFINE VARIABLE appearance14 AS Infragistics.Win.Appearance NO-UNDO.
        appearance14 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraTab1 AS Infragistics.Win.UltraWinTabControl.UltraTab NO-UNDO.
        ultraTab1 = NEW Infragistics.Win.UltraWinTabControl.UltraTab().
        THIS-OBJECT:ultraTabPageControl1 = NEW Infragistics.Win.UltraWinTabControl.UltraTabPageControl().
        THIS-OBJECT:fiTeamName = NEW Infragistics.Win.UltraWinEditors.UltraTextEditor().
        THIS-OBJECT:bsTeam = NEW Progress.Data.BindingSource(THIS-OBJECT:components).
        THIS-OBJECT:fiTeamId = NEW Infragistics.Win.UltraWinEditors.UltraNumericEditor().
        THIS-OBJECT:ultraLabel1 = NEW Infragistics.Win.Misc.UltraLabel().
        THIS-OBJECT:ultraLabel2 = NEW Infragistics.Win.Misc.UltraLabel().
        THIS-OBJECT:ultraToolbarsManager1 = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsManager(THIS-OBJECT:components).
        THIS-OBJECT:teamMaintForm_Fill_Panel = NEW Infragistics.Win.Misc.UltraPanel().
        THIS-OBJECT:ultraSplitter1 = NEW Infragistics.Win.Misc.UltraSplitter().
        THIS-OBJECT:ultraGrid1 = NEW Infragistics.Win.UltraWinGrid.UltraGrid().
        THIS-OBJECT:ultraTabControl1 = NEW Infragistics.Win.UltraWinTabControl.UltraTabControl().
        THIS-OBJECT:ultraTabSharedControlsPage1 = NEW Infragistics.Win.UltraWinTabControl.UltraTabSharedControlsPage().
        THIS-OBJECT:m_teamMaintForm_Toolbars_Dock_Area_Left = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea().
        THIS-OBJECT:m_teamMaintForm_Toolbars_Dock_Area_Right = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea().
        THIS-OBJECT:m_teamMaintForm_Toolbars_Dock_Area_Top = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea().
        THIS-OBJECT:m_teamMaintForm_Toolbars_Dock_Area_Bottom = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea().
        THIS-OBJECT:ultraValidator1 = NEW Infragistics.Win.Misc.UltraValidator(THIS-OBJECT:components).
        THIS-OBJECT:ultraTabPageControl1:SuspendLayout().
        CAST(THIS-OBJECT:fiTeamName, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:bsTeam, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:fiTeamId, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:ultraToolbarsManager1, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:teamMaintForm_Fill_Panel:ClientArea:SuspendLayout().
        THIS-OBJECT:teamMaintForm_Fill_Panel:SuspendLayout().
        CAST(THIS-OBJECT:ultraGrid1, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:ultraTabControl1, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:ultraTabControl1:SuspendLayout().
        CAST(THIS-OBJECT:ultraValidator1, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* ultraTabPageControl1 */
        /*  */
        THIS-OBJECT:ultraTabPageControl1:Controls:Add(THIS-OBJECT:fiTeamName).
        THIS-OBJECT:ultraTabPageControl1:Controls:Add(THIS-OBJECT:fiTeamId).
        THIS-OBJECT:ultraTabPageControl1:Controls:Add(THIS-OBJECT:ultraLabel1).
        THIS-OBJECT:ultraTabPageControl1:Controls:Add(THIS-OBJECT:ultraLabel2).
        THIS-OBJECT:ultraTabPageControl1:Location = NEW System.Drawing.Point(1, 23).
        THIS-OBJECT:ultraTabPageControl1:Name = "ultraTabPageControl1".
        THIS-OBJECT:ultraTabPageControl1:Size = NEW System.Drawing.Size(539, 74).
        /*  */
        /* fiTeamName */
        /*  */
        THIS-OBJECT:fiTeamName:DataBindings:Add(NEW System.Windows.Forms.Binding("Text", THIS-OBJECT:bsTeam, "team_name", TRUE)).
        THIS-OBJECT:fiTeamName:Location = NEW System.Drawing.Point(91, 35).
        THIS-OBJECT:fiTeamName:Name = "fiTeamName".
        THIS-OBJECT:fiTeamName:Size = NEW System.Drawing.Size(270, 21).
        THIS-OBJECT:fiTeamName:TabIndex = 1.
        THIS-OBJECT:fiTeamName:Tag = "sssss".
        THIS-OBJECT:ultraValidator1:GetValidationSettings(THIS-OBJECT:fiTeamName):IsRequired = TRUE.
        THIS-OBJECT:ultraValidator1:GetValidationSettings(THIS-OBJECT:fiTeamName):ValidationTrigger = Infragistics.Win.Misc.ValidationTrigger:OnValidating.
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
        /* fiTeamId */
        /*  */
        THIS-OBJECT:fiTeamId:DataBindings:Add(NEW System.Windows.Forms.Binding("Text", THIS-OBJECT:bsTeam, "team_id", TRUE)).
        THIS-OBJECT:fiTeamId:Enabled = FALSE.
        THIS-OBJECT:fiTeamId:Location = NEW System.Drawing.Point(91, 8).
        THIS-OBJECT:fiTeamId:Name = "fiTeamId".
        THIS-OBJECT:fiTeamId:PromptChar = ' '.
        THIS-OBJECT:fiTeamId:Size = NEW System.Drawing.Size(100, 21).
        THIS-OBJECT:fiTeamId:TabIndex = 0.
        /*  */
        /* ultraLabel1 */
        /*  */
        appearance1:BackColor = System.Drawing.Color:White.
        THIS-OBJECT:ultraLabel1:Appearance = appearance1.
        THIS-OBJECT:ultraLabel1:ImageTransparentColor = System.Drawing.Color:Empty.
        THIS-OBJECT:ultraLabel1:Location = NEW System.Drawing.Point(20, 12).
        THIS-OBJECT:ultraLabel1:Name = "ultraLabel1".
        THIS-OBJECT:ultraLabel1:Size = NEW System.Drawing.Size(100, 23).
        THIS-OBJECT:ultraLabel1:TabIndex = 2.
        THIS-OBJECT:ultraLabel1:Text = "Team Id :".
        /*  */
        /* ultraLabel2 */
        /*  */
        appearance2:BackColor = System.Drawing.Color:White.
        THIS-OBJECT:ultraLabel2:Appearance = appearance2.
        THIS-OBJECT:ultraLabel2:Location = NEW System.Drawing.Point(20, 39).
        THIS-OBJECT:ultraLabel2:Name = "ultraLabel2".
        THIS-OBJECT:ultraLabel2:Size = NEW System.Drawing.Size(100, 23).
        THIS-OBJECT:ultraLabel2:TabIndex = 3.
        THIS-OBJECT:ultraLabel2:Text = "Team Name :".
        /*  */
        /* ultraToolbarsManager1 */
        /*  */
        THIS-OBJECT:ultraToolbarsManager1:DesignerFlags = 1.
        THIS-OBJECT:ultraToolbarsManager1:DockWithinContainer = THIS-OBJECT.
        THIS-OBJECT:ultraToolbarsManager1:DockWithinContainerBaseType = Progress.Util.TypeHelper:GetType("gui.baseForm").
        ribbonTab1:Caption = "ribbon1".
        ribbonGroup1:Caption = "ribbonGroup1".
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
        THIS-OBJECT:ultraToolbarsManager1:Ribbon:NonInheritedRibbonTabs:AddRange(arrayvar4).
        THIS-OBJECT:ultraToolbarsManager1:Ribbon:Visible = TRUE.
        THIS-OBJECT:ultraToolbarsManager1:Style = Infragistics.Win.UltraWinToolbars.ToolbarStyle:Office2007.
        appearance15:Image = CAST(resources:GetObject("appearance15.Image"), System.Object).
        buttonTool6:SharedPropsInternal:AppearancesLarge:Appearance = appearance15.
        appearance16:Image = CAST(resources:GetObject("appearance16.Image"), System.Object).
        buttonTool6:SharedPropsInternal:AppearancesSmall:Appearance = appearance16.
        buttonTool6:SharedPropsInternal:Caption = "New".
        buttonTool6:SharedPropsInternal:Category = "tableio".
        appearance17:Image = CAST(resources:GetObject("appearance17.Image"), System.Object).
        buttonTool7:SharedPropsInternal:AppearancesLarge:Appearance = appearance17.
        appearance18:Image = CAST(resources:GetObject("appearance18.Image"), System.Object).
        buttonTool7:SharedPropsInternal:AppearancesSmall:Appearance = appearance18.
        buttonTool7:SharedPropsInternal:Caption = "Update".
        buttonTool7:SharedPropsInternal:Category = "tableio".
        appearance19:Image = CAST(resources:GetObject("appearance19.Image"), System.Object).
        buttonTool8:SharedPropsInternal:AppearancesLarge:Appearance = appearance19.
        appearance20:Image = CAST(resources:GetObject("appearance20.Image"), System.Object).
        buttonTool8:SharedPropsInternal:AppearancesSmall:Appearance = appearance20.
        buttonTool8:SharedPropsInternal:Caption = "Delete".
        buttonTool8:SharedPropsInternal:Category = "tableio".
        appearance21:Image = CAST(resources:GetObject("appearance21.Image"), System.Object).
        buttonTool9:SharedPropsInternal:AppearancesLarge:Appearance = appearance21.
        appearance22:Image = CAST(resources:GetObject("appearance22.Image"), System.Object).
        buttonTool9:SharedPropsInternal:AppearancesSmall:Appearance = appearance22.
        buttonTool9:SharedPropsInternal:Caption = "Save".
        buttonTool9:SharedPropsInternal:Category = "tableio".
        appearance23:Image = CAST(resources:GetObject("appearance23.Image"), System.Object).
        buttonTool10:SharedPropsInternal:AppearancesLarge:Appearance = appearance23.
        appearance24:Image = CAST(resources:GetObject("appearance24.Image"), System.Object).
        buttonTool10:SharedPropsInternal:AppearancesSmall:Appearance = appearance24.
        buttonTool10:SharedPropsInternal:Caption = "Cancel".
        buttonTool10:SharedPropsInternal:Category = "tableio".
        textBoxTool2:SharedPropsInternal:Caption = "mytext".
        textBoxTool2:Text = "tytyt".
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar5 AS Infragistics.Win.UltraWinToolbars.ToolBase EXTENT 6 NO-UNDO.
        arrayvar5[1] = buttonTool6.
        arrayvar5[2] = buttonTool7.
        arrayvar5[3] = buttonTool8.
        arrayvar5[4] = buttonTool9.
        arrayvar5[5] = buttonTool10.
        arrayvar5[6] = textBoxTool2.
        THIS-OBJECT:ultraToolbarsManager1:Tools:AddRange(arrayvar5).
        THIS-OBJECT:ultraToolbarsManager1:ToolClick:Subscribe(THIS-OBJECT:ultraToolbarsManager1_ToolClick).
        /*  */
        /* teamMaintForm_Fill_Panel */
        /*  */
        /*  */
        /* teamMaintForm_Fill_Panel.ClientArea */
        /*  */
        THIS-OBJECT:teamMaintForm_Fill_Panel:ClientArea:Controls:Add(THIS-OBJECT:ultraSplitter1).
        THIS-OBJECT:teamMaintForm_Fill_Panel:ClientArea:Controls:Add(THIS-OBJECT:ultraGrid1).
        THIS-OBJECT:teamMaintForm_Fill_Panel:ClientArea:Controls:Add(THIS-OBJECT:ultraTabControl1).
        THIS-OBJECT:teamMaintForm_Fill_Panel:Cursor = System.Windows.Forms.Cursors:Default.
        THIS-OBJECT:teamMaintForm_Fill_Panel:Dock = System.Windows.Forms.DockStyle:Fill.
        THIS-OBJECT:teamMaintForm_Fill_Panel:Location = NEW System.Drawing.Point(8, 162).
        THIS-OBJECT:teamMaintForm_Fill_Panel:Name = "teamMaintForm_Fill_Panel".
        THIS-OBJECT:teamMaintForm_Fill_Panel:Size = NEW System.Drawing.Size(543, 248).
        THIS-OBJECT:teamMaintForm_Fill_Panel:TabIndex = 0.
        /*  */
        /* ultraSplitter1 */
        /*  */
        THIS-OBJECT:ultraSplitter1:BackColor = System.Drawing.SystemColors:ActiveCaption.
        THIS-OBJECT:ultraSplitter1:Dock = System.Windows.Forms.DockStyle:Bottom.
        THIS-OBJECT:ultraSplitter1:Location = NEW System.Drawing.Point(0, 143).
        THIS-OBJECT:ultraSplitter1:Name = "ultraSplitter1".
        THIS-OBJECT:ultraSplitter1:RestoreExtent = 0.
        THIS-OBJECT:ultraSplitter1:Size = NEW System.Drawing.Size(543, 5).
        THIS-OBJECT:ultraSplitter1:TabIndex = 1.
        /*  */
        /* ultraGrid1 */
        /*  */
        THIS-OBJECT:ultraGrid1:DataSource = THIS-OBJECT:bsTeam.
        appearance3:BackColor = System.Drawing.SystemColors:Window.
        appearance3:BorderColor = System.Drawing.SystemColors:InactiveCaption.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Appearance = appearance3.
        THIS-OBJECT:ultraGrid1:DisplayLayout:AutoFitStyle = Infragistics.Win.UltraWinGrid.AutoFitStyle:ExtendLastColumn.
        ultraGridColumn1:Header:VisiblePosition = 0.
        ultraGridColumn1:Width = 58.
        ultraGridColumn2:Header:VisiblePosition = 1.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar6 AS System.Object EXTENT 2 NO-UNDO.
        arrayvar6[1] = ultraGridColumn1.
        arrayvar6[2] = ultraGridColumn2.
        ultraGridBand1:Columns:AddRange(arrayvar6).
        THIS-OBJECT:ultraGrid1:DisplayLayout:BandsSerializer:Add(ultraGridBand1).
        THIS-OBJECT:ultraGrid1:DisplayLayout:BorderStyle = Infragistics.Win.UIElementBorderStyle:Solid.
        THIS-OBJECT:ultraGrid1:DisplayLayout:CaptionVisible = Infragistics.Win.DefaultableBoolean:False.
        appearance4:BackColor = System.Drawing.SystemColors:ActiveBorder.
        appearance4:BackColor2 = System.Drawing.SystemColors:ControlDark.
        appearance4:BackGradientStyle = Infragistics.Win.GradientStyle:Vertical.
        appearance4:BorderColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ultraGrid1:DisplayLayout:GroupByBox:Appearance = appearance4.
        appearance5:ForeColor = System.Drawing.SystemColors:GrayText.
        THIS-OBJECT:ultraGrid1:DisplayLayout:GroupByBox:BandLabelAppearance = appearance5.
        THIS-OBJECT:ultraGrid1:DisplayLayout:GroupByBox:BorderStyle = Infragistics.Win.UIElementBorderStyle:Solid.
        appearance6:BackColor = System.Drawing.SystemColors:ControlLightLight.
        appearance6:BackColor2 = System.Drawing.SystemColors:Control.
        appearance6:BackGradientStyle = Infragistics.Win.GradientStyle:Horizontal.
        appearance6:ForeColor = System.Drawing.SystemColors:GrayText.
        THIS-OBJECT:ultraGrid1:DisplayLayout:GroupByBox:PromptAppearance = appearance6.
        THIS-OBJECT:ultraGrid1:DisplayLayout:MaxColScrollRegions = 1.
        THIS-OBJECT:ultraGrid1:DisplayLayout:MaxRowScrollRegions = 1.
        appearance7:BackColor = System.Drawing.SystemColors:Window.
        appearance7:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:ActiveCellAppearance = appearance7.
        appearance8:BackColor = System.Drawing.SystemColors:Highlight.
        appearance8:ForeColor = System.Drawing.SystemColors:HighlightText.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:ActiveRowAppearance = appearance8.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:AllowAddNew = Infragistics.Win.UltraWinGrid.AllowAddNew:No.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:AllowDelete = Infragistics.Win.DefaultableBoolean:False.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:AllowGroupBy = Infragistics.Win.DefaultableBoolean:True.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:AllowUpdate = Infragistics.Win.DefaultableBoolean:False.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:BorderStyleCell = Infragistics.Win.UIElementBorderStyle:Dotted.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:BorderStyleRow = Infragistics.Win.UIElementBorderStyle:Dotted.
        appearance9:BackColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:CardAreaAppearance = appearance9.
        appearance10:BorderColor = System.Drawing.Color:Silver.
        appearance10:TextTrimming = Infragistics.Win.TextTrimming:EllipsisCharacter.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:CellAppearance = appearance10.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction:RowSelect.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:CellPadding = 0.
        appearance11:BackColor = System.Drawing.SystemColors:Control.
        appearance11:BackColor2 = System.Drawing.SystemColors:ControlDark.
        appearance11:BackGradientAlignment = Infragistics.Win.GradientAlignment:Element.
        appearance11:BackGradientStyle = Infragistics.Win.GradientStyle:Horizontal.
        appearance11:BorderColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:GroupByRowAppearance = appearance11.
        appearance12:TextHAlignAsString = "Left".
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:HeaderAppearance = appearance12.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction:SortMulti.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:HeaderStyle = Infragistics.Win.HeaderStyle:WindowsXPCommand.
        appearance13:BackColor = System.Drawing.SystemColors:Window.
        appearance13:BorderColor = System.Drawing.Color:Silver.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:RowAppearance = appearance13.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:RowSelectorHeaderStyle = Infragistics.Win.UltraWinGrid.RowSelectorHeaderStyle:ColumnChooserButton.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:RowSelectors = Infragistics.Win.DefaultableBoolean:True.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:SelectTypeCell = Infragistics.Win.UltraWinGrid.SelectType:None.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:SelectTypeCol = Infragistics.Win.UltraWinGrid.SelectType:None.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:SelectTypeGroupByRow = Infragistics.Win.UltraWinGrid.SelectType:None.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:SelectTypeRow = Infragistics.Win.UltraWinGrid.SelectType:Single.
        appearance14:BackColor = System.Drawing.SystemColors:ControlLight.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:TemplateAddRowAppearance = appearance14.
        THIS-OBJECT:ultraGrid1:DisplayLayout:ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds:ScrollToFill.
        THIS-OBJECT:ultraGrid1:DisplayLayout:ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle:Immediate.
        THIS-OBJECT:ultraGrid1:DisplayLayout:TabNavigation = Infragistics.Win.UltraWinGrid.TabNavigation:NextControlOnLastCell.
        THIS-OBJECT:ultraGrid1:DisplayLayout:ViewStyle = Infragistics.Win.UltraWinGrid.ViewStyle:SingleBand.
        THIS-OBJECT:ultraGrid1:Dock = System.Windows.Forms.DockStyle:Fill.
        THIS-OBJECT:ultraGrid1:Font = NEW System.Drawing.Font("Microsoft Sans Serif", Progress.Util.CastUtil:ToSingle(8.25), System.Drawing.FontStyle:Regular, System.Drawing.GraphicsUnit:Point, System.Convert:ToByte(0)).
        THIS-OBJECT:ultraGrid1:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:ultraGrid1:Name = "ultraGrid1".
        THIS-OBJECT:ultraGrid1:Size = NEW System.Drawing.Size(543, 148).
        THIS-OBJECT:ultraGrid1:TabIndex = 0.
        THIS-OBJECT:ultraGrid1:Text = "ultraGrid1".
        /*  */
        /* ultraTabControl1 */
        /*  */
        THIS-OBJECT:ultraTabControl1:Controls:Add(THIS-OBJECT:ultraTabSharedControlsPage1).
        THIS-OBJECT:ultraTabControl1:Controls:Add(THIS-OBJECT:ultraTabPageControl1).
        THIS-OBJECT:ultraTabControl1:Dock = System.Windows.Forms.DockStyle:Bottom.
        THIS-OBJECT:ultraTabControl1:Location = NEW System.Drawing.Point(0, 148).
        THIS-OBJECT:ultraTabControl1:Name = "ultraTabControl1".
        THIS-OBJECT:ultraTabControl1:SharedControlsPage = THIS-OBJECT:ultraTabSharedControlsPage1.
        THIS-OBJECT:ultraTabControl1:Size = NEW System.Drawing.Size(543, 100).
        THIS-OBJECT:ultraTabControl1:TabIndex = 5.
        ultraTab1:Key = "Main".
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
        THIS-OBJECT:ultraTabSharedControlsPage1:Size = NEW System.Drawing.Size(539, 74).
        /*  */
        /* m_teamMaintForm_Toolbars_Dock_Area_Left */
        /*  */
        THIS-OBJECT:m_teamMaintForm_Toolbars_Dock_Area_Left:AccessibleRole = System.Windows.Forms.AccessibleRole:Grouping.
        THIS-OBJECT:m_teamMaintForm_Toolbars_Dock_Area_Left:BackColor = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(191)), System.Convert:ToInt32(System.Convert:ToByte(219)), System.Convert:ToInt32(System.Convert:ToByte(255))).
        THIS-OBJECT:m_teamMaintForm_Toolbars_Dock_Area_Left:DockedPosition = Infragistics.Win.UltraWinToolbars.DockedPosition:Left.
        THIS-OBJECT:m_teamMaintForm_Toolbars_Dock_Area_Left:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:m_teamMaintForm_Toolbars_Dock_Area_Left:InitialResizeAreaExtent = 8.
        THIS-OBJECT:m_teamMaintForm_Toolbars_Dock_Area_Left:Location = NEW System.Drawing.Point(0, 162).
        THIS-OBJECT:m_teamMaintForm_Toolbars_Dock_Area_Left:Name = "m_teamMaintForm_Toolbars_Dock_Area_Left".
        THIS-OBJECT:m_teamMaintForm_Toolbars_Dock_Area_Left:Size = NEW System.Drawing.Size(8, 248).
        THIS-OBJECT:m_teamMaintForm_Toolbars_Dock_Area_Left:ToolbarsManager = THIS-OBJECT:ultraToolbarsManager1.
        /*  */
        /* m_teamMaintForm_Toolbars_Dock_Area_Right */
        /*  */
        THIS-OBJECT:m_teamMaintForm_Toolbars_Dock_Area_Right:AccessibleRole = System.Windows.Forms.AccessibleRole:Grouping.
        THIS-OBJECT:m_teamMaintForm_Toolbars_Dock_Area_Right:BackColor = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(191)), System.Convert:ToInt32(System.Convert:ToByte(219)), System.Convert:ToInt32(System.Convert:ToByte(255))).
        THIS-OBJECT:m_teamMaintForm_Toolbars_Dock_Area_Right:DockedPosition = Infragistics.Win.UltraWinToolbars.DockedPosition:Right.
        THIS-OBJECT:m_teamMaintForm_Toolbars_Dock_Area_Right:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:m_teamMaintForm_Toolbars_Dock_Area_Right:InitialResizeAreaExtent = 8.
        THIS-OBJECT:m_teamMaintForm_Toolbars_Dock_Area_Right:Location = NEW System.Drawing.Point(551, 162).
        THIS-OBJECT:m_teamMaintForm_Toolbars_Dock_Area_Right:Name = "m_teamMaintForm_Toolbars_Dock_Area_Right".
        THIS-OBJECT:m_teamMaintForm_Toolbars_Dock_Area_Right:Size = NEW System.Drawing.Size(8, 248).
        THIS-OBJECT:m_teamMaintForm_Toolbars_Dock_Area_Right:ToolbarsManager = THIS-OBJECT:ultraToolbarsManager1.
        /*  */
        /* m_teamMaintForm_Toolbars_Dock_Area_Top */
        /*  */
        THIS-OBJECT:m_teamMaintForm_Toolbars_Dock_Area_Top:AccessibleRole = System.Windows.Forms.AccessibleRole:Grouping.
        THIS-OBJECT:m_teamMaintForm_Toolbars_Dock_Area_Top:BackColor = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(191)), System.Convert:ToInt32(System.Convert:ToByte(219)), System.Convert:ToInt32(System.Convert:ToByte(255))).
        THIS-OBJECT:m_teamMaintForm_Toolbars_Dock_Area_Top:DockedPosition = Infragistics.Win.UltraWinToolbars.DockedPosition:Top.
        THIS-OBJECT:m_teamMaintForm_Toolbars_Dock_Area_Top:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:m_teamMaintForm_Toolbars_Dock_Area_Top:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:m_teamMaintForm_Toolbars_Dock_Area_Top:Name = "m_teamMaintForm_Toolbars_Dock_Area_Top".
        THIS-OBJECT:m_teamMaintForm_Toolbars_Dock_Area_Top:Size = NEW System.Drawing.Size(559, 162).
        THIS-OBJECT:m_teamMaintForm_Toolbars_Dock_Area_Top:ToolbarsManager = THIS-OBJECT:ultraToolbarsManager1.
        /*  */
        /* m_teamMaintForm_Toolbars_Dock_Area_Bottom */
        /*  */
        THIS-OBJECT:m_teamMaintForm_Toolbars_Dock_Area_Bottom:AccessibleRole = System.Windows.Forms.AccessibleRole:Grouping.
        THIS-OBJECT:m_teamMaintForm_Toolbars_Dock_Area_Bottom:BackColor = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(191)), System.Convert:ToInt32(System.Convert:ToByte(219)), System.Convert:ToInt32(System.Convert:ToByte(255))).
        THIS-OBJECT:m_teamMaintForm_Toolbars_Dock_Area_Bottom:DockedPosition = Infragistics.Win.UltraWinToolbars.DockedPosition:Bottom.
        THIS-OBJECT:m_teamMaintForm_Toolbars_Dock_Area_Bottom:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:m_teamMaintForm_Toolbars_Dock_Area_Bottom:InitialResizeAreaExtent = 8.
        THIS-OBJECT:m_teamMaintForm_Toolbars_Dock_Area_Bottom:Location = NEW System.Drawing.Point(0, 410).
        THIS-OBJECT:m_teamMaintForm_Toolbars_Dock_Area_Bottom:Name = "m_teamMaintForm_Toolbars_Dock_Area_Bottom".
        THIS-OBJECT:m_teamMaintForm_Toolbars_Dock_Area_Bottom:Size = NEW System.Drawing.Size(559, 8).
        THIS-OBJECT:m_teamMaintForm_Toolbars_Dock_Area_Bottom:ToolbarsManager = THIS-OBJECT:ultraToolbarsManager1.
        /*  */
        /* teamMaintForm */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(559, 418).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:teamMaintForm_Fill_Panel).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:m_teamMaintForm_Toolbars_Dock_Area_Left).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:m_teamMaintForm_Toolbars_Dock_Area_Right).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:m_teamMaintForm_Toolbars_Dock_Area_Bottom).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:m_teamMaintForm_Toolbars_Dock_Area_Top).
        THIS-OBJECT:Name = "teamMaintForm".
        THIS-OBJECT:Text = "teamMaintForm".
        THIS-OBJECT:ultraTabPageControl1:ResumeLayout(FALSE).
        THIS-OBJECT:ultraTabPageControl1:PerformLayout().
        CAST(THIS-OBJECT:fiTeamName, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:bsTeam, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:fiTeamId, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:ultraToolbarsManager1, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:teamMaintForm_Fill_Panel:ClientArea:ResumeLayout(FALSE).
        THIS-OBJECT:teamMaintForm_Fill_Panel:ResumeLayout(FALSE).
        CAST(THIS-OBJECT:ultraGrid1, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:ultraTabControl1, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:ultraTabControl1:ResumeLayout(FALSE).
        CAST(THIS-OBJECT:ultraValidator1, System.ComponentModel.ISupportInitialize):EndInit().
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
	METHOD PRIVATE VOID ultraToolbarsManager1_ToolClick( INPUT sender AS System.Object, INPUT e AS Infragistics.Win.UltraWinToolbars.ToolClickEventArgs ):
				
		/* Action code */
		CASE e:Tool:Key:
		  WHEN "New"
		  THEN DO:
		    bsTeam:AddNew().
		    objTeam:createRow().
		  END.    
          WHEN "Update"
          THEN DO:
            objTeam:enableEdit().
            THIS-OBJECT:ActiveControl = fiTeamName.
          END.    
          WHEN "Delete"
          THEN DO:
            DEFINE VARIABLE lChoice AS LOGICAL NO-UNDO.
            MESSAGE SUBSTITUTE("Are you sure you want to delete &1",QUOTER(fiTeamName:TEXT))
              VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO SET lChoice.  
            IF lChoice
            THEN DO: 
              objTeam:deleteRow().
              THIS-OBJECT:ultraGrid1:Selected:Rows:Clear ().  
            END.  
          END.    
          WHEN "Save"
          THEN DO:            
            fiTeamName:DataBindings["Text"]:WriteValue().
            bsTeam:assign().
            objTeam:saveTeam().
            IF ERROR-STATUS:ERROR
            THEN RETURN.     
            THIS-OBJECT:ultraGrid1:Selected:Rows:Clear ().
          END.    
          WHEN "Cancel"
          THEN DO:
             objTeam:CancelEdit().
             THIS-OBJECT:ultraGrid1:Selected:Rows:Clear ().  
          END.    
        END CASE.		

        /* sync widget code */
        enableTools(INPUT e:Tool:Key).

        /* set active control code */
        IF e:Tool:Key EQ "New" OR
           e:Tool:Key EQ "Update"
        THEN
          THIS-OBJECT:ActiveControl = fiTeamName.

	END METHOD.

	DESTRUCTOR PUBLIC teamMaintForm ( ):

	END DESTRUCTOR.

END CLASS.