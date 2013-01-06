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
	public struct UnitDetails
	{
		public int UnitID;
		public string UnitCode;
		public string UnitName;
	}

	[StrongNameIdentityPermissionAttribute(SecurityAction.LinkDemand,
		 PublicKey = "002400000480000094000000060200000024000" +
		 "052534131000400000100010053D785642F9F960B43157E0380" +
		 "F393BEE53E8DFAFBF441366C1B6F8B48D9DDF0D527B1F3B21EA" +
		 "E85D2FDB664CE81EB8A87DBE4C589D6F4202FE2B7D4B978BB69" +
		 "684874612CB9B8DB7A0339400A9C4E68277884B07817363D242" +
		 "E3696F9FACDBEA831810AE6DC9EDCA91A7B5DA12FE7BF65D113" +
		 "FF52834EAFB5A7A1FDFD5851A3")]
	public class Unit
	{
        public const Int32 DEFAULT_UNIT_ID = 1;
		MySqlConnection mConnection;
		MySqlTransaction mTransaction;
		bool IsInTransaction = false;
		bool TransactionFailed = false;

		public MySqlConnection Connection
		{
			get { return mConnection;	}
		}

		public MySqlTransaction Transaction
		{
			get { return mTransaction;	}
		}


		#region Constructors and Destructors

		public Unit()
		{
			
		}

		public Unit(MySqlConnection Connection, MySqlTransaction Transaction)
		{
			mConnection = Connection;
			mTransaction = Transaction;
			
		}

		public void CommitAndDispose() 
		{
			if (!TransactionFailed)
			{
				if (IsInTransaction)
				{
					mTransaction.Commit();
					mTransaction.Dispose(); 
					mConnection.Close();
					mConnection.Dispose();
				}
			}
		}

		public MySqlConnection GetConnection()
		{
			if (mConnection==null)
			{
				mConnection = new MySqlConnection(AceSoft.RetailPlus.DBConnection.ConnectionString());	
				mConnection.Open(); 
				
				mTransaction = (MySqlTransaction) mConnection.BeginTransaction();
				IsInTransaction = true;
			}

			return mConnection;
		} 


		#endregion

		#region Insert and Update

		public Int32 Insert(UnitDetails Details)
		{
			try 
			{
				string SQL = "INSERT INTO tblUnit (UnitCode, UnitName) VALUES (@UnitCode, @UnitName);";
				  
				MySqlConnection cn = GetConnection();
	 			
				MySqlCommand cmd = new MySqlCommand();
				cmd.Connection = cn;
				cmd.Transaction = mTransaction;
				cmd.CommandType = System.Data.CommandType.Text;
				cmd.CommandText = SQL;
				
				MySqlParameter prmUnitCode = new MySqlParameter("@UnitCode",MySqlDbType.String);			
				prmUnitCode.Value = Details.UnitCode;
				cmd.Parameters.Add(prmUnitCode);

				MySqlParameter prmUnitName = new MySqlParameter("@UnitName",MySqlDbType.String);			
				prmUnitName.Value = Details.UnitName;
				cmd.Parameters.Add(prmUnitName);

				cmd.ExecuteNonQuery();

				SQL = "SELECT LAST_INSERT_ID();";
				
				cmd.Parameters.Clear(); 
				cmd.CommandText = SQL;

                System.Data.DataTable dt = new System.Data.DataTable("LAST_INSERT_ID");
                MySqlDataAdapter adapter = new MySqlDataAdapter(cmd);
                adapter.Fill(dt);

                Int32 iID = 0;
                foreach (System.Data.DataRow dr in dt.Rows)
                {
                    iID = Int32.Parse(dr[0].ToString());
                }

				return iID;
			}

			catch (Exception ex)
			{
				TransactionFailed = true;
				if (IsInTransaction)
					mTransaction.Rollback();

				mTransaction.Dispose(); 
				mConnection.Close();
				mConnection.Dispose();

				throw ex;
			}	
		}

		public void Update(UnitDetails Details)
		{
			try 
			{
				string SQL=	"UPDATE tblUnit SET " + 
							"UnitCode = @UnitCode, " +  
							"UnitName = @UnitName " +  
							"WHERE UnitID = @UnitID;";
				  
				MySqlConnection cn = GetConnection();
	 			
				MySqlCommand cmd = new MySqlCommand();
				cmd.Connection = cn;
				cmd.Transaction = mTransaction;
				cmd.CommandType = System.Data.CommandType.Text;
				cmd.CommandText = SQL;
				
				MySqlParameter prmUnitCode = new MySqlParameter("@UnitCode",MySqlDbType.String);			
				prmUnitCode.Value = Details.UnitCode;
				cmd.Parameters.Add(prmUnitCode);

				MySqlParameter prmUnitName = new MySqlParameter("@UnitName",MySqlDbType.String);			
				prmUnitName.Value = Details.UnitName;
				cmd.Parameters.Add(prmUnitName);

				MySqlParameter prmUnitID = new MySqlParameter("@UnitID",MySqlDbType.Int16);			
				prmUnitID.Value = Details.UnitID;
				cmd.Parameters.Add(prmUnitID);

				cmd.ExecuteNonQuery();
			}

			catch (Exception ex)
			{
				TransactionFailed = true;
				if (IsInTransaction)
					mTransaction.Rollback();

				mTransaction.Dispose(); 
				mConnection.Close();
				mConnection.Dispose();

				throw ex;
			}	
		}


		#endregion

		#region Delete

		public bool Delete(string IDs)
		{
			try 
			{
				string SQL=	"DELETE FROM tblUnit WHERE UnitID IN (" + IDs + ");";
				  
				MySqlConnection cn = GetConnection();
	 			
				MySqlCommand cmd = new MySqlCommand();
				cmd.Connection = cn;
				cmd.Transaction = mTransaction;
				cmd.CommandType = System.Data.CommandType.Text;
				cmd.CommandText = SQL;

				cmd.ExecuteNonQuery();

				return true;
			}

			catch (Exception ex)
			{
				TransactionFailed = true;
				if (IsInTransaction)
					mTransaction.Rollback();

				mTransaction.Dispose(); 
				mConnection.Close();
				mConnection.Dispose();

				throw ex;
			}	
		}


		#endregion

		#region Details

		public UnitDetails Details(Int32 UnitID)
		{
			try
			{
				string SQL=	"SELECT " +
								"UnitID, " +
								"UnitCode, " +
								"UnitName " +
							"FROM tblUnit " +
							"WHERE UnitID = @UnitID;";
				  
				MySqlConnection cn = GetConnection();
	 			
				MySqlCommand cmd = new MySqlCommand();
				cmd.Connection = cn;
				cmd.Transaction = mTransaction;
				cmd.CommandType = System.Data.CommandType.Text;
				cmd.CommandText = SQL;

				MySqlParameter prmUnitID = new MySqlParameter("@UnitID",System.Data.DbType.Int32);
				prmUnitID.Value = UnitID;
				cmd.Parameters.Add(prmUnitID);

				MySqlDataReader myReader = (MySqlDataReader) cmd.ExecuteReader(System.Data.CommandBehavior.SingleResult);
				
				UnitDetails Details = new UnitDetails();

				while (myReader.Read()) 
				{
					Details.UnitID = myReader.GetInt32("UnitID");
					Details.UnitCode = "" + myReader["UnitCode"].ToString();
					Details.UnitName = "" + myReader["UnitName"].ToString();
				}

				myReader.Close();

				return Details;
			}

			catch (Exception ex)
			{
				TransactionFailed = true;
				if (IsInTransaction)
					mTransaction.Rollback();

				mTransaction.Dispose(); 
				mConnection.Close();
				mConnection.Dispose();

				throw ex;
			}	
		}

        public UnitDetails Details(string UnitCode)
		{
			try
			{
				string SQL=	"SELECT " +
								"UnitID, " +
								"UnitCode, " +
								"UnitName " +
							"FROM tblUnit " +
							"WHERE UnitCode = @UnitCode;";
				  
				MySqlConnection cn = GetConnection();
	 			
				MySqlCommand cmd = new MySqlCommand();
				cmd.Connection = cn;
				cmd.Transaction = mTransaction;
				cmd.CommandType = System.Data.CommandType.Text;
				cmd.CommandText = SQL;

				MySqlParameter prmUnitCode = new MySqlParameter("@UnitCode",MySqlDbType.String);
				prmUnitCode.Value = UnitCode;
				cmd.Parameters.Add(prmUnitCode);

				MySqlDataReader myReader = (MySqlDataReader) cmd.ExecuteReader(System.Data.CommandBehavior.SingleResult);

                UnitDetails Details = new UnitDetails();

				while (myReader.Read()) 
				{
					Details.UnitID = myReader.GetInt32("UnitID");
					Details.UnitCode = "" + myReader["UnitCode"].ToString();
					Details.UnitName = "" + myReader["UnitName"].ToString();
				}

				myReader.Close();

				return Details;
			}

			catch (Exception ex)
			{
				TransactionFailed = true;
				if (IsInTransaction)
				{
					mTransaction.Rollback();
					mTransaction.Dispose(); 
					mConnection.Close();
					mConnection.Dispose();
				}

				throw ex;
			}	
		}


		#endregion

		#region Streams

		public MySqlDataReader List(string SortField, SortOption SortOrder)
		{
			try
			{
                if (SortField == null || SortField == string.Empty) SortField = "UnitID";

				string SQL = "SELECT " +
					"UnitID, " +
					"UnitCode, " +
					"UnitName " +
					"FROM tblUnit " +
					"ORDER BY " + SortField;

				if (SortOrder == SortOption.Ascending)
					SQL += " ASC";
				else
					SQL += " DESC";

				MySqlConnection cn = GetConnection();

				MySqlCommand cmd = new MySqlCommand();
				cmd.Connection = cn;
				cmd.Transaction = mTransaction;
				cmd.CommandType = System.Data.CommandType.Text;
				cmd.CommandText = SQL;
				
				MySqlDataReader myReader = (MySqlDataReader) cmd.ExecuteReader();
				
				return myReader;			
			}
			catch (Exception ex)
			{
				TransactionFailed = true;
				if (IsInTransaction)
					mTransaction.Rollback();

				mTransaction.Dispose(); 
				mConnection.Close();
				mConnection.Dispose();

				throw ex;
			}	
		}

		public System.Data.DataTable DataList(string SortField, SortOption SortOrder)
		{
			MySqlDataReader myReader = List(SortField,SortOption.Ascending);
			
			System.Data.DataTable dt = new System.Data.DataTable("tblUnit");

			dt.Columns.Add("UnitID");
			dt.Columns.Add("UnitCode");
			dt.Columns.Add("UnitName");
				
			while (myReader.Read())
			{
				System.Data.DataRow dr = dt.NewRow();

				dr["UnitID"] = "" + myReader["UnitID"].ToString();
				dr["UnitCode"] = "" + myReader["UnitCode"].ToString();
				dr["UnitName"] = "" + myReader["UnitName"].ToString();
					
				dt.Rows.Add(dr);
			}
			
			myReader.Close();

			return dt;
		}

		public MySqlDataReader Search(string SearchKey, string SortField, SortOption SortOrder)
		{
			try
			{
				string SQL ="SELECT " +
								"UnitID, " +
								"UnitCode, " +
								"UnitName " +
							"FROM tblUnit " +
							"WHERE UnitName LIKE @SearchKey " +
							"ORDER BY " + SortField;

				if (SortOrder == SortOption.Ascending)
					SQL += " ASC";
				else
					SQL += " DESC";

				MySqlConnection cn = GetConnection();

				MySqlCommand cmd = new MySqlCommand();
				cmd.Connection = cn;
				cmd.Transaction = mTransaction;
				cmd.CommandType = System.Data.CommandType.Text;
				cmd.CommandText = SQL;
				
				MySqlParameter prmSearchKey = new MySqlParameter("@SearchKey",MySqlDbType.String);
				prmSearchKey.Value = "%" + SearchKey + "%";
				cmd.Parameters.Add(prmSearchKey);

				MySqlDataReader myReader = (MySqlDataReader) cmd.ExecuteReader();
				
				return myReader;			
			}
			catch (Exception ex)
			{
				TransactionFailed = true;
				if (IsInTransaction)
					mTransaction.Rollback();

				mTransaction.Dispose(); 
				mConnection.Close();
				mConnection.Dispose();

				throw ex;
			}	
		}
		
		public System.Data.DataTable DataSearch(string SearchKey, string SortField, SortOption SortOrder)
		{
			MySqlDataReader myReader = Search(SearchKey,SortField,SortOption.Ascending);
			
			System.Data.DataTable dt = new System.Data.DataTable("tblUnit");

			dt.Columns.Add("UnitID");
			dt.Columns.Add("UnitCode");
			dt.Columns.Add("UnitName");
				
			while (myReader.Read())
			{
				System.Data.DataRow dr = dt.NewRow();

				dr["UnitID"] = myReader.GetInt32("UnitID");
				dr["UnitCode"] = "" + myReader["UnitCode"].ToString();
				dr["UnitName"] = "" + myReader["UnitName"].ToString();
					
				dt.Rows.Add(dr);
			}
			
			myReader.Close();

			return dt;
		}

		#endregion
	}
}

