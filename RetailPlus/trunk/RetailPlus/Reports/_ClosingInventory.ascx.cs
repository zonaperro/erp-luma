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

	public partial  class __ClosingInventory : System.Web.UI.UserControl
	{

		protected void Page_Load(object sender, System.EventArgs e)
		{
            if (!IsPostBack && Visible)
			{
				lblReferrer.Text = Request.UrlReferrer.ToString();
				LoadOptions();
                Session["ReportDocument"] = null;
            }
        }

        protected void Page_Init(object sender, System.EventArgs e)
        {
            if (Session["ReportDocument"] != null)
            {
                CRViewer.ReportSource = (ReportDocument)Session["ReportDocument"];
            }
        }

		private void LoadOptions()
		{
            txtStartTransactionDate.Text = DateTime.Now.AddDays(-30).ToString("yyyy-MM-dd");
            txtEndTransactionDate.Text = DateTime.Now.ToString("yyyy-MM-dd");

            ProductGroup clsProductGroup = new ProductGroup();
            cboGroup.DataTextField = "ProductGroupName";
            cboGroup.DataValueField = "ProductGroupID";
            cboGroup.DataSource = clsProductGroup.ListAsDataTable("ProductGroupName", SortOption.Ascending);
            cboGroup.DataBind();
            cboGroup.Items.Insert(0, new ListItem(Constants.ALL,Constants.ZERO_STRING));
            cboGroup.SelectedIndex = 0;

            ProductSubGroupColumns clsProductSubGroupColumns = new ProductSubGroupColumns();
            clsProductSubGroupColumns.ProductSubGroupName = true;

            ProductSubGroupDetails clsSearchKey = new ProductSubGroupDetails();

            ProductSubGroup clsSubGroup = new ProductSubGroup(clsProductGroup.Connection, clsProductGroup.Transaction);
            cboSubGroup.DataTextField = "ProductSubGroupName";
            cboSubGroup.DataValueField = "ProductSubGroupID";
            cboSubGroup.DataSource = clsSubGroup.ListAsDataTable(clsProductSubGroupColumns, clsSearchKey, 0, System.Data.SqlClient.SortOrder.Ascending, 0, ProductSubGroupColumnNames.ProductSubGroupName, System.Data.SqlClient.SortOrder.Ascending);
            cboSubGroup.DataBind();
            cboSubGroup.Items.Insert(0, new ListItem(Constants.ALL,Constants.ZERO_STRING));
            cboSubGroup.SelectedIndex = 0;

            Data.Inventory clsInventory = new Data.Inventory(clsProductGroup.Connection, clsProductGroup.Transaction);
            cboInventoryNo.DataTextField = "ReferenceNo";
            cboInventoryNo.DataValueField = "PostingDate";
            cboInventoryNo.DataSource = clsInventory.ClosingInventoryReferenceNos(Convert.ToDateTime(txtStartTransactionDate.Text), Convert.ToDateTime(txtEndTransactionDate.Text));
            cboInventoryNo.DataBind();
            if (cboInventoryNo.Items.Count == 0) cboInventoryNo.Items.Add(new ListItem(string.Empty, DateTime.MinValue.ToString("yyyy-MM-dd")));
            cboInventoryNo.SelectedIndex = cboInventoryNo.Items.Count - 1;

            clsProductGroup.CommitAndDispose();
		}

        #region Export

        private void Export(ExportFormatType pvtExportFormatType)
        {
            ReportDocument rpt = new ReportDocument();
            rpt.Load(Server.MapPath(Constants.ROOT_DIRECTORY + "/Reports/_ClosingInventory.rpt"));

            SetDataSource(rpt);

            ExportOptions exportop = new ExportOptions();
            DiskFileDestinationOptions dest = new DiskFileDestinationOptions();
            string strPath = Server.MapPath(@"\retailplus\temp\");
            string strFileExtensionName = ".pdf";
            switch (pvtExportFormatType)
            {
                case ExportFormatType.PortableDocFormat: strFileExtensionName = ".pdf"; exportop.ExportFormatType = ExportFormatType.PortableDocFormat; break;
                case ExportFormatType.WordForWindows: strFileExtensionName = ".doc"; exportop.ExportFormatType = ExportFormatType.WordForWindows; break;
                case ExportFormatType.Excel: strFileExtensionName = ".xls"; exportop.ExportFormatType = ExportFormatType.Excel; break;
            }
            string strFileName = "inventoryanalyst_" + Session["UserName"].ToString() + "_" + DateTime.Now.ToString("yyyyMMddhhmmssff") + strFileExtensionName;
            if (System.IO.File.Exists(strPath + strFileName))
                System.IO.File.Delete(strPath + strFileName);

            dest.DiskFileName = strPath + strFileName;
            exportop.DestinationOptions = dest;
            exportop.ExportDestinationType = ExportDestinationType.DiskFile;
            rpt.Export(exportop); //rpt.Close(); rpt.Dispose();

            if (pvtExportFormatType == ExportFormatType.PortableDocFormat)
            {
                rpt.Close(); rpt.Dispose();
                Response.Redirect(Constants.ROOT_DIRECTORY + "/temp/" + strFileName, false);
            }
            else
            {
                CRViewer.ReportSource = rpt;
                Session["ReportDocument"] = rpt;
                CRSHelper.OpenExportedReport(strFileName); // OpenExportedReport(strFileName);
            }

        }

        private void OpenExportedReport(string FileName)
        {
            try
            {
                System.Net.WebClient Client = new System.Net.WebClient();
                Client.DownloadFile(Server.MapPath(Constants.ROOT_DIRECTORY + "/temp/" + FileName), @"c:\" + FileName);

                System.Diagnostics.Process p = new System.Diagnostics.Process();
                p.StartInfo.FileName = @"c:\" + FileName; //Server.MapPath(Constants.ROOT_DIRECTORY + "/temp/" + FileName);
                p.StartInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Normal;
                p.Start();
            }
            catch (Exception ex) { throw ex; }
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

        private void GenerateHTML()
        {
            ReportDocument rpt = new ReportDocument();
            rpt.Load(Server.MapPath(Constants.ROOT_DIRECTORY + "/Reports/_ClosingInventory.rpt"));
            SetDataSource(rpt);
            CRViewer.ReportSource = rpt;
            Session["ReportDocument"] = rpt;
        }

        #endregion

		#region SetDataSource

		private void SetDataSource(ReportDocument Report)
		{
            ReportDataset rptds = new ReportDataset();

            string ProductGroupName = string.Empty;
            if (cboGroup.SelectedItem.Value != Constants.ZERO_STRING) ProductGroupName = cboGroup.SelectedItem.Text;
            string SubGroupName = string.Empty;
            if (cboSubGroup.SelectedItem.Value != Constants.ZERO_STRING) SubGroupName = cboSubGroup.SelectedItem.Text;

			Data.Inventory clsInventory = new Data.Inventory();
            System.Data.DataTable dt = clsInventory.DataList(cboInventoryNo.SelectedItem.Text, chkIncludeShortOverProducts.Checked, long.Parse(cboGroup.SelectedItem.Value), long.Parse(cboSubGroup.SelectedItem.Value), string.Empty, SortOption.Ascending);
            clsInventory.CommitAndDispose();

            foreach (System.Data.DataRow dr in dt.Rows)
            {
                DataRow drInventory = rptds.Inventory.NewRow();

                foreach (DataColumn dc in rptds.Inventory.Columns)
                    drInventory[dc] = dr[dc.ColumnName];

                rptds.Inventory.Rows.Add(drInventory);
            }

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

            paramField = Report.DataDefinition.ParameterFields["ClosingInventoryID"];
            discreteParam = new ParameterDiscreteValue();
            discreteParam.Value = cboInventoryNo.SelectedItem.Text;
            currentValues = new ParameterValues();
            currentValues.Add(discreteParam);
            paramField.ApplyCurrentValues(currentValues);

            paramField = Report.DataDefinition.ParameterFields["PostingDate"];
            discreteParam = new ParameterDiscreteValue();
            discreteParam.Value = Convert.ToDateTime(cboInventoryNo.SelectedItem.Value).ToString("yyyy-MM-dd");
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
            ProductSubGroupColumns clsProductSubGroupColumns = new ProductSubGroupColumns();
            clsProductSubGroupColumns.ProductSubGroupCode = true;
            clsProductSubGroupColumns.ProductSubGroupName = true;

            ProductSubGroupDetails clsSearchKeys = new ProductSubGroupDetails();
            clsSearchKeys.ProductGroupID = long.Parse(cboGroup.SelectedItem.Value);

            ProductSubGroup clsSubGroup = new ProductSubGroup();
            cboSubGroup.DataTextField = "ProductSubGroupName";
            cboSubGroup.DataValueField = "ProductSubGroupID";
            cboSubGroup.DataSource = clsSubGroup.ListAsDataTable(clsProductSubGroupColumns, clsSearchKeys, 0, System.Data.SqlClient.SortOrder.Ascending, 0, ProductSubGroupColumnNames.ProductSubGroupName, System.Data.SqlClient.SortOrder.Ascending);
            cboSubGroup.DataBind();
            cboSubGroup.Items.Insert(0, new ListItem(Constants.ALL,Constants.ZERO_STRING));
            cboSubGroup.SelectedIndex = 0;
            clsSubGroup.CommitAndDispose();
        }
        protected void imgBack_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            Response.Redirect(lblReferrer.Text);
        }
        protected void cmdBack_Click(object sender, EventArgs e)
        {
            Response.Redirect(lblReferrer.Text);
        }

        protected void cmdSearch_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            
        }

        #endregion
    }
}
