namespace AceSoft.RetailPlus.Credits._CardType
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

        }
        private Int32 SaveRecord()
        {
            CardType clsCardType = new CardType();
            CardTypeDetails clsDetails = new CardTypeDetails(CreditCardTypes.Internal);

            clsDetails.CardTypeCode = txtCardTypeCode.Text;
            clsDetails.CardTypeName = txtCardTypeName.Text;

            clsDetails.CreditFinanceCharge = decimal.Parse(txtCreditFinanceCharge.Text);
            clsDetails.CreditLatePenaltyCharge = decimal.Parse(txtCreditLatePenaltyCharge.Text);
            clsDetails.CreditMinimumAmountDue = decimal.Parse(txtCreditMinimumAmountDue.Text);
            clsDetails.CreditMinimumPercentageDue = decimal.Parse(txtCreditMinimumPercentageDue.Text);
            clsDetails.CreditFinanceCharge15th = decimal.Parse(txtCreditFinanceCharge15th.Text);
            clsDetails.CreditLatePenaltyCharge15th = decimal.Parse(txtCreditLatePenaltyCharge15th.Text);
            clsDetails.CreditMinimumAmountDue15th = decimal.Parse(txtCreditMinimumAmountDue15th.Text);
            clsDetails.CreditMinimumPercentageDue15th = decimal.Parse(txtCreditMinimumPercentageDue15th.Text);
            clsDetails.WithGuarantor = chkWithGuarantor.Checked;
            clsDetails.ExemptInTerminalCharge = chkExemptInTerminalCharge.Checked;
            clsDetails.CreatedOn = DateTime.Now;
            clsDetails.LastModified = DateTime.Now;

            Int32 id = clsCardType.Insert(clsDetails);

            clsCardType.CommitAndDispose();

            return id;
        }

        #endregion

    }
}
