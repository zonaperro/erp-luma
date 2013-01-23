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
	public struct ProductSubGroupVariationsMatrixDetails
	{
		public Int64 MatrixID;
		public Int64 SubGroupID;
		public Int32 VariationID;
		public string VariationType;
		public string Description;
	}

	[StrongNameIdentityPermissionAttribute(SecurityAction.LinkDemand,
		 PublicKey = "002400000480000094000000060200000024000" +
		 "052534131000400000100010053D785642F9F960B43157E0380" +
		 "F393BEE53E8DFAFBF441366C1B6F8B48D9DDF0D527B1F3B21EA" +
		 "E85D2FDB664CE81EB8A87DBE4C589D6F4202FE2B7D4B978BB69" +
		 "684874612CB9B8DB7A0339400A9C4E68277884B07817363D242" +
		 "E3696F9FACDBEA831810AE6DC9EDCA91A7B5DA12FE7BF65D113" +
		 "FF52834EAFB5A7A1FDFD5851A3")]
	public struct ProductSubGroupBaseMatrixDetails
	{
		public Int64 MatrixID;
		public Int64 SubGroupID;
		public string Description;
		public Int32 UnitID;
		public string UnitName;
		public decimal Price;
		public decimal PurchasePrice;
		public bool IncludeInSubtotalDiscount;
		public decimal VAT;
		public decimal EVAT;
		public decimal LocalTax;
	}

	[StrongNameIdentityPermissionAttribute(SecurityAction.LinkDemand,
		 PublicKey = "002400000480000094000000060200000024000" +
		 "052534131000400000100010053D785642F9F960B43157E0380" +
		 "F393BEE53E8DFAFBF441366C1B6F8B48D9DDF0D527B1F3B21EA" +
		 "E85D2FDB664CE81EB8A87DBE4C589D6F4202FE2B7D4B978BB69" +
		 "684874612CB9B8DB7A0339400A9C4E68277884B07817363D242" +
		 "E3696F9FACDBEA831810AE6DC9EDCA91A7B5DA12FE7BF65D113" +
		 "FF52834EAFB5A7A1FDFD5851A3")]
	public class ProductSubGroupVariationsMatrix : POSConnection
	{
		#region Constructors and Destructors

		public ProductSubGroupVariationsMatrix()
            : base(null, null)
        {
        }

        public ProductSubGroupVariationsMatrix(MySqlConnection Connection, MySqlTransaction Transaction) 
            : base(Connection, Transaction)
		{

		}

		#endregion
		
		#region Insert and Update

		public Int64 InsertBaseVariation(ProductSubGroupBaseMatrixDetails Details)
		{
			try 
			{
				string SQL = "INSERT INTO tblProductSubGroupBaseVariationsMatrix (" +
								"SubGroupID, " +
								"Description, " +
								"UnitID, " +
								"Price, " +
								"PurchasePrice, " +
								"IncludeInSubtotalDiscount, " +
								"VAT, " +
								"EVAT, " +
								"LocalTax" +
							") VALUES (" +
								"@SubGroupID, " +
								"@Description, " +
								"@UnitID, " +
								"@Price, " +
								"@PurchasePrice, " +
								"@IncludeInSubtotalDiscount, " +
								"@VAT, " +
								"@EVAT, " +
								"@LocalTax);";
				  
				
	 			
				MySqlCommand cmd = new MySqlCommand();
				
				
				cmd.CommandType = System.Data.CommandType.Text;
				cmd.CommandText = SQL;
				
				MySqlParameter prmSubGroupID = new MySqlParameter("@SubGroupID",MySqlDbType.Int64);			
				prmSubGroupID.Value = Details.SubGroupID;
				cmd.Parameters.Add(prmSubGroupID);

				MySqlParameter prmDescription = new MySqlParameter("@Description",MySqlDbType.String);	
				prmDescription.Value = Details.Description;
				cmd.Parameters.Add(prmDescription);

				MySqlParameter prmUnitID = new MySqlParameter("@UnitID",MySqlDbType.Int32);	
				prmUnitID.Value = Details.UnitID;
				cmd.Parameters.Add(prmUnitID);

				MySqlParameter prmPrice = new MySqlParameter("@Price",MySqlDbType.Decimal);	
				prmPrice.Value = Details.Price;
				cmd.Parameters.Add(prmPrice);

				MySqlParameter prmPurchasePrice = new MySqlParameter("@PurchasePrice",MySqlDbType.Decimal);			
				prmPurchasePrice.Value = Details.PurchasePrice;
				cmd.Parameters.Add(prmPurchasePrice);

				MySqlParameter prmIncludeInSubtotalDiscount = new MySqlParameter("@IncludeInSubtotalDiscount",MySqlDbType.Int16);			
				prmIncludeInSubtotalDiscount.Value = Details.IncludeInSubtotalDiscount;
				cmd.Parameters.Add(prmIncludeInSubtotalDiscount);

				MySqlParameter prmVAT = new MySqlParameter("@VAT",MySqlDbType.Decimal);			
				prmVAT.Value = Details.VAT;
				cmd.Parameters.Add(prmVAT);

				MySqlParameter prmEVAT = new MySqlParameter("@EVAT",MySqlDbType.Decimal);			
				prmEVAT.Value = Details.EVAT;
				cmd.Parameters.Add(prmEVAT);

				MySqlParameter prmLocalTax = new MySqlParameter("@LocalTax",MySqlDbType.Decimal);			
				prmLocalTax.Value = Details.LocalTax;
				cmd.Parameters.Add(prmLocalTax);

				base.ExecuteNonQuery(cmd);

				SQL = "SELECT LAST_INSERT_ID();";
				
				cmd.Parameters.Clear(); 
				cmd.CommandText = SQL;

                System.Data.DataTable dt = new System.Data.DataTable("LAST_INSERT_ID");
                base.MySqlDataAdapterFill(cmd, dt);
                

                Int64 iID = 0;
                foreach (System.Data.DataRow dr in dt.Rows)
                {
                    iID = Int64.Parse(dr[0].ToString());
                }							

				return iID;
			}

			catch (Exception ex)
			{
				
				
				{
					
					
					
					
				}

				throw ex;
			}	
		}

		public bool InsertVariation(ProductSubGroupVariationsMatrixDetails Details)
		{
			try 
			{
				string SQL = "INSERT INTO tblProductSubGroupVariationsMatrix (MatrixID, VariationID, Description) VALUES (@MatrixID, @VariationID, @Description);";
				  
				
	 			
				MySqlCommand cmd = new MySqlCommand();
				
				
				cmd.CommandType = System.Data.CommandType.Text;
				cmd.CommandText = SQL;
				
				MySqlParameter prmMatrixID = new MySqlParameter("@MatrixID",MySqlDbType.Int64);			
				prmMatrixID.Value = Details.MatrixID;
				cmd.Parameters.Add(prmMatrixID);

				MySqlParameter prmVariationID = new MySqlParameter("@VariationID",MySqlDbType.Int32);			
				prmVariationID.Value = Details.VariationID;
				cmd.Parameters.Add(prmVariationID);

				MySqlParameter prmDescription = new MySqlParameter("@Description",MySqlDbType.String);			
				prmDescription.Value = Details.Description;
				cmd.Parameters.Add(prmDescription);

				base.ExecuteNonQuery(cmd);
				
				return true;
			}

			catch (Exception ex)
			{
				
				
				{
					
					
					
					
				}

				throw ex;
			}	
		}

		public bool UpdateVariationDesc(ProductSubGroupBaseMatrixDetails Details)
		{
			try 
			{
				string SQL = "UPDATE tblProductSubGroupBaseVariationsMatrix SET " +
								"Description = @Description " +
							 "WHERE SubGroupID = @SubGroupID AND MatrixID = @MatrixID;";
				  
				
	 			
				MySqlCommand cmd = new MySqlCommand();
				
				
				cmd.CommandType = System.Data.CommandType.Text;
				cmd.CommandText = SQL;
				
				MySqlParameter prmSubGroupID = new MySqlParameter("@SubGroupID",MySqlDbType.Int64);			
				prmSubGroupID.Value = Details.SubGroupID;
				cmd.Parameters.Add(prmSubGroupID);

				MySqlParameter prmMatrixID = new MySqlParameter("@MatrixID",MySqlDbType.Int64);			
				prmMatrixID.Value = Details.MatrixID;
				cmd.Parameters.Add(prmMatrixID);

				MySqlParameter prmDescription = new MySqlParameter("@Description",MySqlDbType.String);			
				prmDescription.Value = Details.Description;
				cmd.Parameters.Add(prmDescription);

				base.ExecuteNonQuery(cmd);
				
				return true;
			}

			catch (Exception ex)
			{
				
				
				{
					
					
					
					
				}

				throw ex;
			}	
		}

		public bool UpdateBaseVariation(ProductSubGroupBaseMatrixDetails Details)
		{
			try 
			{
				string SQL = "UPDATE tblProductSubGroupBaseVariationsMatrix SET " +
								"Description			= @Description, " +
								"UnitID					= @UnitID, " +
								"Price					= @Price, " +
								"PurchasePrice			= @PurchasePrice, " +
								"IncludeInSubtotalDiscount	=	@IncludeInSubtotalDiscount, " +
								"VAT					= @VAT, " +
								"EVAT					= @EVAT, " +
								"LocalTax				= @LocalTax " +
							"WHERE SubGroupID = @SubGroupID AND MatrixID = @MatrixID;";
				  
				
	 			
				MySqlCommand cmd = new MySqlCommand();
				
				
				cmd.CommandType = System.Data.CommandType.Text;
				cmd.CommandText = SQL;
				
				MySqlParameter prmSubGroupID = new MySqlParameter("@SubGroupID",MySqlDbType.Int64);			
				prmSubGroupID.Value = Details.SubGroupID;
				cmd.Parameters.Add(prmSubGroupID);

				MySqlParameter prmMatrixID = new MySqlParameter("@MatrixID",MySqlDbType.Int64);			
				prmMatrixID.Value = Details.MatrixID;
				cmd.Parameters.Add(prmMatrixID);

				MySqlParameter prmDescription = new MySqlParameter("@Description",MySqlDbType.String);			
				prmDescription.Value = Details.Description;
				cmd.Parameters.Add(prmDescription);

				MySqlParameter prmUnitID = new MySqlParameter("@UnitID",MySqlDbType.Int32);	
				prmUnitID.Value = Details.UnitID;
				cmd.Parameters.Add(prmUnitID);

				MySqlParameter prmPrice = new MySqlParameter("@Price",MySqlDbType.Decimal);	
				prmPrice.Value = Details.Price;
				cmd.Parameters.Add(prmPrice);

				MySqlParameter prmPurchasePrice = new MySqlParameter("@PurchasePrice",MySqlDbType.Decimal);			
				prmPurchasePrice.Value = Details.PurchasePrice;
				cmd.Parameters.Add(prmPurchasePrice);

				MySqlParameter prmIncludeInSubtotalDiscount = new MySqlParameter("@IncludeInSubtotalDiscount",MySqlDbType.Int16);			
				prmIncludeInSubtotalDiscount.Value = Details.IncludeInSubtotalDiscount;
				cmd.Parameters.Add(prmIncludeInSubtotalDiscount);

				MySqlParameter prmVAT = new MySqlParameter("@VAT",MySqlDbType.Decimal);			
				prmVAT.Value = Details.VAT;
				cmd.Parameters.Add(prmVAT);

				MySqlParameter prmEVAT = new MySqlParameter("@EVAT",MySqlDbType.Decimal);			
				prmEVAT.Value = Details.EVAT;
				cmd.Parameters.Add(prmEVAT);

				MySqlParameter prmLocalTax = new MySqlParameter("@LocalTax",MySqlDbType.Decimal);			
				prmLocalTax.Value = Details.LocalTax;
				cmd.Parameters.Add(prmLocalTax);

				base.ExecuteNonQuery(cmd);
				
				return true;
			}

			catch (Exception ex)
			{
				
				
				{
					
					
					
					
				}

				throw ex;
			}	
		}

		public void Update(ProductSubGroupVariationsMatrixDetails Details)
		{
			try 
			{
				string SQL=	"UPDATE tblProductSubGroupVariationsMatrix SET " + 
								"Description = @Description " +  
							"WHERE MatrixID = @MatrixID " + 
							"AND VariationID = @VariationID;";
				  
				
	 			
				MySqlCommand cmd = new MySqlCommand();
				
				
				cmd.CommandType = System.Data.CommandType.Text;
				cmd.CommandText = SQL;
				
				MySqlParameter prmDescription = new MySqlParameter("@Description",MySqlDbType.String);			
				prmDescription.Value = Details.Description;
				cmd.Parameters.Add(prmDescription);

				MySqlParameter prmMatrixID = new MySqlParameter("@MatrixID",MySqlDbType.Int64);						
				prmMatrixID.Value = Details.MatrixID;
				cmd.Parameters.Add(prmMatrixID);

				MySqlParameter prmVariationID = new MySqlParameter("@VariationID",MySqlDbType.Int32);			
				prmVariationID.Value = Details.VariationID;
				cmd.Parameters.Add(prmVariationID);

				base.ExecuteNonQuery(cmd);
			}

			catch (Exception ex)
			{
				
				
				{
					
					
					
					
				}
				throw ex;
			}	
		}

		
		public void ChangeVAT(decimal OldVAT, decimal NewVAT)
		{
			try 
			{
				string SQL =	"UPDATE tblProductSubGroupBaseVariationsMatrix SET " +
									"VAT		= @NewVAT " +
								"WHERE VAT		= @OldVAT;";
				  
				
	 			
				MySqlCommand cmd = new MySqlCommand();
				
				
				cmd.CommandType = System.Data.CommandType.Text;
				cmd.CommandText = SQL;
				
				MySqlParameter prmNewVAT = new MySqlParameter("@NewVAT",MySqlDbType.Decimal);			
				prmNewVAT.Value = NewVAT;
				cmd.Parameters.Add(prmNewVAT);

				MySqlParameter prmOldVAT = new MySqlParameter("@OldVAT",MySqlDbType.Decimal);			
				prmOldVAT.Value = OldVAT;
				cmd.Parameters.Add(prmOldVAT);

				base.ExecuteNonQuery(cmd);
			}

			catch (Exception ex)
			{
				
				
				{
					
					
					
					
				}

				throw ex;
			}	
		}
		public void ChangeEVAT(decimal OldEVAT, decimal NewEVAT)
		{
			try 
			{
				string SQL =	"UPDATE tblProductSubGroupBaseVariationsMatrix SET " +
									"EVAT		= @NewEVAT " +
								"WHERE EVAT		= @OldEVAT;";
				  
				
	 			
				MySqlCommand cmd = new MySqlCommand();
				
				
				cmd.CommandType = System.Data.CommandType.Text;
				cmd.CommandText = SQL;
				
				MySqlParameter prmNewEVAT = new MySqlParameter("@NewEVAT",MySqlDbType.Decimal);			
				prmNewEVAT.Value = NewEVAT;
				cmd.Parameters.Add(prmNewEVAT);

				MySqlParameter prmOldEVAT = new MySqlParameter("@OldEVAT",MySqlDbType.Decimal);			
				prmOldEVAT.Value = OldEVAT;
				cmd.Parameters.Add(prmOldEVAT);

				base.ExecuteNonQuery(cmd);
			}

			catch (Exception ex)
			{
				
				
				{
					
					
					
					
				}

				throw ex;
			}	
		}

		public void ChangeLocalTax(decimal OldLocalTax, decimal NewLocalTax)
		{
			try 
			{
				string SQL =	"UPDATE tblProductSubGroupBaseVariationsMatrix SET " +
									"LocalTax		= @NewLocalTax " +
								"WHERE LocalTax		= @OldLocalTax;";
				  
				
	 			
				MySqlCommand cmd = new MySqlCommand();
				
				
				cmd.CommandType = System.Data.CommandType.Text;
				cmd.CommandText = SQL;
				
				MySqlParameter prmNewLocalTax = new MySqlParameter("@NewLocalTax",MySqlDbType.Decimal);			
				prmNewLocalTax.Value = NewLocalTax;
				cmd.Parameters.Add(prmNewLocalTax);

				MySqlParameter prmOldLocalTax = new MySqlParameter("@OldLocalTax",MySqlDbType.Decimal);			
				prmOldLocalTax.Value = OldLocalTax;
				cmd.Parameters.Add(prmOldLocalTax);

				base.ExecuteNonQuery(cmd);
			}

			catch (Exception ex)
			{
				
				
				{
					
					
					
					
				}

				throw ex;
			}	
		}

        public void ChangeTax(long ProductGroupID, long ProductSubGroupID, decimal NewVAT, decimal NewEVAT, decimal NewLocalTax)
        {
            try
            {
                string SQL = "UPDATE tblProductSubGroupBaseVariationsMatrix SET " +
                                    "VAT		= @NewVAT, " +
                                    "EVAT		= @NewEVAT, " +
                                    "LocalTax	= @NewLocalTax ";
                if (ProductSubGroupID != 0) SQL += "WHERE SubGroupID		= @ProductSubGroupID;";
                else if (ProductGroupID != 0) SQL += "WHERE SubGroupID IN (SELECT DISTINCT(ProductSubGroupID) FROM tblProductSubGroup WHERE ProductGroupID = @ProductSubGroupID);";

                

                MySqlCommand cmd = new MySqlCommand();
                
                
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = SQL;

                MySqlParameter prmNewVAT = new MySqlParameter("@NewVAT",MySqlDbType.Decimal);
                prmNewVAT.Value = NewVAT;
                cmd.Parameters.Add(prmNewVAT);

                MySqlParameter prmNewEVAT = new MySqlParameter("@NewEVAT",MySqlDbType.Decimal);
                prmNewEVAT.Value = NewEVAT;
                cmd.Parameters.Add(prmNewEVAT);

                MySqlParameter prmNewLocalTax = new MySqlParameter("@NewLocalTax",MySqlDbType.Decimal);
                prmNewLocalTax.Value = NewLocalTax;
                cmd.Parameters.Add(prmNewLocalTax);

                if (ProductSubGroupID != 0)
                {
                    MySqlParameter prmProductSubGroupID = new MySqlParameter("@ProductSubGroupID",MySqlDbType.Int64);
                    prmProductSubGroupID.Value = ProductSubGroupID;
                    cmd.Parameters.Add(prmProductSubGroupID);
                }
                else if (ProductGroupID != 0)
                {
                    MySqlParameter prmProductGroupID = new MySqlParameter("@ProductGroupID",MySqlDbType.Int64);
                    prmProductGroupID.Value = ProductGroupID;
                    cmd.Parameters.Add(prmProductGroupID);
                }

                base.ExecuteNonQuery(cmd);

            }

            catch (Exception ex)
            {
                
                
                {
                    
                    
                    
                    
                }

                throw ex;
            }
        }

		#endregion

		#region Delete

		public bool Delete(string IDs)
		{
			try 
			{
				string SQL=	"DELETE FROM tblProductSubGroupVariationsMatrix WHERE MatrixID IN (" + IDs + ");";
								
				
	 			
				MySqlCommand cmd = new MySqlCommand();
				
				
				cmd.CommandType = System.Data.CommandType.Text;
				cmd.CommandText = SQL;
				base.ExecuteNonQuery(cmd);


				SQL = "DELETE FROM tblProductSubGroupBaseVariationsMatrix WHERE MatrixID IN (" + IDs + ");";

				cmd.CommandType = System.Data.CommandType.Text;
				cmd.CommandText = SQL;
				base.ExecuteNonQuery(cmd);

				return true;
			}

			catch (Exception ex)
			{
				
				
				{
					
					
					
					
				}

				throw ex;
			}	
		}

		
		#endregion

		#region Details

		public ProductSubGroupVariationsMatrixDetails Details(Int64 MatrixID, Int32 VariationID)
		{
			try
			{
				string SQL=	"SELECT * FROM tblProductSubGroupVariationsMatrix " +
					"WHERE MatrixID = @MatrixID AND VariationID = @VariationID;";
				  
				
	 			
				MySqlCommand cmd = new MySqlCommand();
				
				
				cmd.CommandType = System.Data.CommandType.Text;
				cmd.CommandText = SQL;

				MySqlParameter prmMatrixID = new MySqlParameter("@MatrixID",MySqlDbType.Int64);			
				prmMatrixID.Value = MatrixID;
				cmd.Parameters.Add(prmMatrixID);

				MySqlParameter prmVariationID = new MySqlParameter("@VariationID",MySqlDbType.Int32);
				prmVariationID.Value = VariationID;
				cmd.Parameters.Add(prmVariationID);

				MySqlDataReader myReader = base.ExecuteReader(cmd, System.Data.CommandBehavior.SingleResult);
				
				ProductSubGroupVariationsMatrixDetails Details = new ProductSubGroupVariationsMatrixDetails();

				while (myReader.Read()) 
				{
					Details.MatrixID = MatrixID;
					Details.VariationID = VariationID;
					Details.Description = myReader.GetString(2);
				}

				myReader.Close();

				return Details;
			}

			catch (Exception ex)
			{
				
				
				{
					
					
					
					
				}

				throw ex;
			}	
		}

		public ProductSubGroupBaseMatrixDetails BaseDetails(Int64 MatrixID, Int64 SubGroupID)
		{
			try
			{
				string SQL=	"SELECT " +
								"MatrixID, " +
								"SubGroupID, " +
								"description, " +
								"a.UnitID, " +
								"b.UnitName, " +
								"a.Price, " +
								"a.PurchasePrice, " +
								"a.IncludeInSubtotalDiscount, " +
								"a.VAT, " +
								"a.EVAT, " +
								"a.LocalTax " +
							"FROM tblProductSubGroupBaseVariationsMatrix a INNER JOIN " +
							"tblUnit b ON a.UnitID = b.UnitID " +
							"WHERE MatrixID = @MatrixID AND a.SubGroupID = @SubGroupID;"; 

				
	 			
				MySqlCommand cmd = new MySqlCommand();
				
				
				cmd.CommandType = System.Data.CommandType.Text;
				cmd.CommandText = SQL;

				MySqlParameter prmMatrixID = new MySqlParameter("@MatrixID",MySqlDbType.Int64);			
				prmMatrixID.Value = MatrixID;
				cmd.Parameters.Add(prmMatrixID);

				MySqlParameter prmSubGroupID = new MySqlParameter("@SubGroupID",MySqlDbType.Int64);			
				prmSubGroupID.Value = SubGroupID;
				cmd.Parameters.Add(prmSubGroupID);

				MySqlDataReader myReader = base.ExecuteReader(cmd, System.Data.CommandBehavior.SingleResult);
				
				ProductSubGroupBaseMatrixDetails Details = new ProductSubGroupBaseMatrixDetails();

				while (myReader.Read()) 
				{
					Details.MatrixID = myReader.GetInt64("MatrixID");
					Details.SubGroupID = myReader.GetInt64("SubGroupID");
					Details.Description = "" + myReader["Description"].ToString();
					Details.UnitID = myReader.GetInt32("UnitID");
					Details.UnitName = "" + myReader["UnitName"].ToString();
					Details.Price = myReader.GetDecimal("Price");
					Details.PurchasePrice = myReader.GetDecimal("PurchasePrice");
					Details.IncludeInSubtotalDiscount = myReader.GetBoolean("IncludeInSubtotalDiscount");
					Details.VAT = myReader.GetDecimal("VAT");
					Details.EVAT = myReader.GetDecimal("EVAT");
					Details.LocalTax = myReader.GetDecimal("LocalTax");
				}

				myReader.Close();

				return Details;
			}

			catch (Exception ex)
			{
				
				
				{
					
					
					
					
				}

				throw ex;
			}	
		}
		
		#endregion

		#region Streams

		public MySqlDataReader BaseList(Int64 SubGroupID, string SortField, SortOption SortOrder)
		{
			try
			{
				string SQL =	"SELECT MatrixID, " +
									"SubGroupID, " + 
									"Description, " + 
									"a.UnitID, " + 
									"UnitName, " + 
									"a.Price, " +
									"a.PurchasePrice, " +
									"a.IncludeInSubtotalDiscount, " +
									"a.VAT, " +
									"a.EVAT, " +
									"a.LocalTax " +
								"FROM tblProductSubGroupBaseVariationsMatrix a INNER JOIN " +
								"tblUnit b ON a.UnitID = b.UnitID " +	
								"WHERE SubGroupID = @SubGroupID ORDER BY MatrixID, " + SortField;

				if (SortOrder == SortOption.Ascending)
					SQL += " ASC";
				else
					SQL += " DESC";

				

				MySqlCommand cmd = new MySqlCommand();
				
				
				cmd.CommandType = System.Data.CommandType.Text;
				cmd.CommandText = SQL;
				
				MySqlParameter prmSubGroupID = new MySqlParameter("@SubGroupID",MySqlDbType.Int64);			
				prmSubGroupID.Value = SubGroupID;
				cmd.Parameters.Add(prmSubGroupID);

				
				
				return base.ExecuteReader(cmd);			
			}
			catch (Exception ex)
			{
				
				
				{
					
					
					
					
				}

				throw ex;
			}	
		}

		public MySqlDataReader List(Int64 ProductSubGroupBaseVariationsMatrixID)
		{
			try 
			{
				string SQL=	"SELECT MatrixID, VariationID, Description FROM tblProductSubGroupVariationsMatrix " + 
					"WHERE MatrixID = @MatrixID ORDER BY MatrixID ASC;";

				

				MySqlCommand cmd = new MySqlCommand();
				
				
				cmd.CommandType = System.Data.CommandType.Text;
				cmd.CommandText = SQL;
				
				MySqlParameter prmMatrixID = new MySqlParameter("@MatrixID",MySqlDbType.Int64);						
				prmMatrixID.Value = ProductSubGroupBaseVariationsMatrixID;
				cmd.Parameters.Add(prmMatrixID);

				
				
				return base.ExecuteReader(cmd);	
			}

			catch (Exception ex)
			{
				
				
				{
					
					
					
					
				}

				throw ex;
			}	
		}
		public MySqlDataReader Search(Int64 SubGroupID, string SearchKey, string SortField, SortOption SortOrder)
		{
			try
			{
				string SQL = "SELECT MatrixID, " +
								"SubGroupID, " + 
								"Description, " + 
								"a.UnitID, " + 
								"UnitName, " + 
								"a.Price, " +
								"a.PurchasePrice, " +
								"a.IncludeInSubtotalDiscount, " +
								"a.VAT, " +
								"a.EVAT, " +
								"a.LocalTax " +
							"FROM tblProductSubGroupBaseVariationsMatrix a INNER JOIN " +
							"tblUnit b ON a.UnitID = b.UnitID " +	
							"WHERE SubGroupID = @SubGroupID  " + 
							"AND Description LIKE @SearchKey " + 
							"ORDER BY MatrixID, " + SortField;

				if (SortOrder == SortOption.Ascending)
					SQL += " ASC";
				else
					SQL += " DESC";

				

				MySqlCommand cmd = new MySqlCommand();
				
				
				cmd.CommandType = System.Data.CommandType.Text;
				cmd.CommandText = SQL;
				
				MySqlParameter prmSubGroupID = new MySqlParameter("@SubGroupID",MySqlDbType.Int64);			
				prmSubGroupID.Value = SubGroupID;
				cmd.Parameters.Add(prmSubGroupID);

				MySqlParameter prmSearchKey = new MySqlParameter("@SearchKey",MySqlDbType.String);			
				prmSearchKey.Value = "%" + SearchKey + "%";
				cmd.Parameters.Add(prmSearchKey);

				
				
				return base.ExecuteReader(cmd);
			}
			catch (Exception ex)
			{
				
				
				{
					
					
					
					
				}

				throw ex;
			}	
		}


		#endregion

		#region Private Modifiers

		public bool IsVariationExists(Int64 MatrixID, Int32 VariationID)
		{
			try 
			{
				bool boRetValue = false;
					
				string SQL=	"SELECT * FROM tblProductSubGroupVariationsMatrix " + 
								"WHERE MatrixID = @MatrixID " + 
							"AND VariationID = @VariationID;";

				
	 			
				MySqlCommand cmd = new MySqlCommand();
				
				
				cmd.CommandType = System.Data.CommandType.Text;
				cmd.CommandText = SQL;

				MySqlParameter prmMatrixID = new MySqlParameter("@MatrixID",MySqlDbType.Int64);						
				prmMatrixID.Value = MatrixID;
				cmd.Parameters.Add(prmMatrixID);

				MySqlParameter prmVariationID = new MySqlParameter("@VariationID",MySqlDbType.Int32);			
				prmVariationID.Value = VariationID;
				cmd.Parameters.Add(prmVariationID);

				MySqlDataReader myReader = base.ExecuteReader(cmd, System.Data.CommandBehavior.SingleResult);
				
				while (myReader.Read()) 
				{
					boRetValue = true;
				}

				myReader.Close();

				return boRetValue;
			}

			catch (Exception ex)
			{
				
				
				{
					
					
					
					
				}

				throw ex;
			}	
		}


		#endregion
	}
}

