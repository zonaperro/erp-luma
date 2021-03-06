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
	public struct ProductUnitsMatrixDetails
	{
		public Int64 MatrixID;
        public Int64 ProductID;
		public Int32 BaseUnitID;
		public string BaseUnitName;
		public decimal BaseUnitValue;
		public Int32 BottomUnitID;
		public string BottomUnitName;
		public decimal BottomUnitValue;

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
	public class ProductUnitsMatrix : POSConnection
	{
		#region Constructors and Destructors

		public ProductUnitsMatrix()
            : base(null, null)
        {
        }

        public ProductUnitsMatrix(MySqlConnection Connection, MySqlTransaction Transaction) 
            : base(Connection, Transaction)
		{

		}

		#endregion
		
		#region Insert and Update

		public Int32 Insert(ProductUnitsMatrixDetails Details)
		{
			try 
			{
                Save(Details);

                string SQL = "SELECT LAST_INSERT_ID();";

                MySqlCommand cmd = new MySqlCommand();
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = SQL;

                System.Data.DataTable dt = new System.Data.DataTable("LAST_INSERT_ID");
                base.MySqlDataAdapterFill(cmd, dt);

                Int32 iID = 0;
                foreach (System.Data.DataRow dr in dt.Rows)
                {
                    iID = Int32.Parse(dr[0].ToString());
                }							

				return iID;
			}

			catch (Exception ex)
			{
				throw base.ThrowException(ex);
			}	
		}
	
		public void Update(ProductUnitsMatrixDetails Details)
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

        public Int32 Save(ProductUnitsMatrixDetails Details)
        {
            try
            {
                string SQL = "CALL procSaveProductUnitMatrix(@MatrixID, @ProductID, @BaseUnitID, @BaseUnitValue, " +
                                                    "@BottomUnitID, @BottomUnitValue, @CreatedOn, @LastModified);";

                MySqlCommand cmd = new MySqlCommand();
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = SQL;

                cmd.Parameters.AddWithValue("MatrixID", Details.MatrixID);
                cmd.Parameters.AddWithValue("ProductID", Details.ProductID);
                cmd.Parameters.AddWithValue("BaseUnitID", Details.BaseUnitID);
                cmd.Parameters.AddWithValue("BaseUnitValue", Details.BaseUnitValue);
                cmd.Parameters.AddWithValue("BottomUnitID", Details.BottomUnitID);
                cmd.Parameters.AddWithValue("BottomUnitValue", Details.BottomUnitValue);
                cmd.Parameters.AddWithValue("CreatedOn", Details.CreatedOn == DateTime.MinValue ? Constants.C_DATE_MIN_VALUE : Details.CreatedOn);
                cmd.Parameters.AddWithValue("LastModified", Details.LastModified == DateTime.MinValue ? Constants.C_DATE_MIN_VALUE : Details.LastModified);

                return base.ExecuteNonQuery(cmd);
            }

            catch (Exception ex)
            {
                throw base.ThrowException(ex);
            }
        }
		
		#endregion

		#region Details

		public ProductUnitsMatrixDetails Details(long MatrixID)
		{
			try
			{
				string SQL =	"SELECT a.MatrixID, a.ProductID, a.BaseUnitID, b.UnitName 'BaseUnitName', " +
								"a.BaseUnitValue, a.BottomUnitID, c.UnitName 'BottomUnitName', a.BottomUnitValue " +
								"FROM tblProductUnitMatrix a INNER JOIN " +
								"tblUnit b ON a.BaseUnitID = b.UnitID INNER JOIN " + 
								"tblUnit c ON a.BottomUnitID = c.UnitID LEFT OUTER JOIN " + 	
								"tblProducts d ON a.ProductID = d.ProductID " +
								"WHERE a.MatrixID = @MatrixID;"; 
				  
				
	 			
				MySqlCommand cmd = new MySqlCommand();
				
				
				cmd.CommandType = System.Data.CommandType.Text;
				cmd.CommandText = SQL;

				MySqlParameter prmMatrixID = new MySqlParameter("@MatrixID",MySqlDbType.Int32);
				prmMatrixID.Value = MatrixID;
				cmd.Parameters.Add(prmMatrixID);

				MySqlDataReader myReader = base.ExecuteReader(cmd, System.Data.CommandBehavior.SingleResult);
				
				ProductUnitsMatrixDetails Details = new ProductUnitsMatrixDetails();

				while (myReader.Read()) 
				{
					Details.MatrixID = myReader.GetInt64(0);
					Details.ProductID = myReader.GetInt64(1);;
					Details.BaseUnitID = myReader.GetInt16(2);
					Details.BaseUnitName = myReader.GetString(3);
					Details.BaseUnitValue = myReader.GetDecimal(4);
					Details.BottomUnitID = myReader.GetInt16(5);
					Details.BottomUnitName = myReader.GetString(6);
					Details.BottomUnitValue = myReader.GetDecimal(7);
				}

				myReader.Close();

				return Details;
			}

			catch (Exception ex)
			{
				
				
				{
					
					
					
					
				}

				throw base.ThrowException(ex);
			}	
		}

		public ProductUnitsMatrixDetails UnitDetails(long ProductID, long MatrixID)
		{
			try
			{
				string SQL =	"SELECT a.MatrixID, a.ProductID, a.BaseUnitID, b.UnitName 'BaseUnitName', " +
					"a.BaseUnitValue, a.BottomUnitID, c.UnitName 'BottomUnitName', a.BottomUnitValue " +
					"FROM tblProductUnitMatrix a INNER JOIN " +
					"tblUnit b ON a.BaseUnitID = b.UnitID INNER JOIN " + 
					"tblUnit c ON a.BottomUnitID = c.UnitID LEFT OUTER JOIN " + 	
					"tblProducts d ON a.ProductID = d.ProductID " +
					"WHERE a.ProductID = " + ProductID + " " +
					"AND a.MatrixID = " + MatrixID + ";"; 
				  
				
	 			
				MySqlCommand cmd = new MySqlCommand();
				
				
				cmd.CommandType = System.Data.CommandType.Text;
				cmd.CommandText = SQL;

//				MySqlParameter prmProductID = new MySqlParameter("@ProductID",MySqlDbType.Int16);
//				prmProductID.Value = ProductID;
//				cmd.Parameters.Add(prmProductID);

				MySqlDataReader myReader = base.ExecuteReader(cmd, System.Data.CommandBehavior.SingleResult);
				
				ProductUnitsMatrixDetails Details = new ProductUnitsMatrixDetails();

				while (myReader.Read()) 
				{
					Details.MatrixID = myReader.GetInt64(0);
					Details.ProductID = ProductID;
					Details.BaseUnitID = myReader.GetInt16(2);
					Details.BaseUnitName = myReader.GetString(3);
					Details.BaseUnitValue = myReader.GetDecimal(4);
					Details.BottomUnitID = myReader.GetInt16(5);
					Details.BottomUnitName = myReader.GetString(6);
					Details.BottomUnitValue = myReader.GetDecimal(7);
				}

				myReader.Close();

				return Details;
			}

			catch (Exception ex)
			{
				
				
				{
					
					
					
					
				}

				throw base.ThrowException(ex);
			}	
		}


		#endregion

		#region Delete

		public bool Delete(string IDs)
		{
			try 
			{
				string SQL=	"DELETE FROM tblProductUnitMatrix WHERE MatrixID IN (" + IDs + ");";
								
				
	 			
				MySqlCommand cmd = new MySqlCommand();
				
				
				cmd.CommandType = System.Data.CommandType.Text;
				cmd.CommandText = SQL;

				base.ExecuteNonQuery(cmd);

				return true;
			}

			catch (Exception ex)
			{
				
				
				{
					
					
					
					
				}

				throw base.ThrowException(ex);
			}	
		}


		#endregion

		#region Streams

        public System.Data.DataTable ListAsDataTable(Int64 ProductID, string SortField = "b.UnitCode", SortOption SortOrder = SortOption.Ascending)
		{
			try
			{
                MySqlCommand cmd = new MySqlCommand();
                cmd.CommandType = System.Data.CommandType.Text;

				string	SQL =	"SELECT a.MatrixID, a.ProductID, a.BaseUnitID, b.UnitCode 'BaseUnitCode', b.UnitName 'BaseUnitName', " +
					                "a.BaseUnitValue, a.BottomUnitID, c.UnitCode 'BottomUnitCode', c.UnitName 'BottomUnitName', a.BottomUnitValue " +
					            "FROM tblProductUnitMatrix a INNER JOIN " +
					                "tblUnit b ON a.BaseUnitID = b.UnitID INNER JOIN " + 
					                "tblUnit c ON a.BottomUnitID = c.UnitID LEFT OUTER JOIN " + 	
					                "tblProducts d ON a.ProductID = d.ProductID " +
                                "WHERE a.ProductID = @ProductID ";

                cmd.Parameters.AddWithValue("@ProductID", ProductID);

                SQL += "ORDER BY " + (!string.IsNullOrEmpty(SortField) ? SortField : "b.UnitCode") + " ";
                SQL += SortOrder == SortOption.Ascending ? "ASC " : "DESC ";
                //SQL += limit == 0 ? "" : "LIMIT " + limit.ToString() + " ";

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

		public System.Data.DataTable AvailableUnitsForProduct(Int64 ProductID, string SortField = "UnitName", SortOption SortOrder = SortOption.Ascending)
		{
			
			try
			{
                MySqlCommand cmd = new MySqlCommand();
                cmd.CommandType = System.Data.CommandType.Text;

                string SQL = "SELECT " +
                                "UnitID, " +
                                "UnitCode, " +
                                "UnitName " +
                            "FROM tblUnit " +
                                "WHERE UnitID NOT IN (SELECT BaseUnitID FROM tblProductUnitMatrix WHERE ProductID = @ProductID) ";

                cmd.Parameters.AddWithValue("@ProductID", ProductID);

                SQL += "ORDER BY " + (!string.IsNullOrEmpty(SortField) ? SortField : "UnitName") + " ";
                SQL += SortOrder == SortOption.Ascending ? "ASC " : "DESC ";
                //SQL += limit == 0 ? "" : "LIMIT " + limit.ToString() + " ";

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

		public ProductUnitsMatrixDetails LastDetails(Int64 ProductID)
		{
			try
			{
                MySqlCommand cmd = new MySqlCommand();
                cmd.CommandType = System.Data.CommandType.Text;

				string SQL =	"SELECT a.MatrixID, a.ProductID, a.BaseUnitID, b.UnitName 'BaseUnitName', " +
					"a.BaseUnitValue, a.BottomUnitID, c.UnitName 'BottomUnitName', a.BottomUnitValue " +
					"FROM tblProductUnitMatrix a INNER JOIN " +
					"tblUnit b ON a.BaseUnitID = b.UnitID INNER JOIN " + 
					"tblUnit c ON a.BottomUnitID = c.UnitID LEFT OUTER JOIN " + 	
					"tblProducts d ON a.ProductID = d.ProductID " +
					"WHERE a.ProductID = @ProductID " +
					"ORDER BY a.MatrixID DESC LIMIT 1;";

                cmd.Parameters.AddWithValue("@ProductID", ProductID);
				
                cmd.CommandText = SQL;
                string strDataTableName = "tbl" + this.GetType().FullName.Split(new Char[] { '.' })[this.GetType().FullName.Split(new Char[] { '.' }).Length - 1]; System.Data.DataTable dt = new System.Data.DataTable(strDataTableName);
                base.MySqlDataAdapterFill(cmd, dt);

                ProductUnitsMatrixDetails Details = new ProductUnitsMatrixDetails();
                foreach (System.Data.DataRow dr in dt.Rows)
				{
                    Details.MatrixID = Int64.Parse(dr["MatrixID"].ToString());
                    Details.ProductID = Int64.Parse(dr["ProductID"].ToString());
                    Details.BaseUnitID = Int32.Parse(dr["BaseUnitID"].ToString());
                    Details.BaseUnitName = dr["BaseUnitName"].ToString();
                    Details.BaseUnitValue = decimal.Parse(dr["BaseUnitValue"].ToString());
                    Details.BottomUnitID = Int32.Parse(dr["BottomUnitID"].ToString());
                    Details.BottomUnitName = dr["BottomUnitName"].ToString();
                    Details.BottomUnitValue = decimal.Parse(dr["BottomUnitValue"].ToString());
				}

				return Details;
			}
			catch (Exception ex)
			{
				throw base.ThrowException(ex);
			}	
		}

		#endregion
	}
}

