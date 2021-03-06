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
	public struct CreditPaymentDetails
	{
        public BranchDetails BranchDetails;
        public string TerminalNo;
        public Int64 SyncID;
        public Int64 CreditPaymentID;
		public Int64 TransactionID;
        public string TransactionNo;
        public bool IsRefund;
        public DateTime TransactionDate;
        public string CashierName;
        public decimal Amount;
        public ContactDetails CustomerDetails;
        public string Remarks;
        public decimal CreditBefore;
        public decimal CreditAfter;
        public string CreditReason;
        public Int32 CreditReasonID;
        public decimal AmountPaidCuttOffMonth;

        /// <summary>
        /// reference id if payment is from in-house credit card
        /// </summary>
        public Int64 CreditCardPaymentID;
        public Int16 CreditCardTypeID;

        public DateTime CreatedOn;
        public DateTime LastModified;

        /// <summary>
        /// for searching only for Credits with and without Guarantor's
        /// </summary>
        public DateTime PurchaseDateFrom;
        public DateTime PurchaseDateTo;
        public string CreditorLastnameFrom;
        public string CreditorLastnameTo;
        public string GuarantorLastnameFrom;
        public string GuarantorLastnameTo;
        public CreditType CreditType;
	}

	[StrongNameIdentityPermissionAttribute(SecurityAction.LinkDemand,
		 PublicKey = "002400000480000094000000060200000024000" +
		 "052534131000400000100010053D785642F9F960B43157E0380" +
		 "F393BEE53E8DFAFBF441366C1B6F8B48D9DDF0D527B1F3B21EA" +
		 "E85D2FDB664CE81EB8A87DBE4C589D6F4202FE2B7D4B978BB69" +
		 "684874612CB9B8DB7A0339400A9C4E68277884B07817363D242" +
		 "E3696F9FACDBEA831810AE6DC9EDCA91A7B5DA12FE7BF65D113" +
		 "FF52834EAFB5A7A1FDFD5851A3")]
	public class CreditPayments : POSConnection
    {
		#region Constructors and Destructors

		public CreditPayments()
            : base(null, null)
        {
        }

        public CreditPayments(MySqlConnection Connection, MySqlTransaction Transaction) 
            : base(Connection, Transaction)
		{

		}

		#endregion

		#region Insert and Update

		public Int64 Insert(CreditPaymentDetails Details)
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

        public Int32 Save(CreditPaymentDetails Details)
        {
            try
            {
                // [04/03/2012] Added creditcard information as requested by HP

                MySqlCommand cmd = new MySqlCommand();
                cmd.CommandType = System.Data.CommandType.Text;

                string SQL = "CALL procCreditPaymentInsert(@BranchID, @TerminalNo, @TransactionID, @CustomerID, @CreditCardPaymentID, @CreditCardTypeID, @CurrentCredit, @Amount, @TransactionDate, @TransactionNo, @CashierName, @Remarks, @CreditReason, @CreditReasonID, @CreatedOn, @LastModified);";

                cmd.Parameters.AddWithValue("@BranchID", Details.BranchDetails.BranchID);
                cmd.Parameters.AddWithValue("@TerminalNo", Details.TerminalNo);
                cmd.Parameters.AddWithValue("@TransactionID", Details.TransactionID);
                cmd.Parameters.AddWithValue("@CustomerID", Details.CustomerDetails.ContactID);
                cmd.Parameters.AddWithValue("@CreditCardPaymentID", Details.CreditCardPaymentID);
                cmd.Parameters.AddWithValue("@CreditCardTypeID", Details.CreditCardTypeID);
                cmd.Parameters.AddWithValue("@CurrentCredit", Details.CustomerDetails.Credit);
                cmd.Parameters.AddWithValue("@Amount", Details.IsRefund ? -(Details.Amount) : Details.Amount);
                cmd.Parameters.AddWithValue("@TransactionDate", Details.TransactionDate.ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@TransactionNo", Details.TransactionNo);
                cmd.Parameters.AddWithValue("@CashierName", Details.CashierName);
                cmd.Parameters.AddWithValue("@Remarks", Details.Remarks);
                cmd.Parameters.AddWithValue("@CreditReason", Details.CreditReason);
                cmd.Parameters.AddWithValue("@CreditReasonID", Details.CreditReasonID);
                cmd.Parameters.AddWithValue("@CreatedOn", Details.CreatedOn);
                cmd.Parameters.AddWithValue("@LastModified", Details.LastModified);

                cmd.CommandText = SQL;
                base.ExecuteNonQuery(cmd);

                //add credit to masterfile
                Contacts clsContact = new Contacts(base.Connection, base.Transaction);
                clsContact.AddCredit(Details.CustomerDetails.ContactID, Details.IsRefund ? -(Details.Amount) : Details.Amount);
                
                return 0;
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

                string SQL = "DELETE FROM tblCreditPayment WHERE PaymentID IN (" + IDs + ");";
	 			
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
            string stSQL = "SELECT BranchID, TerminalNo, SyncID, CreditPaymentID, TransactionID, ContactID, CreditCardPaymentID, CreditCardTypeID, Amount, Remarks, AmountPaid, TransactionNo, " +
                                  "CreditDate, CreditBefore, CreditAfter, CreditReason, TerminalNo, CashierName, " +
                                  "AmountPaidCuttOffMonth, CreatedOn, LastModified " +
                            "FROM tblCreditPayment ";

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
        public CreditPaymentDetails[] Details(Int32 BranchID, string TerminalNo, Int64 TransactionID)
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

                CreditPaymentDetails[] arrCashDetails = new CreditPaymentDetails[0];

                if (items != null)
                {
                    arrCashDetails = new CreditPaymentDetails[items.Count];
                    items.CopyTo(arrCashDetails);
                }

                return arrCashDetails;
            }
            catch (Exception ex)
            {
                throw base.ThrowException(ex);
            }
        }

        public CreditPaymentDetails[] Details(Int64 ContactID, DateTime CreditDateFrom, DateTime CreditDateTo)
        {
            try
            {
                MySqlCommand cmd = new MySqlCommand();
                cmd.CommandType = System.Data.CommandType.Text;

                string SQL = SQLSelect() + "WHERE ContactID = @ContactID AND CreditDate >= @CreditDateFrom AND CreditDate <= @CreditDateTo;";

                cmd.Parameters.AddWithValue("ContactID", ContactID);
                cmd.Parameters.AddWithValue("TerminalNo", CreditDateFrom);
                cmd.Parameters.AddWithValue("CreditDateTo", CreditDateTo);

                cmd.CommandText = SQL;
                string strDataTableName = "tbl" + this.GetType().FullName.Split(new Char[] { '.' })[this.GetType().FullName.Split(new Char[] { '.' }).Length - 1]; System.Data.DataTable dt = new System.Data.DataTable(strDataTableName);
                base.MySqlDataAdapterFill(cmd, dt);

                ArrayList items = new ArrayList();
                foreach (System.Data.DataRow dr in dt.Rows)
                {
                    items.Add(setDetails(dr));
                }

                CreditPaymentDetails[] arrItems = new CreditPaymentDetails[0];

                if (items != null)
                {
                    arrItems = new CreditPaymentDetails[items.Count];
                    items.CopyTo(arrItems);
                }

                return arrItems;
            }
            catch (Exception ex)
            {
                throw base.ThrowException(ex);
            }
        }

        public CreditPaymentDetails setDetails(System.Data.DataRow dr)
        {
            Data.CreditPaymentDetails Details = new Data.CreditPaymentDetails();

            Details.BranchDetails = new Branch(base.Connection, base.Transaction).Details(Int32.Parse(dr["BranchID"].ToString()));
            Details.TerminalNo = dr["TerminalNo"].ToString();
            Details.SyncID = Int64.Parse(dr["SyncID"].ToString());
            Details.CreditPaymentID = Int64.Parse(dr["CreditPaymentID"].ToString());
            Details.TransactionID = Int64.Parse(dr["TransactionID"].ToString());
            Details.CreditPaymentID = Int64.Parse(dr["CreditPaymentID"].ToString());
            Details.CustomerDetails = new Contacts(base.Connection, base.Transaction).Details(Int64.Parse(dr["ContactID"].ToString()));
            Details.Amount = decimal.Parse(dr["AmountPaid"].ToString());
            Details.TransactionNo = dr["TransactionNo"].ToString();
            Details.TransactionDate = DateTime.Parse(dr["CreditDate"].ToString());
            Details.CreditBefore = decimal.Parse(dr["CreditBefore"].ToString());
            Details.CreditAfter = decimal.Parse(dr["CreditAfter"].ToString());
            Details.CreditReason = dr["CreditReason"].ToString();
            Details.CashierName = dr["CashierName"].ToString();
            Details.AmountPaidCuttOffMonth = decimal.Parse(dr["AmountPaidCuttOffMonth"].ToString());

            Details.Remarks = dr["Remarks"].ToString();
            Details.TransactionNo = dr["TransactionNo"].ToString();

            Details.CreatedOn = DateTime.Parse(dr["CreatedOn"].ToString());
            Details.LastModified = DateTime.Parse(dr["LastModified"].ToString());

            return Details;
        }

		#endregion
		
		#region Streams


		#endregion
	}
}

