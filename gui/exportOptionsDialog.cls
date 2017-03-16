 
 /*------------------------------------------------------------------------
    File        : exportOptionsDialog
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : tcoomans
    Created     : Tue Jan 26 17:15:09 CET 2016
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.
USING System.Windows.Forms.RadioButton FROM ASSEMBLY.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS gui.exportOptionsDialog INHERITS Form: 
	
    DEFINE PRIVATE VARIABLE btnExport AS Telerik.WinControls.UI.RadButton NO-UNDO.
    DEFINE PRIVATE VARIABLE btnCancel AS Telerik.WinControls.UI.RadButton NO-UNDO.
    DEFINE PRIVATE VARIABLE btnBrowseDir AS Telerik.WinControls.UI.RadButton NO-UNDO.
	DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE radGroupBox2 AS Telerik.WinControls.UI.RadGroupBox NO-UNDO.
    DEFINE PRIVATE VARIABLE radGroupBox1 AS Telerik.WinControls.UI.RadGroupBox NO-UNDO.
    DEFINE PRIVATE VARIABLE rbXml AS Telerik.WinControls.UI.RadRadioButton NO-UNDO.
    DEFINE PRIVATE VARIABLE rbJson AS Telerik.WinControls.UI.RadRadioButton NO-UNDO.
    DEFINE PRIVATE VARIABLE txtFileLocation AS Telerik.WinControls.UI.RadTextBox NO-UNDO.

DEFINE PUBLIC VARIABLE myVar AS CHARACTER NO-UNDO.		

	DEFINE PUBLIC PROPERTY fileLocation AS CHARACTER NO-UNDO 
	GET.
	SET. 
    DEFINE PUBLIC PROPERTY exportType AS CHARACTER NO-UNDO 
    GET. 
    SET. 


	CONSTRUCTOR PUBLIC exportOptionsDialog ():
		
		
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
        THIS-OBJECT:radGroupBox1 = NEW Telerik.WinControls.UI.RadGroupBox().
        THIS-OBJECT:rbXml = NEW Telerik.WinControls.UI.RadRadioButton().
        THIS-OBJECT:rbJson = NEW Telerik.WinControls.UI.RadRadioButton().
        THIS-OBJECT:btnExport = NEW Telerik.WinControls.UI.RadButton().
        THIS-OBJECT:btnCancel = NEW Telerik.WinControls.UI.RadButton().
        THIS-OBJECT:radGroupBox2 = NEW Telerik.WinControls.UI.RadGroupBox().
        THIS-OBJECT:btnBrowseDir = NEW Telerik.WinControls.UI.RadButton().
        THIS-OBJECT:txtFileLocation = NEW Telerik.WinControls.UI.RadTextBox().
        CAST(THIS-OBJECT:radGroupBox1, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:radGroupBox1:SuspendLayout().
        CAST(THIS-OBJECT:rbXml, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:rbJson, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:btnExport, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:btnCancel, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:radGroupBox2, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:radGroupBox2:SuspendLayout().
        CAST(THIS-OBJECT:btnBrowseDir, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:txtFileLocation, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* radGroupBox1 */
        /*  */
        THIS-OBJECT:radGroupBox1:AccessibleRole = System.Windows.Forms.AccessibleRole:Grouping.
        THIS-OBJECT:radGroupBox1:Controls:Add(THIS-OBJECT:rbXml).
        THIS-OBJECT:radGroupBox1:Controls:Add(THIS-OBJECT:rbJson).
        THIS-OBJECT:radGroupBox1:HeaderText = "Export Type".
        THIS-OBJECT:radGroupBox1:Location = NEW System.Drawing.Point(12, 12).
        THIS-OBJECT:radGroupBox1:Name = "radGroupBox1".
        THIS-OBJECT:radGroupBox1:Size = NEW System.Drawing.Size(268, 79).
        THIS-OBJECT:radGroupBox1:TabIndex = 3.
        THIS-OBJECT:radGroupBox1:Text = "Export Type".
        /*  */
        /* rbXml */
        /*  */
        THIS-OBJECT:rbXml:Location = NEW System.Drawing.Point(18, 47).
        THIS-OBJECT:rbXml:Name = "rbXml".
        THIS-OBJECT:rbXml:Size = NEW System.Drawing.Size(78, 18).
        THIS-OBJECT:rbXml:TabIndex = 1.
        THIS-OBJECT:rbXml:TabStop = FALSE.
        THIS-OBJECT:rbXml:Text = "XML export".
        /*  */
        /* rbJson */
        /*  */
        THIS-OBJECT:rbJson:CheckState = System.Windows.Forms.CheckState:Checked.
        THIS-OBJECT:rbJson:Location = NEW System.Drawing.Point(18, 22).
        THIS-OBJECT:rbJson:Name = "rbJson".
        THIS-OBJECT:rbJson:Size = NEW System.Drawing.Size(83, 18).
        THIS-OBJECT:rbJson:TabIndex = 0.
        THIS-OBJECT:rbJson:Text = "JSON export".
        THIS-OBJECT:rbJson:ToggleState = Telerik.WinControls.Enumerations.ToggleState:On.
        /*  */
        /* btnExport */
        /*  */
        THIS-OBJECT:btnExport:DialogResult = System.Windows.Forms.DialogResult:OK.
        THIS-OBJECT:btnExport:Location = NEW System.Drawing.Point(200, 185).
        THIS-OBJECT:btnExport:Name = "btnExport".
        THIS-OBJECT:btnExport:Size = NEW System.Drawing.Size(80, 24).
        THIS-OBJECT:btnExport:TabIndex = 4.
        THIS-OBJECT:btnExport:Text = "Export".
        THIS-OBJECT:btnExport:Click:Subscribe(THIS-OBJECT:btnExport_Click).
        /*  */
        /* btnCancel */
        /*  */
        THIS-OBJECT:btnCancel:DialogResult = System.Windows.Forms.DialogResult:Cancel.
        THIS-OBJECT:btnCancel:Location = NEW System.Drawing.Point(114, 185).
        THIS-OBJECT:btnCancel:Name = "btnCancel".
        THIS-OBJECT:btnCancel:Size = NEW System.Drawing.Size(80, 24).
        THIS-OBJECT:btnCancel:TabIndex = 5.
        THIS-OBJECT:btnCancel:Text = "Cancel".
        /*  */
        /* radGroupBox2 */
        /*  */
        THIS-OBJECT:radGroupBox2:AccessibleRole = System.Windows.Forms.AccessibleRole:Grouping.
        THIS-OBJECT:radGroupBox2:Controls:Add(THIS-OBJECT:btnBrowseDir).
        THIS-OBJECT:radGroupBox2:Controls:Add(THIS-OBJECT:txtFileLocation).
        THIS-OBJECT:radGroupBox2:HeaderText = "Export Location".
        THIS-OBJECT:radGroupBox2:Location = NEW System.Drawing.Point(12, 97).
        THIS-OBJECT:radGroupBox2:Name = "radGroupBox2".
        THIS-OBJECT:radGroupBox2:Size = NEW System.Drawing.Size(268, 82).
        THIS-OBJECT:radGroupBox2:TabIndex = 6.
        THIS-OBJECT:radGroupBox2:Text = "Export Location".
        /*  */
        /* btnBrowseDir */
        /*  */
        THIS-OBJECT:btnBrowseDir:Location = NEW System.Drawing.Point(21, 47).
        THIS-OBJECT:btnBrowseDir:Name = "btnBrowseDir".
        THIS-OBJECT:btnBrowseDir:Size = NEW System.Drawing.Size(100, 24).
        THIS-OBJECT:btnBrowseDir:TabIndex = 6.
        THIS-OBJECT:btnBrowseDir:Text = "Browse Directory".
        THIS-OBJECT:btnBrowseDir:Click:Subscribe(THIS-OBJECT:btnBrowseDir_Click).
        /*  */
        /* txtFileLocation */
        /*  */
        THIS-OBJECT:txtFileLocation:Location = NEW System.Drawing.Point(18, 21).
        THIS-OBJECT:txtFileLocation:Name = "txtFileLocation".
        THIS-OBJECT:txtFileLocation:Size = NEW System.Drawing.Size(244, 20).
        THIS-OBJECT:txtFileLocation:TabIndex = 0.
        /*  */
        /* exportOptionsDialog */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(292, 217).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:radGroupBox2).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:btnCancel).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:btnExport).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:radGroupBox1).
        THIS-OBJECT:Name = "exportOptionsDialog".
        THIS-OBJECT:Text = "Export Options Dialog".
        CAST(THIS-OBJECT:radGroupBox1, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:radGroupBox1:ResumeLayout(FALSE).
        THIS-OBJECT:radGroupBox1:PerformLayout().
        CAST(THIS-OBJECT:rbXml, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:rbJson, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:btnExport, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:btnCancel, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:radGroupBox2, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:radGroupBox2:ResumeLayout(FALSE).
        THIS-OBJECT:radGroupBox2:PerformLayout().
        CAST(THIS-OBJECT:btnBrowseDir, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:txtFileLocation, System.ComponentModel.ISupportInitialize):EndInit().
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
	METHOD PRIVATE VOID btnExport_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		THIS-OBJECT:fileLocation = txtFileLocation:TEXT.
		THIS-OBJECT:exportType = IF rbJson:CheckState = System.Windows.Forms.CheckState:Checked
		                         THEN "JSON"
		                         ELSE "XML".

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID btnBrowseDir_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
	    
	    DEFINE VARIABLE cDir AS CHARACTER NO-UNDO.
	    
		SYSTEM-DIALOG GET-DIR cDir.
        txtFileLocation:TEXT = cDir.


	END METHOD.

	DESTRUCTOR PUBLIC exportOptionsDialog ( ):

	END DESTRUCTOR.

END CLASS.