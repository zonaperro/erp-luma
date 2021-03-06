using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using AceSoft.RetailPlus.Security;

namespace AceSoft.RetailPlus.GeneralLedger._Setup
{
	public partial class _Default : System.Web.UI.Page
	{
		protected void Page_Load(object sender, System.EventArgs e)
		{
			const string defaultHeading = "General Ledger";
			string stHeading = defaultHeading;			

			const string defaultTitle = "RetailPlus General Ledger Management";
			SiteTitle.Title = defaultTitle;

			const SearchCategoryID defaultSearchIndex = SearchCategoryID.NotApplicable;
			SearchCategoryID SearchIndex = defaultSearchIndex;			

			HorizontalNavBar.PageNavigatorid = HorizontalNavID.GeneralLedger;
			
			if (Request.QueryString["task"]!=null)
			{
				string task = Common.Decrypt(Request.QueryString["task"].ToString(),Session.SessionID);
				switch(task)
				{
					case "postingdates":
						stHeading = "Allowable Posting Dates Setup";		
						SearchIndex = SearchCategoryID.NotApplicable;
						ctrlPostingDates.Visible = true;
						break;
                    case "linkaccountsap":
                        stHeading = "Setup Links of Payable to Accounts";
                        SearchIndex = SearchCategoryID.NotApplicable;
                        ctrlLinkAccountsAP.Visible = true;
                        break;
                    case "linkaccountsprod":
                        stHeading = "Setup Links of Product to Accounts";
                        SearchIndex = SearchCategoryID.NotApplicable;
                        ctrlProductFinancialSetup.Visible = true;
                        break;	
					default:	
						break;
				}
			}
			LargeHeading.Text = stHeading;
			RightBodySectionSearch.SearchIDSelectedItem = SearchIndex;
		}

		private void ManageSecurity()
		{
			Int64 UID = Convert.ToInt64(Session["UID"]);
			AccessRights clsAccessRights = new AccessRights(); 
			AccessRightsDetails clsDetails = new AccessRightsDetails();

			clsDetails = clsAccessRights.Details(UID,(int) AccessTypes.PurchasesAndPayablesMenu); 
			if (clsDetails.Read==false)
				Server.Transfer("/RetailPlus/Home/Default.aspx");
			clsAccessRights.CommitAndDispose();
		}

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{    

		}
		#endregion
	}
}
