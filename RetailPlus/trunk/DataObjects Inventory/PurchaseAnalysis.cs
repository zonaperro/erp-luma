using System;
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
	public class PurchaseAnalysis : POSConnection
	{
		#region Constructors and Destructors

		public PurchaseAnalysis()
            : base(null, null)
        {
        }

        public PurchaseAnalysis(MySqlConnection Connection, MySqlTransaction Transaction) 
            : base(Connection, Transaction)
		{

		}

		#endregion

		#region Reports

		public System.Data.DataTable ByVendor(DateTime PostingDateFrom, DateTime PostingDateTo)
		{
			try
			{
				string SQL=	"SELECT " +
								"a.ContactCode AS SupplierCode, " +
								"ContactName AS SupplierName, " +
								"SUM(PurchaseCost) AS PurchaseCost, " +
								"SUM(PurchaseVAT) AS PurchaseVAT, " +
								"SUM(PInvoiceCost) AS InvoiceCost, " +
								"SUM(PInvoiceVAT) AS InvoiceVAT, " +
								"SUM(PReturnCost) AS ReturnCost, " +
								"SUM(PReturnVAT) AS ReturnVAT, " +
								"SUM(PDebitCost) AS DebitCost, " +
								"SUM(PDebitVAT) AS DebitVAT " +
							"FROM tblInventory a INNER JOIN tblContacts b ON a.ContactID = b.ContactID " +
							"WHERE (LEFT(ReferenceNo,@LEN_PURCHASE_ORDER_CODE) = @PURCHASE_ORDER_CODE " +
								"OR LEFT(ReferenceNo,@LEN_PURCHASE_RETURN_CODE) = @PURCHASE_RETURN_CODE " +
								"OR LEFT(ReferenceNo,@LEN_PURCHASE_DEBITMEMO_CODE) = @PURCHASE_DEBITMEMO_CODE) " +
								"AND PostingDate BETWEEN @PostingDateFrom AND @PostingDateTo " +
							"GROUP BY a.ContactCode, ContactName " +
							"ORDER BY a.ContactCode;";

				MySqlCommand cmd = new MySqlCommand();
				cmd.CommandType = System.Data.CommandType.Text;
				cmd.CommandText = SQL;
				
				cmd.Parameters.AddWithValue("@LEN_PURCHASE_ORDER_CODE", Constants.PURCHASE_ORDER_CODE.Length);
				cmd.Parameters.AddWithValue("@PURCHASE_ORDER_CODE", Constants.PURCHASE_ORDER_CODE);
				cmd.Parameters.AddWithValue("@LEN_PURCHASE_RETURN_CODE", Constants.PURCHASE_RETURN_CODE.Length);
				cmd.Parameters.AddWithValue("@PURCHASE_RETURN_CODE", Constants.PURCHASE_RETURN_CODE);
				cmd.Parameters.AddWithValue("@LEN_PURCHASE_DEBITMEMO_CODE", Constants.PURCHASE_DEBITMEMO_CODE.Length);
				cmd.Parameters.AddWithValue("@PURCHASE_DEBITMEMO_CODE", Constants.PURCHASE_DEBITMEMO_CODE);
				cmd.Parameters.AddWithValue("@PostingDateFrom", PostingDateFrom.ToString("yyyy-MM-dd HH:mm:ss"));
				cmd.Parameters.AddWithValue("@PostingDateTo", PostingDateTo.ToString("yyyy-MM-dd HH:mm:ss"));

                string strDataTableName = "tbl" + this.GetType().FullName.Split(new Char[] { '.' })[this.GetType().FullName.Split(new Char[] { '.' }).Length - 1]; System.Data.DataTable dt = new System.Data.DataTable(strDataTableName);
                base.MySqlDataAdapterFill(cmd, dt);

				return dt;	
			}
			catch (Exception ex)
			{
				throw base.ThrowException(ex);
			}	
		}
		
		#endregion
	}
}

