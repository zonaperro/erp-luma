using System;
using System.Security.Permissions;
using MySql.Data.MySqlClient;

namespace AceSoft.RetailPlus.Data
{
	public enum PromoStatus
	{
		InActive	= 0,
		Active		= 1
	}

	[StrongNameIdentityPermissionAttribute(SecurityAction.LinkDemand,
		 PublicKey = "002400000480000094000000060200000024000" +
		 "052534131000400000100010053D785642F9F960B43157E0380" +
		 "F393BEE53E8DFAFBF441366C1B6F8B48D9DDF0D527B1F3B21EA" +
		 "E85D2FDB664CE81EB8A87DBE4C589D6F4202FE2B7D4B978BB69" +
		 "684874612CB9B8DB7A0339400A9C4E68277884B07817363D242" +
		 "E3696F9FACDBEA831810AE6DC9EDCA91A7B5DA12FE7BF65D113" +
		 "FF52834EAFB5A7A1FDFD5851A3")]
	public struct PromoDetails
	{
		public long PromoID;
		public string PromoCode;
		public string PromoName;
		public DateTime StartDate;
		public DateTime EndDate;
		public PromoStatus Status;
		public int PromoTypeID;
		//Used this fields when getting details
		public string PromoTypeCode;
		public string PromoTypeName;

        public DateTime CreatedOn;
        public DateTime LastModified;
	}

	[StrongNameIdentityPermissionAttribute(SecurityAction.LinkDemand,
		 PublicKey = "002400000480000094000000060200000024000" +
		 "052534131000400000100010053D785642F9F960B43157E0380" +
		 "F393BEE53E8DFAFBF441366C1B6F8B48D9DDF0D527B1F3B21EA" +
		 "E85D2FDB664CE81EB8A87DBE4C589D6F4202FE2B7D4B978BB69" +
		 "684874612CB9B8DB7A0339400A9C4E68277884B07817363D242" +
		 "E3696F9FACDBEA831810AE6DC9EDCA91A7B5DA12FE7BF65D113" +
		 "FF52834EAFB5A7A1FDFD5851A3")]
	public class Promo : POSConnection
	{
		#region Constructors and Destructors

		public Promo()
            : base(null, null)
        {
        }

        public Promo(MySqlConnection Connection, MySqlTransaction Transaction) 
            : base(Connection, Transaction)
		{

		}

		#endregion
		
		#region Insert and Update

		public Int64 Insert(PromoDetails Details)
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

		public void Update(PromoDetails Details)
		{
			try 
			{
                Save(Details);
			}
			catch (Exception ex)
			{
				throw base.ThrowException(ex);
			}	
		}

        public Int32 Save(PromoDetails Details)
        {
            try
            {
                MySqlCommand cmd = new MySqlCommand();
                cmd.CommandType = System.Data.CommandType.Text;

                string SQL = "CALL procSavePromo(@PromoID, @PromoCode, @PromoName, @StartDate, @EndDate, @PromoTypeID, @Status, @CreatedOn, @LastModified);";

                cmd.Parameters.AddWithValue("PromoID", Details.PromoID);
                cmd.Parameters.AddWithValue("PromoCode", Details.PromoCode);
                cmd.Parameters.AddWithValue("PromoName", Details.PromoName);
                cmd.Parameters.AddWithValue("StartDate", Details.StartDate.ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("EndDate", Details.EndDate.ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("PromoTypeID", Details.PromoTypeID);
                cmd.Parameters.AddWithValue("Status", Details.Status);
                cmd.Parameters.AddWithValue("CreatedOn", Details.CreatedOn == DateTime.MinValue ? Constants.C_DATE_MIN_VALUE : Details.CreatedOn);
                cmd.Parameters.AddWithValue("LastModified", Details.LastModified == DateTime.MinValue ? Constants.C_DATE_MIN_VALUE : Details.LastModified);

                cmd.CommandText = SQL;
                return base.ExecuteNonQuery(cmd);
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

				string SQL=	"DELETE FROM tblPromoItems WHERE PromoID IN (" + IDs + ");";
				
				cmd.CommandText = SQL;
				base.ExecuteNonQuery(cmd);

				SQL=	"DELETE FROM tblPromo WHERE PromoID IN (" + IDs + ");";
				
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

		#region Details

		public PromoDetails Details(Int64 PromoID)
		{
			try
			{
                MySqlCommand cmd = new MySqlCommand();
                cmd.CommandType = System.Data.CommandType.Text;

				string SQL=	"SELECT " +
								"PromoID, " +
								"PromoCode, " +
								"PromoName, " +
								"StartDate, " +
								"EndDate, " +
								"Status, " +
								"a.PromoTypeID, " +
								"PromoTypeCode, " +
								"PromoTypeName " +
							"FROM tblPromo a " +
							"INNER JOIN tblPromoType b ON a.PromoTypeID = b.PromoTypeID " +
							"WHERE a.PromoID = @PromoID;";

                cmd.Parameters.AddWithValue("@PromoID", PromoID);

                cmd.CommandText = SQL;
                string strDataTableName = "tbl" + this.GetType().FullName.Split(new Char[] { '.' })[this.GetType().FullName.Split(new Char[] { '.' }).Length - 1]; System.Data.DataTable dt = new System.Data.DataTable(strDataTableName);
                base.MySqlDataAdapterFill(cmd, dt);

                PromoDetails Details = new PromoDetails();
                foreach (System.Data.DataRow dr in dt.Rows)
                {
                    Details.PromoID = Int64.Parse(dr["PromoID"].ToString());
                    Details.PromoCode = "" + dr["PromoCode"].ToString();
                    Details.PromoName = "" + dr["PromoName"].ToString();
                    Details.StartDate = DateTime.Parse(dr["StartDate"].ToString());
                    Details.EndDate = DateTime.Parse(dr["EndDate"].ToString());
                    Details.PromoTypeID = Int32.Parse(dr["PromoTypeID"].ToString());
                    Details.PromoTypeCode = "" + dr["PromoTypeCode"].ToString();
                    Details.PromoTypeName = "" + dr["PromoTypeName"].ToString();
                }

				return Details;
			}
			catch (Exception ex)
			{
				throw base.ThrowException(ex);
			}	
		}

		
		#endregion

		#region Streams

		public System.Data.DataTable ListAstDataTable(PromoDetails SearchKey, string SortField = "PromoID", SortOption SortOrder = SortOption.Ascending, Int32 limit = 0)
		{
			try
			{
                MySqlCommand cmd = new MySqlCommand();
                cmd.CommandType = System.Data.CommandType.Text;

                string SQL = "SELECT " +
                                    "PromoID, " +
                                    "PromoCode, " +
                                    "PromoName, " +
                                    "StartDate, " +
                                    "EndDate, " +
                                    "Status, " +
                                    "a.PromoTypeID, " +
                                    "PromoTypeCode, " +
                                    "PromoTypeName " +
                                "FROM tblPromo a INNER JOIN " +
                                "tblPromoType b ON a.PromoTypeID = b.PromoTypeID " +
                                "WHERE 1=1 ";

                if (!string.IsNullOrEmpty(SearchKey.PromoCode))
                {
                    SQL += "AND PromoCode LIKE @PromoCode ";
                    cmd.Parameters.AddWithValue("@PromoCode", SearchKey.PromoCode);
                }
                if (!string.IsNullOrEmpty(SearchKey.PromoName))
                {
                    SQL += "AND PromoCode LIKE @PromoName ";
                    cmd.Parameters.AddWithValue("@PromoName", SearchKey.PromoName);
                }
                if (!string.IsNullOrEmpty(SearchKey.PromoTypeCode))
                {
                    SQL += "AND PromoCode LIKE @PromoTypeCode ";
                    cmd.Parameters.AddWithValue("@PromoTypeCode", SearchKey.PromoTypeCode);
                }

                SQL += "ORDER BY " + SortField + " ";
                SQL += SortOrder == SortOption.Ascending ? "ASC " : "DESC ";
                SQL += limit == 0 ? "" : "LIMIT " + limit.ToString() + " ";

                cmd.CommandText = SQL;
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

		#region Activate and Deactivate

		public void DeActivate(string IDs)
		{
			try 
			{
                MySqlCommand cmd = new MySqlCommand();
                cmd.CommandType = System.Data.CommandType.Text;

				string SQL=	"UPDATE tblPromo SET Status = 0 WHERE PromoID IN (" + IDs + ");";
				
				cmd.CommandText = SQL;
				base.ExecuteNonQuery(cmd);
			}
			catch (Exception ex)
			{
				throw base.ThrowException(ex);
			}	
		}

		public void Activate(string IDs)
		{
			try 
			{
                MySqlCommand cmd = new MySqlCommand();
                cmd.CommandType = System.Data.CommandType.Text;

				string SQL=	"UPDATE tblPromo SET Status = 1 WHERE PromoID IN (" + IDs + ");";
				
				cmd.CommandText = SQL;
				base.ExecuteNonQuery(cmd);
			}
			catch (Exception ex)
			{
				throw base.ThrowException(ex);
			}	
		}

		public void ActivateByID(Int64 PromoID)
		{
			try 
			{
                MySqlCommand cmd = new MySqlCommand();
                cmd.CommandType = System.Data.CommandType.Text;

				string SQL=	"UPDATE tblPromo SET Status = 1 WHERE PromoID = @PromoID;";
							
				cmd.Parameters.AddWithValue("@PromoID", PromoID);

                cmd.CommandText = SQL;
				base.ExecuteNonQuery(cmd);
			}
			catch (Exception ex)
			{
				throw base.ThrowException(ex);
			}	
		}


		#endregion
	}
}

