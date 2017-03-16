 
 /*------------------------------------------------------------------------
    File        : CurrencyRatesForm
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : Administrator
    Created     : Tue Feb 02 10:31:42 UTC 2016
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS gui.currencyRates.CurrencyRatesForm INHERITS gui.baseForm: 
    
    
    DEFINE PRIVATE VARIABLE BsCurrencyRates2 AS Progress.Data.BindingSource NO-UNDO.
    DEFINE PRIVATE VARIABLE ficurrencyrates AS Infragistics.Win.UltraWinEditors.UltraTextEditor NO-UNDO.
    DEFINE PRIVATE VARIABLE m_ultraTabPageControl2_Toolbars_Dock_Area_Top AS Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea NO-UNDO.
    DEFINE PRIVATE VARIABLE m_ultraTabPageControl2_Toolbars_Dock_Area_Right AS Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea NO-UNDO.
    DEFINE PRIVATE VARIABLE m_ultraTabPageControl2_Toolbars_Dock_Area_Left AS Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea NO-UNDO.
    DEFINE PRIVATE VARIABLE m_ultraTabPageControl2_Toolbars_Dock_Area_Bottom AS Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea NO-UNDO.
    DEFINE PRIVATE VARIABLE Currency AS Infragistics.Win.Misc.UltraLabel NO-UNDO.
    DEFINE PRIVATE VARIABLE ficurrencyID AS Infragistics.Win.UltraWinEditors.UltraTextEditor NO-UNDO.
    DEFINE PRIVATE VARIABLE fiCurrencyRatesName AS Infragistics.Win.UltraWinEditors.UltraTextEditor NO-UNDO.
    DEFINE PRIVATE VARIABLE fiCurrencySymbol AS Infragistics.Win.UltraWinEditors.UltraTextEditor NO-UNDO.
    DEFINE PRIVATE VARIABLE m_CurrencyRatesForm_Toolbars_Dock_Area_Top AS Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea NO-UNDO.
    DEFINE PRIVATE VARIABLE m_CurrencyRatesForm_Toolbars_Dock_Area_Right AS Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea NO-UNDO.
    DEFINE PRIVATE VARIABLE m_CurrencyRatesForm_Toolbars_Dock_Area_Left AS Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea NO-UNDO.
    DEFINE PRIVATE VARIABLE m_CurrencyRatesForm_Toolbars_Dock_Area_Bottom AS Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea NO-UNDO.
    DEFINE PRIVATE VARIABLE bsCurrencyRates AS Progress.Data.BindingSource NO-UNDO.
	DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE CurrencyRatesForm_Fill_Panel AS Infragistics.Win.Misc.UltraPanel NO-UNDO.

	DEFINE VARIABLE objCurrencyRates AS gui.currencyRates.currencyRatesModel NO-UNDO.
    DEFINE PRIVATE VARIABLE Symbol AS Infragistics.Win.Misc.UltraLabel NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraGrid1 AS Infragistics.Win.UltraWinGrid.UltraGrid NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraGrid2 AS Infragistics.Win.UltraWinGrid.UltraGrid NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraLabel1 AS Infragistics.Win.Misc.UltraLabel NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraTabPageControl2_Fill_Panel AS Infragistics.Win.Misc.UltraPanel NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraTabSharedControlsPage1 AS Infragistics.Win.UltraWinTabControl.UltraTabSharedControlsPage NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraTabPageControl2 AS Infragistics.Win.UltraWinTabControl.UltraTabPageControl NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraTabPageControl1 AS Infragistics.Win.UltraWinTabControl.UltraTabPageControl NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraTabControl1 AS Infragistics.Win.UltraWinTabControl.UltraTabControl NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraTextEditor2 AS Infragistics.Win.UltraWinEditors.UltraTextEditor NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraToolbarsManager1 AS Infragistics.Win.UltraWinToolbars.UltraToolbarsManager NO-UNDO.
    DEFINE VARIABLE objCurrencyRatess AS gui.currencyRates.CurrencyRatesModel NO-UNDO.	
    DEFINE PRIVATE VARIABLE ultraToolbarsManager2 AS Infragistics.Win.UltraWinToolbars.UltraToolbarsManager NO-UNDO.
	CONSTRUCTOR PUBLIC CurrencyRatesForm (  ):
        
                
        
        SUPER().
        InitializeComponent().
        objCurrencyRates = NEW gui.currencyRates.CurrencyRatesModel().
        
        bsCurrencyRates:HANDLE = objcurrencyRates:getCurrencyRates().
		
        
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
	METHOD PRIVATE VOID Currency_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		
		RETURN.

	END METHOD.

    METHOD PUBLIC VOID enableTools(INPUT ipcAction AS CHARACTER):
        
        CASE ipcAction:
            WHEN "New" OR 
            WHEN "Update"
            THEN 
                DO:
                    THIS-OBJECT:ultraToolbarsManager1:Tools:Item["New"]:SharedPropsInternal:Enabled    = FALSE.
                    THIS-OBJECT:ultraToolbarsManager1:Tools:Item["Update"]:SharedPropsInternal:Enabled = FALSE.
                    THIS-OBJECT:ultraToolbarsManager1:Tools:Item["Delete"]:SharedPropsInternal:Enabled = FALSE.
                    THIS-OBJECT:ultraToolbarsManager1:Tools:Item["Save"]:SharedPropsInternal:Enabled   = TRUE.
                    THIS-OBJECT:ultraToolbarsManager1:Tools:Item["Cancel"]:SharedPropsInternal:Enabled = TRUE.   
                    THIS-OBJECT:ultraTabPageControl1:ENABLED = TRUE.
                    THIS-OBJECT:ultraGrid1:Enabled = FALSE.
                END. 
            WHEN "Save" OR 
            WHEN "Cancel" OR 
            WHEN "Init"
            THEN 
                DO:
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
        tableDesc1 = NEW Progress.Data.TableDesc("ttcurrency").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE tableDesc2 AS Progress.Data.TableDesc NO-UNDO.
        tableDesc2 = NEW Progress.Data.TableDesc("ttcurrency_rates").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance1 AS Infragistics.Win.Appearance NO-UNDO.
        appearance1 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridBand1 AS Infragistics.Win.UltraWinGrid.UltraGridBand NO-UNDO.
        ultraGridBand1 = NEW Infragistics.Win.UltraWinGrid.UltraGridBand("ttcurrency_rates", -1).
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn20 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn20 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("currency_rates_id", -1, ?, 0, Infragistics.Win.UltraWinGrid.SortIndicator:Ascending, FALSE).
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn21 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn21 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("currency_rates_amount").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn22 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn22 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("cuerrency_rates_date").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn12 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn12 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("currency_id").
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
        DEFINE VARIABLE ultraTaskPaneToolbar1 AS Infragistics.Win.UltraWinToolbars.UltraTaskPaneToolbar NO-UNDO.
        ultraTaskPaneToolbar1 = NEW Infragistics.Win.UltraWinToolbars.UltraTaskPaneToolbar("UltraToolbar1").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraToolbar1 AS Infragistics.Win.UltraWinToolbars.UltraToolbar NO-UNDO.
        ultraToolbar1 = NEW Infragistics.Win.UltraWinToolbars.UltraToolbar("UltraToolbar2").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool6 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool6 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("New").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool16 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool16 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Update").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool17 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool17 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Delete").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool18 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool18 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Save").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool19 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool19 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Cancel").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool15 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool15 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("New").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance13 AS Infragistics.Win.Appearance NO-UNDO.
        appearance13 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE resources AS Progress.Util.ResourceManager NO-UNDO.
        resources = NEW Progress.Util.ResourceManager("gui.currencyRates.CurrencyRatesForm").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool20 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool20 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Update").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance14 AS Infragistics.Win.Appearance NO-UNDO.
        appearance14 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool21 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool21 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Delete").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance15 AS Infragistics.Win.Appearance NO-UNDO.
        appearance15 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool22 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool22 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Save").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance16 AS Infragistics.Win.Appearance NO-UNDO.
        appearance16 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool23 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool23 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Cancel").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance17 AS Infragistics.Win.Appearance NO-UNDO.
        appearance17 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance18 AS Infragistics.Win.Appearance NO-UNDO.
        appearance18 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridBand2 AS Infragistics.Win.UltraWinGrid.UltraGridBand NO-UNDO.
        ultraGridBand2 = NEW Infragistics.Win.UltraWinGrid.UltraGridBand("ttcurrency", -1).
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn9 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn9 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("currency_id").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn10 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn10 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("symbol").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn11 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn11 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("currency_name").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn13 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn13 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("ttcurrency_rates").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridBand3 AS Infragistics.Win.UltraWinGrid.UltraGridBand NO-UNDO.
        ultraGridBand3 = NEW Infragistics.Win.UltraWinGrid.UltraGridBand("ttcurrency_rates", 0).
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn14 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn14 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("currency_rates_id").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn15 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn15 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("currency_rates_amount").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn16 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn16 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("cuerrency_rates_date").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn17 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn17 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("currency_id").
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
        DEFINE VARIABLE appearance28 AS Infragistics.Win.Appearance NO-UNDO.
        appearance28 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance29 AS Infragistics.Win.Appearance NO-UNDO.
        appearance29 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraTab1 AS Infragistics.Win.UltraWinTabControl.UltraTab NO-UNDO.
        ultraTab1 = NEW Infragistics.Win.UltraWinTabControl.UltraTab().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraTab2 AS Infragistics.Win.UltraWinTabControl.UltraTab NO-UNDO.
        ultraTab2 = NEW Infragistics.Win.UltraWinTabControl.UltraTab().
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
        DEFINE VARIABLE buttonTool4 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool4 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Update").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool5 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool5 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Delete").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool11 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool11 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Save").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool12 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool12 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Cancel").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraToolbar2 AS Infragistics.Win.UltraWinToolbars.UltraToolbar NO-UNDO.
        ultraToolbar2 = NEW Infragistics.Win.UltraWinToolbars.UltraToolbar("CurrencyUltraToolbar").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool1 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool1 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("ButtonTool1").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool2 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool2 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("ButtonTool1").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool7 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool7 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("New").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance30 AS Infragistics.Win.Appearance NO-UNDO.
        appearance30 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance31 AS Infragistics.Win.Appearance NO-UNDO.
        appearance31 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool8 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool8 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Update").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance32 AS Infragistics.Win.Appearance NO-UNDO.
        appearance32 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool9 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool9 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Delete").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance33 AS Infragistics.Win.Appearance NO-UNDO.
        appearance33 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool10 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool10 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Edit").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool13 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool13 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Save").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance34 AS Infragistics.Win.Appearance NO-UNDO.
        appearance34 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool14 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool14 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Cancel").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance35 AS Infragistics.Win.Appearance NO-UNDO.
        appearance35 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE tableDesc3 AS Progress.Data.TableDesc NO-UNDO.
        tableDesc3 = NEW Progress.Data.TableDesc("ttcurrency_rates").
        THIS-OBJECT:ultraTabPageControl1 = NEW Infragistics.Win.UltraWinTabControl.UltraTabPageControl().
        THIS-OBJECT:Currency = NEW Infragistics.Win.Misc.UltraLabel().
        THIS-OBJECT:Symbol = NEW Infragistics.Win.Misc.UltraLabel().
        THIS-OBJECT:ultraLabel1 = NEW Infragistics.Win.Misc.UltraLabel().
        THIS-OBJECT:fiCurrencySymbol = NEW Infragistics.Win.UltraWinEditors.UltraTextEditor().
        THIS-OBJECT:bsCurrencyRates = NEW Progress.Data.BindingSource(THIS-OBJECT:components).
        THIS-OBJECT:ficurrencyID = NEW Infragistics.Win.UltraWinEditors.UltraTextEditor().
        THIS-OBJECT:fiCurrencyRatesName = NEW Infragistics.Win.UltraWinEditors.UltraTextEditor().
        THIS-OBJECT:ultraTabPageControl2 = NEW Infragistics.Win.UltraWinTabControl.UltraTabPageControl().
        THIS-OBJECT:ultraTabPageControl2_Fill_Panel = NEW Infragistics.Win.Misc.UltraPanel().
        THIS-OBJECT:ultraGrid2 = NEW Infragistics.Win.UltraWinGrid.UltraGrid().
        THIS-OBJECT:m_ultraTabPageControl2_Toolbars_Dock_Area_Left = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea().
        THIS-OBJECT:ultraToolbarsManager2 = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsManager(THIS-OBJECT:components).
        THIS-OBJECT:m_ultraTabPageControl2_Toolbars_Dock_Area_Right = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea().
        THIS-OBJECT:m_ultraTabPageControl2_Toolbars_Dock_Area_Bottom = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea().
        THIS-OBJECT:m_ultraTabPageControl2_Toolbars_Dock_Area_Top = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea().
        THIS-OBJECT:CurrencyRatesForm_Fill_Panel = NEW Infragistics.Win.Misc.UltraPanel().
        THIS-OBJECT:ultraGrid1 = NEW Infragistics.Win.UltraWinGrid.UltraGrid().
        THIS-OBJECT:ultraTabControl1 = NEW Infragistics.Win.UltraWinTabControl.UltraTabControl().
        THIS-OBJECT:ultraTabSharedControlsPage1 = NEW Infragistics.Win.UltraWinTabControl.UltraTabSharedControlsPage().
        THIS-OBJECT:m_CurrencyRatesForm_Toolbars_Dock_Area_Right = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea().
        THIS-OBJECT:ultraToolbarsManager1 = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsManager(THIS-OBJECT:components).
        THIS-OBJECT:m_CurrencyRatesForm_Toolbars_Dock_Area_Left = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea().
        THIS-OBJECT:m_CurrencyRatesForm_Toolbars_Dock_Area_Bottom = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea().
        THIS-OBJECT:m_CurrencyRatesForm_Toolbars_Dock_Area_Top = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea().
        THIS-OBJECT:ficurrencyrates = NEW Infragistics.Win.UltraWinEditors.UltraTextEditor().
        THIS-OBJECT:ultraTextEditor2 = NEW Infragistics.Win.UltraWinEditors.UltraTextEditor().
        THIS-OBJECT:BsCurrencyRates2 = NEW Progress.Data.BindingSource(THIS-OBJECT:components).
        THIS-OBJECT:ultraTabPageControl1:SuspendLayout().
        CAST(THIS-OBJECT:fiCurrencySymbol, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:bsCurrencyRates, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:ficurrencyID, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:fiCurrencyRatesName, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:ultraTabPageControl2:SuspendLayout().
        THIS-OBJECT:ultraTabPageControl2_Fill_Panel:ClientArea:SuspendLayout().
        THIS-OBJECT:ultraTabPageControl2_Fill_Panel:SuspendLayout().
        CAST(THIS-OBJECT:ultraGrid2, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:ultraToolbarsManager2, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:CurrencyRatesForm_Fill_Panel:ClientArea:SuspendLayout().
        THIS-OBJECT:CurrencyRatesForm_Fill_Panel:SuspendLayout().
        CAST(THIS-OBJECT:ultraGrid1, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:ultraTabControl1, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:ultraTabControl1:SuspendLayout().
        CAST(THIS-OBJECT:ultraToolbarsManager1, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:ficurrencyrates, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:ultraTextEditor2, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:BsCurrencyRates2, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* ultraTabPageControl1 */
        /*  */
        THIS-OBJECT:ultraTabPageControl1:Controls:Add(THIS-OBJECT:Currency).
        THIS-OBJECT:ultraTabPageControl1:Controls:Add(THIS-OBJECT:Symbol).
        THIS-OBJECT:ultraTabPageControl1:Controls:Add(THIS-OBJECT:ultraLabel1).
        THIS-OBJECT:ultraTabPageControl1:Controls:Add(THIS-OBJECT:fiCurrencySymbol).
        THIS-OBJECT:ultraTabPageControl1:Controls:Add(THIS-OBJECT:ficurrencyID).
        THIS-OBJECT:ultraTabPageControl1:Controls:Add(THIS-OBJECT:fiCurrencyRatesName).
        THIS-OBJECT:ultraTabPageControl1:DataBindings:Add(NEW System.Windows.Forms.Binding("Tag", THIS-OBJECT:bsCurrencyRates, "currency_name", TRUE)).
        THIS-OBJECT:ultraTabPageControl1:Location = NEW System.Drawing.Point(-10000, -10000).
        THIS-OBJECT:ultraTabPageControl1:Name = "ultraTabPageControl1".
        THIS-OBJECT:ultraTabPageControl1:Size = NEW System.Drawing.Size(598, 158).
        /*  */
        /* Currency */
        /*  */
        THIS-OBJECT:Currency:Location = NEW System.Drawing.Point(11, 67).
        THIS-OBJECT:Currency:Name = "Currency".
        THIS-OBJECT:Currency:Size = NEW System.Drawing.Size(65, 24).
        THIS-OBJECT:Currency:TabIndex = 5.
        THIS-OBJECT:Currency:Text = "Currency:".
        THIS-OBJECT:Currency:Click:Subscribe(THIS-OBJECT:Currency_Click).
        /*  */
        /* Symbol */
        /*  */
        THIS-OBJECT:Symbol:Location = NEW System.Drawing.Point(11, 43).
        THIS-OBJECT:Symbol:Name = "Symbol".
        THIS-OBJECT:Symbol:Size = NEW System.Drawing.Size(79, 23).
        THIS-OBJECT:Symbol:TabIndex = 4.
        THIS-OBJECT:Symbol:Text = "Symbol: ".
        THIS-OBJECT:Symbol:Click:Subscribe(THIS-OBJECT:ultraLabel2_Click).
        /*  */
        /* ultraLabel1 */
        /*  */
        THIS-OBJECT:ultraLabel1:Location = NEW System.Drawing.Point(11, 16).
        THIS-OBJECT:ultraLabel1:Name = "ultraLabel1".
        THIS-OBJECT:ultraLabel1:Size = NEW System.Drawing.Size(79, 21).
        THIS-OBJECT:ultraLabel1:TabIndex = 3.
        THIS-OBJECT:ultraLabel1:Text = "Currency ID:".
        THIS-OBJECT:ultraLabel1:Click:Subscribe(THIS-OBJECT:ultraLabel1_Click).
        /*  */
        /* fiCurrencySymbol */
        /*  */
        THIS-OBJECT:fiCurrencySymbol:DataBindings:Add(NEW System.Windows.Forms.Binding("Text", THIS-OBJECT:bsCurrencyRates, "symbol", TRUE)).
        THIS-OBJECT:fiCurrencySymbol:Location = NEW System.Drawing.Point(96, 43).
        THIS-OBJECT:fiCurrencySymbol:Name = "fiCurrencySymbol".
        THIS-OBJECT:fiCurrencySymbol:Size = NEW System.Drawing.Size(100, 21).
        THIS-OBJECT:fiCurrencySymbol:TabIndex = 2.
        /*  */
        /* bsCurrencyRates */
        /*  */
        THIS-OBJECT:bsCurrencyRates:MaxDataGuess = 0.
        THIS-OBJECT:bsCurrencyRates:NoLOBs = FALSE.
        THIS-OBJECT:bsCurrencyRates:Position = 0.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar0 AS "Progress.Data.TableDesc[]" NO-UNDO.
        arrayvar0 = NEW "Progress.Data.TableDesc[]"(0).
        tableDesc2:ChildTables = arrayvar0.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar1 AS Progress.Data.ColumnPropDesc EXTENT 4 NO-UNDO.
        arrayvar1[1] = NEW Progress.Data.ColumnPropDesc("currency_rates_id", "currency rates ID", Progress.Data.DataType:INTEGER).
        arrayvar1[2] = NEW Progress.Data.ColumnPropDesc("currency_rates_amount", "rates", Progress.Data.DataType:INTEGER).
        arrayvar1[3] = NEW Progress.Data.ColumnPropDesc("cuerrency_rates_date", "date", Progress.Data.DataType:DATE).
        arrayvar1[4] = NEW Progress.Data.ColumnPropDesc("currency_id", "Currency id", Progress.Data.DataType:INTEGER).
        tableDesc2:Columns = arrayvar1.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar2 AS Progress.Data.TableDesc EXTENT 1 NO-UNDO.
        arrayvar2[1] = tableDesc2.
        tableDesc1:ChildTables = arrayvar2.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar3 AS Progress.Data.ColumnPropDesc EXTENT 3 NO-UNDO.
        arrayvar3[1] = NEW Progress.Data.ColumnPropDesc("currency_id", "Currency ID", Progress.Data.DataType:INTEGER).
        arrayvar3[2] = NEW Progress.Data.ColumnPropDesc("symbol", "Symbol", Progress.Data.DataType:CHARACTER).
        arrayvar3[3] = NEW Progress.Data.ColumnPropDesc("currency_name", "Currency", Progress.Data.DataType:CHARACTER).
        tableDesc1:Columns = arrayvar3.
        THIS-OBJECT:bsCurrencyRates:TableSchema = tableDesc1.
        /*  */
        /* ficurrencyID */
        /*  */
        THIS-OBJECT:ficurrencyID:DataBindings:Add(NEW System.Windows.Forms.Binding("Text", THIS-OBJECT:bsCurrencyRates, "currency_id", TRUE)).
        THIS-OBJECT:ficurrencyID:Location = NEW System.Drawing.Point(96, 16).
        THIS-OBJECT:ficurrencyID:Name = "ficurrencyID".
        THIS-OBJECT:ficurrencyID:Size = NEW System.Drawing.Size(100, 21).
        THIS-OBJECT:ficurrencyID:TabIndex = 1.
        /*  */
        /* fiCurrencyRatesName */
        /*  */
        THIS-OBJECT:fiCurrencyRatesName:DataBindings:Add(NEW System.Windows.Forms.Binding("Text", THIS-OBJECT:bsCurrencyRates, "currency_name", TRUE)).
        THIS-OBJECT:fiCurrencyRatesName:Location = NEW System.Drawing.Point(96, 70).
        THIS-OBJECT:fiCurrencyRatesName:Name = "fiCurrencyRatesName".
        THIS-OBJECT:fiCurrencyRatesName:Size = NEW System.Drawing.Size(100, 21).
        THIS-OBJECT:fiCurrencyRatesName:TabIndex = 0.
        /*  */
        /* ultraTabPageControl2 */
        /*  */
        THIS-OBJECT:ultraTabPageControl2:Controls:Add(THIS-OBJECT:ultraTabPageControl2_Fill_Panel).
        THIS-OBJECT:ultraTabPageControl2:Controls:Add(THIS-OBJECT:m_ultraTabPageControl2_Toolbars_Dock_Area_Left).
        THIS-OBJECT:ultraTabPageControl2:Controls:Add(THIS-OBJECT:m_ultraTabPageControl2_Toolbars_Dock_Area_Right).
        THIS-OBJECT:ultraTabPageControl2:Controls:Add(THIS-OBJECT:m_ultraTabPageControl2_Toolbars_Dock_Area_Bottom).
        THIS-OBJECT:ultraTabPageControl2:Controls:Add(THIS-OBJECT:m_ultraTabPageControl2_Toolbars_Dock_Area_Top).
        THIS-OBJECT:ultraTabPageControl2:Location = NEW System.Drawing.Point(2, 24).
        THIS-OBJECT:ultraTabPageControl2:Name = "ultraTabPageControl2".
        THIS-OBJECT:ultraTabPageControl2:Size = NEW System.Drawing.Size(598, 158).
        /*  */
        /* ultraTabPageControl2_Fill_Panel */
        /*  */
        /*  */
        /* ultraTabPageControl2_Fill_Panel.ClientArea */
        /*  */
        THIS-OBJECT:ultraTabPageControl2_Fill_Panel:ClientArea:Controls:Add(THIS-OBJECT:ultraTextEditor2).
        THIS-OBJECT:ultraTabPageControl2_Fill_Panel:ClientArea:Controls:Add(THIS-OBJECT:ficurrencyrates).
        THIS-OBJECT:ultraTabPageControl2_Fill_Panel:ClientArea:Controls:Add(THIS-OBJECT:ultraGrid2).
        THIS-OBJECT:ultraTabPageControl2_Fill_Panel:Cursor = System.Windows.Forms.Cursors:Default.
        THIS-OBJECT:ultraTabPageControl2_Fill_Panel:Dock = System.Windows.Forms.DockStyle:Fill.
        THIS-OBJECT:ultraTabPageControl2_Fill_Panel:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:ultraTabPageControl2_Fill_Panel:Name = "ultraTabPageControl2_Fill_Panel".
        THIS-OBJECT:ultraTabPageControl2_Fill_Panel:Size = NEW System.Drawing.Size(598, 131).
        THIS-OBJECT:ultraTabPageControl2_Fill_Panel:TabIndex = 0.
        /*  */
        /* ultraGrid2 */
        /*  */
        THIS-OBJECT:ultraGrid2:DataMember = "ttcurrency_rates".
        THIS-OBJECT:ultraGrid2:DataSource = THIS-OBJECT:bsCurrencyRates.
        appearance1:BackColor = System.Drawing.SystemColors:Window.
        appearance1:BorderColor = System.Drawing.SystemColors:InactiveCaption.
        THIS-OBJECT:ultraGrid2:DisplayLayout:Appearance = appearance1.
        ultraGridColumn20:Header:VisiblePosition = 0.
        ultraGridColumn20:Hidden = TRUE.
        ultraGridColumn21:Header:VisiblePosition = 1.
        ultraGridColumn22:Header:VisiblePosition = 2.
        ultraGridColumn12:Header:VisiblePosition = 3.
        ultraGridColumn12:Hidden = TRUE.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar4 AS System.Object EXTENT 4 NO-UNDO.
        arrayvar4[1] = ultraGridColumn20.
        arrayvar4[2] = ultraGridColumn21.
        arrayvar4[3] = ultraGridColumn22.
        arrayvar4[4] = ultraGridColumn12.
        ultraGridBand1:Columns:AddRange(arrayvar4).
        THIS-OBJECT:ultraGrid2:DisplayLayout:BandsSerializer:Add(ultraGridBand1).
        THIS-OBJECT:ultraGrid2:DisplayLayout:BorderStyle = Infragistics.Win.UIElementBorderStyle:Solid.
        THIS-OBJECT:ultraGrid2:DisplayLayout:CaptionVisible = Infragistics.Win.DefaultableBoolean:False.
        appearance2:BackColor = System.Drawing.SystemColors:ActiveBorder.
        appearance2:BackColor2 = System.Drawing.SystemColors:ControlDark.
        appearance2:BackGradientStyle = Infragistics.Win.GradientStyle:Vertical.
        appearance2:BorderColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ultraGrid2:DisplayLayout:GroupByBox:Appearance = appearance2.
        appearance3:ForeColor = System.Drawing.SystemColors:GrayText.
        THIS-OBJECT:ultraGrid2:DisplayLayout:GroupByBox:BandLabelAppearance = appearance3.
        THIS-OBJECT:ultraGrid2:DisplayLayout:GroupByBox:BorderStyle = Infragistics.Win.UIElementBorderStyle:Solid.
        appearance4:BackColor = System.Drawing.SystemColors:ControlLightLight.
        appearance4:BackColor2 = System.Drawing.SystemColors:Control.
        appearance4:BackGradientStyle = Infragistics.Win.GradientStyle:Horizontal.
        appearance4:ForeColor = System.Drawing.SystemColors:GrayText.
        THIS-OBJECT:ultraGrid2:DisplayLayout:GroupByBox:PromptAppearance = appearance4.
        THIS-OBJECT:ultraGrid2:DisplayLayout:MaxColScrollRegions = 1.
        THIS-OBJECT:ultraGrid2:DisplayLayout:MaxRowScrollRegions = 1.
        appearance5:BackColor = System.Drawing.SystemColors:Window.
        appearance5:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:ultraGrid2:DisplayLayout:Override:ActiveCellAppearance = appearance5.
        appearance6:BackColor = System.Drawing.SystemColors:Highlight.
        appearance6:ForeColor = System.Drawing.SystemColors:HighlightText.
        THIS-OBJECT:ultraGrid2:DisplayLayout:Override:ActiveRowAppearance = appearance6.
        THIS-OBJECT:ultraGrid2:DisplayLayout:Override:BorderStyleCell = Infragistics.Win.UIElementBorderStyle:Dotted.
        THIS-OBJECT:ultraGrid2:DisplayLayout:Override:BorderStyleRow = Infragistics.Win.UIElementBorderStyle:Dotted.
        appearance7:BackColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ultraGrid2:DisplayLayout:Override:CardAreaAppearance = appearance7.
        appearance8:BorderColor = System.Drawing.Color:Silver.
        appearance8:TextTrimming = Infragistics.Win.TextTrimming:EllipsisCharacter.
        THIS-OBJECT:ultraGrid2:DisplayLayout:Override:CellAppearance = appearance8.
        THIS-OBJECT:ultraGrid2:DisplayLayout:Override:CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction:EditAndSelectText.
        THIS-OBJECT:ultraGrid2:DisplayLayout:Override:CellPadding = 0.
        appearance9:BackColor = System.Drawing.SystemColors:Control.
        appearance9:BackColor2 = System.Drawing.SystemColors:ControlDark.
        appearance9:BackGradientAlignment = Infragistics.Win.GradientAlignment:Element.
        appearance9:BackGradientStyle = Infragistics.Win.GradientStyle:Horizontal.
        appearance9:BorderColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ultraGrid2:DisplayLayout:Override:GroupByRowAppearance = appearance9.
        appearance10:TextHAlignAsString = "Left".
        THIS-OBJECT:ultraGrid2:DisplayLayout:Override:HeaderAppearance = appearance10.
        THIS-OBJECT:ultraGrid2:DisplayLayout:Override:HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction:SortMulti.
        THIS-OBJECT:ultraGrid2:DisplayLayout:Override:HeaderStyle = Infragistics.Win.HeaderStyle:WindowsXPCommand.
        appearance11:BackColor = System.Drawing.SystemColors:Window.
        appearance11:BorderColor = System.Drawing.Color:Silver.
        THIS-OBJECT:ultraGrid2:DisplayLayout:Override:RowAppearance = appearance11.
        THIS-OBJECT:ultraGrid2:DisplayLayout:Override:RowSelectors = Infragistics.Win.DefaultableBoolean:False.
        appearance12:BackColor = System.Drawing.SystemColors:ControlLight.
        THIS-OBJECT:ultraGrid2:DisplayLayout:Override:TemplateAddRowAppearance = appearance12.
        THIS-OBJECT:ultraGrid2:DisplayLayout:ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds:ScrollToFill.
        THIS-OBJECT:ultraGrid2:DisplayLayout:ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle:Immediate.
        THIS-OBJECT:ultraGrid2:DisplayLayout:ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand:OutlookGroupBy.
        THIS-OBJECT:ultraGrid2:Font = NEW System.Drawing.Font("Microsoft Sans Serif", Progress.Util.CastUtil:ToSingle(8.25), System.Drawing.FontStyle:Regular, System.Drawing.GraphicsUnit:Point, System.Convert:ToByte(0)).
        THIS-OBJECT:ultraGrid2:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:ultraGrid2:Name = "ultraGrid2".
        THIS-OBJECT:ultraGrid2:Size = NEW System.Drawing.Size(150, 131).
        THIS-OBJECT:ultraGrid2:TabIndex = 1.
        THIS-OBJECT:ultraGrid2:Text = "ultraGrid2".
        THIS-OBJECT:ultraGrid2:InitializeLayout:Subscribe(THIS-OBJECT:ultraGrid2_InitializeLayout).
        /*  */
        /* m_ultraTabPageControl2_Toolbars_Dock_Area_Left */
        /*  */
        THIS-OBJECT:m_ultraTabPageControl2_Toolbars_Dock_Area_Left:AccessibleRole = System.Windows.Forms.AccessibleRole:Grouping.
        THIS-OBJECT:m_ultraTabPageControl2_Toolbars_Dock_Area_Left:BackColor = System.Drawing.SystemColors:GradientActiveCaption.
        THIS-OBJECT:m_ultraTabPageControl2_Toolbars_Dock_Area_Left:DockedPosition = Infragistics.Win.UltraWinToolbars.DockedPosition:Left.
        THIS-OBJECT:m_ultraTabPageControl2_Toolbars_Dock_Area_Left:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:m_ultraTabPageControl2_Toolbars_Dock_Area_Left:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:m_ultraTabPageControl2_Toolbars_Dock_Area_Left:Name = "m_ultraTabPageControl2_Toolbars_Dock_Area_Left".
        THIS-OBJECT:m_ultraTabPageControl2_Toolbars_Dock_Area_Left:Size = NEW System.Drawing.Size(0, 131).
        THIS-OBJECT:m_ultraTabPageControl2_Toolbars_Dock_Area_Left:ToolbarsManager = THIS-OBJECT:ultraToolbarsManager2.
        /*  */
        /* ultraToolbarsManager2 */
        /*  */
        THIS-OBJECT:ultraToolbarsManager2:DesignerFlags = 1.
        THIS-OBJECT:ultraToolbarsManager2:DockWithinContainer = THIS-OBJECT:ultraTabPageControl2.
        ultraTaskPaneToolbar1:DockedColumn = 0.
        ultraTaskPaneToolbar1:DockedPosition = Infragistics.Win.UltraWinToolbars.DockedPosition:Right.
        ultraTaskPaneToolbar1:DockedRow = 0.
        ultraTaskPaneToolbar1:Text = "UltraToolbar1".
        ultraTaskPaneToolbar1:Visible = FALSE.
        ultraToolbar1:DockedColumn = 0.
        ultraToolbar1:DockedPosition = Infragistics.Win.UltraWinToolbars.DockedPosition:Bottom.
        ultraToolbar1:DockedRow = 0.
        ultraToolbar1:FloatingSize = NEW System.Drawing.Size(158, 26).
        ultraToolbar1:IsMainMenuBar = TRUE.
        buttonTool18:InstanceProps:IsFirstInGroup = TRUE.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar5 AS Infragistics.Win.UltraWinToolbars.ToolBase EXTENT 5 NO-UNDO.
        arrayvar5[1] = buttonTool6.
        arrayvar5[2] = buttonTool16.
        arrayvar5[3] = buttonTool17.
        arrayvar5[4] = buttonTool18.
        arrayvar5[5] = buttonTool19.
        ultraToolbar1:NonInheritedTools:AddRange(arrayvar5).
        ultraToolbar1:Text = "UltraToolbar2".
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar6 AS Infragistics.Win.UltraWinToolbars.UltraToolbar EXTENT 2 NO-UNDO.
        arrayvar6[1] = ultraTaskPaneToolbar1.
        arrayvar6[2] = ultraToolbar1.
        THIS-OBJECT:ultraToolbarsManager2:Toolbars:AddRange(arrayvar6).
        appearance13:Image = CAST(resources:GetObject("appearance13.Image"), System.Object).
        buttonTool15:SharedPropsInternal:AppearancesSmall:Appearance = appearance13.
        buttonTool15:SharedPropsInternal:Caption = "New".
        buttonTool15:SharedPropsInternal:DisplayStyle = Infragistics.Win.UltraWinToolbars.ToolDisplayStyle:ImageAndText.
        appearance14:Image = CAST(resources:GetObject("appearance14.Image"), System.Object).
        buttonTool20:SharedPropsInternal:AppearancesSmall:Appearance = appearance14.
        buttonTool20:SharedPropsInternal:Caption = "Update".
        buttonTool20:SharedPropsInternal:DisplayStyle = Infragistics.Win.UltraWinToolbars.ToolDisplayStyle:ImageAndText.
        appearance15:Image = CAST(resources:GetObject("appearance15.Image"), System.Object).
        buttonTool21:SharedPropsInternal:AppearancesSmall:Appearance = appearance15.
        buttonTool21:SharedPropsInternal:Caption = "Delete".
        buttonTool21:SharedPropsInternal:DisplayStyle = Infragistics.Win.UltraWinToolbars.ToolDisplayStyle:ImageAndText.
        appearance16:Image = CAST(resources:GetObject("appearance16.Image"), System.Object).
        buttonTool22:SharedPropsInternal:AppearancesSmall:Appearance = appearance16.
        buttonTool22:SharedPropsInternal:Caption = "Save".
        buttonTool22:SharedPropsInternal:DisplayStyle = Infragistics.Win.UltraWinToolbars.ToolDisplayStyle:ImageAndText.
        appearance17:Image = CAST(resources:GetObject("appearance17.Image"), System.Object).
        buttonTool23:SharedPropsInternal:AppearancesSmall:Appearance = appearance17.
        buttonTool23:SharedPropsInternal:Caption = "Cancel".
        buttonTool23:SharedPropsInternal:DisplayStyle = Infragistics.Win.UltraWinToolbars.ToolDisplayStyle:ImageAndText.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar7 AS Infragistics.Win.UltraWinToolbars.ToolBase EXTENT 5 NO-UNDO.
        arrayvar7[1] = buttonTool15.
        arrayvar7[2] = buttonTool20.
        arrayvar7[3] = buttonTool21.
        arrayvar7[4] = buttonTool22.
        arrayvar7[5] = buttonTool23.
        THIS-OBJECT:ultraToolbarsManager2:Tools:AddRange(arrayvar7).
        THIS-OBJECT:ultraToolbarsManager2:ToolClick:Subscribe(THIS-OBJECT:ultraToolbarsManager2_ToolClick).
        /*  */
        /* m_ultraTabPageControl2_Toolbars_Dock_Area_Right */
        /*  */
        THIS-OBJECT:m_ultraTabPageControl2_Toolbars_Dock_Area_Right:AccessibleRole = System.Windows.Forms.AccessibleRole:Grouping.
        THIS-OBJECT:m_ultraTabPageControl2_Toolbars_Dock_Area_Right:BackColor = System.Drawing.SystemColors:GradientActiveCaption.
        THIS-OBJECT:m_ultraTabPageControl2_Toolbars_Dock_Area_Right:DockedPosition = Infragistics.Win.UltraWinToolbars.DockedPosition:Right.
        THIS-OBJECT:m_ultraTabPageControl2_Toolbars_Dock_Area_Right:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:m_ultraTabPageControl2_Toolbars_Dock_Area_Right:Location = NEW System.Drawing.Point(598, 0).
        THIS-OBJECT:m_ultraTabPageControl2_Toolbars_Dock_Area_Right:Name = "m_ultraTabPageControl2_Toolbars_Dock_Area_Right".
        THIS-OBJECT:m_ultraTabPageControl2_Toolbars_Dock_Area_Right:Size = NEW System.Drawing.Size(0, 131).
        THIS-OBJECT:m_ultraTabPageControl2_Toolbars_Dock_Area_Right:ToolbarsManager = THIS-OBJECT:ultraToolbarsManager2.
        /*  */
        /* m_ultraTabPageControl2_Toolbars_Dock_Area_Bottom */
        /*  */
        THIS-OBJECT:m_ultraTabPageControl2_Toolbars_Dock_Area_Bottom:AccessibleRole = System.Windows.Forms.AccessibleRole:Grouping.
        THIS-OBJECT:m_ultraTabPageControl2_Toolbars_Dock_Area_Bottom:BackColor = System.Drawing.SystemColors:GradientActiveCaption.
        THIS-OBJECT:m_ultraTabPageControl2_Toolbars_Dock_Area_Bottom:DockedPosition = Infragistics.Win.UltraWinToolbars.DockedPosition:Bottom.
        THIS-OBJECT:m_ultraTabPageControl2_Toolbars_Dock_Area_Bottom:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:m_ultraTabPageControl2_Toolbars_Dock_Area_Bottom:Location = NEW System.Drawing.Point(0, 131).
        THIS-OBJECT:m_ultraTabPageControl2_Toolbars_Dock_Area_Bottom:Name = "m_ultraTabPageControl2_Toolbars_Dock_Area_Bottom".
        THIS-OBJECT:m_ultraTabPageControl2_Toolbars_Dock_Area_Bottom:Size = NEW System.Drawing.Size(598, 27).
        THIS-OBJECT:m_ultraTabPageControl2_Toolbars_Dock_Area_Bottom:ToolbarsManager = THIS-OBJECT:ultraToolbarsManager2.
        /*  */
        /* m_ultraTabPageControl2_Toolbars_Dock_Area_Top */
        /*  */
        THIS-OBJECT:m_ultraTabPageControl2_Toolbars_Dock_Area_Top:AccessibleRole = System.Windows.Forms.AccessibleRole:Grouping.
        THIS-OBJECT:m_ultraTabPageControl2_Toolbars_Dock_Area_Top:BackColor = System.Drawing.SystemColors:GradientActiveCaption.
        THIS-OBJECT:m_ultraTabPageControl2_Toolbars_Dock_Area_Top:DockedPosition = Infragistics.Win.UltraWinToolbars.DockedPosition:Top.
        THIS-OBJECT:m_ultraTabPageControl2_Toolbars_Dock_Area_Top:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:m_ultraTabPageControl2_Toolbars_Dock_Area_Top:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:m_ultraTabPageControl2_Toolbars_Dock_Area_Top:Name = "m_ultraTabPageControl2_Toolbars_Dock_Area_Top".
        THIS-OBJECT:m_ultraTabPageControl2_Toolbars_Dock_Area_Top:Size = NEW System.Drawing.Size(598, 0).
        THIS-OBJECT:m_ultraTabPageControl2_Toolbars_Dock_Area_Top:ToolbarsManager = THIS-OBJECT:ultraToolbarsManager2.
        /*  */
        /* CurrencyRatesForm_Fill_Panel */
        /*  */
        /*  */
        /* CurrencyRatesForm_Fill_Panel.ClientArea */
        /*  */
        THIS-OBJECT:CurrencyRatesForm_Fill_Panel:ClientArea:Controls:Add(THIS-OBJECT:ultraGrid1).
        THIS-OBJECT:CurrencyRatesForm_Fill_Panel:ClientArea:Controls:Add(THIS-OBJECT:ultraTabControl1).
        THIS-OBJECT:CurrencyRatesForm_Fill_Panel:Cursor = System.Windows.Forms.Cursors:Default.
        THIS-OBJECT:CurrencyRatesForm_Fill_Panel:Dock = System.Windows.Forms.DockStyle:Fill.
        THIS-OBJECT:CurrencyRatesForm_Fill_Panel:Location = NEW System.Drawing.Point(4, 148).
        THIS-OBJECT:CurrencyRatesForm_Fill_Panel:Name = "CurrencyRatesForm_Fill_Panel".
        THIS-OBJECT:CurrencyRatesForm_Fill_Panel:Size = NEW System.Drawing.Size(602, 388).
        THIS-OBJECT:CurrencyRatesForm_Fill_Panel:TabIndex = 0.
        /*  */
        /* ultraGrid1 */
        /*  */
        THIS-OBJECT:ultraGrid1:DataSource = THIS-OBJECT:bsCurrencyRates.
        appearance18:BackColor = System.Drawing.SystemColors:Window.
        appearance18:BorderColor = System.Drawing.SystemColors:InactiveCaption.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Appearance = appearance18.
        ultraGridColumn9:Header:VisiblePosition = 0.
        ultraGridColumn10:Header:VisiblePosition = 1.
        ultraGridColumn11:Header:VisiblePosition = 2.
        ultraGridColumn13:Header:VisiblePosition = 3.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar8 AS System.Object EXTENT 4 NO-UNDO.
        arrayvar8[1] = ultraGridColumn9.
        arrayvar8[2] = ultraGridColumn10.
        arrayvar8[3] = ultraGridColumn11.
        arrayvar8[4] = ultraGridColumn13.
        ultraGridBand2:Columns:AddRange(arrayvar8).
        ultraGridColumn14:Header:VisiblePosition = 0.
        ultraGridColumn15:Header:VisiblePosition = 1.
        ultraGridColumn16:Header:VisiblePosition = 2.
        ultraGridColumn17:Header:VisiblePosition = 3.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar9 AS System.Object EXTENT 4 NO-UNDO.
        arrayvar9[1] = ultraGridColumn14.
        arrayvar9[2] = ultraGridColumn15.
        arrayvar9[3] = ultraGridColumn16.
        arrayvar9[4] = ultraGridColumn17.
        ultraGridBand3:Columns:AddRange(arrayvar9).
        THIS-OBJECT:ultraGrid1:DisplayLayout:BandsSerializer:Add(ultraGridBand2).
        THIS-OBJECT:ultraGrid1:DisplayLayout:BandsSerializer:Add(ultraGridBand3).
        THIS-OBJECT:ultraGrid1:DisplayLayout:BorderStyle = Infragistics.Win.UIElementBorderStyle:Solid.
        THIS-OBJECT:ultraGrid1:DisplayLayout:CaptionVisible = Infragistics.Win.DefaultableBoolean:False.
        appearance19:BackColor = System.Drawing.SystemColors:ActiveBorder.
        appearance19:BackColor2 = System.Drawing.SystemColors:ControlDark.
        appearance19:BackGradientStyle = Infragistics.Win.GradientStyle:Vertical.
        appearance19:BorderColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ultraGrid1:DisplayLayout:GroupByBox:Appearance = appearance19.
        appearance20:ForeColor = System.Drawing.SystemColors:GrayText.
        THIS-OBJECT:ultraGrid1:DisplayLayout:GroupByBox:BandLabelAppearance = appearance20.
        THIS-OBJECT:ultraGrid1:DisplayLayout:GroupByBox:BorderStyle = Infragistics.Win.UIElementBorderStyle:Solid.
        appearance21:BackColor = System.Drawing.SystemColors:ControlLightLight.
        appearance21:BackColor2 = System.Drawing.SystemColors:Control.
        appearance21:BackGradientStyle = Infragistics.Win.GradientStyle:Horizontal.
        appearance21:ForeColor = System.Drawing.SystemColors:GrayText.
        THIS-OBJECT:ultraGrid1:DisplayLayout:GroupByBox:PromptAppearance = appearance21.
        appearance22:BackColor = System.Drawing.SystemColors:Window.
        appearance22:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:ActiveCellAppearance = appearance22.
        appearance23:BackColor = System.Drawing.SystemColors:Highlight.
        appearance23:ForeColor = System.Drawing.SystemColors:HighlightText.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:ActiveRowAppearance = appearance23.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:AllowAddNew = Infragistics.Win.UltraWinGrid.AllowAddNew:No.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:AllowDelete = Infragistics.Win.DefaultableBoolean:False.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:AllowGroupBy = Infragistics.Win.DefaultableBoolean:True.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:AllowUpdate = Infragistics.Win.DefaultableBoolean:False.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:BorderStyleCell = Infragistics.Win.UIElementBorderStyle:Dotted.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:BorderStyleRow = Infragistics.Win.UIElementBorderStyle:Dotted.
        appearance24:BackColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:CardAreaAppearance = appearance24.
        appearance25:BorderColor = System.Drawing.Color:Silver.
        appearance25:TextTrimming = Infragistics.Win.TextTrimming:EllipsisCharacter.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:CellAppearance = appearance25.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction:RowSelect.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:CellPadding = 0.
        appearance26:BackColor = System.Drawing.SystemColors:Control.
        appearance26:BackColor2 = System.Drawing.SystemColors:ControlDark.
        appearance26:BackGradientAlignment = Infragistics.Win.GradientAlignment:Element.
        appearance26:BackGradientStyle = Infragistics.Win.GradientStyle:Horizontal.
        appearance26:BorderColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:GroupByRowAppearance = appearance26.
        appearance27:TextHAlignAsString = "Left".
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:HeaderAppearance = appearance27.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction:SortMulti.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:HeaderStyle = Infragistics.Win.HeaderStyle:WindowsXPCommand.
        appearance28:BackColor = System.Drawing.SystemColors:Window.
        appearance28:BorderColor = System.Drawing.Color:Silver.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:RowAppearance = appearance28.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:RowSelectorHeaderStyle = Infragistics.Win.UltraWinGrid.RowSelectorHeaderStyle:ColumnChooserButton.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:RowSelectors = Infragistics.Win.DefaultableBoolean:True.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:SelectTypeCell = Infragistics.Win.UltraWinGrid.SelectType:None.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:SelectTypeCol = Infragistics.Win.UltraWinGrid.SelectType:None.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:SelectTypeGroupByRow = Infragistics.Win.UltraWinGrid.SelectType:None.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:SelectTypeRow = Infragistics.Win.UltraWinGrid.SelectType:Extended.
        appearance29:BackColor = System.Drawing.SystemColors:ControlLight.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:TemplateAddRowAppearance = appearance29.
        THIS-OBJECT:ultraGrid1:DisplayLayout:ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle:Immediate.
        THIS-OBJECT:ultraGrid1:DisplayLayout:TabNavigation = Infragistics.Win.UltraWinGrid.TabNavigation:NextControlOnLastCell.
        THIS-OBJECT:ultraGrid1:DisplayLayout:ViewStyle = Infragistics.Win.UltraWinGrid.ViewStyle:SingleBand.
        THIS-OBJECT:ultraGrid1:DisplayLayout:ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand:OutlookGroupBy.
        THIS-OBJECT:ultraGrid1:Dock = System.Windows.Forms.DockStyle:Top.
        THIS-OBJECT:ultraGrid1:Font = NEW System.Drawing.Font("Microsoft Sans Serif", Progress.Util.CastUtil:ToSingle(8.25), System.Drawing.FontStyle:Regular, System.Drawing.GraphicsUnit:Point, System.Convert:ToByte(0)).
        THIS-OBJECT:ultraGrid1:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:ultraGrid1:Name = "ultraGrid1".
        THIS-OBJECT:ultraGrid1:Size = NEW System.Drawing.Size(602, 160).
        THIS-OBJECT:ultraGrid1:TabIndex = 3.
        THIS-OBJECT:ultraGrid1:Text = "ultraGrid1".
        /*  */
        /* ultraTabControl1 */
        /*  */
        THIS-OBJECT:ultraTabControl1:Controls:Add(THIS-OBJECT:ultraTabSharedControlsPage1).
        THIS-OBJECT:ultraTabControl1:Controls:Add(THIS-OBJECT:ultraTabPageControl1).
        THIS-OBJECT:ultraTabControl1:Controls:Add(THIS-OBJECT:ultraTabPageControl2).
        THIS-OBJECT:ultraTabControl1:Dock = System.Windows.Forms.DockStyle:Bottom.
        THIS-OBJECT:ultraTabControl1:Location = NEW System.Drawing.Point(0, 204).
        THIS-OBJECT:ultraTabControl1:Name = "ultraTabControl1".
        THIS-OBJECT:ultraTabControl1:SharedControlsPage = THIS-OBJECT:ultraTabSharedControlsPage1.
        THIS-OBJECT:ultraTabControl1:Size = NEW System.Drawing.Size(602, 184).
        THIS-OBJECT:ultraTabControl1:TabIndex = 2.
        ultraTab1:TabPage = THIS-OBJECT:ultraTabPageControl1.
        ultraTab1:Text = "Options".
        ultraTab2:TabPage = THIS-OBJECT:ultraTabPageControl2.
        ultraTab2:Text = "Rates".
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar10 AS Infragistics.Win.UltraWinTabControl.UltraTab EXTENT 2 NO-UNDO.
        arrayvar10[1] = ultraTab1.
        arrayvar10[2] = ultraTab2.
        THIS-OBJECT:ultraTabControl1:Tabs:AddRange(arrayvar10).
        THIS-OBJECT:ultraTabControl1:SelectedTabChanged:Subscribe(THIS-OBJECT:ultraTabControl1_SelectedTabChanged).
        /*  */
        /* ultraTabSharedControlsPage1 */
        /*  */
        THIS-OBJECT:ultraTabSharedControlsPage1:Location = NEW System.Drawing.Point(-10000, -10000).
        THIS-OBJECT:ultraTabSharedControlsPage1:Name = "ultraTabSharedControlsPage1".
        THIS-OBJECT:ultraTabSharedControlsPage1:Size = NEW System.Drawing.Size(598, 158).
        /*  */
        /* m_CurrencyRatesForm_Toolbars_Dock_Area_Right */
        /*  */
        THIS-OBJECT:m_CurrencyRatesForm_Toolbars_Dock_Area_Right:AccessibleRole = System.Windows.Forms.AccessibleRole:Grouping.
        THIS-OBJECT:m_CurrencyRatesForm_Toolbars_Dock_Area_Right:BackColor = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(191)), System.Convert:ToInt32(System.Convert:ToByte(219)), System.Convert:ToInt32(System.Convert:ToByte(255))).
        THIS-OBJECT:m_CurrencyRatesForm_Toolbars_Dock_Area_Right:DockedPosition = Infragistics.Win.UltraWinToolbars.DockedPosition:Right.
        THIS-OBJECT:m_CurrencyRatesForm_Toolbars_Dock_Area_Right:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:m_CurrencyRatesForm_Toolbars_Dock_Area_Right:InitialResizeAreaExtent = 4.
        THIS-OBJECT:m_CurrencyRatesForm_Toolbars_Dock_Area_Right:Location = NEW System.Drawing.Point(606, 148).
        THIS-OBJECT:m_CurrencyRatesForm_Toolbars_Dock_Area_Right:Name = "m_CurrencyRatesForm_Toolbars_Dock_Area_Right".
        THIS-OBJECT:m_CurrencyRatesForm_Toolbars_Dock_Area_Right:Size = NEW System.Drawing.Size(4, 388).
        THIS-OBJECT:m_CurrencyRatesForm_Toolbars_Dock_Area_Right:ToolbarsManager = THIS-OBJECT:ultraToolbarsManager1.
        /*  */
        /* ultraToolbarsManager1 */
        /*  */
        THIS-OBJECT:ultraToolbarsManager1:DesignerFlags = 1.
        THIS-OBJECT:ultraToolbarsManager1:DockWithinContainer = THIS-OBJECT.
        THIS-OBJECT:ultraToolbarsManager1:DockWithinContainerBaseType = Progress.Util.TypeHelper:GetType("Progress.Windows.Form").
        ribbonTab1:Caption = "Options".
        ribbonGroup1:Caption = "ribbonGroup1".
        buttonTool3:InstanceProps:PreferredSizeOnRibbon = Infragistics.Win.UltraWinToolbars.RibbonToolSize:Large.
        buttonTool4:InstanceProps:PreferredSizeOnRibbon = Infragistics.Win.UltraWinToolbars.RibbonToolSize:Large.
        buttonTool5:InstanceProps:MinimumSizeOnRibbon = Infragistics.Win.UltraWinToolbars.RibbonToolSize:Large.
        buttonTool11:InstanceProps:IsFirstInGroup = TRUE.
        buttonTool11:InstanceProps:PreferredSizeOnRibbon = Infragistics.Win.UltraWinToolbars.RibbonToolSize:Large.
        buttonTool12:InstanceProps:PreferredSizeOnRibbon = Infragistics.Win.UltraWinToolbars.RibbonToolSize:Large.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar11 AS Infragistics.Win.UltraWinToolbars.ToolBase EXTENT 5 NO-UNDO.
        arrayvar11[1] = buttonTool3.
        arrayvar11[2] = buttonTool4.
        arrayvar11[3] = buttonTool5.
        arrayvar11[4] = buttonTool11.
        arrayvar11[5] = buttonTool12.
        ribbonGroup1:Tools:AddRange(arrayvar11).
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar12 AS Infragistics.Win.UltraWinToolbars.RibbonGroup EXTENT 1 NO-UNDO.
        arrayvar12[1] = ribbonGroup1.
        ribbonTab1:Groups:AddRange(arrayvar12).
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar13 AS Infragistics.Win.UltraWinToolbars.RibbonTab EXTENT 1 NO-UNDO.
        arrayvar13[1] = ribbonTab1.
        THIS-OBJECT:ultraToolbarsManager1:Ribbon:NonInheritedRibbonTabs:AddRange(arrayvar13).
        THIS-OBJECT:ultraToolbarsManager1:Ribbon:Visible = TRUE.
        THIS-OBJECT:ultraToolbarsManager1:ShowFullMenusDelay = 500.
        ultraToolbar2:DockedColumn = 0.
        ultraToolbar2:DockedRow = 0.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar14 AS Infragistics.Win.UltraWinToolbars.ToolBase EXTENT 1 NO-UNDO.
        arrayvar14[1] = buttonTool1.
        ultraToolbar2:NonInheritedTools:AddRange(arrayvar14).
        ultraToolbar2:Text = "CurrencyUltraToolbar".
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar15 AS Infragistics.Win.UltraWinToolbars.UltraToolbar EXTENT 1 NO-UNDO.
        arrayvar15[1] = ultraToolbar2.
        THIS-OBJECT:ultraToolbarsManager1:Toolbars:AddRange(arrayvar15).
        buttonTool2:SharedPropsInternal:Caption = "ButtonTool1".
        appearance30:Image = CAST(resources:GetObject("appearance30.Image"), System.Object).
        buttonTool7:SharedPropsInternal:AppearancesLarge:Appearance = appearance30.
        appearance31:Image = CAST(resources:GetObject("appearance31.Image"), System.Object).
        buttonTool7:SharedPropsInternal:AppearancesSmall:Appearance = appearance31.
        buttonTool7:SharedPropsInternal:Caption = "New".
        appearance32:Image = CAST(resources:GetObject("appearance32.Image"), System.Object).
        buttonTool8:SharedPropsInternal:AppearancesSmall:Appearance = appearance32.
        buttonTool8:SharedPropsInternal:Caption = "Update".
        appearance33:Image = CAST(resources:GetObject("appearance33.Image"), System.Object).
        buttonTool9:SharedPropsInternal:AppearancesSmall:Appearance = appearance33.
        buttonTool9:SharedPropsInternal:Caption = "Delete".
        buttonTool10:SharedPropsInternal:Caption = "Edit".
        appearance34:Image = CAST(resources:GetObject("appearance34.Image"), System.Object).
        buttonTool13:SharedPropsInternal:AppearancesSmall:Appearance = appearance34.
        buttonTool13:SharedPropsInternal:Caption = "Save".
        appearance35:Image = CAST(resources:GetObject("appearance35.Image"), System.Object).
        buttonTool14:SharedPropsInternal:AppearancesSmall:Appearance = appearance35.
        buttonTool14:SharedPropsInternal:Caption = "Cancel".
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar16 AS Infragistics.Win.UltraWinToolbars.ToolBase EXTENT 7 NO-UNDO.
        arrayvar16[1] = buttonTool2.
        arrayvar16[2] = buttonTool7.
        arrayvar16[3] = buttonTool8.
        arrayvar16[4] = buttonTool9.
        arrayvar16[5] = buttonTool10.
        arrayvar16[6] = buttonTool13.
        arrayvar16[7] = buttonTool14.
        THIS-OBJECT:ultraToolbarsManager1:Tools:AddRange(arrayvar16).
        THIS-OBJECT:ultraToolbarsManager1:ToolClick:Subscribe(THIS-OBJECT:ultraToolbarsManager1_ToolClick).
        /*  */
        /* m_CurrencyRatesForm_Toolbars_Dock_Area_Left */
        /*  */
        THIS-OBJECT:m_CurrencyRatesForm_Toolbars_Dock_Area_Left:AccessibleRole = System.Windows.Forms.AccessibleRole:Grouping.
        THIS-OBJECT:m_CurrencyRatesForm_Toolbars_Dock_Area_Left:BackColor = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(191)), System.Convert:ToInt32(System.Convert:ToByte(219)), System.Convert:ToInt32(System.Convert:ToByte(255))).
        THIS-OBJECT:m_CurrencyRatesForm_Toolbars_Dock_Area_Left:DockedPosition = Infragistics.Win.UltraWinToolbars.DockedPosition:Left.
        THIS-OBJECT:m_CurrencyRatesForm_Toolbars_Dock_Area_Left:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:m_CurrencyRatesForm_Toolbars_Dock_Area_Left:InitialResizeAreaExtent = 4.
        THIS-OBJECT:m_CurrencyRatesForm_Toolbars_Dock_Area_Left:Location = NEW System.Drawing.Point(0, 148).
        THIS-OBJECT:m_CurrencyRatesForm_Toolbars_Dock_Area_Left:Name = "m_CurrencyRatesForm_Toolbars_Dock_Area_Left".
        THIS-OBJECT:m_CurrencyRatesForm_Toolbars_Dock_Area_Left:Size = NEW System.Drawing.Size(4, 388).
        THIS-OBJECT:m_CurrencyRatesForm_Toolbars_Dock_Area_Left:ToolbarsManager = THIS-OBJECT:ultraToolbarsManager1.
        /*  */
        /* m_CurrencyRatesForm_Toolbars_Dock_Area_Bottom */
        /*  */
        THIS-OBJECT:m_CurrencyRatesForm_Toolbars_Dock_Area_Bottom:AccessibleRole = System.Windows.Forms.AccessibleRole:Grouping.
        THIS-OBJECT:m_CurrencyRatesForm_Toolbars_Dock_Area_Bottom:BackColor = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(191)), System.Convert:ToInt32(System.Convert:ToByte(219)), System.Convert:ToInt32(System.Convert:ToByte(255))).
        THIS-OBJECT:m_CurrencyRatesForm_Toolbars_Dock_Area_Bottom:DockedPosition = Infragistics.Win.UltraWinToolbars.DockedPosition:Bottom.
        THIS-OBJECT:m_CurrencyRatesForm_Toolbars_Dock_Area_Bottom:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:m_CurrencyRatesForm_Toolbars_Dock_Area_Bottom:InitialResizeAreaExtent = 4.
        THIS-OBJECT:m_CurrencyRatesForm_Toolbars_Dock_Area_Bottom:Location = NEW System.Drawing.Point(0, 536).
        THIS-OBJECT:m_CurrencyRatesForm_Toolbars_Dock_Area_Bottom:Name = "m_CurrencyRatesForm_Toolbars_Dock_Area_Bottom".
        THIS-OBJECT:m_CurrencyRatesForm_Toolbars_Dock_Area_Bottom:Size = NEW System.Drawing.Size(610, 4).
        THIS-OBJECT:m_CurrencyRatesForm_Toolbars_Dock_Area_Bottom:ToolbarsManager = THIS-OBJECT:ultraToolbarsManager1.
        /*  */
        /* m_CurrencyRatesForm_Toolbars_Dock_Area_Top */
        /*  */
        THIS-OBJECT:m_CurrencyRatesForm_Toolbars_Dock_Area_Top:AccessibleRole = System.Windows.Forms.AccessibleRole:Grouping.
        THIS-OBJECT:m_CurrencyRatesForm_Toolbars_Dock_Area_Top:BackColor = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(191)), System.Convert:ToInt32(System.Convert:ToByte(219)), System.Convert:ToInt32(System.Convert:ToByte(255))).
        THIS-OBJECT:m_CurrencyRatesForm_Toolbars_Dock_Area_Top:DockedPosition = Infragistics.Win.UltraWinToolbars.DockedPosition:Top.
        THIS-OBJECT:m_CurrencyRatesForm_Toolbars_Dock_Area_Top:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:m_CurrencyRatesForm_Toolbars_Dock_Area_Top:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:m_CurrencyRatesForm_Toolbars_Dock_Area_Top:Name = "m_CurrencyRatesForm_Toolbars_Dock_Area_Top".
        THIS-OBJECT:m_CurrencyRatesForm_Toolbars_Dock_Area_Top:Size = NEW System.Drawing.Size(610, 148).
        THIS-OBJECT:m_CurrencyRatesForm_Toolbars_Dock_Area_Top:ToolbarsManager = THIS-OBJECT:ultraToolbarsManager1.
        /*  */
        /* ficurrencyrates */
        /*  */
        THIS-OBJECT:ficurrencyrates:DataBindings:Add(NEW System.Windows.Forms.Binding("Text", THIS-OBJECT:BsCurrencyRates2, "currency_rates_amount", TRUE)).
        THIS-OBJECT:ficurrencyrates:Location = NEW System.Drawing.Point(268, 21).
        THIS-OBJECT:ficurrencyrates:Name = "ficurrencyrates".
        THIS-OBJECT:ficurrencyrates:Size = NEW System.Drawing.Size(100, 21).
        THIS-OBJECT:ficurrencyrates:TabIndex = 2.
        /*  */
        /* ultraTextEditor2 */
        /*  */
        THIS-OBJECT:ultraTextEditor2:DataBindings:Add(NEW System.Windows.Forms.Binding("Text", THIS-OBJECT:BsCurrencyRates2, "cuerrency_rates_date", TRUE)).
        THIS-OBJECT:ultraTextEditor2:Location = NEW System.Drawing.Point(268, 58).
        THIS-OBJECT:ultraTextEditor2:Name = "ultraTextEditor2".
        THIS-OBJECT:ultraTextEditor2:Size = NEW System.Drawing.Size(100, 21).
        THIS-OBJECT:ultraTextEditor2:TabIndex = 3.
        /*  */
        /* BsCurrencyRates2 */
        /*  */
        THIS-OBJECT:BsCurrencyRates2:MaxDataGuess = 0.
        THIS-OBJECT:BsCurrencyRates2:NoLOBs = FALSE.
        THIS-OBJECT:BsCurrencyRates2:Position = 0.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar17 AS "Progress.Data.TableDesc[]" NO-UNDO.
        arrayvar17 = NEW "Progress.Data.TableDesc[]"(0).
        tableDesc3:ChildTables = arrayvar17.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar18 AS Progress.Data.ColumnPropDesc EXTENT 4 NO-UNDO.
        arrayvar18[1] = NEW Progress.Data.ColumnPropDesc("currency_rates_id", "currency rates ID", Progress.Data.DataType:INTEGER).
        arrayvar18[2] = NEW Progress.Data.ColumnPropDesc("currency_rates_amount", "", Progress.Data.DataType:INTEGER).
        arrayvar18[3] = NEW Progress.Data.ColumnPropDesc("cuerrency_rates_date", "", Progress.Data.DataType:DATE).
        arrayvar18[4] = NEW Progress.Data.ColumnPropDesc("currency_id", "Currency id", Progress.Data.DataType:INTEGER).
        tableDesc3:Columns = arrayvar18.
        THIS-OBJECT:BsCurrencyRates2:TableSchema = tableDesc3.
        /*  */
        /* CurrencyRatesForm */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(610, 540).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:CurrencyRatesForm_Fill_Panel).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:m_CurrencyRatesForm_Toolbars_Dock_Area_Left).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:m_CurrencyRatesForm_Toolbars_Dock_Area_Right).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:m_CurrencyRatesForm_Toolbars_Dock_Area_Bottom).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:m_CurrencyRatesForm_Toolbars_Dock_Area_Top).
        THIS-OBJECT:Name = "CurrencyRatesForm".
        THIS-OBJECT:Text = "CurrencyRatesForm".
        THIS-OBJECT:ultraTabPageControl1:ResumeLayout(FALSE).
        THIS-OBJECT:ultraTabPageControl1:PerformLayout().
        CAST(THIS-OBJECT:fiCurrencySymbol, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:bsCurrencyRates, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:ficurrencyID, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:fiCurrencyRatesName, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:ultraTabPageControl2:ResumeLayout(FALSE).
        THIS-OBJECT:ultraTabPageControl2_Fill_Panel:ClientArea:ResumeLayout(FALSE).
        THIS-OBJECT:ultraTabPageControl2_Fill_Panel:ClientArea:PerformLayout().
        THIS-OBJECT:ultraTabPageControl2_Fill_Panel:ResumeLayout(FALSE).
        CAST(THIS-OBJECT:ultraGrid2, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:ultraToolbarsManager2, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:CurrencyRatesForm_Fill_Panel:ClientArea:ResumeLayout(FALSE).
        THIS-OBJECT:CurrencyRatesForm_Fill_Panel:ResumeLayout(FALSE).
        CAST(THIS-OBJECT:ultraGrid1, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:ultraTabControl1, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:ultraTabControl1:ResumeLayout(FALSE).
        CAST(THIS-OBJECT:ultraToolbarsManager1, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:ficurrencyrates, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:ultraTextEditor2, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:BsCurrencyRates2, System.ComponentModel.ISupportInitialize):EndInit().
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
	METHOD PRIVATE VOID ultraGrid2_InitializeLayout( INPUT sender AS System.Object, INPUT e AS Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs ):
		
		RETURN.

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID ultraLabel1_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		
		RETURN.

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID ultraLabel2_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		
		RETURN.

	END METHOD.


	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID ultraTabControl1_SelectedTabChanged( INPUT sender AS System.Object, INPUT e AS Infragistics.Win.UltraWinTabControl.SelectedTabChangedEventArgs ):
		
		RETURN.

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
            THEN 
                DO:
                    bsCurrencyRates:AddNew().
                    objCurrencyRates:createRow().
                END.    
            WHEN "Update"
            THEN 
                DO:
                    objCurrencyRates:enableEdit().
                    THIS-OBJECT:ActiveControl = fiCurrencyRatesName.
                    THIS-OBJECT:ActiveControl = fiCurrencySymbol.
                END.    
            WHEN "Delete"
            THEN 
                DO:
                    DEFINE VARIABLE lChoice AS LOGICAL NO-UNDO.
                    MESSAGE SUBSTITUTE("Are you sure you want to delete &1",QUOTER(fiCurrencyRatesName:TEXT))
                        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO SET lChoice.  
                    IF lChoice
                        THEN 
                    DO: 
                        objCurrencyRates:deleteRow().
                        THIS-OBJECT:ultraGrid1:Selected:Rows:Clear ().  
                    END.  
                END.    
            WHEN "Save"
            THEN 
                DO:            
                    fiCurrencyRatesName:DataBindings["Text"]:WriteValue().
                    fiCurrencySymbol:DataBindings["Text"]:WriteValue().
                    bsCurrencyRates:assign().
                    objCurrencyRates:saveCurrencyRates().     
                    THIS-OBJECT:ultraGrid1:Selected:Rows:Clear ().
                END.    
            WHEN "Cancel"
            THEN 
                DO:
                    objCurrencyRates:CancelEdit().
                    THIS-OBJECT:ultraGrid1:Selected:Rows:Clear ().  
                END.    
        END CASE.       

        /* sync widget code */
        enableTools(INPUT e:Tool:Key).

        /* set active control code */
        IF e:Tool:Key EQ "New" OR
            e:Tool:Key EQ "Update"
            THEN
            THIS-OBJECT:ActiveControl = fiCurrencyRatesName.

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID ultraToolbarsManager2_ToolClick( INPUT sender AS System.Object, INPUT e AS Infragistics.Win.UltraWinToolbars.ToolClickEventArgs ):
		
		RETURN.

	END METHOD.

	DESTRUCTOR PUBLIC CurrencyRatesForm ( ):

	END DESTRUCTOR.

END CLASS.