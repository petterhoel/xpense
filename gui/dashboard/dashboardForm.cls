 
 /*------------------------------------------------------------------------
    File        : dashboardForm
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : Administrator
    Created     : Tue Feb 02 10:54:15 UTC 2016
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS gui.dashboard.dashboardForm INHERITS Form: 
	
    DEFINE PRIVATE VARIABLE bsChart AS Progress.Data.BindingSource NO-UNDO.
    DEFINE PRIVATE VARIABLE bsProject AS Progress.Data.BindingSource NO-UNDO.
    DEFINE PRIVATE VARIABLE bsCustomer AS Progress.Data.BindingSource NO-UNDO.
    DEFINE PRIVATE VARIABLE bsCountry AS Progress.Data.BindingSource NO-UNDO.
    DEFINE PRIVATE VARIABLE btnFilterProject AS Infragistics.Win.Misc.UltraButton NO-UNDO.
    DEFINE PRIVATE VARIABLE btnFilterTop AS Infragistics.Win.Misc.UltraButton NO-UNDO.
    DEFINE PRIVATE VARIABLE btnGraph AS Infragistics.Win.Misc.UltraButton NO-UNDO.
    DEFINE PRIVATE VARIABLE cbFilterBy AS System.Windows.Forms.ComboBox NO-UNDO.
    DEFINE PRIVATE VARIABLE cbGraphyBy AS System.Windows.Forms.ComboBox NO-UNDO.
	DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE txtFilterProject AS Infragistics.Win.UltraWinEditors.UltraTextEditor NO-UNDO.
    DEFINE PRIVATE VARIABLE txtFilterTop AS Infragistics.Win.UltraWinEditors.UltraTextEditor NO-UNDO.
    DEFINE PRIVATE VARIABLE ucProject AS Infragistics.Win.UltraWinChart.UltraChart NO-UNDO.
    DEFINE PRIVATE VARIABLE ugCompanyCustomer AS Infragistics.Win.UltraWinGrid.UltraGrid NO-UNDO.
    DEFINE PRIVATE VARIABLE ugProject AS Infragistics.Win.UltraWinGrid.UltraGrid NO-UNDO.

    /* Variables */
    DEFINE VARIABLE objDashboardCustomerModel AS gui.dashboard.dashboardCustomerModel NO-UNDO.
    DEFINE VARIABLE objDashboardCountryModel AS gui.dashboard.dashboardCountryModel NO-UNDO.
	DEFINE VARIABLE objDashboardProjectModel AS gui.dashboard.dashboardProjectModel NO-UNDO.
	DEFINE VARIABLE objDashboardProjectChartModel AS gui.dashboard.dashboardProjectChartModel NO-UNDO.
		
	CONSTRUCTOR PUBLIC dashboardForm (  ):
		
        SUPER().
        InitializeComponent().
        
        objDashboardCustomerModel = NEW gui.dashboard.dashboardCustomerModel().
        objDashboardCountryModel = NEW gui.dashboard.dashboardCountryModel().
        objDashboardProjectModel = NEW gui.dashboard.dashboardProjectModel().
        objDashboardProjectChartModel = NEW gui.dashboard.dashboardProjectChartModel().
        
        bsCustomer:HANDLE = objDashboardCustomerModel:getDashboardCustomerHandle().
        bsCountry:HANDLE = objDashboardCountryModel:getDashboardCountryHandle().
        bsProject:HANDLE = objDashboardProjectModel:getDashboardProjectHandle().
        bsChart:HANDLE = objDashboardProjectChartModel:getDashboardProjectChartHandle().
                
        objDashboardCustomerModel:getDashboardCustomer(). 
        objDashboardCountryModel:getDashboardCountry().
                        
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
	METHOD PRIVATE VOID btnFilterProject_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		
	   DEFINE VARIABLE cFieldName AS CHARACTER INITIAL "customer_id" NO-UNDO.
       DEFINE VARIABLE iRowID AS INTEGER NO-UNDO.
        
       IF txtFilterProject:TEXT <> "" THEN
           objDashboardProjectModel:setFilter(INPUT "project_name", INPUT "begins", INPUT txtFilterProject:TEXT).
        
       IF cbFilterBy:SelectedIndex = 2 THEN
        DO:
           ASSIGN cFieldName = "country_id"
                  iRowID = objDashboardCountryModel:activeCountryId.
                  
           objDashboardProjectModel:addFilter(INPUT cFieldName, INPUT "EQ", INPUT STRING(iRowID)).
           objDashboardProjectModel:getDashboardProjectCountry().
           
        END.
       ELSE
        DO:
           ASSIGN cFieldName = "customer_id".
                  iRowID = objDashboardCustomerModel:activeCustomerId.
           
           objDashboardProjectModel:addFilter(INPUT cFieldName, INPUT "EQ", INPUT STRING(iRowID)).       
           objDashboardProjectModel:getDashboardProject().                             
        END.
        
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID btnFilterTop_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		
		CASE btnFilterTop:TEXT.
		  WHEN "Filter by Customer" THEN
		      DO:
		          IF txtFilterTop:TEXT <> "" THEN objDashboardCustomerModel:setFilter(INPUT "customer_name", INPUT "begins", INPUT txtFilterTop:Text).
		          
		          objDashboardCustomerModel:getDashboardCustomer().
	          END.
          WHEN "Filter by Country" THEN
              DO:
                  IF txtFilterTop:TEXT <> "" THEN objDashboardCountryModel:setFilter(INPUT "country_name", INPUT "begins", INPUT txtFilterTop:Text).
                  
                  objDashboardCountryModel:getDashboardCountry().
              END.
         END CASE.
         
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID btnGraph_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		
		ucProject:VISIBLE = (NOT ucProject:VISIBLE).
		
		IF ucProject:VISIBLE THEN
		  DO:
		      IF WIDTH <= 1065 THEN WIDTH = 1065.
		      btnGraph:TEXT = "Hide Graph".
		  END.
		ELSE
		  DO:
		      WIDTH = 726.
    		  btnGraph:TEXT = "Show Graph".
		  END.
        
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID cbFilterBy_SelectedIndexChanged( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		
        SetControlsAvailability().
        SetBindingSources().
        
        btnFilterTop:TEXT = "Filter by " + cbFilterBy:TEXT.

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID cbGraphyBy_SelectedIndexChanged( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		
		CASE cbGraphyBy:SelectedIndex.
		  WHEN 0 THEN
		      DO: 
		          ucProject:Data:DataSource = bsChart.		          		          
		      END.
		  WHEN 1 THEN
		      DO:
		         ucProject:Data:DataSource = bsProject.         
	          END.
          WHEN 2 THEN
              DO:
                  IF cbFilterBy:SelectedIndex = 1 THEN
                      ucProject:Data:Datasource = bsCustomer.
                  ELSE
                      ucProject:Data:Datasource = bsCountry.  
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
        DEFINE VARIABLE appearance1 AS Infragistics.Win.Appearance NO-UNDO.
        appearance1 = NEW Infragistics.Win.Appearance().
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
        DEFINE VARIABLE tableDesc1 AS Progress.Data.TableDesc NO-UNDO.
        tableDesc1 = NEW Progress.Data.TableDesc("ttProject").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE tableDesc2 AS Progress.Data.TableDesc NO-UNDO.
        tableDesc2 = NEW Progress.Data.TableDesc("ttCustomer").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE tableDesc3 AS Progress.Data.TableDesc NO-UNDO.
        tableDesc3 = NEW Progress.Data.TableDesc("ttCountry").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE paintElement1 AS Infragistics.UltraChart.Resources.Appearance.PaintElement NO-UNDO.
        paintElement1 = NEW Infragistics.UltraChart.Resources.Appearance.PaintElement().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE columnChartAppearance1 AS Infragistics.UltraChart.Resources.Appearance.ColumnChartAppearance NO-UNDO.
        columnChartAppearance1 = NEW Infragistics.UltraChart.Resources.Appearance.ColumnChartAppearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE chartTextAppearance1 AS Infragistics.UltraChart.Resources.Appearance.ChartTextAppearance NO-UNDO.
        chartTextAppearance1 = NEW Infragistics.UltraChart.Resources.Appearance.ChartTextAppearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE gradientEffect1 AS Infragistics.UltraChart.Resources.Appearance.GradientEffect NO-UNDO.
        gradientEffect1 = NEW Infragistics.UltraChart.Resources.Appearance.GradientEffect().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE tableDesc4 AS Progress.Data.TableDesc NO-UNDO.
        tableDesc4 = NEW Progress.Data.TableDesc("ttProject").
        THIS-OBJECT:txtFilterTop = NEW Infragistics.Win.UltraWinEditors.UltraTextEditor().
        THIS-OBJECT:btnFilterTop = NEW Infragistics.Win.Misc.UltraButton().
        THIS-OBJECT:ugCompanyCustomer = NEW Infragistics.Win.UltraWinGrid.UltraGrid().
        THIS-OBJECT:ugProject = NEW Infragistics.Win.UltraWinGrid.UltraGrid().
        THIS-OBJECT:bsProject = NEW Progress.Data.BindingSource(THIS-OBJECT:components).
        THIS-OBJECT:btnFilterProject = NEW Infragistics.Win.Misc.UltraButton().
        THIS-OBJECT:txtFilterProject = NEW Infragistics.Win.UltraWinEditors.UltraTextEditor().
        THIS-OBJECT:bsCustomer = NEW Progress.Data.BindingSource(THIS-OBJECT:components).
        THIS-OBJECT:cbFilterBy = NEW System.Windows.Forms.ComboBox().
        THIS-OBJECT:bsCountry = NEW Progress.Data.BindingSource(THIS-OBJECT:components).
        THIS-OBJECT:ucProject = NEW Infragistics.Win.UltraWinChart.UltraChart().
        THIS-OBJECT:bsChart = NEW Progress.Data.BindingSource(THIS-OBJECT:components).
        THIS-OBJECT:btnGraph = NEW Infragistics.Win.Misc.UltraButton().
        THIS-OBJECT:cbGraphyBy = NEW System.Windows.Forms.ComboBox().
        CAST(THIS-OBJECT:txtFilterTop, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:ugCompanyCustomer, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:ugProject, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:bsProject, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:txtFilterProject, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:bsCustomer, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:bsCountry, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:ucProject, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:bsChart, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* txtFilterTop */
        /*  */
        THIS-OBJECT:txtFilterTop:Enabled = FALSE.
        THIS-OBJECT:txtFilterTop:Location = NEW System.Drawing.Point(239, 12).
        THIS-OBJECT:txtFilterTop:Name = "txtFilterTop".
        THIS-OBJECT:txtFilterTop:Size = NEW System.Drawing.Size(241, 21).
        THIS-OBJECT:txtFilterTop:TabIndex = 1.
        /*  */
        /* btnFilterTop */
        /*  */
        THIS-OBJECT:btnFilterTop:Enabled = FALSE.
        THIS-OBJECT:btnFilterTop:Location = NEW System.Drawing.Point(486, 11).
        THIS-OBJECT:btnFilterTop:Name = "btnFilterTop".
        THIS-OBJECT:btnFilterTop:Size = NEW System.Drawing.Size(121, 23).
        THIS-OBJECT:btnFilterTop:TabIndex = 2.
        THIS-OBJECT:btnFilterTop:Text = "Filter by".
        THIS-OBJECT:btnFilterTop:Click:Subscribe(THIS-OBJECT:btnFilterTop_Click).
        /*  */
        /* ugCompanyCustomer */
        /*  */
        appearance1:BackColor = System.Drawing.SystemColors:Window.
        appearance1:BorderColor = System.Drawing.SystemColors:InactiveCaption.
        THIS-OBJECT:ugCompanyCustomer:DisplayLayout:Appearance = appearance1.
        THIS-OBJECT:ugCompanyCustomer:DisplayLayout:AutoFitStyle = Infragistics.Win.UltraWinGrid.AutoFitStyle:ExtendLastColumn.
        THIS-OBJECT:ugCompanyCustomer:DisplayLayout:BorderStyle = Infragistics.Win.UIElementBorderStyle:Solid.
        THIS-OBJECT:ugCompanyCustomer:DisplayLayout:CaptionVisible = Infragistics.Win.DefaultableBoolean:False.
        appearance2:BackColor = System.Drawing.SystemColors:ActiveBorder.
        appearance2:BackColor2 = System.Drawing.SystemColors:ControlDark.
        appearance2:BackGradientStyle = Infragistics.Win.GradientStyle:Vertical.
        appearance2:BorderColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ugCompanyCustomer:DisplayLayout:GroupByBox:Appearance = appearance2.
        appearance3:ForeColor = System.Drawing.SystemColors:GrayText.
        THIS-OBJECT:ugCompanyCustomer:DisplayLayout:GroupByBox:BandLabelAppearance = appearance3.
        THIS-OBJECT:ugCompanyCustomer:DisplayLayout:GroupByBox:BorderStyle = Infragistics.Win.UIElementBorderStyle:Solid.
        appearance4:BackColor = System.Drawing.SystemColors:ControlLightLight.
        appearance4:BackColor2 = System.Drawing.SystemColors:Control.
        appearance4:BackGradientStyle = Infragistics.Win.GradientStyle:Horizontal.
        appearance4:ForeColor = System.Drawing.SystemColors:GrayText.
        THIS-OBJECT:ugCompanyCustomer:DisplayLayout:GroupByBox:PromptAppearance = appearance4.
        THIS-OBJECT:ugCompanyCustomer:DisplayLayout:MaxColScrollRegions = 1.
        THIS-OBJECT:ugCompanyCustomer:DisplayLayout:MaxRowScrollRegions = 1.
        appearance5:BackColor = System.Drawing.SystemColors:Window.
        appearance5:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:ugCompanyCustomer:DisplayLayout:Override:ActiveCellAppearance = appearance5.
        appearance6:BackColor = System.Drawing.SystemColors:Highlight.
        appearance6:ForeColor = System.Drawing.SystemColors:HighlightText.
        THIS-OBJECT:ugCompanyCustomer:DisplayLayout:Override:ActiveRowAppearance = appearance6.
        THIS-OBJECT:ugCompanyCustomer:DisplayLayout:Override:AllowUpdate = Infragistics.Win.DefaultableBoolean:False.
        THIS-OBJECT:ugCompanyCustomer:DisplayLayout:Override:BorderStyleCell = Infragistics.Win.UIElementBorderStyle:Dotted.
        THIS-OBJECT:ugCompanyCustomer:DisplayLayout:Override:BorderStyleRow = Infragistics.Win.UIElementBorderStyle:Dotted.
        appearance7:BackColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ugCompanyCustomer:DisplayLayout:Override:CardAreaAppearance = appearance7.
        appearance8:BorderColor = System.Drawing.Color:Silver.
        appearance8:TextTrimming = Infragistics.Win.TextTrimming:EllipsisCharacter.
        THIS-OBJECT:ugCompanyCustomer:DisplayLayout:Override:CellAppearance = appearance8.
        THIS-OBJECT:ugCompanyCustomer:DisplayLayout:Override:CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction:EditAndSelectText.
        THIS-OBJECT:ugCompanyCustomer:DisplayLayout:Override:CellPadding = 0.
        appearance9:BackColor = System.Drawing.SystemColors:Control.
        appearance9:BackColor2 = System.Drawing.SystemColors:ControlDark.
        appearance9:BackGradientAlignment = Infragistics.Win.GradientAlignment:Element.
        appearance9:BackGradientStyle = Infragistics.Win.GradientStyle:Horizontal.
        appearance9:BorderColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ugCompanyCustomer:DisplayLayout:Override:GroupByRowAppearance = appearance9.
        appearance10:TextHAlignAsString = "Left".
        THIS-OBJECT:ugCompanyCustomer:DisplayLayout:Override:HeaderAppearance = appearance10.
        THIS-OBJECT:ugCompanyCustomer:DisplayLayout:Override:HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction:SortMulti.
        THIS-OBJECT:ugCompanyCustomer:DisplayLayout:Override:HeaderStyle = Infragistics.Win.HeaderStyle:WindowsXPCommand.
        appearance11:BackColor = System.Drawing.SystemColors:Window.
        appearance11:BorderColor = System.Drawing.Color:Silver.
        THIS-OBJECT:ugCompanyCustomer:DisplayLayout:Override:RowAppearance = appearance11.
        THIS-OBJECT:ugCompanyCustomer:DisplayLayout:Override:RowSelectors = Infragistics.Win.DefaultableBoolean:False.
        THIS-OBJECT:ugCompanyCustomer:DisplayLayout:Override:SelectTypeRow = Infragistics.Win.UltraWinGrid.SelectType:None.
        appearance12:BackColor = System.Drawing.SystemColors:ControlLight.
        THIS-OBJECT:ugCompanyCustomer:DisplayLayout:Override:TemplateAddRowAppearance = appearance12.
        THIS-OBJECT:ugCompanyCustomer:DisplayLayout:ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds:ScrollToFill.
        THIS-OBJECT:ugCompanyCustomer:DisplayLayout:ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle:Immediate.
        THIS-OBJECT:ugCompanyCustomer:DisplayLayout:ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand:OutlookGroupBy.
        THIS-OBJECT:ugCompanyCustomer:Enabled = FALSE.
        THIS-OBJECT:ugCompanyCustomer:Location = NEW System.Drawing.Point(13, 51).
        THIS-OBJECT:ugCompanyCustomer:Name = "ugCompanyCustomer".
        THIS-OBJECT:ugCompanyCustomer:Size = NEW System.Drawing.Size(689, 229).
        THIS-OBJECT:ugCompanyCustomer:TabIndex = 3.
        THIS-OBJECT:ugCompanyCustomer:Text = "ultraGrid1".
        THIS-OBJECT:ugCompanyCustomer:AfterRowActivate:Subscribe(THIS-OBJECT:ugCompanyCustomer_AfterRowActivate).
        /*  */
        /* ugProject */
        /*  */
        DEFINE VARIABLE nestedvar0 AS System.Windows.Forms.AnchorStyles NO-UNDO.
        nestedvar0 = CAST(Progress.Util.EnumHelper:Or(System.Windows.Forms.AnchorStyles:Top, System.Windows.Forms.AnchorStyles:Bottom), System.Windows.Forms.AnchorStyles).
        THIS-OBJECT:ugProject:Anchor = CAST(Progress.Util.EnumHelper:Or(nestedvar0, System.Windows.Forms.AnchorStyles:Left), System.Windows.Forms.AnchorStyles).
        appearance13:BackColor = System.Drawing.SystemColors:Window.
        appearance13:BorderColor = System.Drawing.SystemColors:InactiveCaption.
        THIS-OBJECT:ugProject:DisplayLayout:Appearance = appearance13.
        THIS-OBJECT:ugProject:DisplayLayout:BorderStyle = Infragistics.Win.UIElementBorderStyle:Solid.
        THIS-OBJECT:ugProject:DisplayLayout:CaptionVisible = Infragistics.Win.DefaultableBoolean:False.
        appearance14:BackColor = System.Drawing.SystemColors:ActiveBorder.
        appearance14:BackColor2 = System.Drawing.SystemColors:ControlDark.
        appearance14:BackGradientStyle = Infragistics.Win.GradientStyle:Vertical.
        appearance14:BorderColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ugProject:DisplayLayout:GroupByBox:Appearance = appearance14.
        appearance15:ForeColor = System.Drawing.SystemColors:GrayText.
        THIS-OBJECT:ugProject:DisplayLayout:GroupByBox:BandLabelAppearance = appearance15.
        THIS-OBJECT:ugProject:DisplayLayout:GroupByBox:BorderStyle = Infragistics.Win.UIElementBorderStyle:Solid.
        appearance16:BackColor = System.Drawing.SystemColors:ControlLightLight.
        appearance16:BackColor2 = System.Drawing.SystemColors:Control.
        appearance16:BackGradientStyle = Infragistics.Win.GradientStyle:Horizontal.
        appearance16:ForeColor = System.Drawing.SystemColors:GrayText.
        THIS-OBJECT:ugProject:DisplayLayout:GroupByBox:PromptAppearance = appearance16.
        THIS-OBJECT:ugProject:DisplayLayout:MaxColScrollRegions = 1.
        THIS-OBJECT:ugProject:DisplayLayout:MaxRowScrollRegions = 1.
        appearance17:BackColor = System.Drawing.SystemColors:Window.
        appearance17:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:ugProject:DisplayLayout:Override:ActiveCellAppearance = appearance17.
        appearance18:BackColor = System.Drawing.SystemColors:Highlight.
        appearance18:ForeColor = System.Drawing.SystemColors:HighlightText.
        THIS-OBJECT:ugProject:DisplayLayout:Override:ActiveRowAppearance = appearance18.
        THIS-OBJECT:ugProject:DisplayLayout:Override:BorderStyleCell = Infragistics.Win.UIElementBorderStyle:Dotted.
        THIS-OBJECT:ugProject:DisplayLayout:Override:BorderStyleRow = Infragistics.Win.UIElementBorderStyle:Dotted.
        appearance19:BackColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ugProject:DisplayLayout:Override:CardAreaAppearance = appearance19.
        appearance20:BorderColor = System.Drawing.Color:Silver.
        appearance20:TextTrimming = Infragistics.Win.TextTrimming:EllipsisCharacter.
        THIS-OBJECT:ugProject:DisplayLayout:Override:CellAppearance = appearance20.
        THIS-OBJECT:ugProject:DisplayLayout:Override:CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction:EditAndSelectText.
        THIS-OBJECT:ugProject:DisplayLayout:Override:CellPadding = 0.
        appearance21:BackColor = System.Drawing.SystemColors:Control.
        appearance21:BackColor2 = System.Drawing.SystemColors:ControlDark.
        appearance21:BackGradientAlignment = Infragistics.Win.GradientAlignment:Element.
        appearance21:BackGradientStyle = Infragistics.Win.GradientStyle:Horizontal.
        appearance21:BorderColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:ugProject:DisplayLayout:Override:GroupByRowAppearance = appearance21.
        appearance22:TextHAlignAsString = "Left".
        THIS-OBJECT:ugProject:DisplayLayout:Override:HeaderAppearance = appearance22.
        THIS-OBJECT:ugProject:DisplayLayout:Override:HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction:SortMulti.
        THIS-OBJECT:ugProject:DisplayLayout:Override:HeaderStyle = Infragistics.Win.HeaderStyle:WindowsXPCommand.
        appearance23:BackColor = System.Drawing.SystemColors:Window.
        appearance23:BorderColor = System.Drawing.Color:Silver.
        THIS-OBJECT:ugProject:DisplayLayout:Override:RowAppearance = appearance23.
        THIS-OBJECT:ugProject:DisplayLayout:Override:RowSelectors = Infragistics.Win.DefaultableBoolean:False.
        appearance24:BackColor = System.Drawing.SystemColors:ControlLight.
        THIS-OBJECT:ugProject:DisplayLayout:Override:TemplateAddRowAppearance = appearance24.
        THIS-OBJECT:ugProject:DisplayLayout:ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds:ScrollToFill.
        THIS-OBJECT:ugProject:DisplayLayout:ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle:Immediate.
        THIS-OBJECT:ugProject:DisplayLayout:ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand:OutlookGroupBy.
        THIS-OBJECT:ugProject:Enabled = FALSE.
        THIS-OBJECT:ugProject:Location = NEW System.Drawing.Point(13, 337).
        THIS-OBJECT:ugProject:Name = "ugProject".
        THIS-OBJECT:ugProject:Size = NEW System.Drawing.Size(689, 229).
        THIS-OBJECT:ugProject:TabIndex = 6.
        THIS-OBJECT:ugProject:Text = "Project".
        THIS-OBJECT:ugProject:AfterRowActivate:Subscribe(THIS-OBJECT:ugProject_AfterRowActivate).
        /*  */
        /* bsProject */
        /*  */
        THIS-OBJECT:bsProject:MaxDataGuess = 0.
        THIS-OBJECT:bsProject:NoLOBs = FALSE.
        THIS-OBJECT:bsProject:Position = 0.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar0 AS "Progress.Data.TableDesc[]" NO-UNDO.
        arrayvar0 = NEW "Progress.Data.TableDesc[]"(0).
        tableDesc1:ChildTables = arrayvar0.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar1 AS Progress.Data.ColumnPropDesc EXTENT 5 NO-UNDO.
        arrayvar1[1] = NEW Progress.Data.ColumnPropDesc("project_id", "Project ID", Progress.Data.DataType:INTEGER).
        arrayvar1[2] = NEW Progress.Data.ColumnPropDesc("project_name", "Project Name", Progress.Data.DataType:CHARACTER).
        arrayvar1[3] = NEW Progress.Data.ColumnPropDesc("start_date", "Start Date", Progress.Data.DataType:DATE).
        arrayvar1[4] = NEW Progress.Data.ColumnPropDesc("due_date", "Due Date", Progress.Data.DataType:DATE).
        arrayvar1[5] = NEW Progress.Data.ColumnPropDesc("Profit_Loss", "Profit/Loss", Progress.Data.DataType:DECIMAL).
        tableDesc1:Columns = arrayvar1.
        THIS-OBJECT:bsProject:TableSchema = tableDesc1.
        /*  */
        /* btnFilterProject */
        /*  */
        THIS-OBJECT:btnFilterProject:Enabled = FALSE.
        THIS-OBJECT:btnFilterProject:Location = NEW System.Drawing.Point(259, 296).
        THIS-OBJECT:btnFilterProject:Name = "btnFilterProject".
        THIS-OBJECT:btnFilterProject:Size = NEW System.Drawing.Size(121, 23).
        THIS-OBJECT:btnFilterProject:TabIndex = 5.
        THIS-OBJECT:btnFilterProject:Text = "Filter by Project".
        THIS-OBJECT:btnFilterProject:Click:Subscribe(THIS-OBJECT:btnFilterProject_Click).
        /*  */
        /* txtFilterProject */
        /*  */
        THIS-OBJECT:txtFilterProject:Enabled = FALSE.
        THIS-OBJECT:txtFilterProject:Location = NEW System.Drawing.Point(12, 297).
        THIS-OBJECT:txtFilterProject:Name = "txtFilterProject".
        THIS-OBJECT:txtFilterProject:Size = NEW System.Drawing.Size(241, 21).
        THIS-OBJECT:txtFilterProject:TabIndex = 4.
        /*  */
        /* bsCustomer */
        /*  */
        THIS-OBJECT:bsCustomer:MaxDataGuess = 0.
        THIS-OBJECT:bsCustomer:NoLOBs = FALSE.
        THIS-OBJECT:bsCustomer:Position = 0.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar2 AS "Progress.Data.TableDesc[]" NO-UNDO.
        arrayvar2 = NEW "Progress.Data.TableDesc[]"(0).
        tableDesc2:ChildTables = arrayvar2.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar3 AS Progress.Data.ColumnPropDesc EXTENT 4 NO-UNDO.
        arrayvar3[1] = NEW Progress.Data.ColumnPropDesc("customer_id", "Customer ID", Progress.Data.DataType:INTEGER).
        arrayvar3[2] = NEW Progress.Data.ColumnPropDesc("customer_name", "Customer Name", Progress.Data.DataType:CHARACTER).
        arrayvar3[3] = NEW Progress.Data.ColumnPropDesc("country_name", "Country Name", Progress.Data.DataType:CHARACTER).
        arrayvar3[4] = NEW Progress.Data.ColumnPropDesc("Profit_Loss", "Profit/Loss", Progress.Data.DataType:DECIMAL).
        tableDesc2:Columns = arrayvar3.
        THIS-OBJECT:bsCustomer:TableSchema = tableDesc2.
        /*  */
        /* cbFilterBy */
        /*  */
        THIS-OBJECT:cbFilterBy:DropDownStyle = System.Windows.Forms.ComboBoxStyle:DropDownList.
        THIS-OBJECT:cbFilterBy:FormattingEnabled = TRUE.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar4 AS System.Object EXTENT 3 NO-UNDO.
        arrayvar4[1] = "".
        arrayvar4[2] = "Customer".
        arrayvar4[3] = "Country".
        THIS-OBJECT:cbFilterBy:Items:AddRange(arrayvar4).
        THIS-OBJECT:cbFilterBy:Location = NEW System.Drawing.Point(13, 12).
        THIS-OBJECT:cbFilterBy:Name = "cbFilterBy".
        THIS-OBJECT:cbFilterBy:Size = NEW System.Drawing.Size(208, 21).
        THIS-OBJECT:cbFilterBy:TabIndex = 7.
        THIS-OBJECT:cbFilterBy:SelectedIndexChanged:Subscribe(THIS-OBJECT:cbFilterBy_SelectedIndexChanged).
        /*  */
        /* bsCountry */
        /*  */
        THIS-OBJECT:bsCountry:MaxDataGuess = 0.
        THIS-OBJECT:bsCountry:NoLOBs = FALSE.
        THIS-OBJECT:bsCountry:Position = 0.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar5 AS "Progress.Data.TableDesc[]" NO-UNDO.
        arrayvar5 = NEW "Progress.Data.TableDesc[]"(0).
        tableDesc3:ChildTables = arrayvar5.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar6 AS Progress.Data.ColumnPropDesc EXTENT 3 NO-UNDO.
        arrayvar6[1] = NEW Progress.Data.ColumnPropDesc("country_id", "Country Id", Progress.Data.DataType:INTEGER).
        arrayvar6[2] = NEW Progress.Data.ColumnPropDesc("country_name", "Country Name", Progress.Data.DataType:CHARACTER).
        arrayvar6[3] = NEW Progress.Data.ColumnPropDesc("Profit_Loss", "Profit/Loss", Progress.Data.DataType:DECIMAL).
        tableDesc3:Columns = arrayvar6.
        THIS-OBJECT:bsCountry:TableSchema = tableDesc3.
        /*  */
        /* ucProject */
        /*  */
        DEFINE VARIABLE nestedvar1 AS System.Windows.Forms.AnchorStyles NO-UNDO.
        nestedvar1 = CAST(Progress.Util.EnumHelper:Or(CAST(Progress.Util.EnumHelper:Or(System.Windows.Forms.AnchorStyles:Top, System.Windows.Forms.AnchorStyles:Bottom), System.Windows.Forms.AnchorStyles), System.Windows.Forms.AnchorStyles:Left), System.Windows.Forms.AnchorStyles).
        THIS-OBJECT:ucProject:Anchor = CAST(Progress.Util.EnumHelper:Or(nestedvar1, System.Windows.Forms.AnchorStyles:Right), System.Windows.Forms.AnchorStyles).
        THIS-OBJECT:ucProject:Axis:BackColor = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(255)), System.Convert:ToInt32(System.Convert:ToByte(248)), System.Convert:ToInt32(System.Convert:ToByte(220))).
        paintElement1:ElementType = Infragistics.UltraChart.Shared.Styles.PaintElementType:None.
        paintElement1:Fill = System.Drawing.Color:FromArgb(System.Convert:ToInt32(System.Convert:ToByte(255)), System.Convert:ToInt32(System.Convert:ToByte(248)), System.Convert:ToInt32(System.Convert:ToByte(220))).
        THIS-OBJECT:ucProject:Axis:PE = paintElement1.
        THIS-OBJECT:ucProject:Axis:X:Labels:Font = NEW System.Drawing.Font("Verdana", Progress.Util.CastUtil:ToSingle(7)).
        THIS-OBJECT:ucProject:Axis:X:Labels:FontColor = System.Drawing.Color:DimGray.
        THIS-OBJECT:ucProject:Axis:X:Labels:HorizontalAlign = System.Drawing.StringAlignment:Near.
        THIS-OBJECT:ucProject:Axis:X:Labels:ItemFormatString = "".
        THIS-OBJECT:ucProject:Axis:X:Labels:Layout:Behavior = Infragistics.UltraChart.Shared.Styles.AxisLabelLayoutBehaviors:Auto.
        THIS-OBJECT:ucProject:Axis:X:Labels:Orientation = Infragistics.UltraChart.Shared.Styles.TextOrientation:VerticalLeftFacing.
        THIS-OBJECT:ucProject:Axis:X:Labels:SeriesLabels:Font = NEW System.Drawing.Font("Verdana", Progress.Util.CastUtil:ToSingle(7)).
        THIS-OBJECT:ucProject:Axis:X:Labels:SeriesLabels:FontColor = System.Drawing.Color:DimGray.
        THIS-OBJECT:ucProject:Axis:X:Labels:SeriesLabels:HorizontalAlign = System.Drawing.StringAlignment:Center.
        THIS-OBJECT:ucProject:Axis:X:Labels:SeriesLabels:Layout:Behavior = Infragistics.UltraChart.Shared.Styles.AxisLabelLayoutBehaviors:Auto.
        THIS-OBJECT:ucProject:Axis:X:Labels:SeriesLabels:Orientation = Infragistics.UltraChart.Shared.Styles.TextOrientation:Horizontal.
        THIS-OBJECT:ucProject:Axis:X:Labels:SeriesLabels:VerticalAlign = System.Drawing.StringAlignment:Center.
        THIS-OBJECT:ucProject:Axis:X:Labels:SeriesLabels:Visible = TRUE.
        THIS-OBJECT:ucProject:Axis:X:Labels:VerticalAlign = System.Drawing.StringAlignment:Center.
        THIS-OBJECT:ucProject:Axis:X:Labels:Visible = TRUE.
        THIS-OBJECT:ucProject:Axis:X:LineThickness = 1.
        THIS-OBJECT:ucProject:Axis:X:MajorGridLines:AlphaLevel = System.Convert:ToByte(255).
        THIS-OBJECT:ucProject:Axis:X:MajorGridLines:Color = System.Drawing.Color:Gainsboro.
        THIS-OBJECT:ucProject:Axis:X:MajorGridLines:DrawStyle = Infragistics.UltraChart.Shared.Styles.LineDrawStyle:Dot.
        THIS-OBJECT:ucProject:Axis:X:MajorGridLines:Visible = TRUE.
        THIS-OBJECT:ucProject:Axis:X:MinorGridLines:AlphaLevel = System.Convert:ToByte(255).
        THIS-OBJECT:ucProject:Axis:X:MinorGridLines:Color = System.Drawing.Color:LightGray.
        THIS-OBJECT:ucProject:Axis:X:MinorGridLines:DrawStyle = Infragistics.UltraChart.Shared.Styles.LineDrawStyle:Dot.
        THIS-OBJECT:ucProject:Axis:X:MinorGridLines:Visible = TRUE.
        THIS-OBJECT:ucProject:Axis:X:TickmarkStyle = Infragistics.UltraChart.Shared.Styles.AxisTickStyle:Smart.
        THIS-OBJECT:ucProject:Axis:X:Visible = TRUE.
        THIS-OBJECT:ucProject:Axis:X2:Labels:Font = NEW System.Drawing.Font("Verdana", Progress.Util.CastUtil:ToSingle(7)).
        THIS-OBJECT:ucProject:Axis:X2:Labels:FontColor = System.Drawing.Color:Gray.
        THIS-OBJECT:ucProject:Axis:X2:Labels:HorizontalAlign = System.Drawing.StringAlignment:Far.
        THIS-OBJECT:ucProject:Axis:X2:Labels:ItemFormatString = "<ITEM_LABEL>".
        THIS-OBJECT:ucProject:Axis:X2:Labels:Layout:Behavior = Infragistics.UltraChart.Shared.Styles.AxisLabelLayoutBehaviors:Auto.
        THIS-OBJECT:ucProject:Axis:X2:Labels:Orientation = Infragistics.UltraChart.Shared.Styles.TextOrientation:VerticalLeftFacing.
        THIS-OBJECT:ucProject:Axis:X2:Labels:SeriesLabels:Font = NEW System.Drawing.Font("Verdana", Progress.Util.CastUtil:ToSingle(7)).
        THIS-OBJECT:ucProject:Axis:X2:Labels:SeriesLabels:FontColor = System.Drawing.Color:Gray.
        THIS-OBJECT:ucProject:Axis:X2:Labels:SeriesLabels:HorizontalAlign = System.Drawing.StringAlignment:Center.
        THIS-OBJECT:ucProject:Axis:X2:Labels:SeriesLabels:Layout:Behavior = Infragistics.UltraChart.Shared.Styles.AxisLabelLayoutBehaviors:Auto.
        THIS-OBJECT:ucProject:Axis:X2:Labels:SeriesLabels:Orientation = Infragistics.UltraChart.Shared.Styles.TextOrientation:Horizontal.
        THIS-OBJECT:ucProject:Axis:X2:Labels:SeriesLabels:VerticalAlign = System.Drawing.StringAlignment:Center.
        THIS-OBJECT:ucProject:Axis:X2:Labels:SeriesLabels:Visible = TRUE.
        THIS-OBJECT:ucProject:Axis:X2:Labels:VerticalAlign = System.Drawing.StringAlignment:Center.
        THIS-OBJECT:ucProject:Axis:X2:Labels:Visible = FALSE.
        THIS-OBJECT:ucProject:Axis:X2:LineThickness = 1.
        THIS-OBJECT:ucProject:Axis:X2:MajorGridLines:AlphaLevel = System.Convert:ToByte(255).
        THIS-OBJECT:ucProject:Axis:X2:MajorGridLines:Color = System.Drawing.Color:Gainsboro.
        THIS-OBJECT:ucProject:Axis:X2:MajorGridLines:DrawStyle = Infragistics.UltraChart.Shared.Styles.LineDrawStyle:Dot.
        THIS-OBJECT:ucProject:Axis:X2:MajorGridLines:Visible = TRUE.
        THIS-OBJECT:ucProject:Axis:X2:MinorGridLines:AlphaLevel = System.Convert:ToByte(255).
        THIS-OBJECT:ucProject:Axis:X2:MinorGridLines:Color = System.Drawing.Color:LightGray.
        THIS-OBJECT:ucProject:Axis:X2:MinorGridLines:DrawStyle = Infragistics.UltraChart.Shared.Styles.LineDrawStyle:Dot.
        THIS-OBJECT:ucProject:Axis:X2:MinorGridLines:Visible = FALSE.
        THIS-OBJECT:ucProject:Axis:X2:TickmarkStyle = Infragistics.UltraChart.Shared.Styles.AxisTickStyle:Smart.
        THIS-OBJECT:ucProject:Axis:X2:Visible = FALSE.
        THIS-OBJECT:ucProject:Axis:Y:Labels:Font = NEW System.Drawing.Font("Verdana", Progress.Util.CastUtil:ToSingle(7)).
        THIS-OBJECT:ucProject:Axis:Y:Labels:FontColor = System.Drawing.Color:DimGray.
        THIS-OBJECT:ucProject:Axis:Y:Labels:HorizontalAlign = System.Drawing.StringAlignment:Far.
        THIS-OBJECT:ucProject:Axis:Y:Labels:ItemFormatString = "<DATA_VALUE:00.##>".
        THIS-OBJECT:ucProject:Axis:Y:Labels:Layout:Behavior = Infragistics.UltraChart.Shared.Styles.AxisLabelLayoutBehaviors:Auto.
        THIS-OBJECT:ucProject:Axis:Y:Labels:Orientation = Infragistics.UltraChart.Shared.Styles.TextOrientation:Horizontal.
        THIS-OBJECT:ucProject:Axis:Y:Labels:SeriesLabels:Font = NEW System.Drawing.Font("Verdana", Progress.Util.CastUtil:ToSingle(7)).
        THIS-OBJECT:ucProject:Axis:Y:Labels:SeriesLabels:FontColor = System.Drawing.Color:DimGray.
        THIS-OBJECT:ucProject:Axis:Y:Labels:SeriesLabels:FormatString = "".
        THIS-OBJECT:ucProject:Axis:Y:Labels:SeriesLabels:HorizontalAlign = System.Drawing.StringAlignment:Far.
        THIS-OBJECT:ucProject:Axis:Y:Labels:SeriesLabels:Layout:Behavior = Infragistics.UltraChart.Shared.Styles.AxisLabelLayoutBehaviors:Auto.
        THIS-OBJECT:ucProject:Axis:Y:Labels:SeriesLabels:Orientation = Infragistics.UltraChart.Shared.Styles.TextOrientation:VerticalLeftFacing.
        THIS-OBJECT:ucProject:Axis:Y:Labels:SeriesLabels:VerticalAlign = System.Drawing.StringAlignment:Center.
        THIS-OBJECT:ucProject:Axis:Y:Labels:SeriesLabels:Visible = TRUE.
        THIS-OBJECT:ucProject:Axis:Y:Labels:VerticalAlign = System.Drawing.StringAlignment:Center.
        THIS-OBJECT:ucProject:Axis:Y:Labels:Visible = TRUE.
        THIS-OBJECT:ucProject:Axis:Y:LineThickness = 1.
        THIS-OBJECT:ucProject:Axis:Y:MajorGridLines:AlphaLevel = System.Convert:ToByte(255).
        THIS-OBJECT:ucProject:Axis:Y:MajorGridLines:Color = System.Drawing.Color:Gainsboro.
        THIS-OBJECT:ucProject:Axis:Y:MajorGridLines:DrawStyle = Infragistics.UltraChart.Shared.Styles.LineDrawStyle:Dot.
        THIS-OBJECT:ucProject:Axis:Y:MajorGridLines:Visible = TRUE.
        THIS-OBJECT:ucProject:Axis:Y:MinorGridLines:AlphaLevel = System.Convert:ToByte(255).
        THIS-OBJECT:ucProject:Axis:Y:MinorGridLines:Color = System.Drawing.Color:LightGray.
        THIS-OBJECT:ucProject:Axis:Y:MinorGridLines:DrawStyle = Infragistics.UltraChart.Shared.Styles.LineDrawStyle:Dot.
        THIS-OBJECT:ucProject:Axis:Y:MinorGridLines:Visible = FALSE.
        THIS-OBJECT:ucProject:Axis:Y:TickmarkInterval = Progress.Util.CastUtil:ToDouble("20").
        THIS-OBJECT:ucProject:Axis:Y:TickmarkStyle = Infragistics.UltraChart.Shared.Styles.AxisTickStyle:Smart.
        THIS-OBJECT:ucProject:Axis:Y:Visible = TRUE.
        THIS-OBJECT:ucProject:Axis:Y2:Labels:Font = NEW System.Drawing.Font("Verdana", Progress.Util.CastUtil:ToSingle(7)).
        THIS-OBJECT:ucProject:Axis:Y2:Labels:FontColor = System.Drawing.Color:Gray.
        THIS-OBJECT:ucProject:Axis:Y2:Labels:HorizontalAlign = System.Drawing.StringAlignment:Near.
        THIS-OBJECT:ucProject:Axis:Y2:Labels:ItemFormatString = "<DATA_VALUE:00.##>".
        THIS-OBJECT:ucProject:Axis:Y2:Labels:Layout:Behavior = Infragistics.UltraChart.Shared.Styles.AxisLabelLayoutBehaviors:Auto.
        THIS-OBJECT:ucProject:Axis:Y2:Labels:Orientation = Infragistics.UltraChart.Shared.Styles.TextOrientation:Horizontal.
        THIS-OBJECT:ucProject:Axis:Y2:Labels:SeriesLabels:Font = NEW System.Drawing.Font("Verdana", Progress.Util.CastUtil:ToSingle(7)).
        THIS-OBJECT:ucProject:Axis:Y2:Labels:SeriesLabels:FontColor = System.Drawing.Color:Gray.
        THIS-OBJECT:ucProject:Axis:Y2:Labels:SeriesLabels:FormatString = "".
        THIS-OBJECT:ucProject:Axis:Y2:Labels:SeriesLabels:HorizontalAlign = System.Drawing.StringAlignment:Near.
        THIS-OBJECT:ucProject:Axis:Y2:Labels:SeriesLabels:Layout:Behavior = Infragistics.UltraChart.Shared.Styles.AxisLabelLayoutBehaviors:Auto.
        THIS-OBJECT:ucProject:Axis:Y2:Labels:SeriesLabels:Orientation = Infragistics.UltraChart.Shared.Styles.TextOrientation:VerticalLeftFacing.
        THIS-OBJECT:ucProject:Axis:Y2:Labels:SeriesLabels:VerticalAlign = System.Drawing.StringAlignment:Center.
        THIS-OBJECT:ucProject:Axis:Y2:Labels:SeriesLabels:Visible = TRUE.
        THIS-OBJECT:ucProject:Axis:Y2:Labels:VerticalAlign = System.Drawing.StringAlignment:Center.
        THIS-OBJECT:ucProject:Axis:Y2:Labels:Visible = FALSE.
        THIS-OBJECT:ucProject:Axis:Y2:LineThickness = 1.
        THIS-OBJECT:ucProject:Axis:Y2:MajorGridLines:AlphaLevel = System.Convert:ToByte(255).
        THIS-OBJECT:ucProject:Axis:Y2:MajorGridLines:Color = System.Drawing.Color:Gainsboro.
        THIS-OBJECT:ucProject:Axis:Y2:MajorGridLines:DrawStyle = Infragistics.UltraChart.Shared.Styles.LineDrawStyle:Dot.
        THIS-OBJECT:ucProject:Axis:Y2:MajorGridLines:Visible = TRUE.
        THIS-OBJECT:ucProject:Axis:Y2:MinorGridLines:AlphaLevel = System.Convert:ToByte(255).
        THIS-OBJECT:ucProject:Axis:Y2:MinorGridLines:Color = System.Drawing.Color:LightGray.
        THIS-OBJECT:ucProject:Axis:Y2:MinorGridLines:DrawStyle = Infragistics.UltraChart.Shared.Styles.LineDrawStyle:Dot.
        THIS-OBJECT:ucProject:Axis:Y2:MinorGridLines:Visible = FALSE.
        THIS-OBJECT:ucProject:Axis:Y2:TickmarkInterval = Progress.Util.CastUtil:ToDouble("20").
        THIS-OBJECT:ucProject:Axis:Y2:TickmarkStyle = Infragistics.UltraChart.Shared.Styles.AxisTickStyle:Smart.
        THIS-OBJECT:ucProject:Axis:Y2:Visible = FALSE.
        THIS-OBJECT:ucProject:Axis:Z:Labels:Font = NEW System.Drawing.Font("Verdana", Progress.Util.CastUtil:ToSingle(7)).
        THIS-OBJECT:ucProject:Axis:Z:Labels:FontColor = System.Drawing.Color:DimGray.
        THIS-OBJECT:ucProject:Axis:Z:Labels:HorizontalAlign = System.Drawing.StringAlignment:Near.
        THIS-OBJECT:ucProject:Axis:Z:Labels:ItemFormatString = "".
        THIS-OBJECT:ucProject:Axis:Z:Labels:Layout:Behavior = Infragistics.UltraChart.Shared.Styles.AxisLabelLayoutBehaviors:Auto.
        THIS-OBJECT:ucProject:Axis:Z:Labels:Orientation = Infragistics.UltraChart.Shared.Styles.TextOrientation:Horizontal.
        THIS-OBJECT:ucProject:Axis:Z:Labels:SeriesLabels:Font = NEW System.Drawing.Font("Verdana", Progress.Util.CastUtil:ToSingle(7)).
        THIS-OBJECT:ucProject:Axis:Z:Labels:SeriesLabels:FontColor = System.Drawing.Color:DimGray.
        THIS-OBJECT:ucProject:Axis:Z:Labels:SeriesLabels:HorizontalAlign = System.Drawing.StringAlignment:Near.
        THIS-OBJECT:ucProject:Axis:Z:Labels:SeriesLabels:Layout:Behavior = Infragistics.UltraChart.Shared.Styles.AxisLabelLayoutBehaviors:Auto.
        THIS-OBJECT:ucProject:Axis:Z:Labels:SeriesLabels:Orientation = Infragistics.UltraChart.Shared.Styles.TextOrientation:Horizontal.
        THIS-OBJECT:ucProject:Axis:Z:Labels:SeriesLabels:VerticalAlign = System.Drawing.StringAlignment:Center.
        THIS-OBJECT:ucProject:Axis:Z:Labels:SeriesLabels:Visible = TRUE.
        THIS-OBJECT:ucProject:Axis:Z:Labels:VerticalAlign = System.Drawing.StringAlignment:Center.
        THIS-OBJECT:ucProject:Axis:Z:Labels:Visible = FALSE.
        THIS-OBJECT:ucProject:Axis:Z:LineThickness = 1.
        THIS-OBJECT:ucProject:Axis:Z:MajorGridLines:AlphaLevel = System.Convert:ToByte(255).
        THIS-OBJECT:ucProject:Axis:Z:MajorGridLines:Color = System.Drawing.Color:Gainsboro.
        THIS-OBJECT:ucProject:Axis:Z:MajorGridLines:DrawStyle = Infragistics.UltraChart.Shared.Styles.LineDrawStyle:Dot.
        THIS-OBJECT:ucProject:Axis:Z:MajorGridLines:Visible = TRUE.
        THIS-OBJECT:ucProject:Axis:Z:MinorGridLines:AlphaLevel = System.Convert:ToByte(255).
        THIS-OBJECT:ucProject:Axis:Z:MinorGridLines:Color = System.Drawing.Color:LightGray.
        THIS-OBJECT:ucProject:Axis:Z:MinorGridLines:DrawStyle = Infragistics.UltraChart.Shared.Styles.LineDrawStyle:Dot.
        THIS-OBJECT:ucProject:Axis:Z:MinorGridLines:Visible = FALSE.
        THIS-OBJECT:ucProject:Axis:Z:TickmarkStyle = Infragistics.UltraChart.Shared.Styles.AxisTickStyle:Smart.
        THIS-OBJECT:ucProject:Axis:Z:Visible = FALSE.
        THIS-OBJECT:ucProject:Axis:Z2:Labels:Font = NEW System.Drawing.Font("Verdana", Progress.Util.CastUtil:ToSingle(7)).
        THIS-OBJECT:ucProject:Axis:Z2:Labels:FontColor = System.Drawing.Color:Gray.
        THIS-OBJECT:ucProject:Axis:Z2:Labels:HorizontalAlign = System.Drawing.StringAlignment:Near.
        THIS-OBJECT:ucProject:Axis:Z2:Labels:ItemFormatString = "".
        THIS-OBJECT:ucProject:Axis:Z2:Labels:Layout:Behavior = Infragistics.UltraChart.Shared.Styles.AxisLabelLayoutBehaviors:Auto.
        THIS-OBJECT:ucProject:Axis:Z2:Labels:Orientation = Infragistics.UltraChart.Shared.Styles.TextOrientation:Horizontal.
        THIS-OBJECT:ucProject:Axis:Z2:Labels:SeriesLabels:Font = NEW System.Drawing.Font("Verdana", Progress.Util.CastUtil:ToSingle(7)).
        THIS-OBJECT:ucProject:Axis:Z2:Labels:SeriesLabels:FontColor = System.Drawing.Color:Gray.
        THIS-OBJECT:ucProject:Axis:Z2:Labels:SeriesLabels:HorizontalAlign = System.Drawing.StringAlignment:Near.
        THIS-OBJECT:ucProject:Axis:Z2:Labels:SeriesLabels:Layout:Behavior = Infragistics.UltraChart.Shared.Styles.AxisLabelLayoutBehaviors:Auto.
        THIS-OBJECT:ucProject:Axis:Z2:Labels:SeriesLabels:Orientation = Infragistics.UltraChart.Shared.Styles.TextOrientation:Horizontal.
        THIS-OBJECT:ucProject:Axis:Z2:Labels:SeriesLabels:VerticalAlign = System.Drawing.StringAlignment:Center.
        THIS-OBJECT:ucProject:Axis:Z2:Labels:SeriesLabels:Visible = TRUE.
        THIS-OBJECT:ucProject:Axis:Z2:Labels:VerticalAlign = System.Drawing.StringAlignment:Center.
        THIS-OBJECT:ucProject:Axis:Z2:Labels:Visible = FALSE.
        THIS-OBJECT:ucProject:Axis:Z2:LineThickness = 1.
        THIS-OBJECT:ucProject:Axis:Z2:MajorGridLines:AlphaLevel = System.Convert:ToByte(255).
        THIS-OBJECT:ucProject:Axis:Z2:MajorGridLines:Color = System.Drawing.Color:Gainsboro.
        THIS-OBJECT:ucProject:Axis:Z2:MajorGridLines:DrawStyle = Infragistics.UltraChart.Shared.Styles.LineDrawStyle:Dot.
        THIS-OBJECT:ucProject:Axis:Z2:MajorGridLines:Visible = TRUE.
        THIS-OBJECT:ucProject:Axis:Z2:MinorGridLines:AlphaLevel = System.Convert:ToByte(255).
        THIS-OBJECT:ucProject:Axis:Z2:MinorGridLines:Color = System.Drawing.Color:LightGray.
        THIS-OBJECT:ucProject:Axis:Z2:MinorGridLines:DrawStyle = Infragistics.UltraChart.Shared.Styles.LineDrawStyle:Dot.
        THIS-OBJECT:ucProject:Axis:Z2:MinorGridLines:Visible = FALSE.
        THIS-OBJECT:ucProject:Axis:Z2:TickmarkStyle = Infragistics.UltraChart.Shared.Styles.AxisTickStyle:Smart.
        THIS-OBJECT:ucProject:Axis:Z2:Visible = FALSE.
        THIS-OBJECT:ucProject:BackgroundImageLayout = System.Windows.Forms.ImageLayout:Center.
        THIS-OBJECT:ucProject:BorderStyle = System.Windows.Forms.BorderStyle:FixedSingle.
        THIS-OBJECT:ucProject:ColorModel:AlphaLevel = System.Convert:ToByte(150).
        THIS-OBJECT:ucProject:ColorModel:ColorBegin = System.Drawing.Color:Pink.
        THIS-OBJECT:ucProject:ColorModel:ColorEnd = System.Drawing.Color:DarkRed.
        THIS-OBJECT:ucProject:ColorModel:ModelStyle = Infragistics.UltraChart.Shared.Styles.ColorModels:CustomLinear.
        chartTextAppearance1:ChartTextFont = NEW System.Drawing.Font("Arial", Progress.Util.CastUtil:ToSingle(7)).
        chartTextAppearance1:ClipText = FALSE.
        chartTextAppearance1:Column = -2.
        chartTextAppearance1:ItemFormatString = "<DATA_VALUE:00.00>".
        chartTextAppearance1:Row = -2.
        chartTextAppearance1:Visible = TRUE.
        columnChartAppearance1:ChartText:Add(chartTextAppearance1).
        THIS-OBJECT:ucProject:ColumnChart = columnChartAppearance1.
        THIS-OBJECT:ucProject:Data:ZeroAligned = TRUE.
        THIS-OBJECT:ucProject:DataSource = THIS-OBJECT:bsChart.
        THIS-OBJECT:ucProject:Effects:Effects:Add(gradientEffect1).
        THIS-OBJECT:ucProject:EmptyChartText = "No Data.".
        THIS-OBJECT:ucProject:Location = NEW System.Drawing.Point(726, 51).
        THIS-OBJECT:ucProject:Name = "ucProject".
        THIS-OBJECT:ucProject:Size = NEW System.Drawing.Size(2, 515).
        THIS-OBJECT:ucProject:TabIndex = 8.
        THIS-OBJECT:ucProject:TitleBottom:Font = NEW System.Drawing.Font("Microsoft Sans Serif", Progress.Util.CastUtil:ToSingle(7.8000002), System.Drawing.FontStyle:Bold).
        THIS-OBJECT:ucProject:TitleBottom:HorizontalAlign = System.Drawing.StringAlignment:Center.
        THIS-OBJECT:ucProject:TitleTop:Font = NEW System.Drawing.Font("Microsoft Sans Serif", Progress.Util.CastUtil:ToSingle(7.8000002), System.Drawing.FontStyle:Bold).
        THIS-OBJECT:ucProject:TitleTop:HorizontalAlign = System.Drawing.StringAlignment:Center.
        THIS-OBJECT:ucProject:Tooltips:HighlightFillColor = System.Drawing.Color:DimGray.
        THIS-OBJECT:ucProject:Tooltips:HighlightOutlineColor = System.Drawing.Color:DarkGray.
        THIS-OBJECT:ucProject:Visible = FALSE.
        THIS-OBJECT:ucProject:ChartDataClicked:Subscribe(THIS-OBJECT:ucProject_ChartDataClicked).
        /*  */
        /* bsChart */
        /*  */
        THIS-OBJECT:bsChart:MaxDataGuess = 0.
        THIS-OBJECT:bsChart:NoLOBs = FALSE.
        THIS-OBJECT:bsChart:Position = 0.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar7 AS "Progress.Data.TableDesc[]" NO-UNDO.
        arrayvar7 = NEW "Progress.Data.TableDesc[]"(0).
        tableDesc4:ChildTables = arrayvar7.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar8 AS Progress.Data.ColumnPropDesc EXTENT 1 NO-UNDO.
        arrayvar8[1] = NEW Progress.Data.ColumnPropDesc("Profit_Loss", "Profit/Loss", Progress.Data.DataType:DECIMAL).
        tableDesc4:Columns = arrayvar8.
        THIS-OBJECT:bsChart:TableSchema = tableDesc4.
        /*  */
        /* btnGraph */
        /*  */
        THIS-OBJECT:btnGraph:Enabled = FALSE.
        THIS-OBJECT:btnGraph:Location = NEW System.Drawing.Point(581, 296).
        THIS-OBJECT:btnGraph:Name = "btnGraph".
        THIS-OBJECT:btnGraph:Size = NEW System.Drawing.Size(121, 23).
        THIS-OBJECT:btnGraph:TabIndex = 9.
        THIS-OBJECT:btnGraph:Text = "Show Graph".
        THIS-OBJECT:btnGraph:Click:Subscribe(THIS-OBJECT:btnGraph_Click).
        /*  */
        /* cbGraphyBy */
        /*  */
        THIS-OBJECT:cbGraphyBy:DropDownStyle = System.Windows.Forms.ComboBoxStyle:DropDownList.
        THIS-OBJECT:cbGraphyBy:FormattingEnabled = TRUE.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar9 AS System.Object EXTENT 3 NO-UNDO.
        arrayvar9[1] = "Selected Project".
        arrayvar9[2] = "Selected Customer/Country".
        arrayvar9[3] = "Entire Customer/Country".
        THIS-OBJECT:cbGraphyBy:Items:AddRange(arrayvar9).
        THIS-OBJECT:cbGraphyBy:Location = NEW System.Drawing.Point(386, 297).
        THIS-OBJECT:cbGraphyBy:Name = "cbGraphyBy".
        THIS-OBJECT:cbGraphyBy:Size = NEW System.Drawing.Size(189, 21).
        THIS-OBJECT:cbGraphyBy:TabIndex = 10.
        THIS-OBJECT:cbGraphyBy:SelectedIndexChanged:Subscribe(THIS-OBJECT:cbGraphyBy_SelectedIndexChanged).
        /*  */
        /* dashboardForm */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(740, 583).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:cbGraphyBy).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:btnGraph).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:ucProject).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:cbFilterBy).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:ugProject).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:btnFilterProject).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:txtFilterProject).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:ugCompanyCustomer).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:btnFilterTop).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:txtFilterTop).
        THIS-OBJECT:Name = "dashboardForm".
        THIS-OBJECT:SizeGripStyle = System.Windows.Forms.SizeGripStyle:Show.
        THIS-OBJECT:Text = "dashboardForm".
        CAST(THIS-OBJECT:txtFilterTop, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:ugCompanyCustomer, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:ugProject, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:bsProject, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:txtFilterProject, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:bsCustomer, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:bsCountry, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:ucProject, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:bsChart, System.ComponentModel.ISupportInitialize):EndInit().
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

	METHOD PUBLIC VOID SetBindingSources(  ):
		
		IF cbFilterBy:SelectedIndex <> 0 THEN
		  ugProject:DataSource = bsProject.
	    ELSE
	       ugProject:DataSource = ?.
		
		CASE cbFilterBy:SelectedIndex.
		  WHEN 0 THEN
		      DO:
		         ugCompanyCustomer:Datasource = ?.
	          END.
          WHEN 1 THEN
              DO:
                  ugCompanyCustomer:Datasource = bsCustomer.
              END.
          WHEN 2 THEN
              DO:
                  ugCompanyCustomer:Datasource = bsCountry.
              END.
          END CASE.
          
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/

	METHOD PUBLIC VOID SetControlsAvailability(  ):
		
		txtFilterTop:ENABLED = (cbFilterBy:SelectedIndex > 0).
		btnFilterTop:ENABLED = (cbFilterBy:SelectedIndex > 0).
		ugCompanyCustomer:ENABLED = (cbFilterBy:SelectedIndex > 0).
		
		txtFilterProject:ENABLED = (cbFilterBy:SelectedIndex > 0).
		btnFilterProject:ENABLED = (cbFilterBy:SelectedIndex > 0).
		ugProject:ENABLED = (cbFilterBy:SelectedIndex > 0).
		btnGraph:ENABLED = (cbFilterBy:SelectedIndex > 0).
		ucProject:ENABLED = (cbFilterBy:SelectedIndex > 0).
		

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID ucProject_ChartDataClicked( INPUT sender AS System.Object, INPUT e AS Infragistics.UltraChart.Shared.Events.ChartDataEventArgs ):
		
		RETURN.

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID ugCompanyCustomer_AfterRowActivate( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
	   
	   DEFINE VARIABLE cFieldName AS CHARACTER INITIAL "customer_id" NO-UNDO.
	   DEFINE VARIABLE iRowID AS INTEGER NO-UNDO.

       IF cbFilterBy:SelectedIndex = 2 THEN
           DO:
               ASSIGN cFieldName = "country_id"
                      iRowID = objDashboardCountryModel:activeCountryId.
                      
               objDashboardProjectModel:setFilter(INPUT cFieldName, INPUT "EQ", INPUT STRING(iRowID)).
               objDashboardProjectModel:getDashboardProjectCountry().
           END.
       ELSE
           DO:
               ASSIGN cFieldName = "customer_id".
                      iRowID = objDashboardCustomerModel:activeCustomerId.
                      
               objDashboardProjectModel:setFilter(INPUT cFieldName, INPUT "EQ", INPUT STRING(iRowID)).
               objDashboardProjectModel:getDashboardProject().       
           END.
       	
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID ugProject_AfterRowActivate( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		
		DEFINE VARIABLE iRowID AS INTEGER NO-UNDO.
		
		iRowID = objDashboardProjectModel:activeProjectId.
		
        objDashboardProjectChartModel:setFilter( INPUT "project_id", INPUT "EQ", INPUT STRING(iRowID)).
        objDashboardProjectChartModel:getDashboardProject().
        
	END METHOD.

	DESTRUCTOR PUBLIC dashboardForm ( ):

	END DESTRUCTOR.

END CLASS.