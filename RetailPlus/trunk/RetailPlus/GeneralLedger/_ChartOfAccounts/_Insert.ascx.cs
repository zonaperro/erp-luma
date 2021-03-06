namespace AceSoft.RetailPlus.GeneralLedger._ChartOfAccounts
{
	using System;
	using System.Data;
	using System.Drawing;
	using System.Web;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;
	using AceSoft.RetailPlus.Data;
	
	public partial  class __Insert : System.Web.UI.UserControl
	{

		#region Web Form Methods

		protected void Page_Load(object sender, System.EventArgs e)
		{
			if (!IsPostBack)
			{
				if (Visible)
				{
					lblReferrer.Text = Request.UrlReferrer == null ? Constants.ROOT_DIRECTORY : Request.UrlReferrer.ToString();
					LoadOptions();			
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
			SaveRecord();
			string stParam = "?task=" + Common.Encrypt("add",Session.SessionID);
			Response.Redirect("Default.aspx" + stParam);	
		}
		protected void cmdSave_Click(object sender, System.EventArgs e)
		{
			SaveRecord();
			string stParam = "?task=" + Common.Encrypt("add",Session.SessionID);
			Response.Redirect("Default.aspx" + stParam);			
		}

        protected void imgSaveBack_Click(object sender, System.Web.UI.ImageClickEventArgs e)
		{
			SaveRecord();
			Response.Redirect(lblReferrer.Text);
		}
		protected void cmdSaveBack_Click(object sender, System.EventArgs e)
		{
			SaveRecord();
			Response.Redirect(lblReferrer.Text);
		}

        protected void imgCancel_Click(object sender, System.Web.UI.ImageClickEventArgs e)
		{
			Response.Redirect(lblReferrer.Text);
		}
		protected void cmdCancel_Click(object sender, System.EventArgs e)
		{
			Response.Redirect(lblReferrer.Text);
		}

		#endregion

		#region Private Methods

		private void LoadOptions()
		{
			AccountCategories clsAccountCategory = new AccountCategories();
			DataClass clsDataClass = new DataClass();
			
			cboAccountCategory.DataTextField = "AccountCategoryName";
			cboAccountCategory.DataValueField = "AccountCategoryID";
			cboAccountCategory.DataSource = clsDataClass.DataReaderToDataTable(clsAccountCategory.List("AccountCategoryName",SortOption.Ascending)).DefaultView;
			cboAccountCategory.DataBind();
			cboAccountCategory.SelectedIndex = cboAccountCategory.Items.Count - 1;
			clsAccountCategory.CommitAndDispose();
		}

		private Int32 SaveRecord()
		{
			ChartOfAccountDetails clsDetails = new ChartOfAccountDetails();

            clsDetails.AccountCategoryDetails = new AccountCategoryDetails
            {
                AccountCategoryID = Convert.ToInt32(cboAccountCategory.SelectedItem.Value),
            };
			clsDetails.ChartOfAccountCode = txtAccountCode.Text;
			clsDetails.ChartOfAccountName = txtAccountName.Text;
			
			ChartOfAccounts clsChartOfAccount = new ChartOfAccounts();
			Int32 id = clsChartOfAccount.Insert(clsDetails);
			clsChartOfAccount.CommitAndDispose();

			return id;
		}


		#endregion
    }
}
