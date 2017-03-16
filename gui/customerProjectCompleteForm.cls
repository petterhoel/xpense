 
 /*------------------------------------------------------------------------
    File        : customerProjectCompleteForm
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : tcoomans
    Created     : Wed Jan 27 15:26:22 CET 2016
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS gui.customerProjectCompleteForm INHERITS Form: 
	
    DEFINE PRIVATE VARIABLE bsCountry AS Progress.Data.BindingSource NO-UNDO.
    DEFINE PRIVATE VARIABLE bsCustomerprojectComplete AS Progress.Data.BindingSource NO-UNDO.
    DEFINE PRIVATE VARIABLE btnExcel AS Infragistics.Win.Misc.UltraButton NO-UNDO.
    DEFINE PRIVATE VARIABLE btnFilter AS Infragistics.Win.Misc.UltraButton NO-UNDO.
    DEFINE PRIVATE VARIABLE cmbCountry AS Infragistics.Win.UltraWinGrid.UltraCombo NO-UNDO.
	DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraGrid1 AS Infragistics.Win.UltraWinGrid.UltraGrid NO-UNDO.
    
    DEFINE VARIABLE objCustomerProjectComplete AS gui.CustomerProjectCompleteModel NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraGridExcelExporter1 AS Infragistics.Win.UltraWinGrid.ExcelExport.UltraGridExcelExporter NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraLabel1 AS Infragistics.Win.Misc.UltraLabel NO-UNDO.
	DEFINE VARIABLE objCountry AS gui.countryModel NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraSplitter1 AS Infragistics.Win.Misc.UltraSplitter NO-UNDO.
    DEFINE PRIVATE VARIABLE ultraPanel1 AS Infragistics.Win.Misc.UltraPanel NO-UNDO.
		
	CONSTRUCTOR PUBLIC customerProjectCompleteForm (  ):
		
		
        SUPER().
        InitializeComponent().
        
        /* Fill the country combo */
        objCountry = NEW gui.countryModel().
        bsCountry:HANDLE = objCountry:getCountry().
        
        
        /* Launch the backend class */   
        objCustomerProjectComplete = NEW gui.CustomerProjectCompleteModel().
        /* bind the dataset to the bindingsource */
        bsCustomerprojectComplete:HANDLE = objCustomerProjectComplete:getdsCustomerProjectCompleteHandle().
        
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
		
		DEFINE VARIABLE cFileName AS CHARACTER INITIAL "report.xlsx" NO-UNDO.
		
		ultraGridExcelExporter1:Export(ultraGrid1,cFileName).
		System.Diagnostics.Process:start(cFileName).


	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID btnFilter_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):

		IF cmbCountry:VALUE NE ?
		THEN
		  objCustomerProjectComplete:setFilter(INPUT "country_id",
		                                       INPUT "=",
		                                       INPUT STRING(cmbCountry:VALUE)).
		ELSE
		  objCustomerProjectComplete:clearFilter().
		                                         
        objCustomerProjectComplete:getdsCustomerProjectComplete().

	END METHOD.



	METHOD PRIVATE VOID InitializeComponent(  ):
		
        /* NOTE: The following method is automatically generated.
        
        We strongly suggest that the contents of this method only be modified using the
        Visual Designer to avoid any incompatible modifications.
        
        Modifying the contents of this method using a code editor will invalidate any support for this file. */
        THIS-OBJECT:components = NEW System.ComponentModel.Container().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE tableDesc1 AS Progress.Data.TableDesc NO-UNDO.
        tableDesc1 = NEW Progress.Data.TableDesc("ttCustomer").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE tableDesc2 AS Progress.Data.TableDesc NO-UNDO.
        tableDesc2 = NEW Progress.Data.TableDesc("ttProject").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE tableDesc3 AS Progress.Data.TableDesc NO-UNDO.
        tableDesc3 = NEW Progress.Data.TableDesc("ttCost").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE tableDesc4 AS Progress.Data.TableDesc NO-UNDO.
        tableDesc4 = NEW Progress.Data.TableDesc("ttProject_time").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance1 AS Infragistics.Win.Appearance NO-UNDO.
        appearance1 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridBand1 AS Infragistics.Win.UltraWinGrid.UltraGridBand NO-UNDO.
        ultraGridBand1 = NEW Infragistics.Win.UltraWinGrid.UltraGridBand("ttCustomer", -1).
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
        ultraGridColumn4 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("country_id").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn5 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn5 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("phone_number").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn6 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn6 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("registration_date").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn7 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn7 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("country_name").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn8 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn8 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("ttProject").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridBand2 AS Infragistics.Win.UltraWinGrid.UltraGridBand NO-UNDO.
        ultraGridBand2 = NEW Infragistics.Win.UltraWinGrid.UltraGridBand("ttProject", 0).
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
        ultraGridColumn12 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("start_date").
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
        DEFINE VARIABLE ultraGridColumn16 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn16 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("team_name").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn17 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn17 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("ttCost").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn18 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn18 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("ttProject_time").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridBand3 AS Infragistics.Win.UltraWinGrid.UltraGridBand NO-UNDO.
        ultraGridBand3 = NEW Infragistics.Win.UltraWinGrid.UltraGridBand("ttCost", 1).
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn19 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn19 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("cost_id").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn20 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn20 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("cost_type_id").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn21 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn21 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("price").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn22 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn22 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("curency_id").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn23 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn23 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("cost_date").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn24 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn24 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("project_id").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn25 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn25 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("symbol").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn26 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn26 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("cost_type_name").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridBand4 AS Infragistics.Win.UltraWinGrid.UltraGridBand NO-UNDO.
        ultraGridBand4 = NEW Infragistics.Win.UltraWinGrid.UltraGridBand("ttProject_time", 1).
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn27 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn27 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("project_time_id").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn28 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn28 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("project_id").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn29 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn29 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("employee_id").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn30 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn30 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("start_date_time").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn31 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn31 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("stop_date_time").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn32 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn32 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("comment").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn33 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn33 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("employee_name").
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
        DEFINE VARIABLE tableDesc5 AS Progress.Data.TableDesc NO-UNDO.
        tableDesc5 = NEW Progress.Data.TableDesc("ttCountry").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance13 AS Infragistics.Win.Appearance NO-UNDO.
        appearance13 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridBand5 AS Infragistics.Win.UltraWinGrid.UltraGridBand NO-UNDO.
        ultraGridBand5 = NEW Infragistics.Win.UltraWinGrid.UltraGridBand("ttCountry", -1).
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn34 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn34 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("country_id").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn35 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn35 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("country_name").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE ultraGridColumn36 AS Infragistics.Win.UltraWinGrid.UltraGridColumn NO-UNDO.
        ultraGridColumn36 = NEW Infragistics.Win.UltraWinGrid.UltraGridColumn("country_flag").
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
        THIS-OBJECT:bsCustomerprojectComplete = NEW Progress.Data.BindingSource(THIS-OBJECT:components).
        THIS-OBJECT:ultraGrid1 = NEW Infragistics.Win.UltraWinGrid.UltraGrid().
        THIS-OBJECT:btnExcel = NEW Infragistics.Win.Misc.UltraButton().
        THIS-OBJECT:ultraGridExcelExporter1 = NEW Infragistics.Win.UltraWinGrid.ExcelExport.UltraGridExcelExporter(THIS-OBJECT:components).
        THIS-OBJECT:bsCountry = NEW Progress.Data.BindingSource(THIS-OBJECT:components).
        THIS-OBJECT:cmbCountry = NEW Infragistics.Win.UltraWinGrid.UltraCombo().
        THIS-OBJECT:btnFilter = NEW Infragistics.Win.Misc.UltraButton().
        THIS-OBJECT:ultraLabel1 = NEW Infragistics.Win.Misc.UltraLabel().
        THIS-OBJECT:ultraSplitter1 = NEW Infragistics.Win.Misc.UltraSplitter().
        THIS-OBJECT:ultraPanel1 = NEW Infragistics.Win.Misc.UltraPanel().
        CAST(THIS-OBJECT:bsCustomerprojectComplete, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:ultraGrid1, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:bsCountry, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:cmbCountry, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:ultraPanel1:ClientArea:SuspendLayout().
        THIS-OBJECT:ultraPanel1:SuspendLayout().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* bsCustomerprojectComplete */
        /*  */
        THIS-OBJECT:bsCustomerprojectComplete:MaxDataGuess = 0.
        THIS-OBJECT:bsCustomerprojectComplete:NoLOBs = FALSE.
        THIS-OBJECT:bsCustomerprojectComplete:Position = 0.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar0 AS "Progress.Data.TableDesc[]" NO-UNDO.
        arrayvar0 = NEW "Progress.Data.TableDesc[]"(0).
        tableDesc3:ChildTables = arrayvar0.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar1 AS Progress.Data.ColumnPropDesc EXTENT 8 NO-UNDO.
        arrayvar1[1] = NEW Progress.Data.ColumnPropDesc("cost_id", "Cost Id", Progress.Data.DataType:INTEGER).
        arrayvar1[2] = NEW Progress.Data.ColumnPropDesc("cost_type_id", "Cost Type Id", Progress.Data.DataType:INTEGER).
        arrayvar1[3] = NEW Progress.Data.ColumnPropDesc("price", "Price", Progress.Data.DataType:DECIMAL).
        arrayvar1[4] = NEW Progress.Data.ColumnPropDesc("curency_id", "Currency Id", Progress.Data.DataType:INTEGER).
        arrayvar1[5] = NEW Progress.Data.ColumnPropDesc("cost_date", "Date", Progress.Data.DataType:DATE).
        arrayvar1[6] = NEW Progress.Data.ColumnPropDesc("project_id", "Project id", Progress.Data.DataType:INTEGER).
        arrayvar1[7] = NEW Progress.Data.ColumnPropDesc("symbol", "Symbol", Progress.Data.DataType:CHARACTER).
        arrayvar1[8] = NEW Progress.Data.ColumnPropDesc("cost_type_name", "Cost Type Name", Progress.Data.DataType:CHARACTER).
        tableDesc3:Columns = arrayvar1.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar2 AS "Progress.Data.TableDesc[]" NO-UNDO.
        arrayvar2 = NEW "Progress.Data.TableDesc[]"(0).
        tableDesc4:ChildTables = arrayvar2.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar3 AS Progress.Data.ColumnPropDesc EXTENT 7 NO-UNDO.
        arrayvar3[1] = NEW Progress.Data.ColumnPropDesc("project_time_id", "Project Time Id", Progress.Data.DataType:INTEGER).
        arrayvar3[2] = NEW Progress.Data.ColumnPropDesc("project_id", "Project id", Progress.Data.DataType:INTEGER).
        arrayvar3[3] = NEW Progress.Data.ColumnPropDesc("employee_id", "Employee Id", Progress.Data.DataType:INTEGER).
        arrayvar3[4] = NEW Progress.Data.ColumnPropDesc("start_date_time", "Start", Progress.Data.DataType:DATETIME).
        arrayvar3[5] = NEW Progress.Data.ColumnPropDesc("stop_date_time", "Stop", Progress.Data.DataType:DATETIME).
        arrayvar3[6] = NEW Progress.Data.ColumnPropDesc("comment", "Comment", Progress.Data.DataType:CHARACTER).
        arrayvar3[7] = NEW Progress.Data.ColumnPropDesc("employee_name", "Employee Name", Progress.Data.DataType:CHARACTER).
        tableDesc4:Columns = arrayvar3.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar4 AS Progress.Data.TableDesc EXTENT 2 NO-UNDO.
        arrayvar4[1] = tableDesc3.
        arrayvar4[2] = tableDesc4.
        tableDesc2:ChildTables = arrayvar4.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar5 AS Progress.Data.ColumnPropDesc EXTENT 8 NO-UNDO.
        arrayvar5[1] = NEW Progress.Data.ColumnPropDesc("project_id", "Project Id", Progress.Data.DataType:INTEGER).
        arrayvar5[2] = NEW Progress.Data.ColumnPropDesc("customer_id", "Customer Id", Progress.Data.DataType:INTEGER).
        arrayvar5[3] = NEW Progress.Data.ColumnPropDesc("project_name", "Project Name", Progress.Data.DataType:CHARACTER).
        arrayvar5[4] = NEW Progress.Data.ColumnPropDesc("start_date", "Start Date", Progress.Data.DataType:DATE).
        arrayvar5[5] = NEW Progress.Data.ColumnPropDesc("due_date", "Due Date", Progress.Data.DataType:DATE).
        arrayvar5[6] = NEW Progress.Data.ColumnPropDesc("team_id", "Team Id", Progress.Data.DataType:INTEGER).
        arrayvar5[7] = NEW Progress.Data.ColumnPropDesc("project_description", "Project Description", Progress.Data.DataType:CHARACTER).
        arrayvar5[8] = NEW Progress.Data.ColumnPropDesc("team_name", "Team Name", Progress.Data.DataType:CHARACTER).
        tableDesc2:Columns = arrayvar5.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar6 AS Progress.Data.TableDesc EXTENT 1 NO-UNDO.
        arrayvar6[1] = tableDesc2.
        tableDesc1:ChildTables = arrayvar6.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar7 AS Progress.Data.ColumnPropDesc EXTENT 7 NO-UNDO.
        arrayvar7[1] = NEW Progress.Data.ColumnPropDesc("customer_id", "Customer Id", Progress.Data.DataType:INTEGER).
        arrayvar7[2] = NEW Progress.Data.ColumnPropDesc("customer_name", "Customer Name", Progress.Data.DataType:CHARACTER).
        arrayvar7[3] = NEW Progress.Data.ColumnPropDesc("address", "Address", Progress.Data.DataType:CHARACTER).
        arrayvar7[4] = NEW Progress.Data.ColumnPropDesc("country_id", "Country Id", Progress.Data.DataType:INTEGER).
        arrayvar7[5] = NEW Progress.Data.ColumnPropDesc("phone_number", "Phone Number", Progress.Data.DataType:CHARACTER).
        arrayvar7[6] = NEW Progress.Data.ColumnPropDesc("registration_date", "Registration Date", Progress.Data.DataType:DATE).
        arrayvar7[7] = NEW Progress.Data.ColumnPropDesc("country_name", "Country Name", Progress.Data.DataType:CHARACTER).
        tableDesc1:Columns = arrayvar7.
        THIS-OBJECT:bsCustomerprojectComplete:TableSchema = tableDesc1.
        /*  */
        /* ultraGrid1 */
        /*  */
        THIS-OBJECT:ultraGrid1:DataSource = THIS-OBJECT:bsCustomerprojectComplete.
        appearance1:BackColor = System.Drawing.SystemColors:Window.
        appearance1:BorderColor = System.Drawing.SystemColors:InactiveCaption.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Appearance = appearance1.
        ultraGridColumn1:Header:VisiblePosition = 0.
        ultraGridColumn2:Header:VisiblePosition = 1.
        ultraGridColumn3:Header:VisiblePosition = 2.
        ultraGridColumn4:Header:VisiblePosition = 3.
        ultraGridColumn5:Header:VisiblePosition = 4.
        ultraGridColumn6:Header:VisiblePosition = 5.
        ultraGridColumn7:Header:VisiblePosition = 6.
        ultraGridColumn8:Header:VisiblePosition = 7.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar8 AS System.Object EXTENT 8 NO-UNDO.
        arrayvar8[1] = ultraGridColumn1.
        arrayvar8[2] = ultraGridColumn2.
        arrayvar8[3] = ultraGridColumn3.
        arrayvar8[4] = ultraGridColumn4.
        arrayvar8[5] = ultraGridColumn5.
        arrayvar8[6] = ultraGridColumn6.
        arrayvar8[7] = ultraGridColumn7.
        arrayvar8[8] = ultraGridColumn8.
        ultraGridBand1:Columns:AddRange(arrayvar8).
        ultraGridColumn9:Header:VisiblePosition = 0.
        ultraGridColumn10:Header:VisiblePosition = 1.
        ultraGridColumn11:Header:VisiblePosition = 2.
        ultraGridColumn12:Header:VisiblePosition = 3.
        ultraGridColumn13:Header:VisiblePosition = 4.
        ultraGridColumn14:Header:VisiblePosition = 5.
        ultraGridColumn15:Header:VisiblePosition = 6.
        ultraGridColumn16:Header:VisiblePosition = 7.
        ultraGridColumn17:Header:VisiblePosition = 8.
        ultraGridColumn18:Header:VisiblePosition = 9.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar9 AS System.Object EXTENT 10 NO-UNDO.
        arrayvar9[1] = ultraGridColumn9.
        arrayvar9[2] = ultraGridColumn10.
        arrayvar9[3] = ultraGridColumn11.
        arrayvar9[4] = ultraGridColumn12.
        arrayvar9[5] = ultraGridColumn13.
        arrayvar9[6] = ultraGridColumn14.
        arrayvar9[7] = ultraGridColumn15.
        arrayvar9[8] = ultraGridColumn16.
        arrayvar9[9] = ultraGridColumn17.
        arrayvar9[10] = ultraGridColumn18.
        ultraGridBand2:Columns:AddRange(arrayvar9).
        ultraGridColumn19:Header:VisiblePosition = 0.
        ultraGridColumn20:Header:VisiblePosition = 1.
        ultraGridColumn21:Header:VisiblePosition = 2.
        ultraGridColumn22:Header:VisiblePosition = 3.
        ultraGridColumn23:Header:VisiblePosition = 4.
        ultraGridColumn24:Header:VisiblePosition = 5.
        ultraGridColumn25:Header:VisiblePosition = 6.
        ultraGridColumn26:Header:VisiblePosition = 7.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar10 AS System.Object EXTENT 8 NO-UNDO.
        arrayvar10[1] = ultraGridColumn19.
        arrayvar10[2] = ultraGridColumn20.
        arrayvar10[3] = ultraGridColumn21.
        arrayvar10[4] = ultraGridColumn22.
        arrayvar10[5] = ultraGridColumn23.
        arrayvar10[6] = ultraGridColumn24.
        arrayvar10[7] = ultraGridColumn25.
        arrayvar10[8] = ultraGridColumn26.
        ultraGridBand3:Columns:AddRange(arrayvar10).
        ultraGridColumn27:Header:VisiblePosition = 0.
        ultraGridColumn28:Header:VisiblePosition = 1.
        ultraGridColumn29:Header:VisiblePosition = 2.
        ultraGridColumn30:Header:VisiblePosition = 3.
        ultraGridColumn31:Header:VisiblePosition = 4.
        ultraGridColumn32:Header:VisiblePosition = 5.
        ultraGridColumn33:Header:VisiblePosition = 6.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar11 AS System.Object EXTENT 7 NO-UNDO.
        arrayvar11[1] = ultraGridColumn27.
        arrayvar11[2] = ultraGridColumn28.
        arrayvar11[3] = ultraGridColumn29.
        arrayvar11[4] = ultraGridColumn30.
        arrayvar11[5] = ultraGridColumn31.
        arrayvar11[6] = ultraGridColumn32.
        arrayvar11[7] = ultraGridColumn33.
        ultraGridBand4:Columns:AddRange(arrayvar11).
        THIS-OBJECT:ultraGrid1:DisplayLayout:BandsSerializer:Add(ultraGridBand1).
        THIS-OBJECT:ultraGrid1:DisplayLayout:BandsSerializer:Add(ultraGridBand2).
        THIS-OBJECT:ultraGrid1:DisplayLayout:BandsSerializer:Add(ultraGridBand3).
        THIS-OBJECT:ultraGrid1:DisplayLayout:BandsSerializer:Add(ultraGridBand4).
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
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:RowSelectorHeaderStyle = Infragistics.Win.UltraWinGrid.RowSelectorHeaderStyle:ColumnChooserButton.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:RowSelectors = Infragistics.Win.DefaultableBoolean:True.
        appearance12:BackColor = System.Drawing.SystemColors:ControlLight.
        THIS-OBJECT:ultraGrid1:DisplayLayout:Override:TemplateAddRowAppearance = appearance12.
        THIS-OBJECT:ultraGrid1:DisplayLayout:ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds:ScrollToFill.
        THIS-OBJECT:ultraGrid1:DisplayLayout:ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle:Immediate.
        THIS-OBJECT:ultraGrid1:DisplayLayout:ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand:OutlookGroupBy.
        THIS-OBJECT:ultraGrid1:Dock = System.Windows.Forms.DockStyle:Fill.
        THIS-OBJECT:ultraGrid1:Font = NEW System.Drawing.Font("Microsoft Sans Serif", Progress.Util.CastUtil:ToSingle(8.25), System.Drawing.FontStyle:Regular, System.Drawing.GraphicsUnit:Point, System.Convert:ToByte(0)).
        THIS-OBJECT:ultraGrid1:Location = NEW System.Drawing.Point(0, 99).
        THIS-OBJECT:ultraGrid1:Name = "ultraGrid1".
        THIS-OBJECT:ultraGrid1:Size = NEW System.Drawing.Size(616, 305).
        THIS-OBJECT:ultraGrid1:TabIndex = 0.
        THIS-OBJECT:ultraGrid1:Text = "ultraGrid1".
        /*  */
        /* btnExcel */
        /*  */
        THIS-OBJECT:btnExcel:Location = NEW System.Drawing.Point(536, 40).
        THIS-OBJECT:btnExcel:Name = "btnExcel".
        THIS-OBJECT:btnExcel:Size = NEW System.Drawing.Size(68, 44).
        THIS-OBJECT:btnExcel:TabIndex = 1.
        THIS-OBJECT:btnExcel:Text = "Excel".
        THIS-OBJECT:btnExcel:Click:Subscribe(THIS-OBJECT:btnExcel_Click).
        /*  */
        /* bsCountry */
        /*  */
        THIS-OBJECT:bsCountry:MaxDataGuess = 0.
        THIS-OBJECT:bsCountry:NoLOBs = FALSE.
        THIS-OBJECT:bsCountry:Position = 0.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar12 AS "Progress.Data.TableDesc[]" NO-UNDO.
        arrayvar12 = NEW "Progress.Data.TableDesc[]"(0).
        tableDesc5:ChildTables = arrayvar12.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar13 AS Progress.Data.ColumnPropDesc EXTENT 3 NO-UNDO.
        arrayvar13[1] = NEW Progress.Data.ColumnPropDesc("country_id", "Country Id", Progress.Data.DataType:INTEGER).
        arrayvar13[2] = NEW Progress.Data.ColumnPropDesc("country_name", "Country Name", Progress.Data.DataType:CHARACTER).
        arrayvar13[3] = NEW Progress.Data.ColumnPropDesc("country_flag", "Flag", Progress.Data.DataType:BLOB).
        tableDesc5:Columns = arrayvar13.
        THIS-OBJECT:bsCountry:TableSchema = tableDesc5.
        /*  */
        /* cmbCountry */
        /*  */
        THIS-OBJECT:cmbCountry:DataSource = THIS-OBJECT:bsCountry.
        appearance13:BackColor = System.Drawing.SystemColors:Window.
        appearance13:BorderColor = System.Drawing.SystemColors:InactiveCaption.
        THIS-OBJECT:cmbCountry:DisplayLayout:Appearance = appearance13.
        ultraGridColumn34:Header:VisiblePosition = 1.
        ultraGridColumn34:Hidden = TRUE.
        ultraGridColumn35:Header:VisiblePosition = 2.
        appearance14:ImageHAlign = Infragistics.Win.HAlign:Center.
        appearance14:ImageVAlign = Infragistics.Win.VAlign:Middle.
        ultraGridColumn36:CellAppearance = appearance14.
        ultraGridColumn36:Header:VisiblePosition = 0.
        ultraGridColumn36:Style = Infragistics.Win.UltraWinGrid.ColumnStyle:Image.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar14 AS System.Object EXTENT 3 NO-UNDO.
        arrayvar14[1] = ultraGridColumn34.
        arrayvar14[2] = ultraGridColumn35.
        arrayvar14[3] = ultraGridColumn36.
        ultraGridBand5:Columns:AddRange(arrayvar14).
        THIS-OBJECT:cmbCountry:DisplayLayout:BandsSerializer:Add(ultraGridBand5).
        THIS-OBJECT:cmbCountry:DisplayLayout:BorderStyle = Infragistics.Win.UIElementBorderStyle:Solid.
        THIS-OBJECT:cmbCountry:DisplayLayout:CaptionVisible = Infragistics.Win.DefaultableBoolean:False.
        appearance15:BackColor = System.Drawing.SystemColors:ActiveBorder.
        appearance15:BackColor2 = System.Drawing.SystemColors:ControlDark.
        appearance15:BackGradientStyle = Infragistics.Win.GradientStyle:Vertical.
        appearance15:BorderColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:cmbCountry:DisplayLayout:GroupByBox:Appearance = appearance15.
        appearance16:ForeColor = System.Drawing.SystemColors:GrayText.
        THIS-OBJECT:cmbCountry:DisplayLayout:GroupByBox:BandLabelAppearance = appearance16.
        THIS-OBJECT:cmbCountry:DisplayLayout:GroupByBox:BorderStyle = Infragistics.Win.UIElementBorderStyle:Solid.
        appearance17:BackColor = System.Drawing.SystemColors:ControlLightLight.
        appearance17:BackColor2 = System.Drawing.SystemColors:Control.
        appearance17:BackGradientStyle = Infragistics.Win.GradientStyle:Horizontal.
        appearance17:ForeColor = System.Drawing.SystemColors:GrayText.
        THIS-OBJECT:cmbCountry:DisplayLayout:GroupByBox:PromptAppearance = appearance17.
        THIS-OBJECT:cmbCountry:DisplayLayout:MaxColScrollRegions = 1.
        THIS-OBJECT:cmbCountry:DisplayLayout:MaxRowScrollRegions = 1.
        appearance18:BackColor = System.Drawing.SystemColors:Window.
        appearance18:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:cmbCountry:DisplayLayout:Override:ActiveCellAppearance = appearance18.
        appearance19:BackColor = System.Drawing.SystemColors:Highlight.
        appearance19:ForeColor = System.Drawing.SystemColors:HighlightText.
        THIS-OBJECT:cmbCountry:DisplayLayout:Override:ActiveRowAppearance = appearance19.
        THIS-OBJECT:cmbCountry:DisplayLayout:Override:BorderStyleCell = Infragistics.Win.UIElementBorderStyle:Dotted.
        THIS-OBJECT:cmbCountry:DisplayLayout:Override:BorderStyleRow = Infragistics.Win.UIElementBorderStyle:Dotted.
        appearance20:BackColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:cmbCountry:DisplayLayout:Override:CardAreaAppearance = appearance20.
        appearance21:BorderColor = System.Drawing.Color:Silver.
        appearance21:TextTrimming = Infragistics.Win.TextTrimming:EllipsisCharacter.
        THIS-OBJECT:cmbCountry:DisplayLayout:Override:CellAppearance = appearance21.
        THIS-OBJECT:cmbCountry:DisplayLayout:Override:CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction:EditAndSelectText.
        THIS-OBJECT:cmbCountry:DisplayLayout:Override:CellPadding = 0.
        appearance22:BackColor = System.Drawing.SystemColors:Control.
        appearance22:BackColor2 = System.Drawing.SystemColors:ControlDark.
        appearance22:BackGradientAlignment = Infragistics.Win.GradientAlignment:Element.
        appearance22:BackGradientStyle = Infragistics.Win.GradientStyle:Horizontal.
        appearance22:BorderColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:cmbCountry:DisplayLayout:Override:GroupByRowAppearance = appearance22.
        appearance23:TextHAlignAsString = "Left".
        THIS-OBJECT:cmbCountry:DisplayLayout:Override:HeaderAppearance = appearance23.
        THIS-OBJECT:cmbCountry:DisplayLayout:Override:HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction:SortMulti.
        THIS-OBJECT:cmbCountry:DisplayLayout:Override:HeaderStyle = Infragistics.Win.HeaderStyle:WindowsXPCommand.
        appearance24:BackColor = System.Drawing.SystemColors:Window.
        appearance24:BorderColor = System.Drawing.Color:Silver.
        THIS-OBJECT:cmbCountry:DisplayLayout:Override:RowAppearance = appearance24.
        THIS-OBJECT:cmbCountry:DisplayLayout:Override:RowSelectors = Infragistics.Win.DefaultableBoolean:False.
        appearance25:BackColor = System.Drawing.SystemColors:ControlLight.
        THIS-OBJECT:cmbCountry:DisplayLayout:Override:TemplateAddRowAppearance = appearance25.
        THIS-OBJECT:cmbCountry:DisplayLayout:ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds:ScrollToFill.
        THIS-OBJECT:cmbCountry:DisplayLayout:ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle:Immediate.
        THIS-OBJECT:cmbCountry:DisplayLayout:ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand:OutlookGroupBy.
        THIS-OBJECT:cmbCountry:DisplayMember = "country_name".
        THIS-OBJECT:cmbCountry:Font = NEW System.Drawing.Font("Microsoft Sans Serif", Progress.Util.CastUtil:ToSingle(8.25), System.Drawing.FontStyle:Regular, System.Drawing.GraphicsUnit:Point, System.Convert:ToByte(0)).
        THIS-OBJECT:cmbCountry:Location = NEW System.Drawing.Point(67, 12).
        THIS-OBJECT:cmbCountry:Name = "cmbCountry".
        THIS-OBJECT:cmbCountry:Size = NEW System.Drawing.Size(184, 22).
        THIS-OBJECT:cmbCountry:TabIndex = 2.
        THIS-OBJECT:cmbCountry:ValueMember = "country_id".
        /*  */
        /* btnFilter */
        /*  */
        DEFINE VARIABLE nestedvar0 AS System.Windows.Forms.AnchorStyles NO-UNDO.
        nestedvar0 = System.Windows.Forms.AnchorStyles:Top.
        THIS-OBJECT:btnFilter:Anchor = CAST(Progress.Util.EnumHelper:Or(nestedvar0, System.Windows.Forms.AnchorStyles:Right), System.Windows.Forms.AnchorStyles).
        THIS-OBJECT:btnFilter:Location = NEW System.Drawing.Point(536, 12).
        THIS-OBJECT:btnFilter:Name = "btnFilter".
        THIS-OBJECT:btnFilter:Size = NEW System.Drawing.Size(68, 22).
        THIS-OBJECT:btnFilter:TabIndex = 3.
        THIS-OBJECT:btnFilter:Text = "Filter".
        THIS-OBJECT:btnFilter:Click:Subscribe(THIS-OBJECT:btnFilter_Click).
        /*  */
        /* ultraLabel1 */
        /*  */
        THIS-OBJECT:ultraLabel1:Location = NEW System.Drawing.Point(12, 17).
        THIS-OBJECT:ultraLabel1:Name = "ultraLabel1".
        THIS-OBJECT:ultraLabel1:Size = NEW System.Drawing.Size(100, 23).
        THIS-OBJECT:ultraLabel1:TabIndex = 4.
        THIS-OBJECT:ultraLabel1:Text = "Country :".
        /*  */
        /* ultraSplitter1 */
        /*  */
        THIS-OBJECT:ultraSplitter1:BackColor = System.Drawing.SystemColors:Control.
        THIS-OBJECT:ultraSplitter1:Dock = System.Windows.Forms.DockStyle:Top.
        THIS-OBJECT:ultraSplitter1:Location = NEW System.Drawing.Point(0, 93).
        THIS-OBJECT:ultraSplitter1:Name = "ultraSplitter1".
        THIS-OBJECT:ultraSplitter1:RestoreExtent = 305.
        THIS-OBJECT:ultraSplitter1:Size = NEW System.Drawing.Size(616, 6).
        THIS-OBJECT:ultraSplitter1:TabIndex = 5.
        /*  */
        /* ultraPanel1 */
        /*  */
        /*  */
        /* ultraPanel1.ClientArea */
        /*  */
        THIS-OBJECT:ultraPanel1:ClientArea:Controls:Add(THIS-OBJECT:cmbCountry).
        THIS-OBJECT:ultraPanel1:ClientArea:Controls:Add(THIS-OBJECT:btnFilter).
        THIS-OBJECT:ultraPanel1:ClientArea:Controls:Add(THIS-OBJECT:ultraLabel1).
        THIS-OBJECT:ultraPanel1:ClientArea:Controls:Add(THIS-OBJECT:btnExcel).
        THIS-OBJECT:ultraPanel1:Dock = System.Windows.Forms.DockStyle:Top.
        THIS-OBJECT:ultraPanel1:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:ultraPanel1:Name = "ultraPanel1".
        THIS-OBJECT:ultraPanel1:Size = NEW System.Drawing.Size(616, 93).
        THIS-OBJECT:ultraPanel1:TabIndex = 6.
        /*  */
        /* customerProjectCompleteForm */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(616, 404).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:ultraGrid1).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:ultraSplitter1).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:ultraPanel1).
        THIS-OBJECT:Name = "customerProjectCompleteForm".
        THIS-OBJECT:Text = "Customer Project Report".
        CAST(THIS-OBJECT:bsCustomerprojectComplete, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:ultraGrid1, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:bsCountry, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:cmbCountry, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:ultraPanel1:ClientArea:ResumeLayout(FALSE).
        THIS-OBJECT:ultraPanel1:ClientArea:PerformLayout().
        THIS-OBJECT:ultraPanel1:ResumeLayout(FALSE).
        THIS-OBJECT:ResumeLayout(FALSE).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
	END METHOD.

	DESTRUCTOR PUBLIC customerProjectCompleteForm ( ):

	END DESTRUCTOR.

END CLASS.