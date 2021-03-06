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

	public partial  class __ProductHistoryReport : System.Web.UI.UserControl
	{

		protected void Page_Load(object sender, System.EventArgs e)
		{
            if (!IsPostBack && Visible)
			{
				lblReferrer.Text = Request.UrlReferrer == null ? Constants.ROOT_DIRECTORY : Request.UrlReferrer.ToString();
				LoadOptions();
                Session["ReportDocument"] = null;
                Session["ReportType"] = "prodhistory";
			}
		}

        protected void Page_Init(object sender, System.EventArgs e)
        {
            if (Session["ReportDocument"] != null && Session["ReportType"] != null)
            {
                if (Session["ReportType"].ToString() == "prodhistory")
                    CRViewer.ReportSource = (ReportDocument) Session["ReportDocument"];
            }
        }

		private void LoadOptions()
		{
            Int64 UID = Convert.ToInt64(Session["UID"]);
            Security.AccessRights clsAccessRights = new Security.AccessRights();

            cboReportType.Items.Clear();
            cboReportType.Items.Add(new ListItem(ReportTypes.REPORT_SELECTION, ReportTypes.REPORT_SELECTION));
            cboReportType.Items.Add(new ListItem(ReportTypes.REPORT_SELECTION_SEPARATOR, ReportTypes.REPORT_SELECTION_SEPARATOR));
            cboReportType.Items.Add(new ListItem(ReportTypes.ProductHistoryMovement, ReportTypes.ProductHistoryMovement));

            if (clsAccessRights.Details(UID, (int)AccessTypes.PricesReport).Read)
                cboReportType.Items.Add(new ListItem(ReportTypes.ProductHistoryPrice, ReportTypes.ProductHistoryPrice));

            cboReportType.Items.Add(new ListItem(ReportTypes.REPORT_SELECTION_SEPARATOR, ReportTypes.REPORT_SELECTION_SEPARATOR));
            if (clsAccessRights.Details(UID, (int)AccessTypes.MostSalableItemsReport).Read)
                cboReportType.Items.Add(new ListItem(ReportTypes.ProductHistoryMostSaleable, ReportTypes.ProductHistoryMostSaleable));

            if (clsAccessRights.Details(UID, (int)AccessTypes.LeastSalableItemsReport).Read)
                cboReportType.Items.Add(new ListItem(ReportTypes.ProductHistoryLeastSaleable, ReportTypes.ProductHistoryLeastSaleable));

            clsAccessRights.CommitAndDispose();

            cboReportType.SelectedIndex = 0;
            try
            {
                if (Common.Decrypt(Request.QueryString["task"].ToString().ToLower(), Session.SessionID) == "producthistory")
                {
                    cboReportType.SelectedIndex = cboReportType.Items.IndexOf(cboReportType.Items.FindByValue(ReportTypes.ProductHistoryMovement));
                    cboReportType_SelectedIndexChanged(null, null);
                }
            }
            catch {}
            try
            {
                if (Common.Decrypt(Request.QueryString["task"].ToString().ToLower(), Session.SessionID) == "pricehistory")
                {
                    cboReportType.SelectedIndex = cboReportType.Items.IndexOf(cboReportType.Items.FindByValue(ReportTypes.ProductHistoryPrice));
                    cboReportType_SelectedIndexChanged(null, null);
                }
            }
            catch { }

			txtStartDate.Text = DateTime.Now.AddDays(-30).ToString("yyyy-MM-dd");
			txtEndDate.Text = DateTime.Now.ToString("yyyy-MM-dd");

            string strProductCode = string.Empty;
            try
            {
                try
                {
                    if (Request.QueryString["sender"].ToString().ToLower() == "direct" && Request.QueryString["productcode"].ToString() != null)
                        strProductCode = Server.UrlDecode(Request.QueryString["productcode"].ToString());
                }
                catch { strProductCode = Server.UrlDecode(Common.Decrypt(Request.QueryString["productcode"].ToString(), Session.SessionID)); }
                lblReferrer.ToolTip = strProductCode;
            }
            catch { strProductCode = lblReferrer.ToolTip; }

            txtProductCode.Text = strProductCode;

			Data.Products clsProduct = new Data.Products();
			cboProductCode.DataTextField = "ProductCode";
			cboProductCode.DataValueField = "ProductID";
            cboProductCode.DataSource = clsProduct.ProductIDandCodeDataTable(SearchKey: txtProductCode.Text, limit: 100);
            cboProductCode.DataBind();

            Branch clsBranch = new Branch(clsProduct.Connection, clsProduct.Transaction);
            cboBranch.DataTextField = "BranchCode";
            cboBranch.DataValueField = "BranchID";
            cboBranch.DataSource = clsBranch.ListAsDataTable().DefaultView;
            cboBranch.DataBind();
            cboBranch.Items.Insert(0, new ListItem(Constants.ALL, Constants.ZERO_STRING));
            cboBranch.SelectedIndex = 0;

			clsProduct.CommitAndDispose();
			
			if (cboProductCode.Items.Count == 0)
				cboProductCode.Items.Add(new ListItem("No product", "0"));

			cboProductCode.SelectedIndex = 0;
            cboProductCode_SelectedIndexChanged(null, null);
            try
            {
                if (strProductCode != string.Empty && cboProductCode.SelectedItem.Value != "0")
                {
                    if (!string.IsNullOrEmpty(Request.QueryString["reptype"]))
                        GeneratePDF();
                    else 
                        GenerateHTML();
                }
            }
            catch { }
		}

        private ReportDocument getReportDocument()
        {
            ReportDocument rpt = new ReportDocument();

            switch (cboReportType.SelectedValue)
            {
                case ReportTypes.ProductHistoryMovement:
                    rpt.Load(Server.MapPath(Constants.ROOT_DIRECTORY + "/Reports/_productshistory/_producthistoryreportmovement.rpt"));
                    break;
                case ReportTypes.ProductHistoryPrice:
                    rpt.Load(Server.MapPath(Constants.ROOT_DIRECTORY + "/Reports/_productshistory/_producthistoryreportprice.rpt"));
                    break;
                case ReportTypes.ProductHistoryMostSaleable:
                    rpt.Load(Server.MapPath(Constants.ROOT_DIRECTORY + "/Reports/_productshistory/_MostSalableItemsReportGrouped.rpt"));
                    break;
                    //bool boIsGrouped = false;
                    //if (boIsGrouped)
                    //    rpt.Load(Server.MapPath(Constants.ROOT_DIRECTORY + "/Reports/_productshistory/_MostSalableItemsReportGrouped.rpt"));
                    //else
                    //    rpt.Load(Server.MapPath(Constants.ROOT_DIRECTORY + "/Reports/_productshistory/_MostSalableItemsReport.rpt"));
                    //break;
                case ReportTypes.ProductHistoryLeastSaleable:
                    rpt.Load(Server.MapPath(Constants.ROOT_DIRECTORY + "/Reports/_productshistory/_LeastSalableItemsReportGrouped.rpt"));
                    break;
                default:
                    return null;
            }

            return rpt;
        }

        #region Export

        private void Export(ExportFormatType pvtExportFormatType)
        {
            ReportDocument rpt = getReportDocument();

            SetDataSource(rpt);

            if (pvtExportFormatType == ExportFormatType.WordForWindows || pvtExportFormatType == ExportFormatType.Excel || pvtExportFormatType == ExportFormatType.PortableDocFormat)
            {
                string strFileName = Session["UserName"].ToString() + "_prodhistory";
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

            Int64 intProductID = 0;
            if (cboProductCode.Items.Count > 0) intProductID = Int64.Parse(cboProductCode.SelectedItem.Value);
            Int64 intMatrixID = 0;
            if (cboVariation.Items.Count > 0) intMatrixID = Int64.Parse(cboVariation.SelectedItem.Value);

			DateTime DateFrom = DateTime.MinValue;
            DateFrom = DateTime.TryParse(txtStartDate.Text + " " + txtStartTime.Text, out DateFrom) ? DateFrom : DateTime.MinValue;

			DateTime DateTo = DateTime.MinValue;
            DateTo = DateTime.TryParse(txtEndDate.Text + " " + txtEndTime.Text, out DateTo) ? DateTo : DateTime.MinValue;

            Int32 intLimit = 0;
            intLimit = Int32.TryParse(txtLimit.Text, out intLimit) ? intLimit : 0;
            
            Int32 intBranchID = 0;
            intBranchID = Int32.TryParse(cboBranch.SelectedItem.Value, out intBranchID) ? intBranchID : 0;

            switch (cboReportType.SelectedValue)
            {
                case ReportTypes.ProductHistoryMovement:
                    #region Product History Movement
                    StockItem clsStockItem = new StockItem();
                    System.Data.DataTable dtProductHistoryMovement = clsStockItem.ProductMovementReport(intProductID, intMatrixID, DateFrom, DateTo, intBranchID);
                    clsStockItem.CommitAndDispose();
                    foreach (DataRow dr in dtProductHistoryMovement.Rows)
                    {
                        DataRow drNew = rptds.ProductMovement.NewRow();

                        foreach (DataColumn dc in rptds.ProductMovement.Columns)
                            drNew[dc] = dr[dc.ColumnName];

                        rptds.ProductMovement.Rows.Add(drNew);
                    }
                    break;
                    #endregion
                case ReportTypes.ProductHistoryPrice:
                    #region Product price history
                    ProductPackagePriceHistory clsProductPackagePriceHistory = new ProductPackagePriceHistory();
                    clsProductPackagePriceHistory.GetConnection();
                    System.Data.DataTable dtProductList = clsProductPackagePriceHistory.List(DateFrom, DateTo, intProductID);
                    clsProductPackagePriceHistory.CommitAndDispose();

                    foreach (DataRow dr in dtProductList.Rows)
                    {
                        DataRow drNew = rptds.ProductPriceHistory.NewRow();

                        foreach (DataColumn dc in rptds.ProductPriceHistory.Columns)
                            drNew[dc] = dr[dc.ColumnName];

                        rptds.ProductPriceHistory.Rows.Add(drNew);
                    }
                    break;
                    #endregion
                case ReportTypes.ProductHistoryMostSaleable:
                    #region Most Saleable
                    SalesTransactionItems clsSalesTransactionItemsMost = new SalesTransactionItems();
                    System.Data.DataTable dtMostSaleable = clsSalesTransactionItemsMost.MostSalableItems(DateFrom, DateTo, intLimit);
                    clsSalesTransactionItemsMost.CommitAndDispose();
                    foreach (DataRow dr in dtMostSaleable.Rows)
                    {
                        DataRow drNew = rptds.MostSalableItems.NewRow();

                        foreach (DataColumn dc in rptds.MostSalableItems.Columns)
                            drNew[dc] = dr[dc.ColumnName];

                        rptds.MostSalableItems.Rows.Add(drNew);
                    }
                    break;
                    #endregion
                case ReportTypes.ProductHistoryLeastSaleable:
                    #region Least Saleable
                    SalesTransactionItems clsSalesTransactionItemsLeast = new SalesTransactionItems();
                    System.Data.DataTable dtLeastSaleable = clsSalesTransactionItemsLeast.LeastSalableItems(DateFrom, DateTo, intLimit);
                    clsSalesTransactionItemsLeast.CommitAndDispose();
                    foreach (DataRow dr in dtLeastSaleable.Rows)
                    {
                        DataRow drNew = rptds.LeastSalableItems.NewRow();

                        foreach (DataColumn dc in rptds.LeastSalableItems.Columns)
                            drNew[dc] = dr[dc.ColumnName];

                        rptds.LeastSalableItems.Rows.Add(drNew);
                    }
                    break;
                    #endregion
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

            DateTime StartTransactionDate = DateTime.MinValue;
            try
            { StartTransactionDate = Convert.ToDateTime(txtStartDate.Text + " " + txtStartTime.Text); }
            catch { }
            paramField = Report.DataDefinition.ParameterFields["StartTransactionDate"];
            discreteParam = new ParameterDiscreteValue();
            discreteParam.Value = StartTransactionDate;
            currentValues = new ParameterValues();
            currentValues.Add(discreteParam);
            paramField.ApplyCurrentValues(currentValues);

            DateTime EndTransactionDate = DateTime.MinValue;
            try
            { EndTransactionDate = Convert.ToDateTime(txtEndDate.Text + " " + txtEndTime.Text); }
            catch { }
            paramField = Report.DataDefinition.ParameterFields["EndTransactionDate"];
            discreteParam = new ParameterDiscreteValue();
            discreteParam.Value = EndTransactionDate;
            currentValues = new ParameterValues();
            currentValues.Add(discreteParam);
            paramField.ApplyCurrentValues(currentValues);

            switch (cboReportType.SelectedValue)
            {
                case ReportTypes.ProductHistoryMovement:
                    #region Product History Movement
                    Products clsProduct = new Products();
                    long lngMatrixID = Convert.ToInt64(cboVariation.SelectedItem.Value);
                    lngMatrixID = lngMatrixID == -1 ? 0 : lngMatrixID;
                    ProductDetails clsDetails = clsProduct.Details(Convert.ToInt64(cboProductCode.SelectedItem.Value), lngMatrixID, Constants.BRANCH_ID_MAIN);
                    clsProduct.CommitAndDispose();

                    paramField = Report.DataDefinition.ParameterFields["ProductCode"];
                    discreteParam = new ParameterDiscreteValue();
                    discreteParam.Value = clsDetails.ProductCode;
                    currentValues = new ParameterValues();
                    currentValues.Add(discreteParam);
                    paramField.ApplyCurrentValues(currentValues);

                    paramField = Report.DataDefinition.ParameterFields["Description"];
                    discreteParam = new ParameterDiscreteValue();
                    discreteParam.Value = clsDetails.ProductDesc;
                    currentValues = new ParameterValues();
                    currentValues.Add(discreteParam);
                    paramField.ApplyCurrentValues(currentValues);

                    paramField = Report.DataDefinition.ParameterFields["Quantity"];
                    discreteParam = new ParameterDiscreteValue();
                    discreteParam.Value = clsDetails.Quantity.ToString("#,###.#0");
                    currentValues = new ParameterValues();
                    currentValues.Add(discreteParam);
                    paramField.ApplyCurrentValues(currentValues);

                    paramField = Report.DataDefinition.ParameterFields["UnitCode"];
                    discreteParam = new ParameterDiscreteValue();
                    discreteParam.Value = clsDetails.BaseUnitCode;
                    currentValues = new ParameterValues();
                    currentValues.Add(discreteParam);
                    paramField.ApplyCurrentValues(currentValues);

                    paramField = Report.DataDefinition.ParameterFields["ConvertedQuantity"];
                    discreteParam = new ParameterDiscreteValue();
                    discreteParam.Value = clsDetails.ConvertedQuantity;
                    currentValues = new ParameterValues();
                    currentValues.Add(discreteParam);
                    paramField.ApplyCurrentValues(currentValues);
                    break;
                    #endregion
                case ReportTypes.ProductHistoryMostSaleable:
                case ReportTypes.ProductHistoryLeastSaleable:
                    paramField = Report.DataDefinition.ParameterFields["GroupItems"];
			        discreteParam = new ParameterDiscreteValue();
			        discreteParam.Value = chkGroupItems.Checked;
			        currentValues = new ParameterValues();
			        currentValues.Add(discreteParam);
			        paramField.ApplyCurrentValues(currentValues);
                    break;
                case ReportTypes.ProductsInDemoReport:
                    break;
            }
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
		private void InitializeComponent()
		{

		}

		#endregion

        #region Web Control Methods

        protected void cmdView_Click(object sender, System.EventArgs e)
		{
			if (cboProductCode.SelectedItem.Value == "0")
			{
				string stScript = "<Script>";
				stScript += "window.alert('Please select at least one record to print.')";
				stScript += "</Script>";
				Response.Write(stScript);	
			}
			else 
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
		}
        protected void cmdProductCode_Click(object sender, System.Web.UI.ImageClickEventArgs e)
		{
			DataClass clsDataClass = new DataClass();

			Data.Products clsProduct = new Data.Products();
			cboProductCode.DataTextField = "ProductCode";
			cboProductCode.DataValueField = "ProductID";
            cboProductCode.DataSource = clsProduct.ProductIDandCodeDataTable(SearchKey: txtProductCode.Text, limit: 100);
			cboProductCode.DataBind();
			
            clsProduct.CommitAndDispose();
			
			if (cboProductCode.Items.Count == 0) cboProductCode.Items.Add(new ListItem("No product", "0"));
			cboProductCode.SelectedIndex = 0;
            cboProductCode_SelectedIndexChanged(null, null);
		}
        protected void cboProductCode_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                if (cboProductCode.SelectedItem.Text == "No product")
                {
                    imgProductHistory.Visible = false;
                    imgProductPriceHistory.Visible = false;
                    imgInventoryAdjustment.Visible = false;
                    imgEditNow.Visible = false;

                    cboVariation.Items.Clear();
                    cboVariation.Items.Insert(0, new ListItem("No Product", "0"));
                    cboVariation.SelectedIndex = 0;
                }
                else
                {
                    imgProductHistory.Visible = true;
                    imgProductPriceHistory.Visible = true;
                    imgInventoryAdjustment.Visible = true;
                    imgEditNow.Visible = true;
                    txtProductCode.Text = cboProductCode.SelectedItem.Text;

                    Int64 ProductID = Int64.Parse(cboProductCode.SelectedItem.Value);

                    ProductVariationsMatrix clsProductVariationsMatrix = new ProductVariationsMatrix();
                    cboVariation.DataTextField = "MatrixDescription";
                    cboVariation.DataValueField = "MatrixID";
                    cboVariation.DataSource = clsProductVariationsMatrix.BaseListSimpleAsDataTable(ProductID, SortField: "VariationDesc").DefaultView;
                    cboVariation.DataBind();

                    cboVariation.Items.Insert(0, new ListItem("Main Product", "0"));
                    cboVariation.Items.Insert(0, new ListItem(Constants.ALL, "-1"));
                    cboVariation.SelectedIndex = 0;
                }
            }
            catch { }
        }
        protected void imgBack_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            Response.Redirect(lblReferrer.Text);
        }
        protected void cmdBack_Click(object sender, EventArgs e)
        {
            Response.Redirect(lblReferrer.Text);
        }

        protected void imgProductHistory_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            string stParam = "?task=" + Common.Encrypt("producthistory", Session.SessionID) +
                        "&productcode=" + Common.Encrypt(cboProductCode.SelectedItem.Text, Session.SessionID);
            Response.Redirect(Constants.ROOT_DIRECTORY + "/Reports/Default.aspx" + stParam);
        }
        protected void imgProductPriceHistory_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            string stParam = "?task=" + Common.Encrypt("pricehistory", Session.SessionID) +
                                "&productcode=" + Common.Encrypt(cboProductCode.SelectedItem.Text, Session.SessionID);
            Response.Redirect(Constants.ROOT_DIRECTORY + "/Reports/Default.aspx" + stParam);
        }
        protected void imgInventoryAdjustment_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            string stParam = "?task=" + Common.Encrypt("invadjustment", Session.SessionID) +
                        "&productcode=" + Common.Encrypt(cboProductCode.SelectedItem.Text, Session.SessionID);
            Response.Redirect(Constants.ROOT_DIRECTORY + "/Inventory/Default.aspx" + stParam);
        }
        protected void imgEditNow_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            string stParam = "?task=" + Common.Encrypt("edit", Session.SessionID) +
                                "&id=" + Common.Encrypt(cboProductCode.SelectedItem.Value, Session.SessionID);
            Response.Redirect(Constants.ROOT_DIRECTORY + "/MasterFiles/_Product/Default.aspx" + stParam);
        }

        protected void cboReportType_SelectedIndexChanged(object sender, EventArgs e)
        {
            holderBranch.Visible = false;
            holderProductCode.Visible = false;
            holderMostSaleable.Visible = false;
            switch (cboReportType.SelectedValue)
            {
                case ReportTypes.ProductHistoryMovement:
                case ReportTypes.ProductHistoryPrice:
                    holderBranch.Visible = true;
                    holderProductCode.Visible = true;
                    break;
                case ReportTypes.ProductHistoryMostSaleable:
                case ReportTypes.ProductHistoryLeastSaleable:
                    holderMostSaleable.Visible = true;
                    break;
                case ReportTypes.ProductsInDemoReport:
                    holderProductCode.Visible = true;
                    break;
            }
        }

        #endregion

    }
}
