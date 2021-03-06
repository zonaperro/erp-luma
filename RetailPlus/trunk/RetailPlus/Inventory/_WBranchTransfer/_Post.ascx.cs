namespace AceSoft.RetailPlus.Inventory._WBranchTransfer
{
	using System;
	using System.Data;
	using System.Drawing;
	using System.Web;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;
	using AceSoft.RetailPlus.Data;
    using System.IO;
    using System.Xml;
    using AceSoft.RetailPlus.Security;

	public partial  class __Post : System.Web.UI.UserControl
	{
		
		#region Web Form Methods

		protected void Page_Load(object sender, System.EventArgs e)
		{
			if (!IsPostBack)
			{
				lblReferrer.Text = Request.UrlReferrer == null ? Constants.ROOT_DIRECTORY : Request.UrlReferrer.ToString();
				if (Visible)
				{
					LoadOptions();	
					LoadRecord();	
					LoadItems();
					cmdDelete.Attributes.Add("onClick", "return confirm_delete();");
					imgDelete.Attributes.Add("onClick", "return confirm_delete();");
                    //cmdEdit.Attributes.Add("onClick", "return confirm_select();");
                    //imgEdit.Attributes.Add("onClick", "return confirm_select();");

                    // 03Jun2015 : This should be after the loadrecord to determine the status of the record
                    ManageSecurity();
				}
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

		protected void imgSave_Click(object sender, System.Web.UI.ImageClickEventArgs e)
		{
            if (cboProductCode.SelectedItem.Value.ToString() != "0") //|| cboProductCode.SelectedItem.Value.ToString() != null)
            {
				SaveRecord();
				LoadItems();
                LoadOptions();
			}
		}
		protected void cmdSave_Click(object sender, System.EventArgs e)
		{
			if (cboProductCode.SelectedItem.Value.ToString() != "0") //|| cboProductCode.SelectedItem.Value.ToString() != null)
			{
				SaveRecord();
				LoadItems();
                LoadOptions();
			}
		}
		protected void imgCancel_Click(object sender, System.Web.UI.ImageClickEventArgs e)
		{
			Response.Redirect("Default.aspx?task=" + Common.Encrypt("list",Session.SessionID));
		}
		protected void cmdCancel_Click(object sender, System.EventArgs e)
		{
			Response.Redirect("Default.aspx?task=" + Common.Encrypt("list",Session.SessionID));
		}
		protected void imgDelete_Click(object sender, System.Web.UI.ImageClickEventArgs e)
		{
			if (DeleteItems())
				LoadItems();
		}
		protected void cmdDelete_Click(object sender, System.EventArgs e)
		{
			if (DeleteItems())
				LoadItems();
		}
		protected void imgEdit_Click(object sender, System.Web.UI.ImageClickEventArgs e)
		{
			UpdateItem();
		}
		protected void cmdEdit_Click(object sender, System.EventArgs e)
		{
			UpdateItem();
		}
		protected void imgClear_Click(object sender, System.Web.UI.ImageClickEventArgs e)
		{
			LoadOptions();
		}
		protected void cmdClear_Click(object sender, System.EventArgs e)
		{
			LoadOptions();
		}
        protected void imgGRN_Click(object sender, System.Web.UI.ImageClickEventArgs e)
		{
			IssueGRN();
		}
		protected void cmdGRN_Click(object sender, System.EventArgs e)
		{
			IssueGRN();
		}
        protected void imgSubmitForApproval_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            SubmitForApproval();
        }
        protected void cmdSubmitForApproval_Click(object sender, System.EventArgs e)
        {
            SubmitForApproval();
        }

		protected void cboProductCode_SelectedIndexChanged(object sender, System.EventArgs e)
		{
            if (cboProductCode.Items.Count == 0)
                return;

            if (cboProductCode.Items.Count == 1 && cboProductCode.SelectedValue == Constants.ZERO_STRING)
                return;

            DataClass clsDataClass = new DataClass();
            long ProductID = Convert.ToInt64(cboProductCode.SelectedItem.Value);

            ProductVariationsMatrix clsProductVariationsMatrix = new ProductVariationsMatrix();
            cboVariation.DataTextField = "MatrixDescription";
            cboVariation.DataValueField = "MatrixID";
            cboVariation.DataSource = clsProductVariationsMatrix.BaseListSimpleAsDataTable(ProductID, SortField: "VariationDesc").DefaultView;
            cboVariation.DataBind();

            if (cboVariation.Items.Count == 0)
            { cboVariation.Items.Add(new ListItem("No Variation", "0")); }
            cboVariation.SelectedIndex = cboVariation.Items.Count - 1;

            ProductUnitsMatrix clsUnitMatrix = new ProductUnitsMatrix(clsProductVariationsMatrix.Connection, clsProductVariationsMatrix.Transaction);

            cboProductUnit.DataTextField = "BottomUnitCode";
            cboProductUnit.DataValueField = "BottomUnitID";
            cboProductUnit.DataSource = clsUnitMatrix.ListAsDataTable(ProductID, "a.MatrixID", SortOption.Ascending).DefaultView;
            cboProductUnit.DataBind();

            Products clsProduct = new Products(clsProductVariationsMatrix.Connection, clsProductVariationsMatrix.Transaction);
            ProductDetails clsDetails = clsProduct.Details(ProductID);
            ProductPurchasePriceHistory clsProductPurchasePriceHistory = new ProductPurchasePriceHistory(clsProductVariationsMatrix.Connection, clsProductVariationsMatrix.Transaction);
            System.Data.DataTable dtProductPurchasePriceHistory = clsProductPurchasePriceHistory.ListAsDataTable(ProductID, DateTime.Now.AddMonths(-6), "PurchasePrice", SortOption.Ascending);
            clsProductVariationsMatrix.CommitAndDispose();

            string strPurchasePriceHistory = string.Empty;
            foreach (System.Data.DataRow dr in dtProductPurchasePriceHistory.Rows)
            {
                DateTime dtePurchaseDate = DateTime.Parse(dr["PurchaseDate"].ToString());
                decimal decPurchasePrice = decimal.Parse(dr["PurchasePrice"].ToString());
                long lngSupplierID = long.Parse(dr["SupplierID"].ToString());
                string strSupplierName = "" + dr["SupplierName"].ToString();

                strPurchasePriceHistory += dtePurchaseDate.ToString("ddMMMyyyy HH:mm") + ": " + decPurchasePrice.ToString("#,##0.#0").PadLeft(10) + " " + strSupplierName + "\r\n<br />" + Environment.NewLine;
            }
            lblPurchasePriceHistory.Text = "<br />" + strPurchasePriceHistory;
            cboProductUnit.Items.Insert(0, new ListItem(clsDetails.BaseUnitCode, clsDetails.BaseUnitID.ToString()));
			cboProductUnit.SelectedIndex = cboProductUnit.Items.IndexOf(new ListItem(clsDetails.BaseUnitCode, clsDetails.BaseUnitID.ToString()));

			txtPrice.Text = clsDetails.PurchasePrice.ToString("#####0.#0");
            txtSellingPrice.Text = clsDetails.Price.ToString("#####0.#0");
            txtOldSellingPrice.Text = clsDetails.Price.ToString("#####0.#0");
            decimal decMargin = clsDetails.Price - clsDetails.PurchasePrice;
            try { decMargin = decMargin / clsDetails.PurchasePrice; }
            catch { decMargin = 1; }
            decMargin = decMargin * 100;
            txtMargin.Text = decMargin.ToString("#,##0.##0");
            txtVAT.Text = clsDetails.VAT.ToString("#,##0.#0");
            txtEVAT.Text = clsDetails.EVAT.ToString("#,##0.#0");
            txtLocalTax.Text = clsDetails.LocalTax.ToString("#,##0.#0");

			if (clsDetails.VAT >0)
				chkIsTaxable.Checked = true;
			else
				chkIsTaxable.Checked = false;
			
			ComputeItemAmount();
			cboVariation_SelectedIndexChanged(null, null);

		}
        protected void cboVariation_SelectedIndexChanged(object sender, System.EventArgs e)
		{
			long MatrixID = Convert.ToInt64(cboVariation.SelectedItem.Value);
			if (MatrixID != 0)
			{
				long ProductID = Convert.ToInt64(cboProductCode.SelectedItem.Value);

                Products clsProducts = new Products();
                ProductDetails clsDetails = clsProducts.Details(ProductID: ProductID, MatrixID: MatrixID);
                clsProducts.CommitAndDispose();

				txtPrice.Text = clsDetails.PurchasePrice.ToString("####0.#0");
                txtSellingPrice.Text = clsDetails.Price.ToString("#####0.#0");
                txtOldSellingPrice.Text = clsDetails.Price.ToString("#####0.#0");
                decimal decMargin = clsDetails.Price - clsDetails.PurchasePrice;
                try { decMargin = decMargin / clsDetails.PurchasePrice; }
                catch { decMargin = 1; }
                decMargin = decMargin * 100;
                txtMargin.Text = decMargin.ToString("#,##0.##0");
                txtVAT.Text = clsDetails.VAT.ToString("#,##0.#0");
                txtEVAT.Text = clsDetails.EVAT.ToString("#,##0.#0");
                txtLocalTax.Text = clsDetails.LocalTax.ToString("#,##0.#0");

				if (clsDetails.VAT > 0)
					chkIsTaxable.Checked = true;
				else
					chkIsTaxable.Checked = false;
				
				ComputeItemAmount();
			}
		}
		protected void cmdProductCode_Click(object sender, System.Web.UI.ImageClickEventArgs e)
		{
			DataClass clsDataClass = new DataClass();

			Data.Products clsProduct = new Data.Products();
			cboProductCode.DataTextField = "ProductCode";
			cboProductCode.DataValueField = "ProductID";

            string stSearchKey = txtProductCode.Text;
            cboProductCode.DataSource = clsProduct.ProductIDandCodeDataTable(SearchKey: stSearchKey, limit: 100);
			cboProductCode.DataBind();
			clsProduct.CommitAndDispose();

            bool bolShowCommandButtons = false;
            if (cboProductCode.Items.Count == 0)
            {
                cboProductCode.Items.Add(new ListItem("No product", "0"));
                bolShowCommandButtons = false;
            }
            else
            {
                bolShowCommandButtons = true;
            }
            imgProductHistory.Visible = bolShowCommandButtons;
            imgProductPriceHistory.Visible = bolShowCommandButtons;
            imgChangePrice.Visible = bolShowCommandButtons;
            imgEditNow.Visible = bolShowCommandButtons;
            cmdVariationSearch.Visible = bolShowCommandButtons;
            lblPurchasePriceHistory.Visible = bolShowCommandButtons;

			cboProductCode.SelectedIndex = 0;

			cboProductCode_SelectedIndexChanged(null, null);
		}
		protected void cmdVariationSearch_Click(object sender, System.Web.UI.ImageClickEventArgs e)
		{
			string stSearchKey = txtVariation.Text.ToString();

			if (txtVariation.Text == null) stSearchKey = "";

			DataClass clsDataClass = new DataClass();
			long ProductID = Convert.ToInt64(cboProductCode.SelectedItem.Value);

			ProductVariationsMatrix clsProductVariationsMatrix = new ProductVariationsMatrix();
            cboVariation.DataTextField = "Description";
			cboVariation.DataValueField = "MatrixID";
			cboVariation.DataSource = clsDataClass.DataReaderToDataTable(clsProductVariationsMatrix.Search(ProductID, stSearchKey, "VariationDesc",SortOption.Ascending)).DefaultView;
			cboVariation.DataBind();

			if (cboVariation.Items.Count == 0)
			{
				cboVariation.Items.Add(new ListItem("No Variation", "0"));
			}
			cboVariation.SelectedIndex = cboVariation.Items.Count - 1;
			clsProductVariationsMatrix.CommitAndDispose();
		}				
		protected void lstItem_ItemDataBound(object sender, DataListItemEventArgs e)
		{
			if(e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
			{
				DataRowView dr = (DataRowView) e.Item.DataItem;				

				HtmlInputCheckBox chkList = (HtmlInputCheckBox) e.Item.FindControl("chkList");
				chkList.Value = dr["WBranchTransferItemID"].ToString();

                HyperLink lnkBarcode = (HyperLink)e.Item.FindControl("lnkBarcode");
                lnkBarcode.Text = dr["Barcode"].ToString();

                HyperLink lnkDescription = (HyperLink)e.Item.FindControl("lnkDescription");
                lnkDescription.Text = dr["Description"].ToString();
                lnkDescription.NavigateUrl = Constants.ROOT_DIRECTORY + "/MasterFiles/_Product/Default.aspx?task=" + Common.Encrypt("det", Session.SessionID) + "&id=" + Common.Encrypt(dr["ProductID"].ToString(), Session.SessionID);
                lnkBarcode.NavigateUrl = Constants.ROOT_DIRECTORY + "/MasterFiles/_Product/Default.aspx?task=" + Common.Encrypt("det", Session.SessionID) + "&id=" + Common.Encrypt(dr["ProductID"].ToString(), Session.SessionID);

                HyperLink lnkMatrixDescription = (HyperLink)e.Item.FindControl("lnkMatrixDescription");
                if (dr["MatrixDescription"].ToString() != string.Empty && dr["MatrixDescription"].ToString() != null)
                {
                    lnkMatrixDescription.Visible = true;
                    lnkMatrixDescription.Text = dr["MatrixDescription"].ToString();
                    lnkMatrixDescription.NavigateUrl = Constants.ROOT_DIRECTORY + "/MasterFiles/_Product/_VariationsMatrix/Default.aspx?task=" + Common.Encrypt("det", Session.SessionID) + "&prodid=" + Common.Encrypt(dr["ProductID"].ToString(), Session.SessionID) + "&id=" + Common.Encrypt(dr["VariationMatrixID"].ToString(), Session.SessionID);
                }
				
				Label lblQuantity = (Label) e.Item.FindControl("lblQuantity");
				lblQuantity.Text = Convert.ToDecimal(dr["Quantity"].ToString()).ToString("#,##0.#0");

				Label lblProductUnitID = (Label) e.Item.FindControl("lblProductUnitID");
				lblProductUnitID.Text = dr["ProductUnitID"].ToString();

				Label lblProductUnitCode = (Label) e.Item.FindControl("lblProductUnitCode");
				lblProductUnitCode.Text = dr["ProductUnitCode"].ToString();

                //Label lblDiscountApplied = (Label)e.Item.FindControl("lblDiscountApplied");
                //lblDiscountApplied.Text = Convert.ToDecimal(dr["DiscountApplied"].ToString()).ToString("#,##0.#0");

                //DiscountTypes DiscountType = (DiscountTypes)Enum.Parse(typeof(DiscountTypes), dr["DiscountType"].ToString());
                //if (DiscountType == DiscountTypes.Percentage)
                //{
                //    Label lblPercent = (Label)e.Item.FindControl("lblPercent");
                //    lblPercent.Visible = true;
                //}

                //Label lblAmount = (Label) e.Item.FindControl("lblAmount");
                //lblAmount.Text = Convert.ToDecimal(dr["Amount"].ToString()).ToString("#,##0.#0");

                //Label lblVAT = (Label) e.Item.FindControl("lblVAT");
                //lblVAT.Text = Convert.ToDecimal(dr["VAT"].ToString()).ToString("#,##0.#0");

                //Label lblEVAT = (Label) e.Item.FindControl("lblEVAT");
                //lblEVAT.Text = Convert.ToDecimal(dr["EVAT"].ToString()).ToString("#,##0.#0");

                //Label lblisVATInclusive = (Label)e.Item.FindControl("lblisVATInclusive");
                //lblisVATInclusive.Text = Convert.ToBoolean(Convert.ToInt16(dr["isVATInclusive"].ToString())).ToString();

                //Label lblLocalTax = (Label)e.Item.FindControl("lblLocalTax");
                //lblLocalTax.Text = Convert.ToDecimal(dr["LocalTax"].ToString()).ToString("#,##0.#0");

				Label lblRemarks = (Label) e.Item.FindControl("lblRemarks");
				lblRemarks.Text = dr["Remarks"].ToString();

				//For anchor
				HtmlGenericControl divExpCollAsst = (HtmlGenericControl) e.Item.FindControl("divExpCollAsst");

				HtmlAnchor anchorDown = (HtmlAnchor) e.Item.FindControl("anchorDown");
				anchorDown.HRef = "javascript:ToggleDiv('" +  divExpCollAsst.ClientID + "')";
			}
		}
        protected void lstItem_ItemCommand(object source, System.Web.UI.WebControls.DataListCommandEventArgs e)
        {
            HtmlInputCheckBox chkList = (HtmlInputCheckBox)e.Item.FindControl("chkList");

            switch (e.CommandName)
            {
                case "imgItemUpdateClick":
                    { LoadItem(chkList.Value); }
                    break;
            }
        }
        protected void imgPrint_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            PrintWBranchTransfer();
        }
        protected void cmdPrint_Click(object sender, System.EventArgs e)
        {
            PrintWBranchTransfer();
        }
        protected void cmdUpdateHeader_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            UpdateHeader();
        }
        protected void imgUpdateHeader_Click(object sender, System.EventArgs e)
        {
            UpdateHeader();
        }
        protected void txtWBranchTransferDiscountApplied_TextChanged(object sender, EventArgs e)
        {
            UpdateWBranchTransferDiscount();
        }
        protected void cboWBranchTransferDiscountType_SelectedIndexChanged(object sender, EventArgs e)
        {
            UpdateWBranchTransferDiscount();
        }
        protected void txtWBranchTransferFreight_TextChanged(object sender, EventArgs e)
        {
            UpdateFreight();
        }
        protected void txtWBranchTransferDeposit_TextChanged(object sender, EventArgs e)
        {
            UpdateDeposit();
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
        protected void imgChangePrice_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            string stParam = "?task=" + Common.Encrypt("changeprice", Session.SessionID) +
                                "&productcode=" + Common.Encrypt(cboProductCode.SelectedItem.Text, Session.SessionID);
            Response.Redirect(Constants.ROOT_DIRECTORY + "/MasterFiles/_Product/Default.aspx" + stParam);
        }
        protected void imgEditNow_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            string stParam = "?task=" + Common.Encrypt("edit", Session.SessionID) +
                                "&id=" + Common.Encrypt(cboProductCode.SelectedItem.Value, Session.SessionID);
            Response.Redirect(Constants.ROOT_DIRECTORY + "/MasterFiles/_Product/Default.aspx" + stParam);
        }
        protected void cboProductUnit_SelectedIndexChanged(object sender, EventArgs e)
        {
            ProductPackage clsProductPackage = new ProductPackage();
            ProductPackageDetails clsDetails = clsProductPackage.DetailsByProductIDAndUnitID(long.Parse(cboProductCode.SelectedValue), long.Parse(cboProductUnit.SelectedValue));

            if (clsDetails.PackageID == 0)
            {
                ProductUnit clsProductUnit = new ProductUnit(clsProductPackage.Connection, clsProductPackage.Transaction);
                Products clsProduct = new Products(clsProductPackage.Connection, clsProductPackage.Transaction);
                ProductDetails clsProductDetails = clsProduct.Details(long.Parse(cboProductCode.SelectedItem.Value));
                decimal decBaseUnitValue = clsProductUnit.GetBaseUnitValue(long.Parse(cboProductCode.SelectedItem.Value), int.Parse(cboProductUnit.SelectedItem.Value), 1);

                clsDetails.Price = decBaseUnitValue * clsProductDetails.Price;
                clsDetails.PurchasePrice = decBaseUnitValue * clsProductDetails.PurchasePrice;
            }
            clsProductPackage.CommitAndDispose();

            txtPrice.Text = clsDetails.PurchasePrice.ToString("#####0.#0");
            txtSellingPrice.Text = clsDetails.Price.ToString("#####0.#0");
            txtOldSellingPrice.Text = clsDetails.Price.ToString("#####0.#0");
            decimal decMargin = clsDetails.Price - clsDetails.PurchasePrice;
            try { decMargin = decMargin / clsDetails.PurchasePrice; }
            catch { decMargin = 1; }
            decMargin = decMargin * 100;
            txtMargin.Text = decMargin.ToString("#,##0.##0");
            txtVAT.Text = clsDetails.VAT.ToString("#,##0.#0");
            txtEVAT.Text = clsDetails.EVAT.ToString("#,##0.#0");
            txtLocalTax.Text = clsDetails.LocalTax.ToString("#,##0.#0");
        }

        //protected void imgAddProduct_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        //{
        //    string newWindowUrl = Constants.ROOT_DIRECTORY + "/MasterFiles/_Product/Default.aspx?task=" + Common.Encrypt("add", Session.SessionID) + "&windowaction=" + Common.Encrypt("close", Session.SessionID);
        //    string javaScript =
        //     "<script type='text/javascript'>\n" +
        //     "<!--\n" +
        //     "window.open('" + newWindowUrl + "');\n" +
        //     "// -->\n" +
        //     "</script>\n";
        //    this.Page.ClientScript.RegisterStartupScript(GetType(), "openwindow", javaScript);
        //}
		#endregion

		#region Private Methods

        private void ManageSecurity()
        {
            Int64 UID = Convert.ToInt64(Session["UID"]);
            AccessRights clsAccessRights = new AccessRights();
            AccessRightsDetails clsDetails = new AccessRightsDetails();

            WBranchTransferStatus clsWBranchTransferStatus = (WBranchTransferStatus)Enum.Parse(typeof(WBranchTransferStatus), lblStatus.Text);

            updSubmitForApproval.Visible = false;
            updIssueGRN.Visible = false;
            updIssueGRN1.Visible = false;
            updIssueGRN2.Visible = false;
            lblSeparator1.Visible = false;
            lblSeparator2.Visible = false;
            lblSeparator3.Visible = false;

            if (clsWBranchTransferStatus == WBranchTransferStatus.ForApproval)
            {
                clsDetails = clsAccessRights.Details(UID, (int)AccessTypes.WarehouseToBranchTransferIssueGRN);
                lblSeparator1.Visible = clsDetails.Write;
                lblSeparator2.Visible = clsDetails.Write;
                updIssueGRN.Visible = clsDetails.Write;
                updIssueGRN1.Visible = clsDetails.Write;
                updIssueGRN2.Visible = clsDetails.Write;
            }
            else if (clsWBranchTransferStatus == WBranchTransferStatus.Open)
            {
                clsDetails = clsAccessRights.Details(UID, (int)AccessTypes.WarehouseToBranchTransfer);
                updSubmitForApproval.Visible = clsDetails.Write;
            }
            clsAccessRights.CommitAndDispose();
        }
		private void LoadOptions()
		{
			cboProductCode.Items.Clear();
			cboVariation.Items.Clear();
			cboProductUnit.Items.Clear();

            cboProductCode.Items.Add(new ListItem("No Product; Enter product to search.", "0"));

            cboProductCode_SelectedIndexChanged(null, null);
            cboVariation.Items.Add(new ListItem("No Variation", "0"));
            cboProductUnit.Items.Add(new ListItem("No Unit", "0")); 

			cboProductCode_SelectedIndexChanged(null, null);

            txtQuantity.Text = "1";
            txtPrice.Text = "0.00";
            txtDiscount.Text = "0";
            txtSellingQuantity.Text = "0";
            txtMargin.Text = "10";
            txtSellingPrice.Text = "0";
            txtOldSellingPrice.Text = "0";

            txtRemarks.Text = "";
            ComputeItemAmount();
			lblWBranchTransferItemID.Text = "0";

			txtDeliveryDate.Text = DateTime.Now.ToString("yyyy-MM-dd");

            //string stProductAddLink = Constants.ROOT_DIRECTORY + "/MasterFiles/_Product/Default.aspx?task=" + Common.Encrypt("add", Session.SessionID);
            //lnkProductAdd.NavigateUrl = stProductAddLink;
            //lnkProductAdd.Attributes.Add("onclick", "javascript:w=window.open(this.href','','width=400,height=400');"); 
		}
		private void LoadRecord()
		{

            Int64 iID = 0;
            try { iID = Convert.ToInt64(Common.Decrypt(Request.QueryString["WBranchTransferID"], Session.SessionID)); }
            catch { }
            try
            {   if (iID == 0) iID = Convert.ToInt64(lblWBranchTransferID.Text);} catch { }

			WBranchTransfer clsWBranchTransfer = new WBranchTransfer();
			WBranchTransferDetails clsDetails = clsWBranchTransfer.Details(iID);
			clsWBranchTransfer.CommitAndDispose();

			lblWBranchTransferID.Text = clsDetails.WBranchTransferID.ToString();
            lnkWBranchTransferNo.Text = clsDetails.WBranchTransferNo;
            lnkWBranchTransferNo.NavigateUrl = "Default.aspx?task=" + Common.Encrypt("details", Session.SessionID) + "&WBranchTransferID=" + Common.Encrypt(clsDetails.WBranchTransferID.ToString(), Session.SessionID);

			lblWBranchTransferDate.Text = clsDetails.WBranchTransferDate.ToString("yyyy-MM-dd HH:mm:ss");
			lblRequiredDeliveryDate.Text = clsDetails.RequiredDeliveryDate.ToString("yyyy-MM-dd");
			lblBranchCodeFrom.Text = clsDetails.BranchCodeFrom;
            lblBranchCodeTo.Text = clsDetails.BranchCodeTo;
			lblWBranchTransferRemarks.Text = clsDetails.Remarks;

            txtWBranchTransferDiscountApplied.Text = clsDetails.DiscountApplied.ToString("###0.#0");
            cboWBranchTransferDiscountType.SelectedIndex = cboWBranchTransferDiscountType.Items.IndexOf(cboWBranchTransferDiscountType.Items.FindByValue(clsDetails.DiscountType.ToString("d")));
            lblWBranchTransferDiscount.Text = clsDetails.Discount.ToString("#,##0.#0");
            lblWBranchTransferVatableAmount.Text = clsDetails.VatableAmount.ToString("#,##0.#0");
            txtWBranchTransferFreight.Text = clsDetails.Freight.ToString("#,##0.#0");
            txtWBranchTransferDeposit.Text = clsDetails.Deposit.ToString("#,##0.#0");
            lblWBranchTransferSubTotal.Text = Convert.ToDecimal(clsDetails.SubTotal - clsDetails.VAT).ToString("#,##0.#0");
            lblWBranchTransferVAT.Text = clsDetails.VAT.ToString("#,##0.#0");
            lblWBranchTransferTotal.Text = clsDetails.SubTotal.ToString("#,##0.#0");

            lblStatus.Text = clsDetails.Status.ToString("G");
		}
		private void SaveRecord()
		{
			WBranchTransferItemDetails clsDetails = new WBranchTransferItemDetails();

			Products clsProducts = new Products();
            ProductDetails clsProductDetails = clsProducts.Details1(Constants.BRANCH_ID_MAIN, Convert.ToInt64(cboProductCode.SelectedItem.Value));
			
			Terminal clsTerminal = new Terminal(clsProducts.Connection, clsProducts.Transaction);
            TerminalDetails clsTerminalDetails = clsTerminal.Details(Int32.Parse(Session["BranchID"].ToString()), Session["TerminalNo"].ToString());
			clsProducts.CommitAndDispose();

			clsDetails.WBranchTransferID = Convert.ToInt64(lblWBranchTransferID.Text);
			clsDetails.ProductID = Convert.ToInt64(cboProductCode.SelectedItem.Value);
			clsDetails.ProductCode = clsProductDetails.ProductCode;
			clsDetails.BarCode = clsProductDetails.BarCode;
			clsDetails.Description = clsProductDetails.ProductDesc;
			clsDetails.ProductUnitID = Convert.ToInt32(cboProductUnit.SelectedItem.Value);
			clsDetails.ProductUnitCode = cboProductUnit.SelectedItem.Text;
			clsDetails.Quantity = Convert.ToDecimal(txtQuantity.Text);
            clsDetails.UnitCost = Convert.ToDecimal(txtPrice.Text);
            clsDetails.Discount = getItemTotalDiscount();
            clsDetails.DiscountApplied = Convert.ToDecimal(txtDiscount.Text);
            if (clsDetails.DiscountApplied == 0)
            {
                if (chkInPercent.Checked == true)
                    clsDetails.DiscountType = DiscountTypes.Percentage;
                else
                    clsDetails.DiscountType = DiscountTypes.FixedValue;
            }
            else {
                clsDetails.DiscountType = DiscountTypes.NotApplicable;
            }

            clsDetails.IsVatable = chkIsTaxable.Checked;
            clsDetails.Amount = ComputeItemAmount();

            if (clsDetails.IsVatable)
            {
                clsDetails.VatableAmount = clsDetails.Amount;
                clsDetails.EVatableAmount = clsDetails.Amount;
                clsDetails.LocalTax = clsDetails.Amount;

                if (clsTerminalDetails.IsVATInclusive == false)
                {
                    if (clsDetails.VatableAmount < clsDetails.Discount) clsDetails.VatableAmount = 0;
                    if (clsDetails.EVatableAmount < clsDetails.Discount) clsDetails.EVatableAmount = 0;
                    if (clsDetails.LocalTax < clsDetails.Discount) clsDetails.LocalTax = 0;
                }
                else
                {
                    if (clsDetails.VatableAmount >= clsDetails.Discount) clsDetails.VatableAmount = (clsDetails.VatableAmount) / (1 + (clsTerminalDetails.VAT / 100)); else clsDetails.VatableAmount = 0;
                    if (clsDetails.EVatableAmount >= clsDetails.Discount) clsDetails.EVatableAmount = (clsDetails.EVatableAmount) / (1 + (clsTerminalDetails.VAT / 100)); else clsDetails.EVatableAmount = 0;
                    if (clsDetails.LocalTax >= clsDetails.Discount) clsDetails.LocalTax = (clsDetails.LocalTax) / (1 + (clsTerminalDetails.LocalTax / 100)); else clsDetails.LocalTax = 0;
                }

                clsDetails.VAT = clsDetails.VatableAmount * (clsTerminalDetails.VAT / 100);
                clsDetails.EVAT = clsDetails.EVatableAmount * (clsTerminalDetails.EVAT / 100);
                clsDetails.LocalTax = clsDetails.LocalTax * (clsTerminalDetails.LocalTax / 100);
            }
            else
            {
                clsDetails.VAT = 0;
                clsDetails.VatableAmount = 0;
                clsDetails.EVAT = 0;
                clsDetails.EVatableAmount = 0;
                clsDetails.LocalTax = 0;
            }

            clsDetails.isVATInclusive = clsTerminalDetails.IsVATInclusive;
            clsDetails.VariationMatrixID = Convert.ToInt64(cboVariation.SelectedItem.Value);
            if (clsDetails.VariationMatrixID != 0)
                clsDetails.MatrixDescription = cboVariation.SelectedItem.Text;
            clsDetails.ProductGroup = clsProductDetails.ProductGroupCode;
            clsDetails.ProductSubGroup = clsProductDetails.ProductSubGroupCode;
            clsDetails.Remarks = txtRemarks.Text;
            
            clsDetails.SellingPrice = decimal.Parse(txtSellingPrice.Text);
            clsDetails.SellingVAT = decimal.Parse(txtVAT.Text);
            clsDetails.SellingEVAT = decimal.Parse(txtEVAT.Text);
            clsDetails.SellingLocalTax = decimal.Parse(txtLocalTax.Text);
            clsDetails.OldSellingPrice = decimal.Parse(txtOldSellingPrice.Text);

            WBranchTransferItem clsWBranchTransferItem = new WBranchTransferItem();
            if (lblWBranchTransferItemID.Text != "0")
            {
                clsDetails.WBranchTransferItemID = Convert.ToInt64(lblWBranchTransferItemID.Text);
                clsWBranchTransferItem.Update(clsDetails);
            }
            else
                clsWBranchTransferItem.Insert(clsDetails);

            WBranchTransferDetails clsWBranchTransferDetails = new WBranchTransferDetails();
            clsWBranchTransferDetails.WBranchTransferID = clsDetails.WBranchTransferID;
            clsWBranchTransferDetails.DiscountApplied = Convert.ToDecimal(txtWBranchTransferDiscountApplied.Text);
            clsWBranchTransferDetails.DiscountType = (DiscountTypes)Enum.Parse(typeof(DiscountTypes), cboWBranchTransferDiscountType.SelectedItem.Value);

            WBranchTransfer clsWBranchTransfer = new WBranchTransfer(clsWBranchTransferItem.Connection, clsWBranchTransferItem.Transaction);
            clsWBranchTransfer.UpdateDiscount(clsDetails.WBranchTransferID, clsWBranchTransferDetails.DiscountApplied, clsWBranchTransferDetails.DiscountType);
            
            clsWBranchTransferDetails = clsWBranchTransfer.Details(clsDetails.WBranchTransferID);
            clsWBranchTransferItem.CommitAndDispose();

            UpdateFooter(clsWBranchTransferDetails);
		}
		private void ClearAddItem()
		{
			txtQuantity.Text = "1";
			txtDiscount.Text = "0";
			txtRemarks.Text = "";
			ComputeItemAmount();
		}
		private bool DeleteItems()
		{
			bool boRetValue = false;
			string stIDs = "";

			foreach(DataListItem item in lstItem.Items)
			{
				HtmlInputCheckBox chkList = (HtmlInputCheckBox) item.FindControl("chkList");
				if (chkList!=null)
				{
					if (chkList.Checked == true)
					{
						stIDs += chkList.Value + ",";		
						boRetValue = true;
					}
				}
			}
			if (boRetValue)
			{
				WBranchTransferItem clsWBranchTransferItem = new WBranchTransferItem();
				clsWBranchTransferItem.Delete( stIDs.Substring(0,stIDs.Length-1));

				WBranchTransfer clsWBranchTransfer = new WBranchTransfer(clsWBranchTransferItem.Connection, clsWBranchTransferItem.Transaction);
				clsWBranchTransfer.SynchronizeAmount(Convert.ToInt64(lblWBranchTransferID.Text));

				WBranchTransferDetails clsWBranchTransferDetails = clsWBranchTransfer.Details(Convert.ToInt64(lblWBranchTransferID.Text));

				clsWBranchTransferItem.CommitAndDispose();

                UpdateFooter(clsWBranchTransferDetails);
			}

			return boRetValue;
		}
		private void UpdateItem()
		{
			if (isChkListSingle() == true)
			{
				string stID = GetFirstID();
				if (stID!=null)
				{
                    LoadItems();
				}
			}
			else
			{
				string stScript = "<Script>";
				stScript += "window.alert('Cannot update more than one record. Please select at least one record to update.')";
				stScript += "</Script>";
				Response.Write(stScript);	
			}
		}
        private void LoadItem(string stID)
        {
            WBranchTransferItem clsWBranchTransferItem = new WBranchTransferItem();
            WBranchTransferItemDetails clsWBranchTransferItemDetails = clsWBranchTransferItem.Details(Convert.ToInt64(stID));
            clsWBranchTransferItem.CommitAndDispose();

            cboProductCode.Items.Clear();
            cboVariation.Items.Clear();
            cboProductUnit.Items.Clear();

            txtProductCode.Text = clsWBranchTransferItemDetails.BarCode;
            cmdProductCode_Click(null, null);

            cboProductCode.SelectedIndex = cboProductCode.Items.IndexOf(new ListItem(clsWBranchTransferItemDetails.ProductCode, clsWBranchTransferItemDetails.ProductID.ToString()));

            if (clsWBranchTransferItemDetails.VariationMatrixID == 0)
            { cboVariation.Items.Add(new ListItem("No Variation", "0")); cboVariation.SelectedIndex = 0; }
            else
            { cboVariation.SelectedIndex = cboVariation.Items.IndexOf(new ListItem(clsWBranchTransferItemDetails.MatrixDescription, clsWBranchTransferItemDetails.VariationMatrixID.ToString())); }

            if (clsWBranchTransferItemDetails.ProductUnitID == 0)
            { cboProductUnit.Items.Add(new ListItem("No Unit", "0")); cboProductUnit.SelectedIndex = 0; }
            else
            { cboProductUnit.SelectedIndex = cboProductUnit.Items.IndexOf(new ListItem(clsWBranchTransferItemDetails.ProductUnitCode, clsWBranchTransferItemDetails.ProductUnitID.ToString()));}

            txtQuantity.Text = clsWBranchTransferItemDetails.Quantity.ToString("###0.#0");
            txtPrice.Text = clsWBranchTransferItemDetails.UnitCost.ToString("###0.#0");
            txtDiscount.Text = clsWBranchTransferItemDetails.Discount.ToString("###0.#0");

            if (clsWBranchTransferItemDetails.DiscountType == DiscountTypes.Percentage)
                chkInPercent.Checked = true;
            else
            {
                chkInPercent.Checked = false;
            }
            txtAmount.Text = clsWBranchTransferItemDetails.Amount.ToString("###0.#0");
            txtRemarks.Text = clsWBranchTransferItemDetails.Remarks;
            lblWBranchTransferItemID.Text = stID;
            chkIsTaxable.Checked = clsWBranchTransferItemDetails.IsVatable;

            //Added Jan 1, 2010 4:20PM : For selling information
            txtSellingQuantity.Text = "1";
            txtMargin.Text = decimal.Parse(Convert.ToString(((clsWBranchTransferItemDetails.SellingPrice - clsWBranchTransferItemDetails.UnitCost) / clsWBranchTransferItemDetails.UnitCost) * 100)).ToString("###0.#0");
            txtSellingPrice.Text = clsWBranchTransferItemDetails.SellingPrice.ToString("###0.#0");
            txtVAT.Text = clsWBranchTransferItemDetails.SellingVAT.ToString("###0.#0");
            txtEVAT.Text = clsWBranchTransferItemDetails.SellingEVAT.ToString("###0.#0");
            txtLocalTax.Text = clsWBranchTransferItemDetails.SellingLocalTax.ToString("###0.#0");
            txtOldSellingPrice.Text = clsWBranchTransferItemDetails.OldSellingPrice.ToString("###0.#0");

            txtProductCode.Focus();
            ShowCommandButtons(true);
        }
        private void ShowCommandButtons(bool bolShowCommandButtons)
        {
            imgProductHistory.Visible = bolShowCommandButtons;
            imgProductPriceHistory.Visible = bolShowCommandButtons;
            imgChangePrice.Visible = bolShowCommandButtons;
            imgEditNow.Visible = bolShowCommandButtons;
            lnkProductDetails.Visible = bolShowCommandButtons;
            cmdVariationSearch.Visible = bolShowCommandButtons;
            lblPurchasePriceHistory.Visible = bolShowCommandButtons;

            if (bolShowCommandButtons)
            {
                string stParam = "?task=" + Common.Encrypt("det", Session.SessionID) + "&id=" + Common.Encrypt(cboProductCode.SelectedItem.Value, Session.SessionID);
                string newWindowUrl = Constants.ROOT_DIRECTORY + "/MasterFiles/_Product/Default.aspx" + stParam;
                lnkProductDetails.NavigateUrl = newWindowUrl;
            }
        }
		private void LoadItems()
		{
			DataClass clsDataClass = new DataClass();

			WBranchTransferItem clsWBranchTransferItem = new WBranchTransferItem();
            lstItem.DataSource = clsWBranchTransferItem.ListAsDataTable(Convert.ToInt64(lblWBranchTransferID.Text)).DefaultView;
			lstItem.DataBind();
			clsWBranchTransferItem.CommitAndDispose();
		}
		private void IssueGRN()
		{
			DateTime DeliveryDate = Convert.ToDateTime(txtDeliveryDate.Text);

			ERPConfig clsERPConfig = new ERPConfig();
			ERPConfigDetails clsERPConfigDetails = clsERPConfig.Details();
			clsERPConfig.CommitAndDispose();
			
			if (clsERPConfigDetails.PostingDateFrom <= DeliveryDate && clsERPConfigDetails.PostingDateTo >= DeliveryDate)
			{
                Int64 WBranchTransferID = Convert.ToInt64(lblWBranchTransferID.Text);
				string ReceivedBy = txtReceivedBy.Text;

				WBranchTransfer clsWBranchTransfer = new WBranchTransfer();
				clsWBranchTransfer.IssueGRN(WBranchTransferID, ReceivedBy, DeliveryDate);
				clsWBranchTransfer.CommitAndDispose();

				string stParam = "?task=" + Common.Encrypt("list",Session.SessionID) + "&WBranchTransferID=" + Common.Encrypt(WBranchTransferID.ToString(),Session.SessionID);	
				Response.Redirect("Default.aspx" + stParam);
			}
			else
			{
				string stScript = "<Script>";
				stScript += "window.alert('Sorry you cannot post using the delivery date: " + txtDeliveryDate.Text + ". Please enter an allowable posting date.')";
				stScript += "</Script>";
				Response.Write(stScript);	
			}
		}
        private void SubmitForApproval()
        {
            try
            {
                Security.AccessUserDetails clsAccessUserDetails = (Security.AccessUserDetails)Session["AccessUserDetails"];

                Int64 WBranchTransferID = Convert.ToInt64(lblWBranchTransferID.Text);

                WBranchTransfer clsWBranchTransfer = new WBranchTransfer();
                clsWBranchTransfer.SubmitForApproval(WBranchTransferID, clsAccessUserDetails.Name);
                clsWBranchTransfer.CommitAndDispose();

                string stParam = "?task=" + Common.Encrypt("list", Session.SessionID) + "&WBranchTransferID=" + Common.Encrypt(WBranchTransferID.ToString(), Session.SessionID);
                Response.Redirect("Default.aspx" + stParam);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
		private decimal ComputeItemAmount()
		{
			decimal quantity = Convert.ToDecimal(txtQuantity.Text);
			decimal price = Convert.ToDecimal(txtPrice.Text);
			decimal discount = Convert.ToDecimal(txtDiscount.Text);
			decimal amount = 0;
			if (chkInPercent.Checked == true)
			{
				amount = (quantity * (price - (price * discount / 100)));
			}
			else
			{	amount = (quantity * (price - discount));	}
			txtAmount.Text = amount.ToString("####0.#0");
			return amount;
		}
		private decimal getItemTotalDiscount()
		{
			decimal quantity = Convert.ToDecimal(txtQuantity.Text);
			decimal price = Convert.ToDecimal(txtPrice.Text);
			decimal discount = Convert.ToDecimal(txtDiscount.Text);
			decimal amount = 0;
			decimal totaldiscount = 0;

			if (chkInPercent.Checked == true)
			{
				amount = (quantity * (price - (price * discount / 100)));
			}
			else
			{	amount = (quantity * (price - discount));	}

			totaldiscount = (quantity * price) - amount;
			return totaldiscount;
		}
		private string GetFirstID()
		{
			foreach(DataListItem item in lstItem.Items)
			{
				HtmlInputCheckBox chkList = (HtmlInputCheckBox) item.FindControl("chkList");
				if (chkList!=null)
				{
					if (chkList.Checked == true)
					{
						return chkList.Value;
					}
				}
			}
			return null;
		}
		private bool isChkListSingle()
		{
			bool boChkListSingle = true;
			int iCount = 0;
			
			foreach(DataListItem item in lstItem.Items)
			{
				HtmlInputCheckBox chkList = (HtmlInputCheckBox) item.FindControl("chkList");
				if (chkList!=null)
				{
					if (chkList.Checked == true)
					{
						iCount += 1;
						if (iCount >= 2)
						{	return false;	}
					}
				}
			}
			return boChkListSingle;
		}
        private void PrintWBranchTransfer()
        {
            string stParam = "?task=" + Common.Encrypt("reports", Session.SessionID) + "&target=" + Common.Encrypt("WBranchTransfer", Session.SessionID) + "&WBranchTransferID=" + Common.Encrypt(lblWBranchTransferID.Text, Session.SessionID);
            string newWindowUrl = Constants.ROOT_DIRECTORY + "/Inventory/_WBranchTransfer/Default.aspx" + stParam;
            string javaScript = "window.open('" + newWindowUrl + "');";

            System.Web.UI.ScriptManager.RegisterClientScriptBlock(this.updPrint, this.updPrint.GetType(), "openwindow", javaScript, true);
        }
        private void UpdateHeader()
        {
            string stID = lblWBranchTransferID.Text;

            Common Common = new Common();
            string stParam = "?task=" + Common.Encrypt("edit", Session.SessionID) + "&WBranchTransferID=" + Common.Encrypt(stID, Session.SessionID);
            Response.Redirect("Default.aspx" + stParam);
        }
        private void UpdateWBranchTransferDiscount()
        {
            WBranchTransferDetails clsWBranchTransferDetails = new WBranchTransferDetails();
            clsWBranchTransferDetails.WBranchTransferID = Convert.ToInt64(lblWBranchTransferID.Text);
            clsWBranchTransferDetails.DiscountApplied = Convert.ToDecimal(txtWBranchTransferDiscountApplied.Text);
            clsWBranchTransferDetails.DiscountType = (DiscountTypes)Enum.Parse(typeof(DiscountTypes), cboWBranchTransferDiscountType.SelectedItem.Value);

            WBranchTransfer clsWBranchTransfer = new WBranchTransfer();
            clsWBranchTransfer.UpdateDiscount(clsWBranchTransferDetails.WBranchTransferID, clsWBranchTransferDetails.DiscountApplied, clsWBranchTransferDetails.DiscountType);
            clsWBranchTransfer.SynchronizeAmount(Convert.ToInt64(lblWBranchTransferID.Text));
            clsWBranchTransferDetails = clsWBranchTransfer.Details(Convert.ToInt64(lblWBranchTransferID.Text));
            clsWBranchTransfer.CommitAndDispose();

            UpdateFooter(clsWBranchTransferDetails);
        }
        private void UpdateFreight()
        {
            WBranchTransferDetails clsWBranchTransferDetails = new WBranchTransferDetails();
            clsWBranchTransferDetails.WBranchTransferID = Convert.ToInt64(lblWBranchTransferID.Text);
            clsWBranchTransferDetails.Freight = Convert.ToDecimal(txtWBranchTransferFreight.Text);

            WBranchTransfer clsWBranchTransfer = new WBranchTransfer();
            clsWBranchTransfer.UpdateFreight(clsWBranchTransferDetails.WBranchTransferID, clsWBranchTransferDetails.Freight);
            clsWBranchTransfer.SynchronizeAmount(Convert.ToInt64(lblWBranchTransferID.Text));
            clsWBranchTransferDetails = clsWBranchTransfer.Details(Convert.ToInt64(lblWBranchTransferID.Text));
            clsWBranchTransfer.CommitAndDispose();

            UpdateFooter(clsWBranchTransferDetails);
        }
        private void UpdateDeposit()
        {
            WBranchTransferDetails clsWBranchTransferDetails = new WBranchTransferDetails();
            clsWBranchTransferDetails.WBranchTransferID = Convert.ToInt64(lblWBranchTransferID.Text);
            clsWBranchTransferDetails.Deposit = Convert.ToDecimal(txtWBranchTransferDeposit.Text);

            WBranchTransfer clsWBranchTransfer = new WBranchTransfer();
            clsWBranchTransfer.UpdateDeposit(clsWBranchTransferDetails.WBranchTransferID, clsWBranchTransferDetails.Deposit);
            clsWBranchTransfer.SynchronizeAmount(Convert.ToInt64(lblWBranchTransferID.Text));
            clsWBranchTransferDetails = clsWBranchTransfer.Details(Convert.ToInt64(lblWBranchTransferID.Text));
            clsWBranchTransfer.CommitAndDispose();

            UpdateFooter(clsWBranchTransferDetails);
        }
        private void UpdateFooter(WBranchTransferDetails clsWBranchTransferDetails)
        {
            lblWBranchTransferDiscount.Text = clsWBranchTransferDetails.Discount.ToString("#,##0.#0");
            lblWBranchTransferVatableAmount.Text = clsWBranchTransferDetails.VatableAmount.ToString("#,##0.#0");
            txtWBranchTransferFreight.Text = clsWBranchTransferDetails.Freight.ToString("#,##0.#0");
            txtWBranchTransferDeposit.Text = clsWBranchTransferDetails.Deposit.ToString("#,##0.#0");
            lblWBranchTransferSubTotal.Text = Convert.ToDecimal(clsWBranchTransferDetails.SubTotal - clsWBranchTransferDetails.VAT).ToString("#,##0.#0");
            lblWBranchTransferVAT.Text = clsWBranchTransferDetails.VAT.ToString("#,##0.#0");
            lblWBranchTransferTotal.Text = clsWBranchTransferDetails.SubTotal.ToString("#,##0.#0");
        }

		#endregion
        
    }
}
