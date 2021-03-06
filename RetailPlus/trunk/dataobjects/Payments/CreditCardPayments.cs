using System;
using System.Collections;
using System.Security.Permissions;
using MySql.Data.MySqlClient;

namespace AceSoft.RetailPlus.Data
{

	[StrongNameIdentityPermissionAttribute(SecurityAction.LinkDemand,
		 PublicKey = "002400000480000094000000060200000024000" +
		 "052534131000400000100010053D785642F9F960B43157E0380" +
		 "F393BEE53E8DFAFBF441366C1B6F8B48D9DDF0D527B1F3B21EA" +
		 "E85D2FDB664CE81EB8A87DBE4C589D6F4202FE2B7D4B978BB69" +
		 "684874612CB9B8DB7A0339400A9C4E68277884B07817363D242" +
		 "E3696F9FACDBEA831810AE6DC9EDCA91A7B5DA12FE7BF65D113" +
		 "FF52834EAFB5A7A1FDFD5851A3")]
	public struct CreditCardPaymentDetails
	{
        public BranchDetails BranchDetails;
        public string TerminalNo;
        public Int64 SyncID;
        public Int64 CreditCardPaymentID;
		public Int64 TransactionID;
        public string TransactionNo;
        public DateTime TransactionDate;
        public string CashierName;
		public decimal Amount;
        public decimal AdditionalCharge;
        public Int64 ContactID;
        public Int64 GuarantorID;
        public Int16 CardTypeID;
	    public string CardTypeCode;
	    public string CardTypeName;
        public string CardNo;
	    public string CardHolder;
		public string ValidityDates;
		public string Remarks;
        

        public DateTime CreatedOn;
        public DateTime LastModified;

        public CardTypeDetails CardTypeDetails;
        public ContactDetails CreditorDetails;
        public bool IsRefund;
	}

	[StrongNameIdentityPermissionAttribute(SecurityAction.LinkDemand,
		 PublicKey = "002400000480000094000000060200000024000" +
		 "052534131000400000100010053D785642F9F960B43157E0380" +
		 "F393BEE53E8DFAFBF441366C1B6F8B48D9DDF0D527B1F3B21EA" +
		 "E85D2FDB664CE81EB8A87DBE4C589D6F4202FE2B7D4B978BB69" +
		 "684874612CB9B8DB7A0339400A9C4E68277884B07817363D242" +
		 "E3696F9FACDBEA831810AE6DC9EDCA91A7B5DA12FE7BF65D113" +
		 "FF52834EAFB5A7A1FDFD5851A3")]
	public class CreditCardPayments : POSConnection
    {
		#region Constructors and Destructors

		public CreditCardPayments()
            : base(null, null)
        {
        }

        public CreditCardPayments(MySqlConnection Connection, MySqlTransaction Transaction) 
            : base(Connection, Transaction)
		{

		}

		#endregion

		#region Insert and Update

        public Int64 Insert(CreditCardPaymentDetails Details)
		{
			try  
			{
                Save(Details);

                return Int64.Parse(base.getLAST_INSERT_ID(this));
			}
			catch (Exception ex)
			{
				throw base.ThrowException(ex);
			}	
		}

        public Int32 Save(CreditCardPaymentDetails Details)
        {
            try
            {
                MySqlCommand cmd = new MySqlCommand();
                cmd.CommandType = System.Data.CommandType.Text;

                string SQL = "CALL procSaveCreditCardPayment(@BranchID, @TerminalNo, @SyncID, @CreditCardPaymentID, @TransactionID, @TransactionDate, @CashierName, @Amount, @AdditionalCharge, " +
                                                            "@ContactID, @GuarantorID, @CardTypeID, @CardTypeCode, @CardTypeName, @CardNo, @CardHolder, @ValidityDates, @Remarks, @TransactionNo, @CreatedOn, @LastModified);";

                cmd.Parameters.AddWithValue("BranchID", Details.BranchDetails.BranchID);
                cmd.Parameters.AddWithValue("TerminalNo", Details.TerminalNo);
                cmd.Parameters.AddWithValue("SyncID", Details.SyncID);
                cmd.Parameters.AddWithValue("CreditCardPaymentID", Details.CreditCardPaymentID);
                cmd.Parameters.AddWithValue("TransactionID", Details.TransactionID);
                cmd.Parameters.AddWithValue("TransactionDate", Details.TransactionDate);
                cmd.Parameters.AddWithValue("CashierName", Details.CashierName);
                cmd.Parameters.AddWithValue("Amount", Details.Amount);
                cmd.Parameters.AddWithValue("AdditionalCharge", Details.AdditionalCharge);
                cmd.Parameters.AddWithValue("ContactID", Details.CreditorDetails.ContactID);
                cmd.Parameters.AddWithValue("GuarantorID", Details.CreditorDetails.CreditDetails.GuarantorID);
                cmd.Parameters.AddWithValue("CardTypeID", Details.CardTypeID);
                cmd.Parameters.AddWithValue("CardTypeCode", Details.CardTypeCode);
                cmd.Parameters.AddWithValue("CardTypeName", Details.CardTypeName);
                cmd.Parameters.AddWithValue("CardNo", Details.CardNo);
                cmd.Parameters.AddWithValue("CardHolder", Details.CardHolder);
                cmd.Parameters.AddWithValue("ValidityDates", Details.ValidityDates);
                cmd.Parameters.AddWithValue("Remarks", Details.Remarks);
                cmd.Parameters.AddWithValue("TransactionNo", Details.TransactionNo);
                cmd.Parameters.AddWithValue("CreatedOn", Details.CreatedOn == DateTime.MinValue ? Constants.C_DATE_MIN_VALUE : Details.CreatedOn);
                cmd.Parameters.AddWithValue("LastModified", Details.LastModified == DateTime.MinValue ? Constants.C_DATE_MIN_VALUE : Details.LastModified);

                cmd.CommandText = SQL;
                Int32 iRetValue = base.ExecuteNonQuery(cmd);

                // update this if it's an insert
                if (Details.CreditCardPaymentID == 0) Details.CreditCardPaymentID = Int64.Parse(base.getLAST_INSERT_ID(this));

                //save the credit if inhouse credit
                if (Details.CreditorDetails.ContactID != 0)
                {
                    CreditPaymentDetails clsCreditPaymentDetails = new CreditPaymentDetails();

                    clsCreditPaymentDetails.BranchDetails = Details.BranchDetails;
                    clsCreditPaymentDetails.TerminalNo = Details.TerminalNo;
                    clsCreditPaymentDetails.TransactionID = Details.TransactionID;
                    clsCreditPaymentDetails.TransactionNo = Details.TransactionNo;
                    clsCreditPaymentDetails.IsRefund = Details.IsRefund;
                    clsCreditPaymentDetails.TransactionDate = Details.TransactionDate;
                    clsCreditPaymentDetails.CashierName = Details.CashierName;
                    clsCreditPaymentDetails.Amount = Details.Amount;
                    clsCreditPaymentDetails.CustomerDetails = Details.CreditorDetails;
                    clsCreditPaymentDetails.Remarks = Details.Remarks;

                    string additionalRemarks = Details.Remarks;
                    if (!string.IsNullOrEmpty(Details.Remarks))
                        additionalRemarks = ";" + (Details.Remarks.Length > 30 ? Details.Remarks.Substring(0, 30) : Details.Remarks);

                    if (!Details.IsRefund)
                        clsCreditPaymentDetails.CreditReason = CreditReason.IHCC.ToString("G") + " @ Ter#:" + Details.TerminalNo + " Br#:" + Details.BranchDetails.BranchID.ToString() + additionalRemarks;
                    else
                        clsCreditPaymentDetails.CreditReason = CreditReason.IHCC.ToString("G") + " @ Ter#:" + Details.TerminalNo + " Br#:" + Details.BranchDetails.BranchID.ToString() + additionalRemarks + " Refund";

                    clsCreditPaymentDetails.CreditCardPaymentID = Details.CreditCardPaymentID;
                    clsCreditPaymentDetails.CreditCardTypeID = Details.CardTypeDetails.CardTypeID;

                    new CreditPayments(base.Connection, base.Transaction).Insert(clsCreditPaymentDetails);

                    // no need for this this is already included in the insert of CreditPayments
                    //Contacts clsContact = new Contacts(base.Connection, base.Transaction);
                    //if (!Details.IsRefund)
                    //    clsContact.AddCredit(Details.CreditorDetails.ContactID, Details.Amount);
                    //else
                    //    clsContact.AddCredit(Details.CreditorDetails.ContactID, -Details.Amount);
                }

                return iRetValue;
            }
            catch (Exception ex)
            {
                throw base.ThrowException(ex);
            }
        }
		
		#endregion

		#region Delete

		public bool Delete(string IDs)
		{
			try 
			{
                MySqlCommand cmd = new MySqlCommand();
                cmd.CommandType = System.Data.CommandType.Text;

                string SQL = "DELETE FROM tblCreditCardPayment WHERE PaymentID IN (" + IDs + ");";
	 			
				cmd.CommandText = SQL;
				base.ExecuteNonQuery(cmd);

				return true;
			}
			catch (Exception ex)
			{
				throw base.ThrowException(ex);
			}	
		}


		#endregion

        private string SQLSelect()
        {
            string stSQL = "SELECT BranchID, TerminalNo, SyncID, CreditCardPaymentID, TransactionID, TransactionDate, Amount, AdditionalCharge, ContactID, GuarantorID, CardTypeID, CardTypeCode, CardTypeName, CardNo, CardHolder, ValidityDates, Remarks, TransactionNo, CreatedOn, LastModified " +
                            "FROM tblCreditCardPayment ";

            return stSQL;
        }

		#region Details

        /// <summary>
        /// Get the cash payment details of a certain transaction.
        /// </summary>
        /// <param name="BranchID"></param>
        /// <param name="TerminalNo"></param>
        /// <param name="SyncID">Same also as the TransactionID</param>
        /// <returns></returns>
        public CreditCardPaymentDetails[] Details(Int32 BranchID, string TerminalNo, Int64 TransactionID)
        {
            try
            {
                MySqlCommand cmd = new MySqlCommand();
                cmd.CommandType = System.Data.CommandType.Text;

                string SQL = SQLSelect() + "WHERE BranchID = @BranchID AND TerminalNo = @TerminalNo AND TransactionID = @TransactionID;";

                cmd.Parameters.AddWithValue("BranchID", BranchID);
                cmd.Parameters.AddWithValue("TerminalNo", TerminalNo);
                cmd.Parameters.AddWithValue("TransactionID", TransactionID);

                cmd.CommandText = SQL;
                string strDataTableName = "tbl" + this.GetType().FullName.Split(new Char[] { '.' })[this.GetType().FullName.Split(new Char[] { '.' }).Length - 1]; System.Data.DataTable dt = new System.Data.DataTable(strDataTableName);
                base.MySqlDataAdapterFill(cmd, dt);

                ArrayList items = new ArrayList();
                foreach (System.Data.DataRow dr in dt.Rows)
                {
                    items.Add(setDetails(dr));
                }

                CreditCardPaymentDetails[] arrCashDetails = new CreditCardPaymentDetails[0];

                if (items != null)
                {
                    arrCashDetails = new CreditCardPaymentDetails[items.Count];
                    items.CopyTo(arrCashDetails);
                }

                return arrCashDetails;
            }

            catch (Exception ex)
            {
                throw base.ThrowException(ex);
            }
        }

        public CreditCardPaymentDetails setDetails(System.Data.DataRow dr)
        {
            Data.CreditCardPaymentDetails Details = new Data.CreditCardPaymentDetails();

            Details.BranchDetails = new Branch(base.Connection, base.Transaction).Details(Int32.Parse(dr["BranchID"].ToString()));
            Details.TerminalNo = dr["TerminalNo"].ToString();
            Details.SyncID = Int64.Parse(dr["SyncID"].ToString());
            Details.CreditCardPaymentID = Int64.Parse(dr["CreditCardPaymentID"].ToString());
            Details.TransactionID = Int64.Parse(dr["TransactionID"].ToString());
            Details.TransactionDate = DateTime.Parse(dr["TransactionDate"].ToString());
            Details.Amount = decimal.Parse(dr["Amount"].ToString());
            Details.AdditionalCharge = decimal.Parse(dr["AdditionalCharge"].ToString());
            Details.ContactID = Int64.Parse(dr["ContactID"].ToString());
            Details.GuarantorID = Int64.Parse(dr["GuarantorID"].ToString());
            Details.CardTypeID = Int16.Parse(dr["CardTypeID"].ToString());
            Details.CardTypeCode = dr["CardTypeCode"].ToString();
            Details.CardTypeName = dr["CardTypeName"].ToString();
            Details.CardNo = dr["CardNo"].ToString();
            Details.CardHolder = dr["CardHolder"].ToString();
            Details.ValidityDates = dr["ValidityDates"].ToString();
            Details.Remarks = dr["Remarks"].ToString();
            Details.TransactionNo = dr["TransactionNo"].ToString();

            Details.CreatedOn = DateTime.Parse(dr["CreatedOn"].ToString());
            Details.LastModified = DateTime.Parse(dr["LastModified"].ToString());

            Details.CardTypeDetails = new CardType(base.Connection, base.Transaction).Details(Details.CardTypeID);

            Details.CreditorDetails = new Contacts(base.Connection, base.Transaction).Details(Details.ContactID);

            return Details;
        }

		#endregion
		
		#region Streams


		#endregion
	}
}

