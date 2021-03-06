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
    public struct SalutationDetails
    {
        public Int32 SalutationID;
        public string SalutationCode;
        public string SalutationName;

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
    public class Salutation : POSConnection
    {
		#region Constructors and Destructors

		public Salutation()
            : base(null, null)
        {
        }

        public Salutation(MySqlConnection Connection, MySqlTransaction Transaction) 
            : base(Connection, Transaction)
		{

		}

		#endregion

        #region Insert and Update

        public Int32 Insert(SalutationDetails Details)
        {
            try
            {
                Save(Details);

                return Int32.Parse(base.getLAST_INSERT_ID(this));
            }

            catch (Exception ex)
            {
                throw base.ThrowException(ex);
            }
        }

        public void Update(SalutationDetails Details)
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

        public Int32 Save(SalutationDetails Details)
        {
            try
            {
                string SQL = "CALL procSaveSalutation(@SalutationID, @SalutationCode, @SalutationName, @CreatedOn, @LastModified);";

                MySqlCommand cmd = new MySqlCommand();
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = SQL;

                cmd.Parameters.AddWithValue("SalutationID", Details.SalutationID);
                cmd.Parameters.AddWithValue("SalutationCode", Details.SalutationCode);
                cmd.Parameters.AddWithValue("SalutationName", Details.SalutationName);
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

        #region Streams

        public System.Data.DataTable ListAsDataTable(string Salutation = "", string SortField = "SalutationCode", System.Data.SqlClient.SortOrder SortOrder = System.Data.SqlClient.SortOrder.Ascending)
        {
            try
            {
                string SQL = "CALL procSalutationSelect(@Salutation, @SortField, @SortOrder)";

                MySqlCommand cmd = new MySqlCommand();
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = SQL;

                cmd.Parameters.AddWithValue("@Salutation", Salutation);
                cmd.Parameters.AddWithValue("@SortField", SortField);
                switch (SortOrder)
                {
                    case System.Data.SqlClient.SortOrder.Ascending:
                        cmd.Parameters.AddWithValue("@SortOrder", "ASC");
                        break;
                    case System.Data.SqlClient.SortOrder.Descending:
                        cmd.Parameters.AddWithValue("@SortOrder", "DESC");
                        break;
                }

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

