namespace AceSoft.RetailPlus.Home.GLA
{
	using System;
	using System.Data;
	using System.Drawing;
	using System.Web;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;
	using AceSoft.RetailPlus.Data;
	using System.Xml;
	using System.IO;
    using System.Collections.Generic;


	/// <summary>
	///		Summary description for __Upload.
	/// </summary>
	public partial  class __UploadSales : System.Web.UI.UserControl
	{
        
		#region Web Form Methods

		protected void Page_Load(object sender, System.EventArgs e)
		{
			if (!IsPostBack)
			{
				lblReferrer.Text = Request.UrlReferrer == null ? Constants.ROOT_DIRECTORY : Request.UrlReferrer.ToString();
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
		
		///		Required method for Designer support - do not modify
		///		the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.imgCancel.Click += new System.Web.UI.ImageClickEventHandler(this.imgCancel_Click);
			this.imgUpload.Click += new System.Web.UI.ImageClickEventHandler(this.imgUpload_Click);

		}
		#endregion

		#region Web Control Methods

		private void imgCancel_Click(object sender, System.Web.UI.ImageClickEventArgs e)
		{
			Response.Redirect(lblReferrer.Text);
		}

		protected void cmdCancel_Click(object sender, System.EventArgs e)
		{
			Response.Redirect(lblReferrer.Text);
		}

		private void imgUpload_Click(object sender, System.Web.UI.ImageClickEventArgs e)
		{
			Upload();
		}

		protected void cmdUpload_Click(object sender, System.EventArgs e)
		{
			Upload();
		}


		#endregion

		#region Private Methods

		private void Upload()
		{
            try
            {
                string BatchID = string.Empty;

                List<HttpPostedFile> pfiles = new List<HttpPostedFile>();
                List<string> pfilesName = new List<string>();

                for (int i = 0; i < Request.Files.Count; i++)
                {
                    HttpPostedFile file = Request.Files[i];
                    if (file.ContentLength > 0)
                    {
                        pfiles.Add(file); pfilesName.Add(System.IO.Path.GetFileName(file.FileName.ToLower()));
                    }
                }

                Label1.Text = "";
                // Label1.Text = "Files to upload:";
                //Label1.Text += "      <br />"
                if (pfilesName.IndexOf(Constants.GLA_file_batch) < 0)
                    Label1.Text = "<br /><br /><b><font class='ms-error'>Please include the batch file in the upload. Filename: " + Constants.GLA_file_batch + "</font></b><br />";
                if (pfilesName.IndexOf(Constants.GLA_file_discount) < 0)
                    Label1.Text += "<br /><br /><b><font class='ms-error'>Please include the discount file in the upload. Filename: " + Constants.GLA_file_discount + "</font></b><br />";
                if (pfilesName.IndexOf(Constants.GLA_file_employee) < 0)
                    Label1.Text += "<br /><br /><b><font class='ms-error'>Please include the employees file in the upload. Filename: " + Constants.GLA_file_employee + "</font></b><br />";
                if (pfilesName.IndexOf(Constants.GLA_file_location) < 0)
                    Label1.Text += "<br /><br /><b><font class='ms-error'>Please include the location file in the upload. Filename: " + Constants.GLA_file_location + "</font></b><br />";
                //remove ths first: check why is 14MB not allowed in upload
                //if (pfilesName.IndexOf(Constants.GLA_file_menuitems) < 0)
                //    Label1.Text += "<br /><br /><b><font class='ms-error'>Please include the menu items file in the upload. Filename: " + Constants.GLA_file_menuitems + "</font></b><br />";
                if (pfilesName.IndexOf(Constants.GLA_file_servicecharge) < 0)
                    Label1.Text += "<br /><br /><b><font class='ms-error'>Please include the service charge file in the upload. Filename: " + Constants.GLA_file_servicecharge + "</font></b><br />";
                if (pfilesName.IndexOf(Constants.GLA_file_tender) < 0)
                    Label1.Text += "<br /><br /><b><font class='ms-error'>Please include the tender definitions file in the upload. Filename: " + Constants.GLA_file_tender + "</font></b><br />";
                if (pfilesName.IndexOf(Constants.GLA_file_checkdiscount) < 0)
                    Label1.Text += "<br /><br /><b><font class='ms-error'>Please include the discount details file in the upload. Filename: " + Constants.GLA_file_checkdiscount + "</font></b><br />";
                if (pfilesName.IndexOf(Constants.GLA_file_checkheaders) < 0)
                    Label1.Text += "<br /><br /><b><font class='ms-error'>Please include the check information file in the upload. Filename: " + Constants.GLA_file_checkheaders + "</font></b><br />";
                if (pfilesName.IndexOf(Constants.GLA_file_checksvscharge) < 0)
                    Label1.Text += "<br /><br /><b><font class='ms-error'>Please include the service charge file in the upload. Filename: " + Constants.GLA_file_checksvscharge + "</font></b><br />";
                if (pfilesName.IndexOf(Constants.GLA_file_checktenders) < 0)
                    Label1.Text += "<br /><br /><b><font class='ms-error'>Please include the tender detail file in the upload. Filename: " + Constants.GLA_file_checktenders + "</font></b><br />";
                if (pfilesName.IndexOf(Constants.GLA_file_otntender) < 0)
                    Label1.Text += "<br /><br /><b><font class='ms-error'>Please include the OTN_Tender file in the upload. Filename: " + Constants.GLA_file_otntender + "</font></b><br />";

                if (!string.IsNullOrEmpty(Label1.Text)) return;

                string strfile = "";
                string strfolder = "/RetailPlus/temp/uploaded/gla/";

                if (1==1)    //process batchfile
                {
                    strfile = Server.MapPath(strfolder + Constants.GLA_file_batch);

                    if (System.IO.File.Exists(strfile))
                        System.IO.File.Delete(strfile);

                    pfiles[pfilesName.IndexOf(Constants.GLA_file_batch)].SaveAs(strfile);

                    using (var reader = new StreamReader(strfile))
                    {
                        string line;
                        while ((line = reader.ReadLine()) != null)
                        {
                            //get the firstline as the batchid
                            BatchID = line;
                            break;
                        }
                    }
                }

                if (string.IsNullOrEmpty(BatchID))
                {
                    Label1.Text += "<br /><br /><b><font class='ms-error'>Cannot get any information from batch file. Please double check the batch file: " + Constants.GLA_file_batch + "</font></b><br />";
                    return;
                }

                Label1.Text += "<br /><br /><b><font class='ms-error'>Uploading Batch ID: " + BatchID + "</font></b><br />";

                // delete the temporary batch file
                if (System.IO.File.Exists(strfile))
                    System.IO.File.Delete(strfile);

                // save it again in a folder
                strfolder = strfolder + BatchID + "/";

                foreach (HttpPostedFile pfile in pfiles)
                {
                    strfile = Server.MapPath(strfolder + System.IO.Path.GetFileName(pfile.FileName));

                    if (!System.IO.Directory.Exists(Server.MapPath(strfolder)))
                        System.IO.Directory.CreateDirectory(Server.MapPath(strfolder));
                    
                    if (System.IO.File.Exists(strfile))
                        System.IO.File.Delete(strfile);

                    pfile.SaveAs(strfile);
                }

                //pfiles[pfilesName.IndexOf(Constants.GLA_file_batch)].SaveAs(strfile);
                
                //pfiles[pfilesName.IndexOf(Constants.GLA_file_batch)].SaveAs(strfile + Constants.GLA_file_batch);

                /***** upload the transaction *****/
                Label1.Text = "Processing" + Constants.GLA_file_checkheaders + " ...";
                strfile = Server.MapPath(strfolder + System.IO.Path.GetFileName(Constants.GLA_file_checkheaders));

                Security.AccessUserDetails clsAccessUserDetails = (Security.AccessUserDetails)Session["AccessUserDetails"];
                DateTime DateCreated = DateTime.Now;

                List<TransactionGLADetails> lstTransactionGLADetails = new List<TransactionGLADetails>();
                TransactionGLADetails clsTransactionGLADetails = new TransactionGLADetails();
                int iTranCount = 0;
                using (var reader = new StreamReader(strfile))
                {
                    string line;
                    while ((line = reader.ReadLine()) != null)
                    {
                        clsTransactionGLADetails = setHdrDetails(line, DateCreated, clsAccessUserDetails.Name, Constants.GLA_file_checkheaders, BatchID);
                        lstTransactionGLADetails.Add(clsTransactionGLADetails);
                            
                        iTranCount++;
                    }
                }

                TransactionGLA clsTransactionGLA = new TransactionGLA();
                Data.SalesTransactions clsTransaction = new SalesTransactions(clsTransactionGLA.Connection, clsTransactionGLA.Transaction);
                Data.SalesTransactionDetails clsSalesTransactionDetails = new SalesTransactionDetails();

                clsTransaction.DeleteByDataSource(BatchID);
                foreach (TransactionGLADetails det in lstTransactionGLADetails)
                {
                    clsTransactionGLA.Insert(det);
                    clsSalesTransactionDetails = setSalesTransactionDetails(det);

                    clsSalesTransactionDetails.TransactionID = clsTransaction.Insert(clsSalesTransactionDetails);
                    clsTransaction.Close(clsSalesTransactionDetails.TransactionID, clsSalesTransactionDetails.SubTotal, clsSalesTransactionDetails.ItemsDiscount, clsSalesTransactionDetails.Discount, clsSalesTransactionDetails.TransDiscount, clsSalesTransactionDetails.TransDiscountType, clsSalesTransactionDetails.VAT, clsSalesTransactionDetails.VatableAmount, clsSalesTransactionDetails.EVAT, clsSalesTransactionDetails.EVatableAmount, clsSalesTransactionDetails.LocalTax, clsSalesTransactionDetails.AmountPaid, clsSalesTransactionDetails.CashPayment, clsSalesTransactionDetails.ChequePayment, clsSalesTransactionDetails.CreditCardPayment, clsSalesTransactionDetails.CreditPayment, clsSalesTransactionDetails.DebitPayment, clsSalesTransactionDetails.RewardPointsPayment, clsSalesTransactionDetails.RewardConvertedPayment, clsSalesTransactionDetails.BalanceAmount, clsSalesTransactionDetails.ChangeAmount, clsSalesTransactionDetails.PaymentType, clsSalesTransactionDetails.DiscountCode, clsSalesTransactionDetails.DiscountRemarks, clsSalesTransactionDetails.Charge, clsSalesTransactionDetails.ChargeAmount, clsSalesTransactionDetails.ChargeCode, clsSalesTransactionDetails.ChargeRemarks, clsSalesTransactionDetails.CashierID, clsSalesTransactionDetails.CashierName);
                    clsTransaction.UpdateDateClosed(clsSalesTransactionDetails.TransactionID, clsSalesTransactionDetails.DateClosed);
                }
                Label1.Text += "      <br /><b><font class='ms-error'>" + lstTransactionGLADetails.Count.ToString() + " has been successfully uploaded...</font></b><br />";
                /***** upload the transaction end *****/

                /***** upload the otn tender *****/
                Label1.Text = "Processing" + Constants.GLA_file_otntender + " ...";
                strfile = Server.MapPath(strfolder + System.IO.Path.GetFileName(Constants.GLA_file_otntender));

                List<OrderTenderGLADetails> lstOrderTenderGLADetails = new List<OrderTenderGLADetails>();
                OrderTenderGLADetails clsOrderTenderGLADetails = new OrderTenderGLADetails();
                iTranCount = 0;
                using (var reader = new StreamReader(strfile))
                {
                    string line;
                    while ((line = reader.ReadLine()) != null)
                    {
                        clsOrderTenderGLADetails = setOrderTenderDetails(line, DateCreated, clsAccessUserDetails.Name, Constants.GLA_file_otntender, BatchID);
                        lstOrderTenderGLADetails.Add(clsOrderTenderGLADetails);

                        iTranCount++;
                    }
                }

                OrderTenderGLA clsOrderTenderGLA = new OrderTenderGLA(clsTransactionGLA.Connection, clsTransactionGLA.Transaction);

                Data.Contacts clsContacts = new Contacts(clsTransactionGLA.Connection, clsTransactionGLA.Transaction);
                Data.ContactDetails clsContactDetails = new ContactDetails();

                foreach (OrderTenderGLADetails det in lstOrderTenderGLADetails)
                {

                    clsOrderTenderGLA.Insert(det);
                    clsSalesTransactionDetails = clsTransaction.Details(det.tender_seq.ToString(), Constants.C_DEFAULT_TERMINAL_01, Constants.BRANCH_ID_MAIN);
                        
                    // update the customer information
                    clsSalesTransactionDetails = setSalesTransactionDetails(det, clsSalesTransactionDetails);
                    clsContactDetails = clsContacts.Details(det.auth_acct_no);

                    clsTransaction.UpdateContact(clsSalesTransactionDetails.TransactionID, clsSalesTransactionDetails.TransactionDate, clsContactDetails);
                        
                    //clsTransaction.Close(clsSalesTransactionDetails.TransactionID, clsSalesTransactionDetails.SubTotal, clsSalesTransactionDetails.ItemsDiscount, clsSalesTransactionDetails.Discount, clsSalesTransactionDetails.TransDiscount, clsSalesTransactionDetails.TransDiscountType, clsSalesTransactionDetails.VAT, clsSalesTransactionDetails.VatableAmount, clsSalesTransactionDetails.EVAT, clsSalesTransactionDetails.EVatableAmount, clsSalesTransactionDetails.LocalTax, clsSalesTransactionDetails.AmountPaid, clsSalesTransactionDetails.CashPayment, clsSalesTransactionDetails.ChequePayment, clsSalesTransactionDetails.CreditCardPayment, clsSalesTransactionDetails.CreditPayment, clsSalesTransactionDetails.DebitPayment, clsSalesTransactionDetails.RewardPointsPayment, clsSalesTransactionDetails.RewardConvertedPayment, clsSalesTransactionDetails.BalanceAmount, clsSalesTransactionDetails.ChangeAmount, clsSalesTransactionDetails.PaymentType, clsSalesTransactionDetails.DiscountCode, clsSalesTransactionDetails.DiscountRemarks, clsSalesTransactionDetails.Charge, clsSalesTransactionDetails.ChargeAmount, clsSalesTransactionDetails.ChargeCode, clsSalesTransactionDetails.ChargeRemarks, clsSalesTransactionDetails.CashierID, clsSalesTransactionDetails.CashierName);
                    //clsTransaction.UpdateDateClosed(clsSalesTransactionDetails.TransactionID, clsSalesTransactionDetails.DateClosed);
                }
                clsTransactionGLA.CommitAndDispose();
                Label1.Text += "      <br /><b><font class='ms-error'>" + lstOrderTenderGLADetails.Count.ToString() + " has been successfully uploaded...</font></b><br />";

            }
            catch (Exception ex){
                throw ex;
            }
		}


        private TransactionGLADetails setHdrDetails(string line, DateTime DateCreated, string CreatedBy, string filename, string BatchID)
        {
            DateTime dteRetvalue = Constants.C_DATE_MIN_VALUE;
            int intRetValue = 0;
            bool boRetValue = false;
            decimal decRetValue = 0;
            TransactionGLADetails clsDetails = new TransactionGLADetails();

            int iCol = 0;
            foreach (string col in line.Split(','))
            {
                dteRetvalue = Constants.C_DATE_MIN_VALUE;
                intRetValue = 0;

                switch (iCol)
                {
                    case 0: clsDetails.fk_business_date = DateTime.TryParse(col, out dteRetvalue) ? dteRetvalue : Constants.C_DATE_MIN_VALUE; break;
                    case 1: clsDetails.fk_location_def = int.TryParse(col, out intRetValue) ? intRetValue : 0; break;
                    case 2: clsDetails.fk_emp_def = int.TryParse(col, out intRetValue) ? intRetValue : 0; break;
                    case 3: clsDetails.status_flag = col; break;
                    case 4: clsDetails.chk_headers_seq_number = int.TryParse(col, out intRetValue) ? intRetValue : 0; break;
                    case 5: clsDetails.chk_num = int.TryParse(col, out intRetValue) ? intRetValue : 0; break;
                    case 6: clsDetails.chk_id = col; break;
                    case 7: clsDetails.ot_number = int.TryParse(col, out intRetValue) ? intRetValue : 0; break;
                    case 8: clsDetails.Ot_Name = col; break;
                    case 9: clsDetails.Tbl_Number = int.TryParse(col, out intRetValue) ? intRetValue : 0; break;
                    case 10: clsDetails.Chk_Open_Date_Time = DateTime.TryParse(col, out dteRetvalue) ? dteRetvalue : Constants.C_DATE_MIN_VALUE; break;
                    case 11: clsDetails.Chk_Closed_Date_Time = DateTime.TryParse(col, out dteRetvalue) ? dteRetvalue : Constants.C_DATE_MIN_VALUE; break;
                    case 12: clsDetails.Uws_Number = int.TryParse(col, out intRetValue) ? intRetValue : 0; break;
                    case 13: clsDetails.Is_HotelMark_Promo = Convert.ToBoolean(int.TryParse(col, out intRetValue) ? intRetValue : 0); break;
                    case 14: clsDetails.Sub_Ttl = decimal.TryParse(col, out decRetValue) ? decRetValue : 0; break;
                    case 15: clsDetails.Tax_Ttl = decimal.TryParse(col, out decRetValue) ? decRetValue : 0; break;
                    case 16: clsDetails.Auto_Svc_Ttl = decimal.TryParse(col, out decRetValue) ? decRetValue : 0; break;
                    case 17: clsDetails.Other_Svc_Ttl = decimal.TryParse(col, out decRetValue) ? decRetValue : 0; break;
                    case 18: clsDetails.Dsc_Ttl = decimal.TryParse(col, out decRetValue) ? decRetValue : 0; break;
                    case 19: clsDetails.Pymnt_Ttl = decimal.TryParse(col, out decRetValue) ? decRetValue : 0; break;
                    case 20: clsDetails.Chk_Prntd_Cnt = int.TryParse(col, out intRetValue) ? intRetValue : 0; break;
                    case 21: clsDetails.Cov_Cnt = int.TryParse(col, out intRetValue) ? intRetValue : 0; break;
                    case 22: clsDetails.Num_Dtl = int.TryParse(col, out intRetValue) ? intRetValue : 0; break;
                    case 23: clsDetails.Itemizer1 = decimal.TryParse(col, out decRetValue) ? decRetValue : 0; break;
                    case 24: clsDetails.Itemizer2 = decimal.TryParse(col, out decRetValue) ? decRetValue : 0; break;
                    case 25: clsDetails.Itemizer3 = decimal.TryParse(col, out decRetValue) ? decRetValue : 0; break;
                    case 26: clsDetails.Itemizer4 = decimal.TryParse(col, out decRetValue) ? decRetValue : 0; break;
                    case 27: clsDetails.Itemizer5 = decimal.TryParse(col, out decRetValue) ? decRetValue : 0; break;
                    case 28: clsDetails.Itemizer6 = decimal.TryParse(col, out decRetValue) ? decRetValue : 0; break;
                    case 29: clsDetails.Itemizer7 = decimal.TryParse(col, out decRetValue) ? decRetValue : 0; break;
                    case 30: clsDetails.Itemizer8 = decimal.TryParse(col, out decRetValue) ? decRetValue : 0; break;
                    case 31: clsDetails.Itemizer9 = decimal.TryParse(col, out decRetValue) ? decRetValue : 0; break;
                    case 32: clsDetails.Itemizer10 = decimal.TryParse(col, out decRetValue) ? decRetValue : 0; break;
                    case 33: clsDetails.Itemizer11 = decimal.TryParse(col, out decRetValue) ? decRetValue : 0; break;
                    case 34: clsDetails.Itemizer12 = decimal.TryParse(col, out decRetValue) ? decRetValue : 0; break;
                    case 35: clsDetails.Itemizer13 = decimal.TryParse(col, out decRetValue) ? decRetValue : 0; break;
                    case 36: clsDetails.Itemizer14 = decimal.TryParse(col, out decRetValue) ? decRetValue : 0; break;
                    case 37: clsDetails.Itemizer15 = decimal.TryParse(col, out decRetValue) ? decRetValue : 0; break;
                    case 38: clsDetails.Itemizer16 = decimal.TryParse(col, out decRetValue) ? decRetValue : 0; break;
                    case 39: clsDetails.Tip_ttl = decimal.TryParse(col, out decRetValue) ? decRetValue : 0; break;
                }
                iCol++;
            }
            clsDetails.DateCreated = DateCreated;
            clsDetails.CreatedBy = CreatedBy;
            clsDetails.Filename = filename;
            clsDetails.BatchID = BatchID;

            return clsDetails;
        }
        private SalesTransactionDetails setSalesTransactionDetails(TransactionGLADetails glaDetails)
        {
            SalesTransactionDetails mclsSalesTransactionDetails = new SalesTransactionDetails();

            // for insert
            mclsSalesTransactionDetails.CustomerID = glaDetails.fk_emp_def;
            mclsSalesTransactionDetails.AgentID = Constants.C_RETAILPLUS_AGENTID;
            mclsSalesTransactionDetails.AgentName = Constants.C_RETAILPLUS_AGENT;
            mclsSalesTransactionDetails.AgentPositionName = Constants.C_RETAILPLUS_AGENT_POSITIONNAME;
            mclsSalesTransactionDetails.AgentDepartmentName = Constants.C_RETAILPLUS_AGENT_DEPARTMENT_NAME;
            mclsSalesTransactionDetails.WaiterID = Constants.C_RETAILPLUS_WAITERID;
            mclsSalesTransactionDetails.WaiterName = Constants.C_RETAILPLUS_WAITER;
            mclsSalesTransactionDetails.CreatedByID = glaDetails.fk_emp_def;
            mclsSalesTransactionDetails.CreatedByName = Constants.C_RETAILPLUS_WAITER;
            mclsSalesTransactionDetails.CashierID = glaDetails.fk_emp_def;
            mclsSalesTransactionDetails.CashierName = glaDetails.Filename;
            mclsSalesTransactionDetails.CustomerID = Constants.C_RETAILPLUS_CUSTOMERID;
            mclsSalesTransactionDetails.CustomerName = Constants.C_RETAILPLUS_CUSTOMER;
            mclsSalesTransactionDetails.TransactionDate = glaDetails.Chk_Open_Date_Time;
            mclsSalesTransactionDetails.DateSuspended = Constants.C_DATE_MIN_VALUE;
            mclsSalesTransactionDetails.TerminalNo = Constants.C_DEFAULT_TERMINAL_01;
            mclsSalesTransactionDetails.BranchID = Constants.BRANCH_ID_MAIN;
            mclsSalesTransactionDetails.BranchCode = Constants.BRANCH_MAIN;
            mclsSalesTransactionDetails.TransactionStatus = TransactionStatus.Closed;
            mclsSalesTransactionDetails.TransactionType = TransactionTypes.POSNormal;
            mclsSalesTransactionDetails.TransactionNo = glaDetails.chk_headers_seq_number.ToString();

            //for update
            mclsSalesTransactionDetails.Charge = glaDetails.Auto_Svc_Ttl + glaDetails.Other_Svc_Ttl + glaDetails.Tip_ttl;
            mclsSalesTransactionDetails.Discount = -glaDetails.Dsc_Ttl;
            mclsSalesTransactionDetails.AmountDue = glaDetails.Sub_Ttl + glaDetails.Tax_Ttl + mclsSalesTransactionDetails.Charge - mclsSalesTransactionDetails.Discount;
            mclsSalesTransactionDetails.SubTotal = glaDetails.Sub_Ttl + glaDetails.Tax_Ttl + mclsSalesTransactionDetails.Charge;

            mclsSalesTransactionDetails.DiscountableAmount = mclsSalesTransactionDetails.Discount <= 0 ? 0 : glaDetails.Dsc_Ttl;
            mclsSalesTransactionDetails.ItemsDiscount = 0;
            mclsSalesTransactionDetails.VAT = glaDetails.Tax_Ttl;
            mclsSalesTransactionDetails.VatableAmount = glaDetails.Sub_Ttl + glaDetails.Tax_Ttl;
            mclsSalesTransactionDetails.NonVATableAmount = 0;
            mclsSalesTransactionDetails.EVAT = 0;
            mclsSalesTransactionDetails.EVatableAmount = 0;
            mclsSalesTransactionDetails.NonEVATableAmount = glaDetails.Sub_Ttl + glaDetails.Tax_Ttl;
            mclsSalesTransactionDetails.LocalTax = 0;
            mclsSalesTransactionDetails.TotalItemSold = glaDetails.Cov_Cnt;
            mclsSalesTransactionDetails.TotalQuantitySold = glaDetails.Num_Dtl;

            mclsSalesTransactionDetails.AmountPaid = glaDetails.Pymnt_Ttl;
            mclsSalesTransactionDetails.CashPayment = mclsSalesTransactionDetails.SubTotal;
            mclsSalesTransactionDetails.ChangeAmount = glaDetails.Pymnt_Ttl; 
            mclsSalesTransactionDetails.ChequePayment = 0;
            mclsSalesTransactionDetails.CreditCardPayment = 0;
            mclsSalesTransactionDetails.CreditPayment = 0;
            mclsSalesTransactionDetails.CreditChargeAmount = 0;
            mclsSalesTransactionDetails.DebitPayment = 0;
            mclsSalesTransactionDetails.RewardPointsPayment = 0;
            mclsSalesTransactionDetails.DateClosed = glaDetails.Chk_Closed_Date_Time;
            mclsSalesTransactionDetails.DateResumed = glaDetails.DateCreated;
            mclsSalesTransactionDetails.DataSource = glaDetails.BatchID;

            return mclsSalesTransactionDetails;
        }

        private OrderTenderGLADetails setOrderTenderDetails(string line, DateTime DateCreated, string CreatedBy, string filename, string BatchID)
        {
            DateTime dteRetvalue = Constants.C_DATE_MIN_VALUE;
            long lngRetValue = 0;
            int intRetValue = 0;
            decimal decRetValue = 0;
            OrderTenderGLADetails clsDetails = new OrderTenderGLADetails();

            int iCol = 0;
            int iColText = 0;
            foreach (string colText in line.Split('"'))
            {
                switch (iColText)
                {
                    case 0: break;
                    case 1: clsDetails.identifier = colText; break;
                    case 2:
                        iCol = 0;
                        foreach (string col in colText.Split(','))
                        {
                            dteRetvalue = Constants.C_DATE_MIN_VALUE;
                            intRetValue = 0;

                            string col2 = col.Replace("$", "").Trim();
                            switch (iCol)
                            {
                                case 0: break;
                                case 1: clsDetails.order_hdr_id = long.TryParse(col2, out lngRetValue) ? lngRetValue : 0; break;
                                case 2: clsDetails.tender_seq = long.TryParse(col2, out lngRetValue) ? lngRetValue : 0; break;
                                case 3: clsDetails.tender_id = long.TryParse(col2, out lngRetValue) ? lngRetValue : 0; break;
                                case 4: clsDetails.tender_amt = decimal.TryParse(col2, out decRetValue) ? decRetValue : 0; break;
                                case 5: clsDetails.prorata_sales_amt_gross = decimal.TryParse(col2, out decRetValue) ? decRetValue : 0; break;
                                case 6: clsDetails.prorata_discount_amt = decimal.TryParse(col2, out decRetValue) ? decRetValue : 0; break;
                                case 7: clsDetails.prorata_tax_amt = decimal.TryParse(col2, out decRetValue) ? decRetValue : 0; break;
                                case 8: clsDetails.prorata_grat_amt = decimal.TryParse(col2, out decRetValue) ? decRetValue : 0; break;
                                case 9: clsDetails.prorata_svc_chg_amt = decimal.TryParse(col2, out decRetValue) ? decRetValue : 0; break;
                                case 10: clsDetails.tip_amt = decimal.TryParse(col2, out decRetValue) ? decRetValue : 0; break;
                                case 11: clsDetails.breakage_amt = decimal.TryParse(col2, out decRetValue) ? decRetValue : 0; break;
                                case 12: clsDetails.received_curr_amt = decimal.TryParse(col2, out decRetValue) ? decRetValue : 0; break;
                                case 13: clsDetails.curr_decimal_places = int.TryParse(col2, out intRetValue) ? intRetValue : 0; break;
                                case 14: clsDetails.exchange_rate = int.TryParse(col2, out intRetValue) ? intRetValue : 0; break;
                                case 15: clsDetails.change_amt = decimal.TryParse(col2, out decRetValue) ? decRetValue : 0; break;
                                case 16: clsDetails.change_tender_id = int.TryParse(col2, out intRetValue) ? intRetValue : 0; break;
                                case 17: clsDetails.tax_removed_code = int.TryParse(col2, out intRetValue) ? intRetValue : 0; break;
                                case 18: clsDetails.tender_type_id = int.TryParse(col2, out intRetValue) ? intRetValue : 0; break;
                                case 19: clsDetails.subtender_id = int.TryParse(col2, out intRetValue) ? intRetValue : 0; break;
                                
                            }
                            iCol++;
                        }
                        break;
                    case 3: clsDetails.auth_acct_no = colText; break;
                    case 4: break;
                    case 5: clsDetails.post_acct_no = colText; break;
                    case 6: break;
                    case 7: clsDetails.customer_name = colText; break;
                    case 8:
                        iCol = 0;
                        foreach (string col in colText.Split(','))
                        {
                            dteRetvalue = Constants.C_DATE_MIN_VALUE;
                            intRetValue = 0;

                            string col2 = col.Replace("$", "").Trim();
                            switch (iCol)
                            {
                                case 0: break;
                                case 1: break;
                                case 2: clsDetails.adtnl_info = col2; break;
                                case 3: clsDetails.subtender_qty = int.TryParse(col2, out intRetValue) ? intRetValue : 0; break;
                                case 4: clsDetails.charges_to_date_amt = decimal.TryParse(col2, out decRetValue) ? decRetValue : 0; break;
                                case 5: clsDetails.remaining_balance_amt = decimal.TryParse(col2, out decRetValue) ? decRetValue : 0; break;
                                case 6: clsDetails.PMS_post_flag = Convert.ToBoolean(int.TryParse(col2, out intRetValue) ? intRetValue : 0); break;
                                case 7: clsDetails.sales_tippable_flag = Convert.ToBoolean(int.TryParse(col2, out intRetValue) ? intRetValue : 0); break;
                                case 8: clsDetails.post_system1_flag = Convert.ToBoolean(int.TryParse(col2, out intRetValue) ? intRetValue : 0); break;
                                case 9: clsDetails.post_system2_flag = Convert.ToBoolean(int.TryParse(col2, out intRetValue) ? intRetValue : 0); break;
                                case 10: clsDetails.post_system3_flag = Convert.ToBoolean(int.TryParse(col2, out intRetValue) ? intRetValue : 0); break;
                                case 11: clsDetails.post_system4_flag = Convert.ToBoolean(int.TryParse(col2, out intRetValue) ? intRetValue : 0); break;
                                case 12: clsDetails.post_system5_flag = Convert.ToBoolean(int.TryParse(col2, out intRetValue) ? intRetValue : 0); break;
                                case 13: clsDetails.post_system6_flag = Convert.ToBoolean(int.TryParse(col2, out intRetValue) ? intRetValue : 0); break;
                                case 14: clsDetails.post_system7_flag = Convert.ToBoolean(int.TryParse(col2, out intRetValue) ? intRetValue : 0); break;
                                case 15: clsDetails.post_system8_flag = Convert.ToBoolean(int.TryParse(col2, out intRetValue) ? intRetValue : 0); break;
                            }
                            iCol++;
                        }
                        break;
                }
                iColText++;
            }

            clsDetails.DateCreated = DateCreated;
            clsDetails.CreatedBy = CreatedBy;
            clsDetails.Filename = filename;
            clsDetails.BatchID = BatchID;

            return clsDetails;
        }
        private SalesTransactionDetails setSalesTransactionDetails(OrderTenderGLADetails glaDetails, SalesTransactionDetails mclsSalesTransactionDetails)
        {

            // for update
            
            //mclsSalesTransactionDetails.CustomerID = glaDetails.fk_emp_def;
            //mclsSalesTransactionDetails.AgentID = Constants.C_RETAILPLUS_AGENTID;
            //mclsSalesTransactionDetails.AgentName = Constants.C_RETAILPLUS_AGENT;
            //mclsSalesTransactionDetails.AgentPositionName = Constants.C_RETAILPLUS_AGENT_POSITIONNAME;
            //mclsSalesTransactionDetails.AgentDepartmentName = Constants.C_RETAILPLUS_AGENT_DEPARTMENT_NAME;
            //mclsSalesTransactionDetails.WaiterID = Constants.C_RETAILPLUS_WAITERID;
            //mclsSalesTransactionDetails.WaiterName = Constants.C_RETAILPLUS_WAITER;
            //mclsSalesTransactionDetails.CreatedByID = glaDetails.fk_emp_def;
            //mclsSalesTransactionDetails.CreatedByName = Constants.C_RETAILPLUS_WAITER;
            //mclsSalesTransactionDetails.CashierID = glaDetails.fk_emp_def;
            //mclsSalesTransactionDetails.CashierName = glaDetails.Filename;
            //mclsSalesTransactionDetails.CustomerID = Constants.C_RETAILPLUS_CUSTOMERID;
            //mclsSalesTransactionDetails.CustomerName = Constants.C_RETAILPLUS_CUSTOMER;
            //mclsSalesTransactionDetails.TransactionDate = glaDetails.Chk_Open_Date_Time;
            //mclsSalesTransactionDetails.DateSuspended = Constants.C_DATE_MIN_VALUE;
            //mclsSalesTransactionDetails.TerminalNo = Constants.C_DEFAULT_TERMINAL_01;
            //mclsSalesTransactionDetails.BranchID = Constants.BRANCH_ID_MAIN;
            //mclsSalesTransactionDetails.BranchCode = Constants.BRANCH_MAIN;
            //mclsSalesTransactionDetails.TransactionStatus = TransactionStatus.Closed;
            //mclsSalesTransactionDetails.TransactionType = TransactionTypes.POSNormal;
            //mclsSalesTransactionDetails.TransactionNo = glaDetails.chk_headers_seq_number.ToString();

            ////for update
            //mclsSalesTransactionDetails.Charge = glaDetails.Auto_Svc_Ttl + glaDetails.Other_Svc_Ttl + glaDetails.Tip_ttl;
            //mclsSalesTransactionDetails.Discount = -glaDetails.Dsc_Ttl;
            //mclsSalesTransactionDetails.AmountDue = glaDetails.Sub_Ttl + glaDetails.Tax_Ttl + mclsSalesTransactionDetails.Charge - mclsSalesTransactionDetails.Discount;
            //mclsSalesTransactionDetails.SubTotal = glaDetails.Sub_Ttl + glaDetails.Tax_Ttl + mclsSalesTransactionDetails.Charge;

            //mclsSalesTransactionDetails.DiscountableAmount = mclsSalesTransactionDetails.Discount <= 0 ? 0 : glaDetails.Dsc_Ttl;
            //mclsSalesTransactionDetails.ItemsDiscount = 0;
            //mclsSalesTransactionDetails.VAT = glaDetails.Tax_Ttl;
            //mclsSalesTransactionDetails.VatableAmount = glaDetails.Sub_Ttl + glaDetails.Tax_Ttl;
            //mclsSalesTransactionDetails.NonVATableAmount = 0;
            //mclsSalesTransactionDetails.EVAT = 0;
            //mclsSalesTransactionDetails.EVatableAmount = 0;
            //mclsSalesTransactionDetails.NonEVATableAmount = glaDetails.Sub_Ttl + glaDetails.Tax_Ttl;
            //mclsSalesTransactionDetails.LocalTax = 0;
            //mclsSalesTransactionDetails.TotalItemSold = glaDetails.Cov_Cnt;
            //mclsSalesTransactionDetails.TotalQuantitySold = glaDetails.Num_Dtl;

            //mclsSalesTransactionDetails.AmountPaid = glaDetails.Pymnt_Ttl;
            //mclsSalesTransactionDetails.CashPayment = mclsSalesTransactionDetails.SubTotal;
            //mclsSalesTransactionDetails.ChangeAmount = glaDetails.Pymnt_Ttl;
            //mclsSalesTransactionDetails.ChequePayment = 0;
            //mclsSalesTransactionDetails.CreditCardPayment = 0;
            //mclsSalesTransactionDetails.CreditPayment = 0;
            //mclsSalesTransactionDetails.CreditChargeAmount = 0;
            //mclsSalesTransactionDetails.DebitPayment = 0;
            //mclsSalesTransactionDetails.RewardPointsPayment = 0;
            //mclsSalesTransactionDetails.DateClosed = glaDetails.Chk_Closed_Date_Time;
            //mclsSalesTransactionDetails.DateResumed = glaDetails.DateCreated;
            //mclsSalesTransactionDetails.DataSource = glaDetails.BatchID;

            return mclsSalesTransactionDetails;
        }

		#endregion
	}
}
