using System;
using System.Collections.Generic;
using System.Text;

namespace AceSoft.RetailPlus
{
    public class DataConstants
    {
        public const long DEFAULT_PRODUCT_GROUP = 1;

        public const long MAX_PURCHASE_PRICE_SUPPLIER = 5;

    }

    public struct Constants
    {
        public const Int32 CONTACT_GROUP_CUSTOMER = 1;
        public const Int32 CONTACT_GROUP_SUPPLIER = 2;
        public const Int32 CONTACT_GROUP_BOTH = 3;
        public const Int32 CONTACT_GROUP_AGENT = 4;

        public const string C_RETAILPLUS_CUSTOMER = "RetailPlus Customer ™";
        public const Int64 C_RETAILPLUS_CUSTOMERID = 1;

        public const string C_RETAILPLUS_SUPPLIER = "RetailPlus Supplier ™";
        public const Int64 C_RETAILPLUS_SUPPLIERID = 2;

        public const string C_RETAILPLUS_WAITER = "RetailPlus Default";
        public const Int64 C_RETAILPLUS_WAITERID = 2;

        public const string C_RETAILPLUS_AGENT = "RetailPlus Agent ™";
        public const Int64 C_RETAILPLUS_AGENTID = 1;

        public const string C_RETAILPLUS_ORDER_SLIP_CUSTOMER = "ORDER SLIP";

        public const int C_RETAILPLUS_AGENT_DEPARTMENTID = 1;
        public const int C_RETAILPLUS_AGENT_POSITIONID = 1;
        public const string C_RETAILPLUS_AGENT_POSITIONNAME = "System Default Position";
        public const string C_RETAILPLUS_AGENT_DEPARTMENT_NAME = "System Default Department";

        public const int C_DEFAULT_TERMINAL_ID_01 = 1;
        public const string C_DEFAULT_TERMINAL_01 = "01";

        public const int C_DEFAULT_LIMIT_OF_RECORD_TO_SHOW = 100;

        public const int BRANCH_ID_MAIN = 1;
        public const string BRANCH_MAIN = "MAIN";
        public static int TerminalBranchID
        {
            get
            {
                int intRetValue = BRANCH_ID_MAIN;

                if (System.Configuration.ConfigurationManager.AppSettings["BranchID"] != null)
                {
                    try { Int32.TryParse(System.Configuration.ConfigurationManager.AppSettings["BranchID"], out intRetValue); }
                    catch { }

                    if (intRetValue == 0) intRetValue = BRANCH_ID_MAIN;
                }

                return intRetValue;
            }
        }

        public const string ALL = "ALL";
        public const string PLEASE_SELECT = "Please Select";
        public const long ZERO = 0;
        public const string ZERO_STRING = "0";

        // 05Jun2015
        public const string PLUSCARDMEMBERS = "PLUS-CARD MEMBERS";
        public const long PLUSCARDMEMBERSID = 999999999999999;
        public const string PLUSCARDMEMBERSID_STRING = "999999999999999";

        public const string ICCARDMEMBERS = "ICCARD MEMBERS";
        public const long ICCARDMEMBERSID = 999999999999998;
        public const string ICCARDMEMBERSID_STRING = "999999999999998";

        public const string GCCARDMEMBERS = "GROUP CREDIT CARD MEMBERS";
        public const long GCCARDMEMBERSID = 999999999999997;
        public const string GCCARDMEMBERSID_STRING = "999999999999997";

        //public static string C_DISCOUNT_CODE_SENIORCITIZEN
        //{
        //    get
        //    {
        //        string strRetValue = "SNR"; ;
        //        try { strRetValue = System.Configuration.ConfigurationManager.AppSettings["SeniorCitizenDiscountCode"].ToString(); }
        //        catch { }
        //        return strRetValue;
        //    }
        //}
        //public static string C_DISCOUNT_CODE_PWD
        //{
        //    get
        //    {
        //        string strRetValue = "PWD"; ;
        //        try { strRetValue = System.Configuration.ConfigurationManager.AppSettings["PWDDiscountCode"].ToString(); }
        //        catch { }
        //        return strRetValue;
        //    }
        //}
        public const string C_DISCOUNT_CODE_FREE = "FREE";

        public const string RETAILPLUS_BUSINESS_SOLUTIONS = "RetailPlus™ Business Solutions";
        public const string DEMO_EXPIRED_HEADER = "RetailPlus™ Demo Version";
        public const string DEMO_EXPIRED_MESSAGE = "This copy has been expired. Please contact your nearest software distributor or email <a href='mailto:sales@myretailplus.com'>sales@myretailplus.com</a>";
        public const string STOCK_TYPE_TRANSFER_TO_BRANCH_ID = "5";
        public const string STOCK_TYPE_TRANSFER_FROM_BRANCH_ID = "6";
        public const string ROOT_DIRECTORY = "/RetailPlus";
        public const string ROOT_DIRECTORY_BILLING_WoutG = "/RetailPlus/temp/billings/woutg";
        public const string ROOT_DIRECTORY_BILLING_WithG = "/RetailPlus/temp/billings/withg";
        public const string PURCHASE_ORDER_CODE = "PO-";
        public const string PURCHASE_RETURN_CODE = "PORET-";
        public const string PURCHASE_DEBITMEMO_CODE = "PODEB-";
        public const string SALES_ORDER_CODE = "SO-";
        public const string SALES_RETURN_CODE = "SORET-";
        public const string SALES_CREDITMEMO_CODE = "SOCRE-";
        public const string TRANSFER_IN_CODE = "TXI-";
        public const string TRANSFER_OUT_CODE = "TXO-";
        public const string INVENTORY_ADJUSTMENT_CODE = "INADJ-";
        public const string BRANCH_TRANSFER_CODE = "BX-";
        public const decimal DEFAULTS_VAT = 12;

        public const string CLOSE_INVENTORY_CODE = "CINV-";
        public const string CLOSE_INVENTORY_FILE_NAME_CODE = "CLOSE-INV";
        public const string CLOSE_INVENTORY_SHEET_NAME = "INVENTORY";
        public const string CLOSE_INVENTORY_SHEET_NAME_QUANTITY_ERROR = "QUANTITY_ERROR";
        public const string CLOSE_INVENTORY_SHEET_NAME_INVALID_PRODUCT = "INVALID_PRODUCT";

        public const string ERROR = "ERROR";

        public const string SWIPE_REWARD_CARD = "SWIPE REWARD or CREDIT CARD:";

        public const int C_RESTOPLUS_MAX_SUB_GROUP = 7;
        public const int C_RESTOPLUS_MAX_PRODUCTS = 20;
        public const int C_RESTOPLUS_MAX_TABLES = 20;
        public const string C_RESTOPLUS = "RestoPlus ™";
        public const string C_RESTOPLUS_CUSTOMER_ORDERS = "CUSTOMER's ORDER";

        public const string C_FE_DEFAULT_DECIMAL_FORMAT = "#,##0.##0";

        public const string C_FE_NOT_VALID_AS_RECEIPT = "NOT VALID AS RECEIPT";

        public enum DateSelectionString
        {
            ALL = 0,
            Today = 1,
            NextMonth = 2,
            CurrentMonth = 3,
            PreviousMonth = 4,
        }

        public const Int32 C_DEFAULT_MYSQL_PROCESS_TIMEOUT = 120;

        public static DateTime C_DATE_MIN_VALUE = Convert.ToDateTime("1900-01-01");
        public const string C_DATE_MIN_VALUE_STRING = "1900-01-01";

        public const string SYS_CONFIG_BACKEND_VARIATION_TYPE = "BACKEND_VARIATION_TYPE";
        public const string SYS_CONFIG_BACKEND_VARIATION_TYPE_EXPIRATION_LOTNO = "EXPIRATION;LOTNO";
        public const string SYS_CONFIG_BE_COMPANY_CODE = "BECompanyCode";
        public const string SYS_CONFIG_COMPANY_CODE = "CompanyCode";
        public const string SYS_CONFIG_COMPANY_NAME = "CompanyName";
        public const string SYS_CONFIG_CURRENCY = "Currency";
        public const string SYS_CONFIG_TIN = "TIN";
        public const string SYS_CONFIG_VERSION_FTP_IPADDRESS = "VersionFTPIPAddress";
        public const string SYS_CONFIG_CHECK_OUT_BILL_HEADER_LABEL = "CheckOutBillHeaderLabel";
        public const string SYS_CONFIG_CHARGE_SLIP_HEADER_LABEL = "ChargeSlipHeaderLabel";
        public const string SYS_CONFIG_CREDIT_VERIFICATION_SLIP_HEADER_LABEL = "CreditVerificationSlipHeaderLabel";
        public const string SYS_CONFIG_WILL_PRINT_CREDITPAYMENT_HEADER = "WillPrintCreditPaymentHeader";
        public const string SYS_CONFIG_WILL_WRITE_SYSTEM_LOG = "WillWriteSystemLog";
        public const string SYS_CONFIG_WILL_DEDUCT_TF_IN_XREAD = "WillDeductTFInXRead";
        public const string SYS_CONFIG_WILL_DEDUCT_TF_IN_ZREAD = "WillDeductTFInZRead";
        public const string SYS_CONFIG_WILL_DEDUCT_TF_IN_TERMINAL_REPORT = "WillDeductTFInTerminalReport";
        public const string SYS_CONFIG_WILL_ASK_DO_NOT_PRINT_TRANSACTIONDATE = "WillAskDoNotPrintTransactionDate";
        public const string SYS_CONFIG_WILL_SHOW_PRODUCT_TOTAL_QUANTITY_IN_ITEMSELECT = "WillShowProductTotalQuantityInItemSelect";
        public const string SYS_CONFIG_WILL_SHOW_PRODUCT_BRANCH_QUANTITY_IN_ITEMSELECT = "WillShowProductBranchQuantityInItemSelect";
        public const string SYS_CONFIG_WILL_NOT_PRINT_REPRINT_MESSAGE = "WillNotPrintReprintMessage";
        public const string SYS_CONFIG_WILL_DEPOSIT_CHANGE_OF_CREDIT_PAYMENT = "WillDepositChangeOfCreditPayment";
        public const string SYS_CONFIG_CREDIT_PAYMENT_TYPE = "CreditPaymentType";
        public const string SYS_CONFIG_ALLOW_DEBIT_PAYMENT = "AllowDebitPayment";
        public const string SYS_CONFIG_ALLOW_REWARD_POINTS_PAYMENT = "AllowRewardPointsPayment";
        public const string SYS_CONFIG_ALLOW_DISCOUNT_GREATER_THAN_AMOUNT = "AllowDiscountGreaterThanAmount";
        public const string SYS_CONFIG_ALLOW_ZERO_AMOUNT_TRANSACTION = "AllowZeroAmountTransaction";
        public const string SYS_CONFIG_ALLOW_MORE_THAN_1ITEM_IF_CONSIGNMENT = "AllowMoreThan1ItemIfConsignment";
        public const string SYS_CONFIG_WILL_PROCESS_CREDIT_BILLER_IN_PROGRAM = "WillProcessCreditBillerInProgram";
        public const string SYS_CONFIG_WILL_CONVERT_WEIGHT_MEASUREMENT_TO1_IN_QTY_SOLD = "WillConvertWeightMeasurementTo1InQtySold";
        public const string SYS_CONFIG_WILL_CONVERT_WEIGHT_MEASUREMENT = "WeightMeasurement";
        public const string SYS_CONFIG_IS_DEFAULT_BUTTON_YES_INPRINTTRANSACTION = "isDefaultButtonYesInPrintTransaction";
        public const string SYS_CONFIG_OUT_OF_STOCK_CUSTOMER_CODE = "OutOfStockCustomerCode";
        public const string SYS_CONFIG_WALKIN_CUSTOMER_CODE = "WalkInCustomerCode";
        public const string SYS_CONFIG_CHEQUE_PAYMENT_ACCEPTABLE_NO_OF_DAYS = "ChequePaymentAcceptableNoOfDays";
        public const string SYS_CONFIG_ENABLE_PRICE_LEVEL = "EnablePriceLevel";

        public const string SYS_CONFIG_OR_HEADER = "ORHeader";

        public const string SYS_CONFIG_INVENTORY_TRUSTFUND = "InventoryTrustFund";
        public const string SYS_CONFIG_CONTACTADDWND_TYPE = "ContactAddWndType";
        public const string SYS_CONFIG_ITEMSELECTWND_COLUMNTYPE = "ItemSelectWndColumnType";
        public const string SYS_CONFIG_ITEMSELECTWND_COLUMN_SEARCH_TYPE = "ItemSelectWndColumnSearchType";

        public const string SYS_CONFIG_BSD_DISCOUNT_CODE = "BSDDiscountCode";
        public const string SYS_CONFIG_BSD_DISCOUNT_CODE_DINER_COUNT = "BSDDiscountCodeDinerCount";

        public const string SYS_CONFIG_PROD_LAST_SYNC_DATETIME = "ProdLastSyncDateTime";
        public const string SYS_CONFIG_PROD_SYNC_INTERVAL = "ProdSyncInterval";

        /// <summary>
        /// GLA Files
        /// </summary>
        public const string GLA_file_batch_id = "batch_id.dat";
        public const string GLA_file_d_dsc_def = "d_dsc_def.dat";
        public const string GLA_file_d_emp_def = "d_emp_def.dat";
        public const string GLA_file_d_location_def = "d_location_def.dat";
        public const string GLA_file_d_mi_def = "d_mi_def.dat";
        public const string GLA_file_d_svc_def = "d_svc_def.dat";
        public const string GLA_file_d_tmd_def = "d_tmd_def.dat";
        public const string GLA_file_f_dtl_chk_dsc = "f_dtl_chk_dsc.dat";
        public const string GLA_file_f_dtl_chk_headers = "f_dtl_chk_headers.dat";
        public const string GLA_file_f_dtl_chk_mi = "f_dtl_chk_mi.dat";
        public const string GLA_file_f_dtl_chk_svc = "f_dtl_chk_svc.dat";
        public const string GLA_file_f_dtl_chk_tmd = "f_dtl_chk_tmd.dat";
        public const string GLA_file_otntender = "otn_tender.txt";

        /// <summary>
        /// SysCreditConfig
        /// </summary>
        public const string SYS_CONFIG_CRED_MIN_AMOUNT_DUE = "SYS_CONFIG_CRED_MIN_AMOUNT_DUE";
        public const string SYS_CONFIG_CRED_MIN_PERCENTAGE_DUE = "SYS_CONFIG_CRED_MIN_PERCENTAGE_DUE";
        public const string SYS_CREDIT_FINANCE_CHARGE = "SYS_CREDIT_FINANCE_CHARGE";
        public const string SYS_CREDIT_LATE_PENALTY_CHARGE = "SYS_CREDIT_LATE_PENALTY_CHARGE";
        public const string SYS_CREDIT_USE_LASTDAY_CUTT_OFF_DATE = "SYS_CREDIT_USE_LASTDAY_CUTT_OFF_DATE";
        
        public const string SYS_BILLING_DATE = "SYS_BILLING_DATE";
        public const string SYS_CREDIT_CUTOFF_DATE = "SYS_CREDIT_CUTOFF_DATE";

        public const string TRUSTFUND_UPDATE_REASON_XREAD = "XREAD";
        public const string TRUSTFUND_UPDATE_REASON_ALT_DEL = "ALT+DEL";

        public const Int16 C_DEF_COUNTRY_ID = 1;
        public const string C_DEF_COUNTRY_CODE = "Philippines";

        public const Int16 C_DEF_PROMO_TYPE_ID = 2;
        public const string C_DEF_PROMO_TYPE_CODE = "Percent-Off after quantity reached.";
    }
}
