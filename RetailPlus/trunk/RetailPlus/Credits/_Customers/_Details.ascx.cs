namespace AceSoft.RetailPlus.Credits._Customers
{
	using System;
	using System.Data;
	using System.Drawing;
	using System.Web;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;
	using AceSoft.RetailPlus.Data;
	
	public partial  class __Details : System.Web.UI.UserControl
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
                }
            }
        }

        #endregion

        #region Web Form Designer generated code
        override protected void OnInit(EventArgs e)
        {
            InitializeComponent();
            base.OnInit(e);
        }

        private void InitializeComponent()
        {

        }
        #endregion

        #region Web Control Methods

        protected void imgBack_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            Response.Redirect(lblReferrer.Text);
        }
        protected void cmdBack_Click(object sender, System.EventArgs e)
        {
            Response.Redirect(lblReferrer.Text);
        }

        protected void cmdPrintBilling_Click(object sender, System.EventArgs e)
        {
            PrintBillingReport();
        }

        protected void imgPrintBilling_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            PrintBillingReport();
        }

        #endregion

        #region Private Methods

        private void LoadOptions()
        {
            lblContactID.Text = Common.Decrypt(Request.QueryString["id"], Session.SessionID);

            ContactGroups clsContactGroup = new ContactGroups();

            cboGroup.DataTextField = "ContactGroupName";
            cboGroup.DataValueField = "ContactGroupID";
            cboGroup.DataSource = clsContactGroup.ListAsDataTable().DefaultView;
            cboGroup.DataBind();
            cboGroup.SelectedIndex = cboGroup.Items.Count - 1;

            Department clsDepartment = new Department(clsContactGroup.Connection, clsContactGroup.Transaction);
            cboDepartment.DataTextField = "DepartmentName";
            cboDepartment.DataValueField = "DepartmentID";
            cboDepartment.DataSource = clsDepartment.ListAsDataTable("DepartmentName", SortOption.Ascending, 0).DefaultView;
            cboDepartment.DataBind();
            cboDepartment.SelectedIndex = 0;

            Positions clsPosition = new Positions(clsContactGroup.Connection, clsContactGroup.Transaction);
            cboPosition.DataTextField = "PositionName";
            cboPosition.DataValueField = "PositionID";
            cboPosition.DataSource = clsPosition.ListAsDataTable("PositionName", SortOption.Ascending, 0).DefaultView;
            cboPosition.DataBind();
            cboPosition.SelectedIndex = 0;


            Billing clsBilling = new Billing(clsContactGroup.Connection, clsContactGroup.Transaction);
            cboBillingDate.DataTextField = "BillingDate";
            cboBillingDate.DataValueField = "BillingFile";
            cboBillingDate.DataSource = clsBilling.ListBillingDateAsDataTable(long.Parse(lblContactID.Text)).DefaultView;
            cboBillingDate.DataBind();
            cboBillingDate.Items.Insert(0, new ListItem(Constants.PLEASE_SELECT, Constants.PLEASE_SELECT));
            cboBillingDate.SelectedIndex = 0;

            clsContactGroup.CommitAndDispose();
        }
        private void LoadRecord()
        {
            Int64 iID = Convert.ToInt64(Common.Decrypt(Request.QueryString["id"], Session.SessionID));
            Contacts clsContact = new Contacts();
            ContactDetails clsDetails = clsContact.Details(iID);

            clsContact.CommitAndDispose();

            lblContactID.Text = clsDetails.ContactID.ToString();
            txtContactCode.Text = clsDetails.ContactCode;
            txtContactName.Text = clsDetails.ContactName;
            cboGroup.SelectedIndex = cboGroup.Items.IndexOf(cboGroup.Items.FindByValue(clsDetails.ContactGroupID.ToString()));
            cboModeOfTerms.SelectedIndex = cboModeOfTerms.Items.IndexOf(cboModeOfTerms.Items.FindByValue(clsDetails.ModeOfTerms.ToString("d")));
            txtTerms.Text = clsDetails.Terms.ToString("#,##0");
            txtAddress.Text = clsDetails.Address;
            txtBusinessName.Text = clsDetails.BusinessName;
            txtTelephoneNo.Text = clsDetails.TelephoneNo;
            txtRemarks.Text = clsDetails.Remarks;
            txtDebit.Text = clsDetails.Debit.ToString("#,##0.#0");
            txtCredit.Text = clsDetails.Credit.ToString("#,##0.#0");
            clsDetails.IsCreditAllowed = chkIsCreditAllowed.Checked;
            //if (clsDetails.IsCreditAllowed == 0)
            //    chkIsCreditAllowed.Checked = false;
            //else
            //    chkIsCreditAllowed.Checked = true;
            txtCreditLimit.Text = clsDetails.CreditLimit.ToString("#,##0.#0");
            cboDepartment.SelectedIndex = cboDepartment.Items.IndexOf(cboDepartment.Items.FindByValue(clsDetails.DepartmentID.ToString()));
            cboPosition.SelectedIndex = cboPosition.Items.IndexOf(cboPosition.Items.FindByValue(clsDetails.PositionID.ToString()));

            txtCreditType.Text = clsDetails.CreditDetails.CardTypeDetails.CardTypeCode;
            txtCreditCardNo.Text = clsDetails.CreditDetails.CreditCardNo;
            txtCreditCardStatus.Text = clsDetails.CreditDetails.CreditCardStatus.ToString("G");
            txtTotalPurchases.Text = clsDetails.CreditDetails.TotalPurchases.ToString("#,##0.#0");
            txtExpiryDate.Text = clsDetails.CreditDetails.ExpiryDate.ToString("dd-MMM-yyyy");
            txtLastBillingDate.Text = clsDetails.CreditDetails.LastBillingDate.ToString("dd-MMM-yyyy");
            txtCreditLimitInfo.Text = clsDetails.CreditLimit.ToString("#,##0.#0");
            txtCreditInfo.Text = clsDetails.Credit.ToString("#,##0.#0");
            txtAvailableCredit.Text = Convert.ToDecimal(clsDetails.CreditLimit - clsDetails.Credit).ToString("#,##0.#0");
        }

        private void PrintBillingReport()
        {
            
            string stParam = cboBillingDate.SelectedItem.Value;
            if (stParam != Constants.PLEASE_SELECT)
            {
                Response.Redirect(Constants.ROOT_DIRECTORY + "/billings/" + stParam);
            }
        }

        #endregion

	}
}
