using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using System.IO;
using RetailPlus.Datasets;
using AceSoft.RetailPlus.Data;
using MySql.Data.MySqlClient;

namespace AceSoft.RetailPlus.Reports
{
	using System;
	using System.Data;
	using System.Drawing;
	using System.Web;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;

	public partial  class __InventoryAnalyst : System.Web.UI.UserControl
	{

		protected void Page_Load(object sender, System.EventArgs e)
		{
            if (!IsPostBack && Visible)
			{
				lblReferrer.Text = Request.UrlReferrer == null ? Constants.ROOT_DIRECTORY : Request.UrlReferrer.ToString();
				LoadOptions();
                Session["ReportDocument"] = null;
                Session["ReportType"] = "inventoryanalyst";
            }
        }

        protected void Page_Init(object sender, System.EventArgs e)
        {
            if (Session["ReportDocument"] != null && Session["ReportType"] != null)
            {
                if (Session["ReportType"].ToString() == "inventoryanalyst")
                    try { CRViewer.ReportSource = (ReportDocument)Session["ReportDocument"]; } catch { }
            }
        }

		private void LoadOptions()
		{
            ProductGroup clsProductGroup = new ProductGroup();
            cboGroup.DataTextField = "ProductGroupName";
            cboGroup.DataValueField = "ProductGroupID";
            cboGroup.DataSource = clsProductGroup.ListAsDataTable();
            cboGroup.DataBind();
            cboGroup.Items.Insert(0, new ListItem(Constants.ALL,Constants.ZERO_STRING));
            cboGroup.SelectedIndex = 0;

            ProductSubGroupColumns clsProductSubGroupColumns = new ProductSubGroupColumns() { ColumnsNameID = true };

            ProductSubGroup clsSubGroup = new ProductSubGroup(clsProductGroup.Connection, clsProductGroup.Transaction);
            cboSubGroup.DataTextField = "ProductSubGroupName";
            cboSubGroup.DataValueField = "ProductSubGroupID";
            cboSubGroup.DataSource = clsSubGroup.ListAsDataTable(clsProductSubGroupColumns, SortField: "ProductSubGroupName", SortOrder: System.Data.SqlClient.SortOrder.Ascending);
            cboSubGroup.DataBind();
            cboSubGroup.Items.Insert(0, new ListItem(Constants.ALL,Constants.ZERO_STRING));
            cboSubGroup.SelectedIndex = 0;

            Contacts clsContact = new Contacts(clsProductGroup.Connection, clsProductGroup.Transaction);
            cboSupplier.DataTextField = "ContactName";
            cboSupplier.DataValueField = "ContactID";
            cboSupplier.DataSource = clsContact.SuppliersAsDataTable(string.Empty, 0, "ContactName", SortOption.Ascending);
            cboSupplier.DataBind();
            cboSupplier.Items.Add(new ListItem(Constants.ALL, Constants.ZERO_STRING));
            cboSupplier.SelectedIndex = cboSupplier.Items.Count - 1;

            clsProductGroup.CommitAndDispose();

            txtStartTransactionDate.Text = DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd");
            txtEndTransactionDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
		}

        private ReportDocument getReportDocument()
        {
            ReportDocument rpt = new ReportDocument();

            rpt.Load(Server.MapPath(Constants.ROOT_DIRECTORY + "/Reports/_InventoryAnalyst.rpt"));

            return rpt;
        }

        #region Export

        private void Export(ExportFormatType pvtExportFormatType)
        {
            ReportDocument rpt = getReportDocument();

            SetDataSource(rpt);

            if (pvtExportFormatType == ExportFormatType.WordForWindows || pvtExportFormatType == ExportFormatType.Excel || pvtExportFormatType == ExportFormatType.PortableDocFormat)
            {
                string strFileName = Session["UserName"].ToString() + "_inventoryanalyst";
                CRSHelper.GenerateReport(strFileName, rpt, this.updPrint, pvtExportFormatType);
            }
            else
            {
                CRViewer.ReportSource = rpt;
                Session["ReportDocument"] = rpt;
            }
        }

        #endregion

        #region GeneratePDF
        private void GeneratePDF() { Export(ExportFormatType.PortableDocFormat); }
        #endregion

        #region GenerateWord
        private void GenerateWord() { Export(ExportFormatType.WordForWindows); }
        #endregion

        #region GenerateExcel
        private void GenerateExcel() { Export(ExportFormatType.Excel); }
        #endregion

        #region GenerateHTML
        private void GenerateHTML() { Export(ExportFormatType.HTML40); }
        #endregion

		#region SetDataSource

		private void SetDataSource(ReportDocument Report)
		{
            ReportDataset rptds = new ReportDataset();

            string ProductGroupName = string.Empty;
            if (cboGroup.SelectedItem.Value != Constants.ZERO_STRING) ProductGroupName = cboGroup.SelectedItem.Text;
            string SubGroupName = string.Empty;
            if (cboSubGroup.SelectedItem.Value != Constants.ZERO_STRING) SubGroupName = cboSubGroup.SelectedItem.Text;

            DateTime dteIDCStartDate = DateTime.Now.AddDays(-14);
            DateTime dteIDCEndDate = DateTime.Now;
            
            try { dteIDCStartDate = Convert.ToDateTime(txtStartTransactionDate.Text + " " + txtStartTime.Text);}catch{}
            try { dteIDCEndDate = Convert.ToDateTime(txtEndTransactionDate.Text + " " + txtEndTime.Text);}catch{}

			Products clsProduct = new Products();
            
            if (cboSupplier.SelectedItem.Text == Constants.ALL)
            { 
                if (cboSubGroup.SelectedItem.Text == Constants.ALL)
                { clsProduct.UpdateProductReorderOverStockPerSubGroup(long.Parse(cboSubGroup.SelectedItem.Value), dteIDCStartDate, dteIDCEndDate); }
                else if (cboSubGroup.SelectedItem.Text == Constants.ALL)
                { clsProduct.UpdateProductReorderOverStockPerGroup(long.Parse(cboGroup.SelectedItem.Value), dteIDCStartDate, dteIDCEndDate); }
                else
                { clsProduct.UpdateProductReorderOverStock(dteIDCStartDate, dteIDCEndDate); }
            }
            else
            {
                if (cboSubGroup.SelectedItem.Text == Constants.ALL)
                { clsProduct.UpdateProductReorderOverStockPerSupplierPerSubGroup(long.Parse(cboSupplier.SelectedValue), long.Parse(cboSubGroup.SelectedItem.Value), dteIDCStartDate, dteIDCEndDate); }
                else if (cboSubGroup.SelectedItem.Text == Constants.ALL)
                { clsProduct.UpdateProductReorderOverStockPerSupplierPerGroup(long.Parse(cboSupplier.SelectedValue), long.Parse(cboGroup.SelectedItem.Value), dteIDCStartDate, dteIDCEndDate); }
                else
                { clsProduct.UpdateProductReorderOverStockPerSupplier(long.Parse(cboSupplier.SelectedValue), dteIDCStartDate, dteIDCEndDate); }
            }
            clsProduct.CommitAndDispose();

            clsProduct = new Products();
            System.Data.DataTable dt = (clsProduct.SearchDataTable(ProductListFilterType.ShowActiveOnly, string.Empty, long.Parse(cboSupplier.SelectedValue),
                                            long.Parse(cboGroup.SelectedItem.Value), string.Empty, long.Parse(cboSubGroup.SelectedItem.Value), string.Empty, 0, false, false, string.Empty, SortOption.Ascending));
            clsProduct.CommitAndDispose();

            foreach(System.Data.DataRow dr in dt.Rows)
            {
                DataRow drProducts = rptds.Products.NewRow();

                foreach (DataColumn dc in rptds.Products.Columns)
                    drProducts[dc] = dr[dc.ColumnName];

                rptds.Products.Rows.Add(drProducts);
            }

            //ProductVariationsMatrix clsMatrix = new ProductVariationsMatrix(clsProduct.Connection, clsProduct.Transaction);
            //rptds.Tables.Add(clsMatrix.BaseListAsDataTable(0, "a.ProductID", SortOption.Ascending));
            // ds.Tables.Add(clsMatrix.ForReorder("a.Quantity", SortOption.Ascending));

            Report.SetDataSource(rptds);

			SetParameters(Report);
		}

		#endregion

		#region SetParameters
		private void SetParameters (ReportDocument Report)
		{
			ParameterFieldDefinition paramField;
			ParameterValues currentValues;
			ParameterDiscreteValue discreteParam;

			paramField = Report.DataDefinition.ParameterFields["CompanyName"];
			discreteParam = new ParameterDiscreteValue();
			discreteParam.Value = CompanyDetails.CompanyName;
			currentValues = new ParameterValues();
			currentValues.Add(discreteParam);
			paramField.ApplyCurrentValues(currentValues);

			paramField = Report.DataDefinition.ParameterFields["PrintedBy"];
			discreteParam = new ParameterDiscreteValue();
			discreteParam.Value = Session["Name"].ToString();
			currentValues = new ParameterValues();
			currentValues.Add(discreteParam);
			paramField.ApplyCurrentValues(currentValues);


            paramField = Report.DataDefinition.ParameterFields["SupplierName"];
            discreteParam = new ParameterDiscreteValue();
            discreteParam.Value = cboSupplier.SelectedItem.Text;
            currentValues = new ParameterValues();
            currentValues.Add(discreteParam);
            paramField.ApplyCurrentValues(currentValues);

            paramField = Report.DataDefinition.ParameterFields["AnalysisStartDate"];
            discreteParam = new ParameterDiscreteValue();
            discreteParam.Value = Convert.ToDateTime(txtStartTransactionDate.Text + " " + txtStartTime.Text).ToString("yyyy-MM-dd HH:mm");
            currentValues = new ParameterValues();
            currentValues.Add(discreteParam);
            paramField.ApplyCurrentValues(currentValues);

            paramField = Report.DataDefinition.ParameterFields["AnalysisEndDate"];
            discreteParam = new ParameterDiscreteValue();
            discreteParam.Value = Convert.ToDateTime(txtEndTransactionDate.Text + " " + txtEndTime.Text).ToString("yyyy-MM-dd HH:mm");
            currentValues = new ParameterValues();
            currentValues.Add(discreteParam);
            paramField.ApplyCurrentValues(currentValues);

            paramField = Report.DataDefinition.ParameterFields["ProductGroupName"];
            discreteParam = new ParameterDiscreteValue();
            discreteParam.Value = cboGroup.SelectedItem.Text;
            currentValues = new ParameterValues();
            currentValues.Add(discreteParam);
            paramField.ApplyCurrentValues(currentValues);

            paramField = Report.DataDefinition.ParameterFields["ProductSubGroupName"];
            discreteParam = new ParameterDiscreteValue();
            discreteParam.Value = cboSubGroup.SelectedItem.Text;
            currentValues = new ParameterValues();
            currentValues.Add(discreteParam);
            paramField.ApplyCurrentValues(currentValues);
		}

		#endregion

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		///		Required method for Designer support - do not modify
		///		the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{

		}
		#endregion

        #region Web Control Methods
        
        protected void cmdView_Click(object sender, System.EventArgs e)
		{
            //fraViewer.Visible = true;

			switch (Convert.ToInt16(cboReportOptions.SelectedItem.Value))
			{
				case 0:
					GenerateHTML();
					break;
				case 1:
					GeneratePDF();
					break;
				case 2:
					GenerateWord();
					break;
				case 3:
					GenerateExcel();
					break;
			}
		}
        protected void cboGroup_SelectedIndexChanged(object sender, EventArgs e)
        {
            ProductSubGroupDetails clsSearchKeys = new ProductSubGroupDetails();
            clsSearchKeys.ProductGroupID = long.Parse(cboGroup.SelectedItem.Value);

            ProductSubGroupColumns clsProductSubGroupColumns = new ProductSubGroupColumns() { ColumnsNameID = true };

            ProductSubGroup clsProductSubGroup = new ProductSubGroup();
            cboSubGroup.DataTextField = "ProductSubGroupName";
            cboSubGroup.DataValueField = "ProductSubGroupID";
            cboSubGroup.DataSource = clsProductSubGroup.ListAsDataTable(clsProductSubGroupColumns, clsSearchKeys, SortField: "ProductSubGroupName", SortOrder: System.Data.SqlClient.SortOrder.Ascending);
            cboSubGroup.DataBind();
            cboSubGroup.Items.Insert(0, new ListItem(Constants.ALL,Constants.ZERO_STRING));
            cboSubGroup.SelectedIndex = 0;
            clsProductSubGroup.CommitAndDispose();
        }
        protected void imgBack_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            Response.Redirect(lblReferrer.Text);
        }
        protected void cmdBack_Click(object sender, EventArgs e)
        {
            Response.Redirect(lblReferrer.Text);
        }

        #endregion
    }
}
