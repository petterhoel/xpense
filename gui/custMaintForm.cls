 
 /*------------------------------------------------------------------------
    File        : custMaintForm
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : Administrator
    Created     : Fri Jan 29 09:39:46 UTC 2016
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.
USING Infragistics.Win.UltraWinToolbars.TextBoxTool FROM ASSEMBLY.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS gui.custMaintForm INHERITS gui.baseForm:
	
    DEFINE PRIVATE VARIABLE bindingSource1 AS Progress.Data.BindingSource NO-UNDO.
    DEFINE PRIVATE VARIABLE bindingSource2 AS Progress.Data.BindingSource NO-UNDO.
    DEFINE PRIVATE VARIABLE bindingSource3 AS Progress.Data.BindingSource NO-UNDO.
    DEFINE PRIVATE VARIABLE cbCountry AS Infragistics.Win.UltraWinGrid.UltraCombo NO-UNDO. 
    DEFINE PRIVATE VARIABLE fiAddress AS Infragistics.Win.UltraWinEditors.UltraTextEditor NO-UNDO.
    DEFINE PRIVATE VARIABLE fiDate AS Infragistics.Win.UltraWinSchedule.UltraCalendarCombo NO-UNDO.
    DEFINE PRIVATE VARIABLE fiPhoneNumber AS Infragistics.Win.UltraWinEditors.UltraTextEditor NO-UNDO.
    DEFINE PRIVATE VARIABLE lblCustomerName AS Infragistics.Win.Misc.UltraLabel NO-UNDO.
    DEFINE PRIVATE VARIABLE lblCustomerId AS Infragistics.Win.Misc.UltraLabel NO-UNDO.
    DEFINE PRIVATE VARIABLE fiCustomerName AS Infragistics.Win.UltraWinEditors.UltraTextEditor NO-UNDO.
    DEFINE PRIVATE VARIABLE fiCustomerId AS Infragistics.Win.UltraWinEditors.UltraNumericEditor NO-UNDO.
    DEFINE PRIVATE VARIABLE m_custMaintForm_Toolbars_Dock_Area_Top AS Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea NO-UNDO.
    DEFINE PRIVATE VARIABLE m_custMaintForm_Toolbars_Dock_Area_Right AS Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea NO-UNDO.
    DEFINE PRIVATE VARIABLE m_custMaintForm_Toolbars_Dock_Area_Left AS Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea NO-UNDO.
    DEFINE PRIVATE VARIABLE m_custMaintForm_Toolbars_Dock_Area_Bottom AS Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea NO-UNDO.
	DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraGrid1 AS Infragistics.Win.UltraWinGrid.UltraGrid NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraGrid2 AS Infragistics.Win.UltraWinGrid.UltraGrid NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraLabel1 AS Infragistics.Win.Misc.UltraLabel NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraLabel2 AS Infragistics.Win.Misc.UltraLabel NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraLabel4 AS Infragistics.Win.Misc.UltraLabel NO-UNDO. 
    DEFINE PRIVATE VARIABLE ultraLabel3 AS Infragistics.Win.Misc.UltraLabel NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraTabPageControl1 AS Infragistics.Win.UltraWinTabControl.UltraTabPageControl NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraTabPageControl2 AS Infragistics.Win.UltraWinTabControl.UltraTabPageControl NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraTabSharedControlsPage1 AS Infragistics.Win.UltraWinTabControl.UltraTabSharedControlsPage NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraTabControl1 AS Infragistics.Win.UltraWinTabControl.UltraTabControl NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraSplitter1 AS Infragistics.Win.Misc.UltraSplitter NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraToolbarsManager1 AS Infragistics.Win.UltraWinToolbars.UltraToolbarsManager NO-UNDO.
    DEFINE PRIVATE VARIABLE custMaintForm_Fill_Panel AS Infragistics.Win.Misc.UltraPanel NO-UNDO.

	DEFINE VARIABLE objCustomer AS gui.customerModel NO-UNDO.
	DEFINE VARIABLE objCountry AS gui.countryModel NO-UNDO.
	DEFINE VARIABLE objProject AS gui.projectModel NO-UNDO.
		
	CONSTRUCTOR PUBLIC custMaintForm (  ):
		
		
        SUPER().
        InitializeComponent().
        
        enableTools(INPUT "init").
        
        objCustomer = NEW gui.customerModel().
        bindingSource1:HANDLE = objCustomer:getCustomer().
        
        objCountry = NEW gui.countryModel().
        objCountry:getCountry().
        /* runs the getCountry method in the class outputting dsCountry (dataset) */
        bindingSource2:HANDLE = objCountry:getCountryHandle().                            
        /*  This binds the form to the country model */
        
        objProject = NEW gui.projectModel().
        bindingSource3:HANDLE = objProject:getProject().
        
        
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
	METHOD PRIVATE VOID cbCountry_InitializeLayout( INPUT sender AS System.Object, INPUT e AS Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs ):
		
		RETURN.

	END METHOD.



	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID cbCountry_ValueChanged( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		
		      /* set filter (only if we need to use the fields as a filter*/
/*        objCustomer:setFilter(INPUT "country_id",                   */
/*                                     INPUT "=",                     */
/*                                     INPUT STRING(cbCountry:VALUE)).*/
/*                                                                    */
/*        objCustomer:getCustomer().                                  */
        
	END METHOD.


	

	METHOD PRIVATE VOID InitializeComponent(  ):
		
        /* NOTE: The following method is automatically generated.
        
        We strongly suggest that the contents of this method only be modified using the
        Visual Designer to avoid any incompatible modifications.
        
        Modifying the contents of this method using a code editor will invalidate any support for this file. */
        THIS-OBJECT:components = NEW System.ComponentModel.Container().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE dateButton1 AS Infragistics.Win.UltraWinSchedule.CalendarCombo.DateButton NO-UNDO.
        dateButton1 = NEW Infragistics.Win.UltraWinSchedule.CalendarCombo.DateButton().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE tableDesc1 AS Progress.Data.TableDesc NO-UNDO.
        tableDesc1 = NEW Progress.Data.TableDesc("ttCustomer").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance1 AS Infragistics.Win.Appearance NO-UNDO.
        appearance1 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridBand1 AS Infragistics.Win.UltraWinGrid.UltraGridBand NO-UNDO.
        ultraGridBand1 = NEW Infragistics.Win.UltraWinGrid.UltraGridBand("ttCountry", -1).
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn7 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn7 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("country_id").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn8 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn8 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("country_name").
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
        tableDesc2 = NEW Progress.Data.TableDesc("ttCountry").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance13 AS Infragistics.Win.Appearance NO-UNDO.
        appearance13 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridBand2 AS Infragistics.Win.UltraWinGrid.UltraGridBand NO-UNDO.
        ultraGridBand2 = NEW Infragistics.Win.UltraWinGrid.UltraGridBand("ttProject", -1).
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn9 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn9 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("project_id").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn10 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn10 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("customer_id").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn11 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn11 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("project_name").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn12 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn12 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("start_date", -1, ?, 0, Infragistics.Win.UltraWinGrid.SortIndicator:Descending, FALSE).
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn13 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn13 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("due_date").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn14 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn14 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("team_id").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn15 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn15 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("project_description").
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
        tableDesc3 = NEW Progress.Data.TableDesc("ttProject").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE textBoxTool3 AS Infragistics.Win.UltraWinToolbars.TextBoxTool NO-UNDO.
        textBoxTool3 = NEW Infragistics.Win.UltraWinToolbars.TextBoxTool("TextBoxTool1").
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
        DEFINE VARIABLE ribbonGroup2 AS Infragistics.Win.UltraWinToolbars.RibbonGroup NO-UNDO.
        ribbonGroup2 = NEW Infragistics.Win.UltraWinToolbars.RibbonGroup("ribbonGroup2").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE textBoxTool1 AS Infragistics.Win.UltraWinToolbars.TextBoxTool NO-UNDO.
        textBoxTool1 = NEW Infragistics.Win.UltraWinToolbars.TextBoxTool("Filter").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool13 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool13 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Search").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool6 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool6 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("New").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance38 AS Infragistics.Win.Appearance NO-UNDO.
        appearance38 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE resources AS Progress.Util.ResourceManager NO-UNDO.
        resources = NEW Progress.Util.ResourceManager("gui.custMaintForm").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool7 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool7 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Update").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance39 AS Infragistics.Win.Appearance NO-UNDO.
        appearance39 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool8 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool8 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Delete").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance40 AS Infragistics.Win.Appearance NO-UNDO.
        appearance40 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool9 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool9 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Save").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance41 AS Infragistics.Win.Appearance NO-UNDO.
        appearance41 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool10 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool10 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Cancel").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance42 AS Infragistics.Win.Appearance NO-UNDO.
        appearance42 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE textBoxTool2 AS Infragistics.Win.UltraWinToolbars.TextBoxTool NO-UNDO.
        textBoxTool2 = NEW Infragistics.Win.UltraWinToolbars.TextBoxTool("Filter").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE textBoxTool4 AS Infragistics.Win.UltraWinToolbars.TextBoxTool NO-UNDO.
        textBoxTool4 = NEW Infragistics.Win.UltraWinToolbars.TextBoxTool("TextBoxTool1").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool12 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool12 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("Search").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE buttonTool14 AS Infragistics.Win.UltraWinToolbars.ButtonTool NO-UNDO.
        buttonTool14 = NEW Infragistics.Win.UltraWinToolbars.ButtonTool("ButtonTool1").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance25 AS Infragistics.Win.Appearance NO-UNDO.
        appearance25 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridBand3 AS Infragistics.Win.UltraWinGrid.UltraGridBand NO-UNDO.
        ultraGridBand3 = NEW Infragistics.Win.UltraWinGrid.UltraGridBand("ttCustomer", -1).
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn1 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn1 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("customer_id").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn2 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn2 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("customer_name").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn3 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn3 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("address").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn4 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn4 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("country_id", -1, ?, 0, Infragistics.Win.UltraWinGrid.SortIndicator:Descending, FALSE).
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn5 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn5 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("phone_number").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn6 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn6 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("registration_date").
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
        DEFINE VARIABLE ultraTab1 AS Infragistics.Win.UltraWinTabControl.UltraTab NO-UNDO.
        ultraTab1 = NEW Infragistics.Win.UltraWinTabControl.UltraTab().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraTab2 AS Infragistics.Win.UltraWinTabControl.UltraTab NO-UNDO.
        ultraTab2 = NEW Infragistics.Win.UltraWinTabControl.UltraTab().
        THIS-OBJECT:ultraTabPageControl1 = NEW Infragistics.Win.UltraWinTabControl.UltraTabPageControl().
        THIS-OBJECT:fiDate = NEW Infragistics.Win.UltraWinSchedule.UltraCalendarCombo().
        THIS-OBJECT:bindingSource1 = NEW Progress.Data.BindingSource(THIS-OBJECT:components).
        THIS-OBJECT:ultraLabel4 = NEW Infragistics.Win.Misc.UltraLabel().
        THIS-OBJECT:fiPhoneNumber = NEW Infragistics.Win.UltraWinEditors.UltraTextEditor().
        THIS-OBJECT:ultraLabel3 = NEW Infragistics.Win.Misc.UltraLabel().
        THIS-OBJECT:cbCountry = NEW Infragistics.Win.UltraWinGrid.UltraCombo().
        THIS-OBJECT:bindingSource2 = NEW Progress.Data.BindingSource(THIS-OBJECT:components).
        THIS-OBJECT:fiAddress = NEW Infragistics.Win.UltraWinEditors.UltraTextEditor().
        THIS-OBJECT:fiCustomerId = NEW Infragistics.Win.UltraWinEditors.UltraNumericEditor().
        THIS-OBJECT:fiCustomerName = NEW Infragistics.Win.UltraWinEditors.UltraTextEditor().
        THIS-OBJECT:lblCustomerName = NEW Infragistics.Win.Misc.UltraLabel().
        THIS-OBJECT:lblCustomerId = NEW Infragistics.Win.Misc.UltraLabel().
        THIS-OBJECT:ultraLabel1 = NEW Infragistics.Win.Misc.UltraLabel().
        THIS-OBJECT:ultraLabel2 = NEW Infragistics.Win.Misc.UltraLabel().
        THIS-OBJECT:ultraTabPageControl2 = NEW Infragistics.Win.UltraWinTabControl.UltraTabPageControl().
        THIS-OBJECT:ultraGrid2 = NEW Infragistics.Win.UltraWinGrid.UltraGrid().
        THIS-OBJECT:bindingSource3 = NEW Progress.Data.BindingSource(THIS-OBJECT:components).
        THIS-OBJECT:ultraToolbarsManager1 = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsManager(THIS-OBJECT:components).
        THIS-OBJECT:custMaintForm_Fill_Panel = NEW Infragistics.Win.Misc.UltraPanel().
        THIS-OBJECT:ultraSplitter1 = NEW Infragistics.Win.Misc.UltraSplitter().
        THIS-OBJECT:ultraGrid1 = NEW Infragistics.Win.UltraWinGrid.UltraGrid().
        THIS-OBJECT:ultraTabControl1 = NEW Infragistics.Win.UltraWinTabControl.UltraTabControl().
        THIS-OBJECT:ultraTabSharedControlsPage1 = NEW Infragistics.Win.UltraWinTabControl.UltraTabSharedControlsPage().
        THIS-OBJECT:m_custMaintForm_Toolbars_Dock_Area_Left = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea().
        THIS-OBJECT:m_custMaintForm_Toolbars_Dock_Area_Right = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea().
        THIS-OBJECT:m_custMaintForm_Toolbars_Dock_Area_Top = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea().
        THIS-OBJECT:m_custMaintForm_Toolbars_Dock_Area_Bottom = NEW Infragistics.Win.UltraWinToolbars.UltraToolbarsDockArea().
        THIS-OBJECT:ultraTabPageControl1:SuspendLayout().
        CAST(THIS-OBJECT:fiDate, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:bindingSource1, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:fiPhoneNumber, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:cbCountry, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:bindingSource2, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:fiAddress, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:fiCustomerId, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:fiCustomerName, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:ultraTabPageControl2:SuspendLayout().
        CAST(THIS-OBJECT:ultraGrid2, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:bindingSource3, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:ultraToolbarsManager1, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:custMaintForm_Fill_Panel:ClientArea:SuspendLayout().
        THIS-OBJECT:custMaintForm_Fill_Panel:SuspendLayout().
        CAST(THIS-OBJECT:ultraGrid1, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:ultraTabControl1, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:ultraTabControl1:SuspendLayout().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* ultraTabPageControl1 */
        /*  */
        THIS-OBJECT:ultraTabPageControl1:Controls:Add(THIS-OBJECT:fiDate).
        THIS-OBJECT:ultraTabPageControl1:Controls:Add(THIS-OBJECT:ultraLabel4).
        THIS-OBJECT:ultraTabPageControl1:Controls:Add(THIS-OBJECT:fiPhoneNumber).
        THIS-OBJECT:ultraTabPageControl1:Controls:Add(THIS-OBJECT:ultraLabel3).
        THIS-OBJECT:ultraTabPageControl1:Controls:Add(THIS-OBJECT:cbCountry).
        THIS-OBJECT:ultraTabPageControl1:Controls:Add(THIS-OBJECT:fiAddress).
        THIS-OBJECT:ultraTabPageControl1:Controls:Add(THIS-OBJECT:fiCustomerId).
        THIS-OBJECT:ultraTabPageControl1:Controls:Add(THIS-OBJECT:fiCustomerName).
        THIS-OBJECT:ultraTabPageControl1:Controls:Add(THIS-OBJECT:lblCustomerName).
        THIS-OBJECT:ultraTabPageControl1:Controls:Add(THIS-OBJECT:lblCustomerId).
        THIS-OBJECT:ultraTabPageControl1:Controls:Add(THIS-OBJECT:ultraLabel1).
        THIS-OBJECT:ultraTabPageControl1:Controls:Add(THIS-OBJECT:ultraLabel2).
        THIS-OBJECT:ultraTabPageControl1:Location = NEW System.Drawing.Point(-10000, -10000).
        THIS-OBJECT:ultraTabPageControl1:Name = "ultraTabPageControl1".
        THIS-OBJECT:ultraTabPageControl1:Size = NEW System.Drawing.Size(669, 132).
        /*  */
        /* fiDate */
        /*  */
        THIS-OBJECT:fiDate:DataBindings:Add(NEW System.Windows.Forms.Binding("Value", THIS-OBJECT:bindingSource1, "registration_date", TRUE)).
        THIS-OBJECT:fiDate:DateButtons:Add(dateButton1).
        THIS-OBJECT:fiDate:Location = NEW System.Drawing.Point(475, 66).
        THIS-OBJECT:fiDate:Name = "fiDate".
        THIS-OBJECT:fiDate:NonAutoSizeHeight = 21.
        THIS-OBJECT:fiDate:Size = NEW System.Drawing.Size(151, 21).
        THIS-OBJECT:fiDate:TabIndex = 11.
        THIS-OBJECT:fiDate:Value = Progress.Util.DateTimeHelper:Create(2016, 2, 1, 0, 0, 0, 0).
        /*  */
        /* bindingSource1 */
        /*  */
        THIS-OBJECT:bindingSource1:MaxDataGuess = 0.
        THIS-OBJECT:bindingSource1:NoLOBs = FALSE.
        THIS-OBJECT:bindingSource1:Position = 0.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar0 AS "Progress.Data.TableDesc[]" NO-UNDO.
        arrayvar0 = NEW "Progress.Data.TableDesc[]"(0).
        tableDesc1:ChildTables = arrayvar0.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar1 AS Progress.Data.ColumnPropDesc EXTENT 6 NO-UNDO.
        arrayvar1[1] = NEW Progress.Data.ColumnPropDesc("customer_id", "Customer Id", Progress.Data.DataType:INTEGER).
        arrayvar1[2] = NEW Progress.Data.ColumnPropDesc("customer_name", "Customer Name", Progress.Data.DataType:CHARACTER).
        arrayvar1[3] = NEW Progress.Data.ColumnPropDesc("address", "Address", Progress.Data.DataType:CHARACTER).
        arrayvar1[4] = NEW Progress.Data.ColumnPropDesc("country_id", "Country Id", Progress.Data.DataType:INTEGER).
        arrayvar1[5] = NEW Progress.Data.ColumnPropDesc("phone_number", "Phone Number", Progress.Data.DataType:CHARACTER).
        arrayvar1[6] = NEW Progress.Data.ColumnPropDesc("registration_date", "Registration Date", Progress.Data.DataType:DATE).
        tableDesc1:Columns = arrayvar1.
        THIS-OBJECT:bindingSource1:TableSchema = tableDesc1.
        /*  */
        /* ultraLabel4 */
        /*  */
        THIS-OBJECT:ultraLabel4:Location = NEW System.Drawing.Point(382, 70).
        THIS-OBJECT:ultraLabel4:Name = "ultraLabel4".
        THIS-OBJECT:ultraLabel4:Size = NEW System.Drawing.Size(100, 23).
        THIS-OBJECT:ultraLabel4:TabIndex = 10.
        THIS-OBJECT:ultraLabel4:Text = "Registration Date".
        /*  */
        /* fiPhoneNumber */
        /*  */
        THIS-OBJECT:fiPhoneNumber:DataBindings:Add(NEW System.Windows.Forms.Binding("Text", THIS-OBJECT:bindingSource1, "phone_number", TRUE)).
        THIS-OBJECT:fiPhoneNumber:Location = NEW System.Drawing.Point(101, 66).
        THIS-OBJECT:fiPhoneNumber:Name = "fiPhoneNumber".
        THIS-OBJECT:fiPhoneNumber:Size = NEW System.Drawing.Size(202, 21).
        THIS-OBJECT:fiPhoneNumber:TabIndex = 9.
        /*  */
        /* ultraLabel3 */
        /*  */
        THIS-OBJECT:ultraLabel3:Location = NEW System.Drawing.Point(19, 70).
        THIS-OBJECT:ultraLabel3:Name = "ultraLabel3".
        THIS-OBJECT:ultraLabel3:Size = NEW System.Drawing.Size(100, 23).
        THIS-OBJECT:ultraLabel3:TabIndex = 8.
        THIS-OBJECT:ultraLabel3:Text = "Phone Number".
        /*  */
        /* cbCountry */
        /*  */
        THIS-OBJECT:cbCountry:DataBindings:Add(NEW System.Windows.Forms.Binding("Value", THIS-OBJECT:bindingSource1, "country_id", TRUE)).
        THIS-OBJECT:cbCountry:DataSource = THIS-OBJECT:bindingSource2.
        appearance1:BackColor = System.Drawing.SystemColors:Window.
        appearance1:BorderColor = System.Drawing.SystemColors:InactiveCaption.
        THIS-OBJECT:cbCountry:DisplayLayout:Appearance = appearance1.
        ultraGridColumn7:Header:VisiblePosition = 0.
        ultraGridColumn8:Header:VisiblePosition = 1.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar2 AS System.Object EXTENT 2 NO-UNDO.
        arrayvar2[1] = ultraGridColumn7.
        arrayvar2[2] = ultraGridColumn8.
        ultraGridBand1:Columns:AddRange(arrayvar2).
        THIS-OBJECT:cbCountry:DisplayLayout:BandsSerializer:Add(ultraGridBand1).
        THIS-OBJECT:cbCountry:DisplayLayout:BorderStyle = Infragistics.Win.UIElementBorderStyle:Solid.
        THIS-OBJECT:cbCountry:DisplayLayout:CaptionVisible = Infragistics.Win.DefaultableBoolean:False.
        appearance2:BackColor = System.Drawing.SystemColors:ActiveBorder.
        appearance2:BackColor2 = System.Drawing.SystemColors:ControlDark.
        appearance2:BackGradientStyle = Infragistics.Win.GradientStyle:Vertical.
        appearance2:BorderColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:cbCountry:DisplayLayout:GroupByBox:Appearance = appearance2.
        appearance3:ForeColor = System.Drawing.SystemColors:GrayText.
        THIS-OBJECT:cbCountry:DisplayLayout:GroupByBox:BandLabelAppearance = appearance3.
        THIS-OBJECT:cbCountry:DisplayLayout:GroupByBox:BorderStyle = Infragistics.Win.UIElementBorderStyle:Solid.
        appearance4:BackColor = System.Drawing.SystemColors:ControlLightLight.
        appearance4:BackColor2 = System.Drawing.SystemColors:Control.
        appearance4:BackGradientStyle = Infragistics.Win.GradientStyle:Horizontal.
        appearance4:ForeColor = System.Drawing.SystemColors:GrayText.
        THIS-OBJECT:cbCountry:DisplayLayout:GroupByBox:PromptAppearance = appearance4.
        THIS-OBJECT:cbCountry:DisplayLayout:MaxColScrollRegions = 1.
        THIS-OBJECT:cbCountry:DisplayLayout:MaxRowScrollRegions = 1.
        appearance5:BackColor = System.Drawing.SystemColors:Window.
        appearance5:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:cbCountry:DisplayLayout:Override:ActiveCellAppearance = appearance5.
        appearance6:BackColor = System.Drawing.SystemColors:Highlight.
        appearance6:ForeColor = System.Drawing.SystemColors:HighlightText.
        THIS-OBJECT:cbCountry:DisplayLayout:Override:ActiveRowAppearance = appearance6.
        THIS-OBJECT:cbCountry:DisplayLayout:Override:BorderStyleCell = Infragistics.Win.UIElementBorderStyle:Dotted.
        THIS-OBJECT:cbCountry:DisplayLayout:Override:BorderStyleRow = Infragistics.Win.UIElementBorderStyle:Dotted.
        appearance7:BackColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:cbCountry:DisplayLayout:Override:CardAreaAppearance = appearance7.
        appearance8:BorderColor = System.Drawing.Color:Silver.
        appearance8:TextTrimming = Infragistics.Win.TextTrimming:EllipsisCharacter.
        THIS-OBJECT:cbCountry:DisplayLayout:Override:CellAppearance = appearance8.
        THIS-OBJECT:cbCountry:DisplayLayout:Override:CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction:EditAndSelectText.
        THIS-OBJECT:cbCountry:DisplayLayout:Override:CellPadding = 0.
        appearance9:BackColor = System.Drawing.SystemColors:Control.
        appearance9:BackColor2 = System.Drawing.SystemColors:ControlDark.
        appearance9:BackGradientAlignment = Infragistics.Win.GradientAlignment:Element.
        appearance9:BackGradientStyle = Infragistics.Win.GradientStyle:Horizontal.
        appearance9:BorderColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:cbCountry:DisplayLayout:Override:GroupByRowAppearance = appearance9.
        appearance10:TextHAlignAsString = "Left".
        THIS-OBJECT:cbCountry:DisplayLayout:Override:HeaderAppearance = appearance10.
        THIS-OBJECT:cbCountry:DisplayLayout:Override:HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction:SortMulti.
        THIS-OBJECT:cbCountry:DisplayLayout:Override:HeaderStyle = Infragistics.Win.HeaderStyle:WindowsXPCommand.
        appearance11:BackColor = System.Drawing.SystemColors:Window.
        appearance11:BorderColor = System.Drawing.Color:Silver.
        THIS-OBJECT:cbCountry:DisplayLayout:Override:RowAppearance = appearance11.
        THIS-OBJECT:cbCountry:DisplayLayout:Override:RowSelectors = Infragistics.Win.DefaultableBoolean:False.
        appearance12:BackColor = System.Drawing.SystemColors:ControlLight.
        THIS-OBJECT:cbCountry:DisplayLayout:Override:TemplateAddRowAppearance = appearance12.
        THIS-OBJECT:cbCountry:DisplayLayout:ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds:ScrollToFill.
        THIS-OBJECT:cbCountry:DisplayLayout:ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle:Immediate.
        THIS-OBJECT:cbCountry:DisplayLayout:ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand:OutlookGroupBy.
        THIS-OBJECT:cbCountry:DisplayMember = "country_name".
        THIS-OBJECT:cbCountry:Font = NEW System.Drawing.Font("Microsoft Sans Serif", Progress.Util.CastUtil:ToSingle(8.25), System.Drawing.FontStyle:Regular, System.Drawing.GraphicsUnit:Point, System.Convert:ToByte(0)).
        THIS-OBJECT:cbCountry:Location = NEW System.Drawing.Point(475, 39).
        THIS-OBJECT:cbCountry:Name = "cbCountry".
        THIS-OBJECT:cbCountry:Size = NEW System.Drawing.Size(151, 22).
        THIS-OBJECT:cbCountry:TabIndex = 6.
        THIS-OBJECT:cbCountry:ValueMember = "country_id".
        THIS-OBJECT:cbCountry:InitializeLayout:Subscribe(THIS-OBJECT:cbCountry_InitializeLayout).
        THIS-OBJECT:cbCountry:ValueChanged:Subscribe(THIS-OBJECT:cbCountry_ValueChanged).
        /*  */
        /* bindingSource2 */
        /*  */
        THIS-OBJECT:bindingSource2:MaxDataGuess = 0.
        THIS-OBJECT:bindingSource2:NoLOBs = FALSE.
        THIS-OBJECT:bindingSource2:Position = 0.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar3 AS "Progress.Data.TableDesc[]" NO-UNDO.
        arrayvar3 = NEW "Progress.Data.TableDesc[]"(0).
        tableDesc2:ChildTables = arrayvar3.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar4 AS Progress.Data.ColumnPropDesc EXTENT 2 NO-UNDO.
        arrayvar4[1] = NEW Progress.Data.ColumnPropDesc("country_id", "Country Id", Progress.Data.DataType:INTEGER).
        arrayvar4[2] = NEW Progress.Data.ColumnPropDesc("country_name", "Country Name", Progress.Data.DataType:CHARACTER).
        tableDesc2:Columns = arrayvar4.
        THIS-OBJECT:bindingSource2:TableSchema = tableDesc2.
        /*  */
        /* fiAddress */
        /*  */
        THIS-OBJECT:fiAddress:DataBindings:Add(NEW System.Windows.Forms.Binding("Text", THIS-OBJECT:bindingSource1, "address", TRUE)).
        THIS-OBJECT:fiAddress:Location = NEW System.Drawing.Point(101, 39).
        THIS-OBJECT:fiAddress:Name = "fiAddress".
        THIS-OBJECT:fiAddress:Size = NEW System.Drawing.Size(202, 21).
        THIS-OBJECT:fiAddress:TabIndex = 4.
        /*  */
        /* fiCustomerId */
        /*  */
        THIS-OBJECT:fiCustomerId:DataBindings:Add(NEW System.Windows.Forms.Binding("Text", THIS-OBJECT:bindingSource1, "customer_id", TRUE)).
        THIS-OBJECT:fiCustomerId:Enabled = FALSE.
        THIS-OBJECT:fiCustomerId:Location = NEW System.Drawing.Point(552, 12).
        THIS-OBJECT:fiCustomerId:Name = "fiCustomerId".
        THIS-OBJECT:fiCustomerId:PromptChar = ' '.
        THIS-OBJECT:fiCustomerId:Size = NEW System.Drawing.Size(74, 21).
        THIS-OBJECT:fiCustomerId:TabIndex = 3.
        /*  */
        /* fiCustomerName */
        /*  */
        THIS-OBJECT:fiCustomerName:DataBindings:Add(NEW System.Windows.Forms.Binding("Text", THIS-OBJECT:bindingSource1, "customer_name", TRUE)).
        THIS-OBJECT:fiCustomerName:Location = NEW System.Drawing.Point(101, 12).
        THIS-OBJECT:fiCustomerName:Name = "fiCustomerName".
        THIS-OBJECT:fiCustomerName:Size = NEW System.Drawing.Size(202, 21).
        THIS-OBJECT:fiCustomerName:TabIndex = 2.
        /*  */
        /* lblCustomerName */
        /*  */
        THIS-OBJECT:lblCustomerName:Location = NEW System.Drawing.Point(17, 15).
        THIS-OBJECT:lblCustomerName:Name = "lblCustomerName".
        THIS-OBJECT:lblCustomerName:Size = NEW System.Drawing.Size(100, 23).
        THIS-OBJECT:lblCustomerName:TabIndex = 1.
        THIS-OBJECT:lblCustomerName:Text = "Customer Name".
        /*  */
        /* lblCustomerId */
        /*  */
        THIS-OBJECT:lblCustomerId:Location = NEW System.Drawing.Point(486, 16).
        THIS-OBJECT:lblCustomerId:Name = "lblCustomerId".
        THIS-OBJECT:lblCustomerId:Size = NEW System.Drawing.Size(100, 23).
        THIS-OBJECT:lblCustomerId:TabIndex = 0.
        THIS-OBJECT:lblCustomerId:Text = "Customer ID".
        /*  */
        /* ultraLabel1 */
        /*  */
        THIS-OBJECT:ultraLabel1:Location = NEW System.Drawing.Point(52, 43).
        THIS-OBJECT:ultraLabel1:Name = "ultraLabel1".
        THIS-OBJECT:ultraLabel1:Size = NEW System.Drawing.Size(72, 23).
        THIS-OBJECT:ultraLabel1:TabIndex = 5.
        THIS-OBJECT:ultraLabel1:Text = "Address".
        /*  */
        /* ultraLabel2 */
        /*  */
        THIS-OBJECT:ultraLabel2:Location = NEW System.Drawing.Point(427, 43).
        THIS-OBJECT:ultraLabel2:Name = "ultraLabel2".
        THIS-OBJECT:ultraLabel2:Size = NEW System.Drawing.Size(100, 23).
        THIS-OBJECT:ultraLabel2:TabIndex = 7.
        THIS-OBJECT:ultraLabel2:Text = "Country".
        /*  */
        /* ultraTabPageControl2 */
        /*  */
        THIS-OBJECT:ultraTabPageControl2:Controls:Add(THIS-OBJECT:ultraGrid2).
        THIS-OBJECT:ultraTabPageControl2:Location = NEW System.Drawing.Point(2, 24).
        THIS-OBJECT:ultraTabPageControl2:Name = "ultraTabPageControl2".
        THIS-OBJECT:ultraTabPageControl2:Size = NEW System.Drawing.Size(669, 132).
        /*  */
        /* ultraGrid2 */
        /*  */
        THIS-OBJECT:ultraGrid2:DataSource = THIS-OBJECT:bindingSource3.
        appearance13:BackColor = System.Drawing.SystemColors:Window.
        appearance13:BorderColor = System.Drawing.SystemColors:InactiveCaption.
        THIS-OBJECT:ultraGrid2:DisplayLayout:Appearance = appearance13.
        ultraGridColumn9:Header:VisiblePosition = 0.
        ultraGridColumn10:Header:VisiblePosition = 1.
        ultraGridColumn11:Header:VisiblePosition = 2.
        ultraGridColumn12:Header:VisiblePosition = 3.
        ultraGridColumn13:Header:VisiblePosition = 4.
        ultraGridColumn14:Header:VisiblePosition = 5.
        ultraGridColumn15:Header:VisiblePosition = 6.
        ultraGridColumn15:Width = 167.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar5 AS System.Object EXTENT 7 NO-UNDO.
        arrayvar5[1] = ultraGridColumn9.
        arrayvar5[2] = ultraGridColumn10.
        arrayvar5[3] = ultraGridColumn11.
        arrayvar5[4] = ultraGridColumn12.
        arrayvar5[5] = ultraGridColumn13.
        arrayvar5[6] = ultraGridColumn14.
        arrayvar5[7] = ultraGridColumn15.
        ultraGridBand2:Columns:AddRange(arrayvar5).
        THIS-OBJECT:ultraGrid2:DisplayLayout:BandsSerializer:Add(ultraGridBand2).
        THIS-OBJECT:ultraGrid2:DisplayLayout:BorderStyle = Infragistics.Win.UIElementBorderStyle:Solid.
        THIS-OBJECT:ultraGrid2:DisplayLayout:CaptionVisible = Infragistics.Win.DefaultableBoolean:False.
        appearance14:BackColor = System.Drawing.SystemColors:ActiveBorder.
        appearance14:BackColor2 = System.Drawing.SystemColors:ControlDark.
        appearance14:BackGradientStyle = Infragistics.Win.GradientStyle:Vertical.
        appearance14:BorderColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ultraGrid2:DisplayLayout:GroupByBox:Appearance = appearance14.
        appearance15:ForeColor = System.Drawing.SystemColors:GrayText.
        THIS-OBJECT:ultraGrid2:DisplayLayout:GroupByBox:BandLabelAppearance = appearance15.
        THIS-OBJECT:ultraGrid2:DisplayLayout:GroupByBox:BorderStyle = Infragistics.Win.UIElementBorderStyle:Solid.
        appearance16:BackColor = System.Drawing.SystemColors:ControlLightLight.
        appearance16:BackColor2 = System.Drawing.SystemColors:Control.
        appearance16:BackGradientStyle = Infragistics.Win.GradientStyle:Horizontal.
        appearance16:ForeColor = System.Drawing.SystemColors:GrayText.
        THIS-OBJECT:ultraGrid2:DisplayLayout:GroupByBox:PromptAppearance = appearance16.
        THIS-OBJECT:ultraGrid2:DisplayLayout:MaxColScrollRegions = 1.
        THIS-OBJECT:ultraGrid2:DisplayLayout:MaxRowScrollRegions = 1.
        appearance17:BackColor = System.Drawing.SystemColors:Window.
        appearance17:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:ultraGrid2:DisplayLayout:Override:ActiveCellAppearance = appearance17.
        appearance18:BackColor = System.Drawing.SystemColors:Highlight.
        appearance18:ForeColor = System.Drawing.SystemColors:HighlightText.
        THIS-OBJECT:ultraGrid2:DisplayLayout:Override:ActiveRowAppearance = appearance18.
        THIS-OBJECT:ultraGrid2:DisplayLayout:Override:BorderStyleCell = Infragistics.Win.UIElementBorderStyle:Dotted.
        THIS-OBJECT:ultraGrid2:DisplayLayout:Override:BorderStyleRow = Infragistics.Win.UIElementBorderStyle:Dotted.
        appearance19:BackColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ultraGrid2:DisplayLayout:Override:CardAreaAppearance = appearance19.
        appearance20:BorderColor = System.Drawing.Color:Silver.
        appearance20:TextTrimming = Infragistics.Win.TextTrimming:EllipsisCharacter.
        THIS-OBJECT:ultraGrid2:DisplayLayout:Override:CellAppearance = appearance20.
        THIS-OBJECT:ultraGrid2:DisplayLayout:Override:CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction:EditAndSelectText.
        THIS-OBJECT:ultraGrid2:DisplayLayout:Override:CellPadding = 0.
        appearance21:BackColor = System.Drawing.SystemColors:Control.
        appearance21:BackColor2 = System.Drawing.SystemColors:ControlDark.
        appearance21:BackGradientAlignment = Infragistics.Win.GradientAlignment:Element.
        appearance21:BackGradientStyle = Infragistics.Win.GradientStyle:Horizontal.
        appearance21:BorderColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ultraGrid2:DisplayLayout:Override:GroupByRowAppearance = appearance21.
        appearance22:TextHAlignAsString = "Left".
        THIS-OBJECT:ultraGrid2:DisplayLayout:Override:HeaderAppearance = appearance22.
        THIS-OBJECT:ultraGrid2:DisplayLayout:Override:HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction:SortMulti.
        THIS-OBJECT:ultraGrid2:DisplayLayout:Override:HeaderStyle = Infragistics.Win.HeaderStyle:WindowsXPCommand.
        appearance23:BackColor = System.Drawing.SystemColors:Window.
        appearance23:BorderColor = System.Drawing.Color:Silver.
        THIS-OBJECT:ultraGrid2:DisplayLayout:Override:RowAppearance = appearance23.
        THIS-OBJECT:ultraGrid2:DisplayLayout:Override:RowSelectors = Infragistics.Win.DefaultableBoolean:False.
        appearance24:BackColor = System.Drawing.SystemColors:ControlLight.
        THIS-OBJECT:ultraGrid2:DisplayLayout:Override:TemplateAddRowAppearance = appearance24.
        THIS-OBJECT:ultraGrid2:DisplayLayout:ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds:ScrollToFill.
        THIS-OBJECT:ultraGrid2:DisplayLayout:ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle:Immediate.
        THIS-OBJECT:ultraGrid2:DisplayLayout:ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand:OutlookGroupBy.
        THIS-OBJECT:ultraGrid2:Dock = System.Windows.Forms.DockStyle:Left.
        THIS-OBJECT:ultraGrid2:Font = NEW System.Drawing.Font("Microsoft Sans Serif", Progress.Util.CastUtil:ToSingle(8.25), System.Drawing.FontStyle:Regular, System.Drawing.GraphicsUnit:Point, System.Convert:ToByte(0)).
        THIS-OBJECT:ultraGrid2:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:ultraGrid2:Name = "ultraGrid2".
        THIS-OBJECT:ultraGrid2:Size = NEW System.Drawing.Size(669, 132).
        THIS-OBJECT:ultraGrid2:TabIndex = 0.
        THIS-OBJECT:ultraGrid2:Text = "ultraGrid2".
        THIS-OBJECT:ultraGrid2:InitializeLayout:Subscribe(THIS-OBJECT:ultraGrid2_InitializeLayout).
        /*  */
        /* bindingSource3 */
        /*  */
        THIS-OBJECT:bindingSource3:MaxDataGuess = 0.
        THIS-OBJECT:bindingSource3:NoLOBs = FALSE.
        THIS-OBJECT:bindingSource3:Position = 0.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar6 AS "Progress.Data.TableDesc[]" NO-UNDO.
        arrayvar6 = NEW "Progress.Data.TableDesc[]"(0).
        tableDesc3:ChildTables = arrayvar6.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar7 AS Progress.Data.ColumnPropDesc EXTENT 7 NO-UNDO.
        arrayvar7[1] = NEW Progress.Data.ColumnPropDesc("project_id", "Project ID", Progress.Data.DataType:INTEGER).
        arrayvar7[2] = NEW Progress.Data.ColumnPropDesc("customer_id", "Customer ID", Progress.Data.DataType:INTEGER).
        arrayvar7[3] = NEW Progress.Data.ColumnPropDesc("project_name", "Project Name", Progress.Data.DataType:CHARACTER).
        arrayvar7[4] = NEW Progress.Data.ColumnPropDesc("start_date", "Start Date", Progress.Data.DataType:DATE).
        arrayvar7[5] = NEW Progress.Data.ColumnPropDesc("due_date", "Due Date", Progress.Data.DataType:DATE).
        arrayvar7[6] = NEW Progress.Data.ColumnPropDesc("team_id", "Team ID", Progress.Data.DataType:INTEGER).
        arrayvar7[7] = NEW Progress.Data.ColumnPropDesc("project_description", "Project Description", Progress.Data.DataType:CHARACTER).
        tableDesc3:Columns = arrayvar7.
        THIS-OBJECT:bindingSource3:TableSchema = tableDesc3.
        /*  */
        /* ultraToolbarsManager1 */
        /*  */
        THIS-OBJECT:ultraToolbarsManager1:DesignerFlags = 1.
        THIS-OBJECT:ultraToolbarsManager1:DockWithinContainer = THIS-OBJECT.
        THIS-OBJECT:ultraToolbarsManager1:DockWithinContainerBaseType = Progress.Util.TypeHelper:GetType("gui.baseForm").
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar8 AS Infragistics.Win.UltraWinToolbars.ToolBase EXTENT 1 NO-UNDO.
        arrayvar8[1] = textBoxTool3.
        THIS-OBJECT:ultraToolbarsManager1:MiniToolbar:NonInheritedTools:AddRange(arrayvar8).
        THIS-OBJECT:ultraToolbarsManager1:MiniToolbar:ToolRowCount = 1.
        ribbonTab1:Caption = "Main".
        ribbonGroup1:Caption = "".
        buttonTool1:InstanceProps:PreferredSizeOnRibbon = Infragistics.Win.UltraWinToolbars.RibbonToolSize:Large.
        buttonTool2:InstanceProps:PreferredSizeOnRibbon = Infragistics.Win.UltraWinToolbars.RibbonToolSize:Large.
        buttonTool3:InstanceProps:PreferredSizeOnRibbon = Infragistics.Win.UltraWinToolbars.RibbonToolSize:Large.
        buttonTool4:InstanceProps:IsFirstInGroup = TRUE.
        buttonTool4:InstanceProps:PreferredSizeOnRibbon = Infragistics.Win.UltraWinToolbars.RibbonToolSize:Large.
        buttonTool5:InstanceProps:PreferredSizeOnRibbon = Infragistics.Win.UltraWinToolbars.RibbonToolSize:Large.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar9 AS Infragistics.Win.UltraWinToolbars.ToolBase EXTENT 5 NO-UNDO.
        arrayvar9[1] = buttonTool1.
        arrayvar9[2] = buttonTool2.
        arrayvar9[3] = buttonTool3.
        arrayvar9[4] = buttonTool4.
        arrayvar9[5] = buttonTool5.
        ribbonGroup1:Tools:AddRange(arrayvar9).
        ribbonGroup2:Caption = "".
        textBoxTool1:InstanceProps:ButtonGroup = "q".
        textBoxTool1:InstanceProps:PreferredSizeOnRibbon = Infragistics.Win.UltraWinToolbars.RibbonToolSize:Normal.
        buttonTool13:InstanceProps:ButtonGroup = "q".
        buttonTool13:InstanceProps:MinimumSizeOnRibbon = Infragistics.Win.UltraWinToolbars.RibbonToolSize:Large.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar10 AS Infragistics.Win.UltraWinToolbars.ToolBase EXTENT 2 NO-UNDO.
        arrayvar10[1] = textBoxTool1.
        arrayvar10[2] = buttonTool13.
        ribbonGroup2:Tools:AddRange(arrayvar10).
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar11 AS Infragistics.Win.UltraWinToolbars.RibbonGroup EXTENT 2 NO-UNDO.
        arrayvar11[1] = ribbonGroup1.
        arrayvar11[2] = ribbonGroup2.
        ribbonTab1:Groups:AddRange(arrayvar11).
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar12 AS Infragistics.Win.UltraWinToolbars.RibbonTab EXTENT 1 NO-UNDO.
        arrayvar12[1] = ribbonTab1.
        THIS-OBJECT:ultraToolbarsManager1:Ribbon:NonInheritedRibbonTabs:AddRange(arrayvar12).
        THIS-OBJECT:ultraToolbarsManager1:Ribbon:Visible = TRUE.
        THIS-OBJECT:ultraToolbarsManager1:ShowFullMenusDelay = 500.
        appearance38:Image = CAST(resources:GetObject("appearance38.Image"), System.Object).
        buttonTool6:SharedPropsInternal:AppearancesLarge:Appearance = appearance38.
        buttonTool6:SharedPropsInternal:Caption = "New".
        buttonTool6:SharedPropsInternal:Category = "tableio".
        appearance39:Image = CAST(resources:GetObject("appearance39.Image"), System.Object).
        buttonTool7:SharedPropsInternal:AppearancesLarge:Appearance = appearance39.
        buttonTool7:SharedPropsInternal:Caption = "Update".
        buttonTool7:SharedPropsInternal:Category = "tableio".
        appearance40:Image = CAST(resources:GetObject("appearance40.Image"), System.Object).
        buttonTool8:SharedPropsInternal:AppearancesLarge:Appearance = appearance40.
        buttonTool8:SharedPropsInternal:Caption = "Delete".
        buttonTool8:SharedPropsInternal:Category = "tableio".
        appearance41:Image = CAST(resources:GetObject("appearance41.Image"), System.Object).
        buttonTool9:SharedPropsInternal:AppearancesLarge:Appearance = appearance41.
        buttonTool9:SharedPropsInternal:Caption = "Save".
        buttonTool9:SharedPropsInternal:Category = "tableio".
        appearance42:Image = CAST(resources:GetObject("appearance42.Image"), System.Object).
        buttonTool10:SharedPropsInternal:AppearancesLarge:Appearance = appearance42.
        buttonTool10:SharedPropsInternal:Caption = "Cancel".
        buttonTool10:SharedPropsInternal:Category = "tableio".
        textBoxTool4:SharedPropsInternal:Caption = "TextBoxTool1".
        textBoxTool4:SharedPropsInternal:MinWidth = 500.
        textBoxTool4:SharedPropsInternal:Width = 550.
        buttonTool12:SharedPropsInternal:Caption = "Search".
        buttonTool12:SharedPropsInternal:DisplayStyle = Infragistics.Win.UltraWinToolbars.ToolDisplayStyle:ImageAndText.
        buttonTool14:SharedPropsInternal:Caption = "ButtonTool1".
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar13 AS Infragistics.Win.UltraWinToolbars.ToolBase EXTENT 9 NO-UNDO.
        arrayvar13[1] = buttonTool6.
        arrayvar13[2] = buttonTool7.
        arrayvar13[3] = buttonTool8.
        arrayvar13[4] = buttonTool9.
        arrayvar13[5] = buttonTool10.
        arrayvar13[6] = textBoxTool2.
        arrayvar13[7] = textBoxTool4.
        arrayvar13[8] = buttonTool12.
        arrayvar13[9] = buttonTool14.
        THIS-OBJECT:ultraToolbarsManager1:Tools:AddRange(arrayvar13).
        THIS-OBJECT:ultraToolbarsManager1:ToolClick:Subscribe(THIS-OBJECT:ultraToolbarsManager1_ToolClick).
        /*  */
        /* custMaintForm_Fill_Panel */
        /*  */
        /*  */
        /* custMaintForm_Fill_Panel.ClientArea */
        /*  */
        THIS-OBJECT:custMaintForm_Fill_Panel:ClientArea:Controls:Add(THIS-OBJECT:ultraSplitter1).
        THIS-OBJECT:custMaintForm_Fill_Panel:ClientArea:Controls:Add(THIS-OBJECT:ultraGrid1).
        THIS-OBJECT:custMaintForm_Fill_Panel:ClientArea:Controls:Add(THIS-OBJECT:ultraTabControl1).
        THIS-OBJECT:custMaintForm_Fill_Panel:Cursor = System.Windows.Forms.Cursors:Default.
        THIS-OBJECT:custMaintForm_Fill_Panel:Dock = System.Windows.Forms.DockStyle:Fill.
        THIS-OBJECT:custMaintForm_Fill_Panel:Location = NEW System.Drawing.Point(4, 148).
        THIS-OBJECT:custMaintForm_Fill_Panel:Name = "custMaintForm_Fill_Panel".
        THIS-OBJECT:custMaintForm_Fill_Panel:Size = NEW System.Drawing.Size(673, 381).
        THIS-OBJECT:custMaintForm_Fill_Panel:TabIndex = 0.
        /*  */
        /* ultraSplitter1 */
        /*  */
        THIS-OBJECT:ultraSplitter1:BackColor = System.Drawing.Color:Goldenrod.
        THIS-OBJECT:ultraSplitter1:Dock = System.Windows.Forms.DockStyle:Bottom.
        THIS-OBJECT:ultraSplitter1:Location = NEW System.Drawing.Point(0, 217).
        THIS-OBJECT:ultraSplitter1:Name = "ultraSplitter1".
        THIS-OBJECT:ultraSplitter1:RestoreExtent = 0.
        THIS-OBJECT:ultraSplitter1:Size = NEW System.Drawing.Size(673, 6).
        THIS-OBJECT:ultraSplitter1:TabIndex = 1.
        /*  */
        /* ultraGrid1 */
        /*  */
        THIS-OBJECT:ultraGrid1:DataSource = THIS-OBJECT:bindingSource1.
        appearance25:BackColor = System.Drawing.SystemColors:Window.
        appearance25:BorderColor = System.Drawing.SystemColors:InactiveCaption.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Appearance = appearance25.
        THIS-OBJECT:ultraGrid1:DisplayLayout:AutoFitStyle = Infragistics.Win.UltraWinGrid.AutoFitStyle:ExtendLastColumn.
        ultraGridColumn1:Header:VisiblePosition = 0.
        ultraGridColumn2:Header:VisiblePosition = 1.
        ultraGridColumn3:Header:VisiblePosition = 2.
        ultraGridColumn4:Header:VisiblePosition = 3.
        ultraGridColumn5:Header:VisiblePosition = 4.
        ultraGridColumn6:Header:VisiblePosition = 5.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar14 AS System.Object EXTENT 6 NO-UNDO.
        arrayvar14[1] = ultraGridColumn1.
        arrayvar14[2] = ultraGridColumn2.
        arrayvar14[3] = ultraGridColumn3.
        arrayvar14[4] = ultraGridColumn4.
        arrayvar14[5] = ultraGridColumn5.
        arrayvar14[6] = ultraGridColumn6.
        ultraGridBand3:Columns:AddRange(arrayvar14).
        THIS-OBJECT:ultraGrid1:DisplayLayout:BandsSerializer:Add(ultraGridBand3).
        THIS-OBJECT:ultraGrid1:DisplayLayout:BorderStyle = Infragistics.Win.UIElementBorderStyle:Solid.
        THIS-OBJECT:ultraGrid1:DisplayLayout:CaptionVisible = Infragistics.Win.DefaultableBoolean:False.
        appearance26:BackColor = System.Drawing.SystemColors:ActiveBorder.
        appearance26:BackColor2 = System.Drawing.SystemColors:ControlDark.
        appearance26:BackGradientStyle = Infragistics.Win.GradientStyle:Vertical.
        appearance26:BorderColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ultraGrid1:DisplayLayout:GroupByBox:Appearance = appearance26.
        appearance27:ForeColor = System.Drawing.SystemColors:GrayText.
        THIS-OBJECT:ultraGrid1:DisplayLayout:GroupByBox:BandLabelAppearance = appearance27.
        THIS-OBJECT:ultraGrid1:DisplayLayout:GroupByBox:BorderStyle = Infragistics.Win.UIElementBorderStyle:Solid.
        appearance28:BackColor = System.Drawing.SystemColors:ControlLightLight.
        appearance28:BackColor2 = System.Drawing.SystemColors:Control.
        appearance28:BackGradientStyle = Infragistics.Win.GradientStyle:Horizontal.
        appearance28:ForeColor = System.Drawing.SystemColors:GrayText.
        THIS-OBJECT:ultraGrid1:DisplayLayout:GroupByBox:PromptAppearance = appearance28.
        THIS-OBJECT:ultraGrid1:DisplayLayout:MaxColScrollRegions = 1.
        THIS-OBJECT:ultraGrid1:DisplayLayout:MaxRowScrollRegions = 1.
        appearance29:BackColor = System.Drawing.SystemColors:Window.
        appearance29:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:ActiveCellAppearance = appearance29.
        appearance30:BackColor = System.Drawing.SystemColors:Highlight.
        appearance30:ForeColor = System.Drawing.SystemColors:HighlightText.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:ActiveRowAppearance = appearance30.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:AllowAddNew = Infragistics.Win.UltraWinGrid.AllowAddNew:No.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:AllowDelete = Infragistics.Win.DefaultableBoolean:False.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:AllowGroupBy = Infragistics.Win.DefaultableBoolean:True.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:AllowUpdate = Infragistics.Win.DefaultableBoolean:False.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:BorderStyleCell = Infragistics.Win.UIElementBorderStyle:Dotted.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:BorderStyleRow = Infragistics.Win.UIElementBorderStyle:Dotted.
        appearance31:BackColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:CardAreaAppearance = appearance31.
        appearance32:BorderColor = System.Drawing.Color:Silver.
        appearance32:TextTrimming = Infragistics.Win.TextTrimming:EllipsisCharacter.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:CellAppearance = appearance32.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction:RowSelect.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:CellPadding = 0.
        appearance33:BackColor = System.Drawing.SystemColors:Control.
        appearance33:BackColor2 = System.Drawing.SystemColors:ControlDark.
        appearance33:BackGradientAlignment = Infragistics.Win.GradientAlignment:Element.
        appearance33:BackGradientStyle = Infragistics.Win.GradientStyle:Horizontal.
        appearance33:BorderColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:GroupByRowAppearance = appearance33.
        appearance34:TextHAlignAsString = "Left".
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:HeaderAppearance = appearance34.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction:SortMulti.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:HeaderStyle = Infragistics.Win.HeaderStyle:WindowsXPCommand.
        appearance35:BackColor = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(224)), System.Convert:ToInt32(System.Convert:ToByte(224)), System.Convert:ToInt32(System.Convert:ToByte(224))).
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:RowAlternateAppearance = appearance35.
        appearance36:BackColor = System.Drawing.SystemColors:Window.
        appearance36:BorderColor = System.Drawing.Color:Silver.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:RowAppearance = appearance36.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:RowSelectors = Infragistics.Win.DefaultableBoolean:False.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:SelectTypeCell = Infragistics.Win.UltraWinGrid.SelectType:None.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:SelectTypeCol = Infragistics.Win.UltraWinGrid.SelectType:None.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:SelectTypeGroupByRow = Infragistics.Win.UltraWinGrid.SelectType:None.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:SelectTypeRow = Infragistics.Win.UltraWinGrid.SelectType:Extended.
        appearance37:BackColor = System.Drawing.SystemColors:ControlLight.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:TemplateAddRowAppearance = appearance37.
        THIS-OBJECT:ultraGrid1:DisplayLayout:ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds:ScrollToFill.
        THIS-OBJECT:ultraGrid1:DisplayLayout:ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle:Immediate.
        THIS-OBJECT:ultraGrid1:DisplayLayout:TabNavigation = Infragistics.Win.UltraWinGrid.TabNavigation:NextControlOnLastCell.
        THIS-OBJECT:ultraGrid1:DisplayLayout:ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand:OutlookGroupBy.
        THIS-OBJECT:ultraGrid1:Dock = System.Windows.Forms.DockStyle:Fill.
        THIS-OBJECT:ultraGrid1:Font = NEW System.Drawing.Font("Microsoft Sans Serif", Progress.Util.CastUtil:ToSingle(8.25), System.Drawing.FontStyle:Regular, System.Drawing.GraphicsUnit:Point, System.Convert:ToByte(0)).
        THIS-OBJECT:ultraGrid1:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:ultraGrid1:Name = "ultraGrid1".
        THIS-OBJECT:ultraGrid1:Size = NEW System.Drawing.Size(673, 223).
        THIS-OBJECT:ultraGrid1:TabIndex = 0.
        THIS-OBJECT:ultraGrid1:Text = "ultraGrid1".
        THIS-OBJECT:ultraGrid1:AfterRowActivate:Subscribe(THIS-OBJECT:ultraGrid1_AfterRowActivate).
        /*  */
        /* ultraTabControl1 */
        /*  */
        THIS-OBJECT:ultraTabControl1:Controls:Add(THIS-OBJECT:ultraTabSharedControlsPage1).
        THIS-OBJECT:ultraTabControl1:Controls:Add(THIS-OBJECT:ultraTabPageControl1).
        THIS-OBJECT:ultraTabControl1:Controls:Add(THIS-OBJECT:ultraTabPageControl2).
        THIS-OBJECT:ultraTabControl1:Dock = System.Windows.Forms.DockStyle:Bottom.
        THIS-OBJECT:ultraTabControl1:Location = NEW System.Drawing.Point(0, 223).
        THIS-OBJECT:ultraTabControl1:Name = "ultraTabControl1".
        THIS-OBJECT:ultraTabControl1:SharedControlsPage = THIS-OBJECT:ultraTabSharedControlsPage1.
        THIS-OBJECT:ultraTabControl1:Size = NEW System.Drawing.Size(673, 158).
        THIS-OBJECT:ultraTabControl1:TabIndex = 2.
        ultraTab1:Key = "Customer".
        ultraTab1:TabPage = THIS-OBJECT:ultraTabPageControl1.
        ultraTab1:Text = "Customer".
        ultraTab2:Key = "Project".
        ultraTab2:TabPage = THIS-OBJECT:ultraTabPageControl2.
        ultraTab2:Text = "Project".
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar15 AS Infragistics.Win.UltraWinTabControl.UltraTab EXTENT 2 NO-UNDO.
        arrayvar15[1] = ultraTab1.
        arrayvar15[2] = ultraTab2.
        THIS-OBJECT:ultraTabControl1:Tabs:AddRange(arrayvar15).
        /*  */
        /* ultraTabSharedControlsPage1 */
        /*  */
        THIS-OBJECT:ultraTabSharedControlsPage1:Location = NEW System.Drawing.Point(-10000, -10000).
        THIS-OBJECT:ultraTabSharedControlsPage1:Name = "ultraTabSharedControlsPage1".
        THIS-OBJECT:ultraTabSharedControlsPage1:Size = NEW System.Drawing.Size(669, 132).
        /*  */
        /* m_custMaintForm_Toolbars_Dock_Area_Left */
        /*  */
        THIS-OBJECT:m_custMaintForm_Toolbars_Dock_Area_Left:AccessibleRole = System.Windows.Forms.AccessibleRole:Grouping.
        THIS-OBJECT:m_custMaintForm_Toolbars_Dock_Area_Left:BackColor = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(191)), System.Convert:ToInt32(System.Convert:ToByte(219)), System.Convert:ToInt32(System.Convert:ToByte(255))).
        THIS-OBJECT:m_custMaintForm_Toolbars_Dock_Area_Left:DockedPosition = Infragistics.Win.UltraWinToolbars.DockedPosition:Left.
        THIS-OBJECT:m_custMaintForm_Toolbars_Dock_Area_Left:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:m_custMaintForm_Toolbars_Dock_Area_Left:InitialResizeAreaExtent = 4.
        THIS-OBJECT:m_custMaintForm_Toolbars_Dock_Area_Left:Location = NEW System.Drawing.Point(0, 148).
        THIS-OBJECT:m_custMaintForm_Toolbars_Dock_Area_Left:Name = "m_custMaintForm_Toolbars_Dock_Area_Left".
        THIS-OBJECT:m_custMaintForm_Toolbars_Dock_Area_Left:Size = NEW System.Drawing.Size(4, 381).
        THIS-OBJECT:m_custMaintForm_Toolbars_Dock_Area_Left:ToolbarsManager = THIS-OBJECT:ultraToolbarsManager1.
        /*  */
        /* m_custMaintForm_Toolbars_Dock_Area_Right */
        /*  */
        THIS-OBJECT:m_custMaintForm_Toolbars_Dock_Area_Right:AccessibleRole = System.Windows.Forms.AccessibleRole:Grouping.
        THIS-OBJECT:m_custMaintForm_Toolbars_Dock_Area_Right:BackColor = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(191)), System.Convert:ToInt32(System.Convert:ToByte(219)), System.Convert:ToInt32(System.Convert:ToByte(255))).
        THIS-OBJECT:m_custMaintForm_Toolbars_Dock_Area_Right:DockedPosition = Infragistics.Win.UltraWinToolbars.DockedPosition:Right.
        THIS-OBJECT:m_custMaintForm_Toolbars_Dock_Area_Right:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:m_custMaintForm_Toolbars_Dock_Area_Right:InitialResizeAreaExtent = 4.
        THIS-OBJECT:m_custMaintForm_Toolbars_Dock_Area_Right:Location = NEW System.Drawing.Point(677, 148).
        THIS-OBJECT:m_custMaintForm_Toolbars_Dock_Area_Right:Name = "m_custMaintForm_Toolbars_Dock_Area_Right".
        THIS-OBJECT:m_custMaintForm_Toolbars_Dock_Area_Right:Size = NEW System.Drawing.Size(4, 381).
        THIS-OBJECT:m_custMaintForm_Toolbars_Dock_Area_Right:ToolbarsManager = THIS-OBJECT:ultraToolbarsManager1.
        /*  */
        /* m_custMaintForm_Toolbars_Dock_Area_Top */
        /*  */
        THIS-OBJECT:m_custMaintForm_Toolbars_Dock_Area_Top:AccessibleRole = System.Windows.Forms.AccessibleRole:Grouping.
        THIS-OBJECT:m_custMaintForm_Toolbars_Dock_Area_Top:BackColor = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(191)), System.Convert:ToInt32(System.Convert:ToByte(219)), System.Convert:ToInt32(System.Convert:ToByte(255))).
        THIS-OBJECT:m_custMaintForm_Toolbars_Dock_Area_Top:DockedPosition = Infragistics.Win.UltraWinToolbars.DockedPosition:Top.
        THIS-OBJECT:m_custMaintForm_Toolbars_Dock_Area_Top:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:m_custMaintForm_Toolbars_Dock_Area_Top:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:m_custMaintForm_Toolbars_Dock_Area_Top:Name = "m_custMaintForm_Toolbars_Dock_Area_Top".
        THIS-OBJECT:m_custMaintForm_Toolbars_Dock_Area_Top:Size = NEW System.Drawing.Size(681, 148).
        THIS-OBJECT:m_custMaintForm_Toolbars_Dock_Area_Top:ToolbarsManager = THIS-OBJECT:ultraToolbarsManager1.
        /*  */
        /* m_custMaintForm_Toolbars_Dock_Area_Bottom */
        /*  */
        THIS-OBJECT:m_custMaintForm_Toolbars_Dock_Area_Bottom:AccessibleRole = System.Windows.Forms.AccessibleRole:Grouping.
        THIS-OBJECT:m_custMaintForm_Toolbars_Dock_Area_Bottom:BackColor = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(191)), System.Convert:ToInt32(System.Convert:ToByte(219)), System.Convert:ToInt32(System.Convert:ToByte(255))).
        THIS-OBJECT:m_custMaintForm_Toolbars_Dock_Area_Bottom:DockedPosition = Infragistics.Win.UltraWinToolbars.DockedPosition:Bottom.
        THIS-OBJECT:m_custMaintForm_Toolbars_Dock_Area_Bottom:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:m_custMaintForm_Toolbars_Dock_Area_Bottom:InitialResizeAreaExtent = 4.
        THIS-OBJECT:m_custMaintForm_Toolbars_Dock_Area_Bottom:Location = NEW System.Drawing.Point(0, 529).
        THIS-OBJECT:m_custMaintForm_Toolbars_Dock_Area_Bottom:Name = "m_custMaintForm_Toolbars_Dock_Area_Bottom".
        THIS-OBJECT:m_custMaintForm_Toolbars_Dock_Area_Bottom:Size = NEW System.Drawing.Size(681, 4).
        THIS-OBJECT:m_custMaintForm_Toolbars_Dock_Area_Bottom:ToolbarsManager = THIS-OBJECT:ultraToolbarsManager1.
        /*  */
        /* custMaintForm */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(681, 533).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:custMaintForm_Fill_Panel).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:m_custMaintForm_Toolbars_Dock_Area_Left).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:m_custMaintForm_Toolbars_Dock_Area_Right).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:m_custMaintForm_Toolbars_Dock_Area_Bottom).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:m_custMaintForm_Toolbars_Dock_Area_Top).
        THIS-OBJECT:Name = "custMaintForm".
        THIS-OBJECT:Text = "custMaintForm".
        THIS-OBJECT:ultraTabPageControl1:ResumeLayout(FALSE).
        THIS-OBJECT:ultraTabPageControl1:PerformLayout().
        CAST(THIS-OBJECT:fiDate, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:bindingSource1, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:fiPhoneNumber, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:cbCountry, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:bindingSource2, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:fiAddress, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:fiCustomerId, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:fiCustomerName, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:ultraTabPageControl2:ResumeLayout(FALSE).
        CAST(THIS-OBJECT:ultraGrid2, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:bindingSource3, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:ultraToolbarsManager1, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:custMaintForm_Fill_Panel:ClientArea:ResumeLayout(FALSE).
        THIS-OBJECT:custMaintForm_Fill_Panel:ResumeLayout(FALSE).
        CAST(THIS-OBJECT:ultraGrid1, System.ComponentModel.ISupportInitialize):EndInit().
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
	METHOD PUBLIC VOID enableTools(INPUT ipcAction AS CHARACTER):
        
        CASE ipcAction:
            WHEN "New" OR WHEN "Update"
            THEN DO:
                THIS-OBJECT:ultraToolbarsManager1:Tools:Item["New"]:SharedPropsInternal:Enabled = FALSE.
                THIS-OBJECT:ultraToolbarsManager1:Tools:Item["Update"]:SharedPropsInternal:Enabled = FALSE.
                THIS-OBJECT:ultraToolbarsManager1:Tools:Item["Delete"]:SharedPropsInternal:Enabled = FALSE.
                THIS-OBJECT:ultraToolbarsManager1:Tools:Item["Save"]:SharedPropsInternal:Enabled = TRUE.
                THIS-OBJECT:ultraToolbarsManager1:Tools:Item["Cancel"]:SharedPropsInternal:Enabled = TRUE.   
                THIS-OBJECT:ultraToolbarsManager1:Tools:Item["Filter"]:SharedPropsInternal:Enabled = FALSE.
                THIS-OBJECT:ultraToolbarsManager1:Tools:Item["Search"]:SharedPropsInternal:Enabled = FALSE.
                THIS-OBJECT:ultraTabPageControl1:enabled = TRUE. 
                THIS-OBJECT:ultraGrid1:enabled = FALSE. 
                ultraTabControl1:SelectedTab = ultraTabControl1:Tabs["Customer"].       
            END. 
            WHEN "Save" OR WHEN "Cancel" OR WHEN "Init"
            THEN DO:
                THIS-OBJECT:ultraToolbarsManager1:Tools:Item["New"]:SharedPropsInternal:Enabled = TRUE.
                THIS-OBJECT:ultraToolbarsManager1:Tools:Item["Update"]:SharedPropsInternal:Enabled = TRUE.
                THIS-OBJECT:ultraToolbarsManager1:Tools:Item["Delete"]:SharedPropsInternal:Enabled = TRUE.
                THIS-OBJECT:ultraToolbarsManager1:Tools:Item["Save"]:SharedPropsInternal:Enabled = FALSE.
                THIS-OBJECT:ultraToolbarsManager1:Tools:Item["Cancel"]:SharedPropsInternal:Enabled = FALSE.   
                THIS-OBJECT:ultraToolbarsManager1:Tools:Item["Filter"]:SharedPropsInternal:Enabled = TRUE.
                THIS-OBJECT:ultraToolbarsManager1:Tools:Item["Search"]:SharedPropsInternal:Enabled = TRUE.
                THIS-OBJECT:ultraTabPageControl1:enabled = FALSE.
                THIS-OBJECT:ultraGrid1:enabled = TRUE.
                ultraTabControl1:SelectedTab = ultraTabControl1:Tabs["Project"].
            END.    
        END CASE.
        RETURN.

    END METHOD.
	

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID ultraGrid1_AfterRowActivate( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		
		            /* set filter (only if we need to use the fields as a filter*/
        objProject:setFilter(INPUT "customer_id",                   
                              INPUT "=",                     
                              INPUT STRING(objCustomer:activeCustomerId)).
                                                                    
        objProject:getProject().

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
	METHOD PRIVATE VOID ultraToolbarsManager1_ToolClick( INPUT sender AS System.Object, INPUT e AS Infragistics.Win.UltraWinToolbars.ToolClickEventArgs ):
		
		/*Action code */
		CASE e:Tool:Key:		
		
		WHEN "New"
		THEN DO:
/*		    objCustomer:enableEdit().*/
		    bindingSource1:AddNew(). /* addnew is a method in the binding source properties */
		    objCustomer:createRow().
		     END.
		     
		WHEN "Update"
        THEN DO:
             objCustomer:enableEdit().
             END.
             
        WHEN "Delete"
        THEN DO:
/*             objCustomer:enableEdit().*/  /* dont need this as its in the customermodel now */
               DEFINE VARIABLE lChoice AS LOGICAL NO-UNDO.
               MESSAGE SUBSTITUTE ("Are you sure you want to delete &1",QUOTER(fiCustomerName:TEXT)) /* fiCustomerName is an object and TEXT is one of the objects properties */
               VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO SET lChoice.
               IF lChoice
               THEN DO:
               objCustomer:deleteRow().
               THIS-OBJECT:ultraGrid1:selected:rows:clear(). /* clears the selected row once done (to stop having 2) */             
             END.
             END.
        WHEN "Save"
        THEN DO:
             fiCustomerName:DataBindings["Text"]:WriteValue(). /* takes the field name, looks at the databinding property(set as text this time) and forces it to write the value before leaving */
             fiAddress:DataBindings["Text"]:WriteValue(). /* takes the field name, looks at the databinding property(set as text this time) and forces it to write the value before leaving */
             cbCountry:DataBindings["Value"]:WriteValue(). /* takes the field name, looks at the databinding property(set as text this time) and forces it to write the value before leaving */
             fiPhoneNumber:DataBindings["Text"]:WriteValue().
             fiDate:DataBindings["Value"]:WriteValue().
             bindingSource1:ASSIGN (). /* pushes the data to the ds */
/*             objCustomer:disableEdit(). /* turns tracking changes off  but this is done in the save method in the customer model*/*/
             objCustomer:saveCustomer(). /* runs save customer which assigns the dataset to the db */
             THIS-OBJECT:ultraGrid1:selected:rows:clear(). /* clears the selected row once done (to stop having 2) */
             END.
             
        WHEN "Cancel"
        THEN DO:
/*             objCustomer:disableEdit().*/  /* this is done in the customermodel now */
               objCustomer:CancelEdit().
               THIS-OBJECT:ultraGrid1:selected:rows:clear(). /* clears the selected row once done (to stop having 2) */
             END.
             
        WHEN "Search"
        THEN DO:
/*             MESSAGE STRING(CAST(ultraToolbarsManager1:Tools:Item["Filter"],TextBoxTool):text)*/
/*             VIEW-AS ALERT-BOX.                                                               */
             objCustomer:setFilter(INPUT "customer_name",
                                   INPUT "BEGINS",
                                   INPUT STRING(CAST(ultraToolbarsManager1:Tools:Item["Filter"],TextBoxTool):text)).
                                   
             objCustomer:getCustomer().                      
             END.                                                                                    
		    
		END CASE.
		
		/* sync widget code */
		enableTools(INPUT e:Tool:Key).
		
		/* set active control code */
		IF e:Tool:key = "New" OR
		   e:Tool:key = "Update"
		THEN
		  THIS-OBJECT:ActiveControl = fiCustomerName. /* puts the cursor into the customer name field */
		
/*		MESSAGE e:Tool:key*/
/*		VIEW-AS ALERT-BOX.*/
		
		RETURN.

	END METHOD.

	DESTRUCTOR PUBLIC custMaintForm ( ):
 
	END DESTRUCTOR.

END CLASS.