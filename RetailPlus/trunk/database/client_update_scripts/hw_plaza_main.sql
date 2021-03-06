
-- /*!40000 ALTER TABLE tblProducts DISABLE KEYS */;

DELETE FROM tblTerminal WHERE TerminalID > 2;
DELETE FROM tblTerminalReport WHERE TerminalID > 2;
DELETE FROM tblTerminalReportHistory WHERE TerminalID > 2;

DELETE FROM tblTransactionItems WHERE TransactionID IN (SELECT DISTINCT TransactionID FROM tblTransactions WHERE TerminalNo > 2);
DELETE FROM tblCashPayment WHERE TransactionID IN (SELECT DISTINCT TransactionID FROM tblTransactions WHERE TerminalNo > 2);
DELETE FROM tblChequePayment WHERE TransactionID IN (SELECT DISTINCT TransactionID FROM tblTransactions WHERE TerminalNo > 2);
DELETE FROM tblCreditCardPayment WHERE TransactionID IN (SELECT DISTINCT TransactionID FROM tblTransactions WHERE TerminalNo > 2);
DELETE FROM tblCreditPayment WHERE TransactionID IN (SELECT DISTINCT TransactionID FROM tblTransactions WHERE TerminalNo > 2);
DELETE FROM tblDebitPayment WHERE TransactionID IN (SELECT DISTINCT TransactionID FROM tblTransactions WHERE TerminalNo > 2);
DELETE FROM tblCreditPaymentCash WHERE TransactionID IN (SELECT DISTINCT TransactionID FROM tblTransactions WHERE TerminalNo > 2);
DELETE FROM tblCreditPaymentCheque WHERE TransactionID IN (SELECT DISTINCT TransactionID FROM tblTransactions WHERE TerminalNo > 2);
DELETE FROM tblTransactions WHERE TerminalNo > 2;

DELETE FROM tblPaidOut WHERE TerminalNo > 2;
DELETE FROM tblDisburse WHERE TerminalNo > 2;
DELETE FROM tblWithHold WHERE TerminalNo > 2;
DELETE FROM tblDeposit WHERE TerminalNo > 2;
DELETE FROM tblDisburse WHERE TerminalNo > 2;
DELETE FROM tblDisburse WHERE TerminalNo > 2;

INSERT INTO tblTerminal (TerminalID, TerminalNo, TerminalCode, TerminalName, DateCreated, MachineSerialNo, AccreditationNo )
		VALUES		(3, '03', 'Terminal No. 03', 'Terminal No. 03', NOW(), '000000', '0000-000-00000-000');
INSERT INTO tblTerminal (TerminalID, TerminalNo, TerminalCode, TerminalName, DateCreated, MachineSerialNo, AccreditationNo )
		VALUES		(4, '04', 'Terminal No. 04', 'Terminal No. 04', NOW(), '000000', '0000-000-00000-000');
INSERT INTO tblTerminal (TerminalID, TerminalNo, TerminalCode, TerminalName, DateCreated, MachineSerialNo, AccreditationNo )
		VALUES		(5, '05', 'Terminal No. 05', 'Terminal No. 05', NOW(), '000000', '0000-000-00000-000');
INSERT INTO tblTerminal (TerminalID, TerminalNo, TerminalCode, TerminalName, DateCreated, MachineSerialNo, AccreditationNo )
		VALUES		(6, '06', 'Terminal No. 06', 'Terminal No. 06', NOW(), '000000', '0000-000-00000-000');
INSERT INTO tblTerminal (TerminalID, TerminalNo, TerminalCode, TerminalName, DateCreated, MachineSerialNo, AccreditationNo )
		VALUES		(7, '07', 'Terminal No. 07', 'Terminal No. 07', NOW(), '000000', '0000-000-00000-000');
INSERT INTO tblTerminal (TerminalID, TerminalNo, TerminalCode, TerminalName, DateCreated, MachineSerialNo, AccreditationNo )
		VALUES		(8, '08', 'Terminal No. 08', 'Terminal No. 08', NOW(), '000000', '0000-000-00000-000');
INSERT INTO tblTerminal (TerminalID, TerminalNo, TerminalCode, TerminalName, DateCreated, MachineSerialNo, AccreditationNo )
		VALUES		(9, '09', 'Terminal No. 09', 'Terminal No. 09', NOW(), '000000', '0000-000-00000-000');
INSERT INTO tblTerminal (TerminalID, TerminalNo, TerminalCode, TerminalName, DateCreated, MachineSerialNo, AccreditationNo )
		VALUES		(10, '10', 'Terminal No. 10', 'Terminal No. 10', NOW(), '000000', '0000-000-00000-000');
INSERT INTO tblTerminal (TerminalID, TerminalNo, TerminalCode, TerminalName, DateCreated, MachineSerialNo, AccreditationNo )
		VALUES		(11, '11', 'Terminal No. 11', 'Terminal No. 11', NOW(), '000000', '0000-000-00000-000');
INSERT INTO tblTerminal (TerminalID, TerminalNo, TerminalCode, TerminalName, DateCreated, MachineSerialNo, AccreditationNo )
		VALUES		(12, '12', 'Terminal No. 12', 'Terminal No. 12', NOW(), '000000', '0000-000-00000-000');
INSERT INTO tblTerminal (TerminalID, TerminalNo, TerminalCode, TerminalName, DateCreated, MachineSerialNo, AccreditationNo )
		VALUES		(13, '13', 'Terminal No. 13', 'Terminal No. 13', NOW(), '000000', '0000-000-00000-000');
INSERT INTO tblTerminal (TerminalID, TerminalNo, TerminalCode, TerminalName, DateCreated, MachineSerialNo, AccreditationNo )
		VALUES		(14, '14', 'Terminal No. 14', 'Terminal No. 14', NOW(), '000000', '0000-000-00000-000');
INSERT INTO tblTerminal (TerminalID, TerminalNo, TerminalCode, TerminalName, DateCreated, MachineSerialNo, AccreditationNo )
		VALUES		(15, '15', 'Terminal No. 15', 'Terminal No. 15', NOW(), '000000', '0000-000-00000-000');
INSERT INTO tblTerminal (TerminalID, TerminalNo, TerminalCode, TerminalName, DateCreated, MachineSerialNo, AccreditationNo )
		VALUES		(16, '16', 'Terminal No. 16', 'Terminal No. 16', NOW(), '000000', '0000-000-00000-000');
INSERT INTO tblTerminal (TerminalID, TerminalNo, TerminalCode, TerminalName, DateCreated, MachineSerialNo, AccreditationNo )
		VALUES		(17, '17', 'Terminal No. 17', 'Terminal No. 17', NOW(), '000000', '0000-000-00000-000');
INSERT INTO tblTerminal (TerminalID, TerminalNo, TerminalCode, TerminalName, DateCreated, MachineSerialNo, AccreditationNo )
		VALUES		(18, '18', 'Terminal No. 18', 'Terminal No. 18', NOW(), '000000', '0000-000-00000-000');
INSERT INTO tblTerminal (TerminalID, TerminalNo, TerminalCode, TerminalName, DateCreated, MachineSerialNo, AccreditationNo )
		VALUES		(19, '19', 'Terminal No. 19', 'Terminal No. 19', NOW(), '000000', '0000-000-00000-000');
INSERT INTO tblTerminal (TerminalID, TerminalNo, TerminalCode, TerminalName, DateCreated, MachineSerialNo, AccreditationNo )
		VALUES		(20, '20', 'Terminal No. 20', 'Terminal No. 20', NOW(), '000000', '0000-000-00000-000');
-- CN Traders
INSERT INTO tblTerminal (TerminalID, TerminalNo, TerminalCode, TerminalName, DateCreated, MachineSerialNo, AccreditationNo )
		VALUES		(80, '80', 'Terminal No. 80', 'Terminal No. 80', NOW(), '000000', '0000-000-00000-000');
INSERT INTO tblTerminal (TerminalID, TerminalNo, TerminalCode, TerminalName, DateCreated, MachineSerialNo, AccreditationNo )
		VALUES		(81, '81', 'Terminal No. 81', 'Terminal No. 81', NOW(), '000000', '0000-000-00000-000');
INSERT INTO tblTerminal (TerminalID, TerminalNo, TerminalCode, TerminalName, DateCreated, MachineSerialNo, AccreditationNo )
		VALUES		(82, '82', 'Terminal No. 82', 'Terminal No. 82', NOW(), '000000', '0000-000-00000-000');
INSERT INTO tblTerminal (TerminalID, TerminalNo, TerminalCode, TerminalName, DateCreated, MachineSerialNo, AccreditationNo )
		VALUES		(83, '83', 'Terminal No. 83', 'Terminal No. 83', NOW(), '000000', '0000-000-00000-000');
INSERT INTO tblTerminal (TerminalID, TerminalNo, TerminalCode, TerminalName, DateCreated, MachineSerialNo, AccreditationNo )
		VALUES		(84, '84', 'Terminal No. 84', 'Terminal No. 84', NOW(), '000000', '0000-000-00000-000');
-- Customer Service
INSERT INTO tblTerminal (TerminalID, TerminalNo, TerminalCode, TerminalName, DateCreated, MachineSerialNo, AccreditationNo )
		VALUES		(90, '90', 'Terminal No. 90', 'Terminal No. 90', NOW(), '000000', '0000-000-00000-000');
INSERT INTO tblTerminal (TerminalID, TerminalNo, TerminalCode, TerminalName, DateCreated, MachineSerialNo, AccreditationNo )
		VALUES		(91, '91', 'Terminal No. 91', 'Terminal No. 91', NOW(), '000000', '0000-000-00000-000');
INSERT INTO tblTerminal (TerminalID, TerminalNo, TerminalCode, TerminalName, DateCreated, MachineSerialNo, AccreditationNo )
		VALUES		(92, '92', 'Terminal No. 92', 'Terminal No. 92', NOW(), '000000', '0000-000-00000-000');

-- Default for loading old data
INSERT INTO tblTerminal (TerminalID, TerminalNo, TerminalCode, TerminalName, DateCreated, MachineSerialNo, AccreditationNo )
		VALUES		(9999, '9999', 'Terminal No. 9999', 'Terminal No. 9999', NOW(), '000000', '0000-000-00000-000');
				
		-- 09362765999 - jun							

INSERT INTO tblTerminalReport (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000001', '00000000000001', '00000000000001', '00000000000001', 1, 1, 2, '02', DATE_SUB(DATE(NOW()), INTERVAL 1 DAY));
INSERT INTO tblTerminalReport (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000001', '00000000000001', '00000000000001', '00000000000001',  1, 1, 4, '04', DATE_SUB(DATE(NOW()), INTERVAL 1 DAY));
INSERT INTO tblTerminalReport (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000001', '00000000000001', '00000000000001', '00000000000001',  1, 1, 5, '05', DATE_SUB(DATE(NOW()), INTERVAL 1 DAY));
INSERT INTO tblTerminalReport (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000001', '00000000000001', '00000000000001', '00000000000001',  1, 1, 6, '06', DATE_SUB(DATE(NOW()), INTERVAL 1 DAY));
INSERT INTO tblTerminalReport (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000001', '00000000000001', '00000000000001', '00000000000001',  1, 1, 7, '07', DATE_SUB(DATE(NOW()), INTERVAL 1 DAY));
INSERT INTO tblTerminalReport (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000001', '00000000000001', '00000000000001', '00000000000001',  1, 1, 8, '08', DATE_SUB(DATE(NOW()), INTERVAL 1 DAY));
INSERT INTO tblTerminalReport (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000001', '00000000000001', '00000000000001', '00000000000001',  1, 1, 9, '09', DATE_SUB(DATE(NOW()), INTERVAL 1 DAY));
INSERT INTO tblTerminalReport (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000001', '00000000000001', '00000000000001', '00000000000001',  1, 1, 10, '10', DATE_SUB(DATE(NOW()), INTERVAL 1 DAY));
INSERT INTO tblTerminalReport (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000001', '00000000000001', '00000000000001', '00000000000001',  1, 1, 11, '11', DATE_SUB(DATE(NOW()), INTERVAL 1 DAY));
INSERT INTO tblTerminalReport (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000001', '00000000000001', '00000000000001', '00000000000001',  1, 1, 12, '12', DATE_SUB(DATE(NOW()), INTERVAL 1 DAY));
INSERT INTO tblTerminalReport (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000001', '00000000000001', '00000000000001', '00000000000001',  1, 1, 13, '13', DATE_SUB(DATE(NOW()), INTERVAL 1 DAY));
INSERT INTO tblTerminalReport (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000001', '00000000000001', '00000000000001', '00000000000001',  1, 1, 14, '14', DATE_SUB(DATE(NOW()), INTERVAL 1 DAY));
INSERT INTO tblTerminalReport (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000001', '00000000000001', '00000000000001', '00000000000001',  1, 1, 15, '15', DATE_SUB(DATE(NOW()), INTERVAL 1 DAY));
INSERT INTO tblTerminalReport (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000001', '00000000000001', '00000000000001', '00000000000001',  1, 1, 16, '16', DATE_SUB(DATE(NOW()), INTERVAL 1 DAY));
INSERT INTO tblTerminalReport (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000001', '00000000000001', '00000000000001', '00000000000001',  1, 1, 17, '17', DATE_SUB(DATE(NOW()), INTERVAL 1 DAY));
INSERT INTO tblTerminalReport (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000001', '00000000000001', '00000000000001', '00000000000001',  1, 1, 18, '18', DATE_SUB(DATE(NOW()), INTERVAL 1 DAY));
INSERT INTO tblTerminalReport (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000001', '00000000000001', '00000000000001', '00000000000001',  1, 1, 19, '19', DATE_SUB(DATE(NOW()), INTERVAL 1 DAY));
INSERT INTO tblTerminalReport (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000001', '00000000000001', '00000000000001', '00000000000001',  1, 1, 20, '20', DATE_SUB(DATE(NOW()), INTERVAL 1 DAY));
-- CN Traders
INSERT INTO tblTerminalReport (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000001', '00000000000001', '00000000000001', '00000000000001',  1, 1, 80, '80', DATE_SUB(DATE(NOW()), INTERVAL 1 DAY));
INSERT INTO tblTerminalReport (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000001', '00000000000001', '00000000000001', '00000000000001',  1, 1, 81, '81', DATE_SUB(DATE(NOW()), INTERVAL 1 DAY));
INSERT INTO tblTerminalReport (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000001', '00000000000001', '00000000000001', '00000000000001',  1, 1, 82, '82', DATE_SUB(DATE(NOW()), INTERVAL 1 DAY));
INSERT INTO tblTerminalReport (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000001', '00000000000001', '00000000000001', '00000000000001',  1, 1, 83, '83', DATE_SUB(DATE(NOW()), INTERVAL 1 DAY));
INSERT INTO tblTerminalReport (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000001', '00000000000001', '00000000000001', '00000000000001',  1, 1, 84, '84', DATE_SUB(DATE(NOW()), INTERVAL 1 DAY));
-- CS
INSERT INTO tblTerminalReport (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000001', '00000000000001', '00000000000001', '00000000000001',  1, 1, 90, '90', DATE_SUB(DATE(NOW()), INTERVAL 1 DAY));
INSERT INTO tblTerminalReport (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000001', '00000000000001', '00000000000001', '00000000000001',  1, 1, 91, '91', DATE_SUB(DATE(NOW()), INTERVAL 1 DAY));
INSERT INTO tblTerminalReport (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000001', '00000000000001', '00000000000001', '00000000000001',  1, 1, 92, '92', DATE_SUB(DATE(NOW()), INTERVAL 1 DAY));
		
				
INSERT INTO tblTerminalReportHistory (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000000', '00000000000000', '00000000000000', '00000000000000',  0, 0, 3, '03', DATE_SUB(DATE(NOW()), INTERVAL 2 DAY));
INSERT INTO tblTerminalReportHistory (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000000', '00000000000000', '00000000000000', '00000000000000', 0, 0, 4, '04', DATE_SUB(DATE(NOW()), INTERVAL 2 DAY));
INSERT INTO tblTerminalReportHistory (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000000', '00000000000000', '00000000000000', '00000000000000', 0, 0, 5, '05', DATE_SUB(DATE(NOW()), INTERVAL 2 DAY));
INSERT INTO tblTerminalReportHistory (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000000', '00000000000000', '00000000000000', '00000000000000', 0, 0, 6, '06', DATE_SUB(DATE(NOW()), INTERVAL 2 DAY));
INSERT INTO tblTerminalReportHistory (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000000', '00000000000000', '00000000000000', '00000000000000', 0, 0, 7, '07', DATE_SUB(DATE(NOW()), INTERVAL 2 DAY));
INSERT INTO tblTerminalReportHistory (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000000', '00000000000000', '00000000000000', '00000000000000', 0, 0, 8, '08', DATE_SUB(DATE(NOW()), INTERVAL 2 DAY));
INSERT INTO tblTerminalReportHistory (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000000', '00000000000000', '00000000000000', '00000000000000', 0, 0, 9, '09', DATE_SUB(DATE(NOW()), INTERVAL 2 DAY));
INSERT INTO tblTerminalReportHistory (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000000', '00000000000000', '00000000000000', '00000000000000', 0, 0, 10, '10', DATE_SUB(DATE(NOW()), INTERVAL 2 DAY));
INSERT INTO tblTerminalReportHistory (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000000', '00000000000000', '00000000000000', '00000000000000', 0, 0, 11, '11', DATE_SUB(DATE(NOW()), INTERVAL 2 DAY));
INSERT INTO tblTerminalReportHistory (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000000', '00000000000000', '00000000000000', '00000000000000', 0, 0, 12, '12', DATE_SUB(DATE(NOW()), INTERVAL 2 DAY));
INSERT INTO tblTerminalReportHistory (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000000', '00000000000000', '00000000000000', '00000000000000', 0, 0, 13, '13', DATE_SUB(DATE(NOW()), INTERVAL 2 DAY));
INSERT INTO tblTerminalReportHistory (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000000', '00000000000000', '00000000000000', '00000000000000', 0, 0, 14, '14', DATE_SUB(DATE(NOW()), INTERVAL 2 DAY));
INSERT INTO tblTerminalReportHistory (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000000', '00000000000000', '00000000000000', '00000000000000', 0, 0, 15, '15', DATE_SUB(DATE(NOW()), INTERVAL 2 DAY));
INSERT INTO tblTerminalReportHistory (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000000', '00000000000000', '00000000000000', '00000000000000', 0, 0, 16, '16', DATE_SUB(DATE(NOW()), INTERVAL 2 DAY));
INSERT INTO tblTerminalReportHistory (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000000', '00000000000000', '00000000000000', '00000000000000', 0, 0, 17, '17', DATE_SUB(DATE(NOW()), INTERVAL 2 DAY));
INSERT INTO tblTerminalReportHistory (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000000', '00000000000000', '00000000000000', '00000000000000', 0, 0, 18, '18', DATE_SUB(DATE(NOW()), INTERVAL 2 DAY));
INSERT INTO tblTerminalReportHistory (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000000', '00000000000000', '00000000000000', '00000000000000', 0, 0, 19, '19', DATE_SUB(DATE(NOW()), INTERVAL 2 DAY));
INSERT INTO tblTerminalReportHistory (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000000', '00000000000000', '00000000000000', '00000000000000', 0, 0, 20, '20', DATE_SUB(DATE(NOW()), INTERVAL 2 DAY));
-- CN Traders
INSERT INTO tblTerminalReportHistory (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000000', '00000000000000', '00000000000000', '00000000000000', 0, 0, 80, '80', DATE_SUB(DATE(NOW()), INTERVAL 2 DAY));
INSERT INTO tblTerminalReportHistory (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000000', '00000000000000', '00000000000000', '00000000000000', 0, 0, 81, '81', DATE_SUB(DATE(NOW()), INTERVAL 2 DAY));
INSERT INTO tblTerminalReportHistory (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000000', '00000000000000', '00000000000000', '00000000000000', 0, 0, 82, '82', DATE_SUB(DATE(NOW()), INTERVAL 2 DAY));
INSERT INTO tblTerminalReportHistory (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000000', '00000000000000', '00000000000000', '00000000000000', 0, 0, 83, '83', DATE_SUB(DATE(NOW()), INTERVAL 2 DAY));
INSERT INTO tblTerminalReportHistory (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000000', '00000000000000', '00000000000000', '00000000000000', 0, 0, 84, '84', DATE_SUB(DATE(NOW()), INTERVAL 2 DAY));
-- CS 
INSERT INTO tblTerminalReportHistory (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000000', '00000000000000', '00000000000000', '00000000000000', 0, 0, 90, '90', DATE_SUB(DATE(NOW()), INTERVAL 2 DAY));
INSERT INTO tblTerminalReportHistory (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000000', '00000000000000', '00000000000000', '00000000000000', 0, 0, 91, '91', DATE_SUB(DATE(NOW()), INTERVAL 2 DAY));
INSERT INTO tblTerminalReportHistory (BeginningTransactionNo, EndingTransactionNo, BeginningORNo, EndingORNo, ZReadCount, XReadCount, TerminalID, TerminalNo, DateLastInitialized)
		VALUES		('00000000000000', '00000000000000', '00000000000000', '00000000000000', 0, 0, 92, '92', DATE_SUB(DATE(NOW()), INTERVAL 2 DAY));


UPDATE tblTerminal SET FORM_Behavior = 'MODAL' WHERE TerminalID > 2 AND TerminalID < 80;
UPDATE tblTerminal SET FORM_Behavior = 'NON_MODAL' WHERE TerminalID >= 80 or TerminalID = 5;
UPDATE tblTerminal SET CashCountBeforeReport = 1;
UPDATE tblTerminal SET IsVATInclusive = 1;
UPDATE tblTerminal SET CheckCutOffTime = 1;
UPDATE tblTerminal SET StartCutOffTime = '01:00';
UPDATE tblTerminal SET EndCutOffTime = '02:00';
UPDATE tblTerminal SET WillPrintVoidItem = 0;

UPDATE tblTerminal SET EnableRewardPoints = 1;		
UPDATE tblTerminal SET RoundDownRewardPoints = 1;	
UPDATE tblTerminal SET RewardPointsMinimum = 0;		
UPDATE tblTerminal SET RewardPointsEvery = 100;		
UPDATE tblTerminal SET RewardPoints = 1;			

UPDATE tblTerminal SET RewardPointsMaxPercentageForPayment = 0;
UPDATE tblTerminal SET RewardPointsPaymentValue = 1;
UPDATE tblTerminal SET RewardPointsPaymentCashEquivalent = 0.50;
UPDATE tblTerminal SET EnableRewardPointsAsPayment = 1;

UPDATE tblTerminal SET IsPrinterAutoCutter = 1;
UPDATE tblDiscount SET DiscountCode = 'SNR', DiscountType = 'SENIOR CITIZEN', DiscountPrice = 5, InPercent = 1 WHERE DiscountCode = 'DEF';
UPDATE tblDiscount SET DiscountPrice = 5, InPercent = 1 WHERE DiscountCode = 'SNR';
UPDATE tblTerminal SET SeniorCitizenDiscountCode = 'SNR';

INSERT INTO tblDiscount(DiscountCode, DiscountType, DiscountPrice, InPercent)VALUES('PWD', 'PWD Discount', 5, 1);
UPDATE tblDiscount SET DiscountCode = 'PWD', DiscountType = 'PWD Discount', DiscountPrice = 5, InPercent = 1 WHERE DiscountCode = 'PWD';
UPDATE tblTerminal SET PWDDiscountCode = 'PWD';
UPDATE tblTerminal SET AutoGenerateRewardCardNo = 1;


UPDATE tblChargeType SET ChargeTypeCode = 'CRC', ChargeType = 'In-House Credit Charge', ChargeAmount = 7, InPercent = 1 WHERE ChargeTypeCode = 'PC' OR ChargeTypeCode = 'CRC';
UPDATE tblTerminal SET GroupChargeTypeID = (SELECT ChargeTypeID FROM tblChargeType WHERE ChargeTypeCode = 'CRC');



UPDATE tblTerminal SET ShowCustomerSelection = 0;	
UPDATE tblTerminal SET RewardsPermitNo = '1107-064-24317-000';

UPDATE tblTerminal SET IncludeCreditChargeAgreement = 1;
UPDATE tblTerminal SET IncludeTermsAndConditions = 1;
UPDATE tblTerminal SET WillPrintChargeSlip = 1;

-- disable the CN Traders printing of charge slip
UPDATE tblTerminal SET WillPrintChargeSlip = 0 WHERE TerminalNo >= 80 AND TerminalNo <= 89;

-- disable the CS printing of charge slip
UPDATE tblTerminal SET WillPrintChargeSlip = 0 WHERE TerminalNo >= 90 AND TerminalNo <= 99;

DELETE FROM tblProductInventory WHERE ProductID IN (SELECT ProductID FROM tblProducts WHERE ProductCode = 'BRANCH OFFLINE TRX');  
DELETE FROM tblProductPackage WHERE ProductID IN (SELECT ProductID FROM tblProducts WHERE ProductCode = 'BRANCH OFFLINE TRX');  
DELETE FROM tblProducts WHERE ProductCode = 'BRANCH OFFLINE TRX';  
INSERT INTO tblProducts(ProductCode, ProductDesc, ProductSubGroupID, BaseUnitID, SupplierID, Deleted, DateCreated) VALUES ('BRANCH OFFLINE TRX','BRANCH OFFLINE TRX',1,1,2,1,NOW());
INSERT INTO tblProductPackage (Barcode1, ProductID, UnitID, Price, PurchasePrice, Quantity)   SELECT '99001', ProductID, BaseUnitID, 0, 0, 1 FROM tblProducts WHERE ProductCode = 'BRANCH OFFLINE TRX';
INSERT INTO tblProductInventory(BranchID, ProductID, Quantity) SELECT 1, ProductID, 999999999 FROM tblProducts WHERE ProductCode = 'BRANCH OFFLINE TRX';
UPDATE tblProducts SET IsCreditChargeExcluded =1 WHERE ProductCode = 'BRANCH OFFLINE TRX'; 

DELETE FROM tblProductInventory WHERE ProductID IN (SELECT ProductID FROM tblProducts WHERE ProductCode = 'SHAKEY''S OFFLINE TRX');  
DELETE FROM tblProductPackage WHERE ProductID IN (SELECT ProductID FROM tblProducts WHERE ProductCode = 'SHAKEY''S OFFLINE TRX');  
DELETE FROM tblProducts WHERE ProductCode = 'SHAKEY''S OFFLINE TRX';  
INSERT INTO tblProducts(ProductCode, ProductDesc, ProductSubGroupID, BaseUnitID, SupplierID, Deleted, DateCreated) VALUES ('SHAKEY''S OFFLINE TRX','SHAKEY''S OFFLINE TRX',1,1,2,1,NOW());
INSERT INTO tblProductPackage (Barcode1, ProductID, UnitID, Price, PurchasePrice, Quantity)   SELECT '99002', ProductID, BaseUnitID, 0, 0, 1 FROM tblProducts WHERE ProductCode = 'SHAKEY''S OFFLINE TRX';
INSERT INTO tblProductInventory(BranchID, ProductID, Quantity) SELECT 1, ProductID, 999999999 FROM tblProducts WHERE ProductCode = 'SHAKEY''S OFFLINE TRX';
UPDATE tblProducts SET IsCreditChargeExcluded =1 WHERE ProductCode = 'SHAKEY''S OFFLINE TRX'; 

DELETE FROM tblProductInventory WHERE ProductID IN (SELECT ProductID FROM tblProducts WHERE ProductCode = 'BEL-AIR OFFLINE TRX');  
DELETE FROM tblProductPackage WHERE ProductID IN (SELECT ProductID FROM tblProducts WHERE ProductCode = 'BEL-AIR OFFLINE TRX');  
DELETE FROM tblProducts WHERE ProductCode = 'BEL-AIR OFFLINE TRX';  
INSERT INTO tblProducts(ProductCode, ProductDesc, ProductSubGroupID, BaseUnitID, SupplierID, Deleted, DateCreated) VALUES ('BEL-AIR OFFLINE TRX','BEL-AIR OFFLINE TRX',1,1,2,1,NOW());
INSERT INTO tblProductPackage (Barcode1, ProductID, UnitID, Price, PurchasePrice, Quantity)   SELECT '99003', ProductID, BaseUnitID, 0, 0, 1 FROM tblProducts WHERE ProductCode = 'BEL-AIR OFFLINE TRX';
INSERT INTO tblProductInventory(BranchID, ProductID, Quantity) SELECT 1, ProductID, 999999999 FROM tblProducts WHERE ProductCode = 'BEL-AIR OFFLINE TRX';
UPDATE tblProducts SET IsCreditChargeExcluded =1 WHERE ProductCode = 'BEL-AIR OFFLINE TRX'; 

DELETE FROM tblProductInventory WHERE ProductID IN (SELECT ProductID FROM tblProducts WHERE ProductCode = 'CINEMA OFFLINE TRX');  
DELETE FROM tblProductPackage WHERE ProductID IN (SELECT ProductID FROM tblProducts WHERE ProductCode = 'CINEMA OFFLINE TRX');  
DELETE FROM tblProducts WHERE ProductCode = 'CINEMA OFFLINE TRX';  
INSERT INTO tblProducts(ProductCode, ProductDesc, ProductSubGroupID, BaseUnitID, SupplierID, Deleted, DateCreated) VALUES ('CINEMA OFFLINE TRX','CINEMA OFFLINE TRX',1,1,2,1,NOW());
INSERT INTO tblProductPackage (Barcode1, ProductID, UnitID, Price, PurchasePrice, Quantity)   SELECT '99004', ProductID, BaseUnitID, 0, 0, 1 FROM tblProducts WHERE ProductCode = 'CINEMA OFFLINE TRX';
INSERT INTO tblProductInventory(BranchID, ProductID, Quantity) SELECT 1, ProductID, 999999999 FROM tblProducts WHERE ProductCode = 'CINEMA OFFLINE TRX';
UPDATE tblProducts SET IsCreditChargeExcluded =1 WHERE ProductCode = 'CINEMA OFFLINE TRX'; 

DELETE FROM tblProductInventory WHERE ProductID IN (SELECT ProductID FROM tblProducts WHERE ProductCode = 'FOOD CHOICES OFFLINE TRX');  
DELETE FROM tblProductPackage WHERE ProductID IN (SELECT ProductID FROM tblProducts WHERE ProductCode = 'FOOD CHOICES OFFLINE TRX');  
DELETE FROM tblProducts WHERE ProductCode = 'FOOD CHOICES OFFLINE TRX';  
INSERT INTO tblProducts(ProductCode, ProductDesc, ProductSubGroupID, BaseUnitID, SupplierID, Deleted, DateCreated) VALUES ('FOOD CHOICES OFFLINE TRX','FOOD CHOICES OFFLINE TRX',1,1,2,1,NOW());
INSERT INTO tblProductPackage (Barcode1, ProductID, UnitID, Price, PurchasePrice, Quantity)   SELECT '99005', ProductID, BaseUnitID, 0, 0, 1 FROM tblProducts WHERE ProductCode = 'FOOD CHOICES OFFLINE TRX';
INSERT INTO tblProductInventory(BranchID, ProductID, Quantity) SELECT 1, ProductID, 999999999 FROM tblProducts WHERE ProductCode = 'FOOD CHOICES OFFLINE TRX';
UPDATE tblProducts SET IsCreditChargeExcluded =1 WHERE ProductCode = 'FOOD CHOICES OFFLINE TRX'; 

DELETE FROM tblProductInventory WHERE ProductID IN (SELECT ProductID FROM tblProducts WHERE ProductCode = 'TERRACE GRILL OFFLINE TRX');  
DELETE FROM tblProductPackage WHERE ProductID IN (SELECT ProductID FROM tblProducts WHERE ProductCode = 'TERRACE GRILL OFFLINE TRX');  
DELETE FROM tblProducts WHERE ProductCode = 'TERRACE GRILL OFFLINE TRX';  
INSERT INTO tblProducts(ProductCode, ProductDesc, ProductSubGroupID, BaseUnitID, SupplierID, Deleted, DateCreated) VALUES ('TERRACE GRILL OFFLINE TRX','TERRACE GRILL OFFLINE TRX',1,1,2,1,NOW());
INSERT INTO tblProductPackage (Barcode1, ProductID, UnitID, Price, PurchasePrice, Quantity)   SELECT '99006', ProductID, BaseUnitID, 0, 0, 1 FROM tblProducts WHERE ProductCode = 'TERRACE GRILL OFFLINE TRX';
INSERT INTO tblProductInventory(BranchID, ProductID, Quantity) SELECT 1, ProductID, 999999999 FROM tblProducts WHERE ProductCode = 'TERRACE GRILL OFFLINE TRX';
UPDATE tblProducts SET IsCreditChargeExcluded =1 WHERE ProductCode = 'TERRACE GRILL OFFLINE TRX'; 

DELETE FROM tblProductInventory WHERE ProductID IN (SELECT ProductID FROM tblProducts WHERE ProductCode = 'HOTPOT OFFLINE TRX');  
DELETE FROM tblProductPackage WHERE ProductID IN (SELECT ProductID FROM tblProducts WHERE ProductCode = 'HOTPOT OFFLINE TRX');  
DELETE FROM tblProducts WHERE ProductCode = 'HOTPOT OFFLINE TRX';  
INSERT INTO tblProducts(ProductCode, ProductDesc, ProductSubGroupID, BaseUnitID, SupplierID, Deleted, DateCreated) VALUES ('HOTPOT OFFLINE TRX','HOTPOT OFFLINE TRX',1,1,2,1,NOW());
INSERT INTO tblProductPackage (Barcode1, ProductID, UnitID, Price, PurchasePrice, Quantity)   SELECT '99007', ProductID, BaseUnitID, 0, 0, 1 FROM tblProducts WHERE ProductCode = 'HOTPOT OFFLINE TRX';
INSERT INTO tblProductInventory(BranchID, ProductID, Quantity) SELECT 1, ProductID, 999999999 FROM tblProducts WHERE ProductCode = 'HOTPOT OFFLINE TRX';
UPDATE tblProducts SET IsCreditChargeExcluded =1 WHERE ProductCode = 'HOTPOT OFFLINE TRX'; 

DELETE FROM tblProductInventory WHERE ProductID IN (SELECT ProductID FROM tblProducts WHERE ProductCode = 'MUSIC THEATRE OFFLINE TRX');  
DELETE FROM tblProductPackage WHERE ProductID IN (SELECT ProductID FROM tblProducts WHERE ProductCode = 'MUSIC THEATRE OFFLINE TRX');  
DELETE FROM tblProducts WHERE ProductCode = 'MUSIC THEATRE OFFLINE TRX';  
INSERT INTO tblProducts(ProductCode, ProductDesc, ProductSubGroupID, BaseUnitID, SupplierID, Deleted, DateCreated) VALUES ('MUSIC THEATRE OFFLINE TRX','MUSIC THEATRE OFFLINE TRX',1,1,2,1,NOW());
INSERT INTO tblProductPackage (Barcode1, ProductID, UnitID, Price, PurchasePrice, Quantity)   SELECT '99008', ProductID, BaseUnitID, 0, 0, 1 FROM tblProducts WHERE ProductCode = 'MUSIC THEATRE OFFLINE TRX';
INSERT INTO tblProductInventory(BranchID, ProductID, Quantity) SELECT 1, ProductID, 999999999 FROM tblProducts WHERE ProductCode = 'MUSIC THEATRE OFFLINE TRX';
UPDATE tblProducts SET IsCreditChargeExcluded =1 WHERE ProductCode = 'MUSIC THEATRE OFFLINE TRX'; 

DELETE FROM tblProductInventory WHERE ProductID IN (SELECT ProductID FROM tblProducts WHERE ProductCode = 'HC-APPLIANCES OFFLINE TRX');  
DELETE FROM tblProductPackage WHERE ProductID IN (SELECT ProductID FROM tblProducts WHERE ProductCode = 'HC-APPLIANCES OFFLINE TRX');  
DELETE FROM tblProducts WHERE ProductCode = 'HC-APPLIANCES OFFLINE TRX';  
INSERT INTO tblProducts(ProductCode, ProductDesc, ProductSubGroupID, BaseUnitID, SupplierID, Deleted, DateCreated) VALUES ('HC-APPLIANCES OFFLINE TRX','HC-APPLIANCES OFFLINE TRX',1,1,2,1,NOW());
INSERT INTO tblProductPackage (Barcode1, ProductID, UnitID, Price, PurchasePrice, Quantity)   SELECT '99009', ProductID, BaseUnitID, 0, 0, 1 FROM tblProducts WHERE ProductCode = 'HC-APPLIANCES OFFLINE TRX';
INSERT INTO tblProductInventory(BranchID, ProductID, Quantity) SELECT 1, ProductID, 999999999 FROM tblProducts WHERE ProductCode = 'HC-APPLIANCES OFFLINE TRX';
UPDATE tblProducts SET IsCreditChargeExcluded =1 WHERE ProductCode = 'HC-APPLIANCES OFFLINE TRX'; 

DELETE FROM tblProductInventory WHERE ProductID IN (SELECT ProductID FROM tblProducts WHERE ProductCode = 'FOOD EXPRESS OFFLINE TRX');  
DELETE FROM tblProductPackage WHERE ProductID IN (SELECT ProductID FROM tblProducts WHERE ProductCode = 'FOOD EXPRESS OFFLINE TRX');  
DELETE FROM tblProducts WHERE ProductCode = 'FOOD EXPRESS OFFLINE TRX';  
INSERT INTO tblProducts(ProductCode, ProductDesc, ProductSubGroupID, BaseUnitID, SupplierID, Deleted, DateCreated) VALUES ('FOOD EXPRESS OFFLINE TRX','FOOD EXPRESS OFFLINE TRX',1,1,2,1,NOW());
INSERT INTO tblProductPackage (Barcode1, ProductID, UnitID, Price, PurchasePrice, Quantity)   SELECT '99010', ProductID, BaseUnitID, 0, 0, 1 FROM tblProducts WHERE ProductCode = 'FOOD EXPRESS OFFLINE TRX';
INSERT INTO tblProductInventory(BranchID, ProductID, Quantity) SELECT 1, ProductID, 999999999 FROM tblProducts WHERE ProductCode = 'FOOD EXPRESS OFFLINE TRX';
UPDATE tblProducts SET IsCreditChargeExcluded =1 WHERE ProductCode = 'FOOD EXPRESS OFFLINE TRX'; 

DELETE FROM tblProductInventory WHERE ProductID IN (SELECT ProductID FROM tblProducts WHERE ProductCode = 'CASH ADVANCE (10%)');  
DELETE FROM tblProductPackage WHERE ProductID IN (SELECT ProductID FROM tblProducts WHERE ProductCode = 'CASH ADVANCE (10%)');  
DELETE FROM tblProducts WHERE ProductCode = 'CASH ADVANCE (10%)';  
INSERT INTO tblProducts(ProductCode, ProductDesc, ProductSubGroupID, BaseUnitID, SupplierID, Deleted, DateCreated) VALUES ('CASH ADVANCE (10%)','CASH ADVANCE (10%)',1,1,2,1,NOW());
INSERT INTO tblProductPackage (Barcode1, ProductID, UnitID, Price, PurchasePrice, Quantity)   SELECT '99011', ProductID, BaseUnitID, 0, 0, 1 FROM tblProducts WHERE ProductCode = 'CASH ADVANCE (10%)';
INSERT INTO tblProductInventory(BranchID, ProductID, Quantity) SELECT 1, ProductID, 999999999 FROM tblProducts WHERE ProductCode = 'CASH ADVANCE (10%)';
UPDATE tblProducts SET IsCreditChargeExcluded =1 WHERE ProductCode = 'CASH ADVANCE (10%)'; 

DELETE FROM tblProductInventory WHERE ProductID IN (SELECT ProductID FROM tblProducts WHERE ProductCode = 'AT HOME OFFLINE TRX');  
DELETE FROM tblProductPackage WHERE ProductID IN (SELECT ProductID FROM tblProducts WHERE ProductCode = 'AT HOME OFFLINE TRX');  
DELETE FROM tblProducts WHERE ProductCode = 'AT HOME OFFLINE TRX';  
INSERT INTO tblProducts(ProductCode, ProductDesc, ProductSubGroupID, BaseUnitID, SupplierID, Deleted, DateCreated) VALUES ('AT HOME OFFLINE TRX','AT HOME OFFLINE TRX',1,1,2,1,NOW());
INSERT INTO tblProductPackage (Barcode1, ProductID, UnitID, Price, PurchasePrice, Quantity)   SELECT '99012', ProductID, BaseUnitID, 0, 0, 1 FROM tblProducts WHERE ProductCode = 'AT HOME OFFLINE TRX';
INSERT INTO tblProductInventory(BranchID, ProductID, Quantity) SELECT 1, ProductID, 999999999 FROM tblProducts WHERE ProductCode = 'AT HOME OFFLINE TRX';
UPDATE tblProducts SET IsCreditChargeExcluded =1 WHERE ProductCode = 'AT HOME OFFLINE TRX'; 

DELETE FROM tblProductInventory WHERE ProductID IN (SELECT ProductID FROM tblProducts WHERE ProductCode = 'COFFEE SHOP OFFLINE TRX');  
DELETE FROM tblProductPackage WHERE ProductID IN (SELECT ProductID FROM tblProducts WHERE ProductCode = 'COFFEE SHOP OFFLINE TRX');  
DELETE FROM tblProducts WHERE ProductCode = 'COFFEE SHOP OFFLINE TRX';  
INSERT INTO tblProducts(ProductCode, ProductDesc, ProductSubGroupID, BaseUnitID, SupplierID, Deleted, DateCreated) VALUES ('COFFEE SHOP OFFLINE TRX','COFFEE SHOP OFFLINE TRX',1,1,2,1,NOW());
INSERT INTO tblProductPackage (Barcode1, ProductID, UnitID, Price, PurchasePrice, Quantity)   SELECT '99013', ProductID, BaseUnitID, 0, 0, 1 FROM tblProducts WHERE ProductCode = 'COFFEE SHOP OFFLINE TRX';
INSERT INTO tblProductInventory(BranchID, ProductID, Quantity) SELECT 1, ProductID, 999999999 FROM tblProducts WHERE ProductCode = 'COFFEE SHOP OFFLINE TRX';
UPDATE tblProducts SET IsCreditChargeExcluded =1 WHERE ProductCode = 'COFFEE SHOP OFFLINE TRX'; 

DELETE FROM tblProductInventory WHERE ProductID IN (SELECT ProductID FROM tblProducts WHERE ProductCode = 'BREAD SHOP OFFLINE TRX');  
DELETE FROM tblProductPackage WHERE ProductID IN (SELECT ProductID FROM tblProducts WHERE ProductCode = 'BREAD SHOP OFFLINE TRX');  
DELETE FROM tblProducts WHERE ProductCode = 'BREAD SHOP OFFLINE TRX';  
INSERT INTO tblProducts(ProductCode, ProductDesc, ProductSubGroupID, BaseUnitID, SupplierID, Deleted, DateCreated) VALUES ('BREAD SHOP OFFLINE TRX','BREAD SHOP OFFLINE TRX',1,1,2,1,NOW());
INSERT INTO tblProductPackage (Barcode1, ProductID, UnitID, Price, PurchasePrice, Quantity)   SELECT '99014', ProductID, BaseUnitID, 0, 0, 1 FROM tblProducts WHERE ProductCode = 'BREAD SHOP OFFLINE TRX';
INSERT INTO tblProductInventory(BranchID, ProductID, Quantity) SELECT 1, ProductID, 999999999 FROM tblProducts WHERE ProductCode = 'BREAD SHOP OFFLINE TRX';
UPDATE tblProducts SET IsCreditChargeExcluded =1 WHERE ProductCode = 'BREAD SHOP OFFLINE TRX'; 

DELETE FROM tblProductInventory WHERE ProductID IN (SELECT ProductID FROM tblProducts WHERE ProductCode = 'FOOD TOGO OFFLINE TRX');  
DELETE FROM tblProductPackage WHERE ProductID IN (SELECT ProductID FROM tblProducts WHERE ProductCode = 'FOOD TOGO OFFLINE TRX');  
DELETE FROM tblProducts WHERE ProductCode = 'FOOD TOGO OFFLINE TRX';  
INSERT INTO tblProducts(ProductCode, ProductDesc, ProductSubGroupID, BaseUnitID, SupplierID, Deleted, DateCreated) VALUES ('FOOD TOGO OFFLINE TRX','FOOD TOGO OFFLINE TRX',1,1,2,1,NOW());
INSERT INTO tblProductPackage (Barcode1, ProductID, UnitID, Price, PurchasePrice, Quantity)   SELECT '99015', ProductID, BaseUnitID, 0, 0, 1 FROM tblProducts WHERE ProductCode = 'FOOD TOGO OFFLINE TRX';
INSERT INTO tblProductInventory(BranchID, ProductID, Quantity) SELECT 1, ProductID, 999999999 FROM tblProducts WHERE ProductCode = 'FOOD TOGO OFFLINE TRX';
UPDATE tblProducts SET IsCreditChargeExcluded =1 WHERE ProductCode = 'FOOD TOGO OFFLINE TRX'; 

DELETE FROM tblProductInventory WHERE ProductID IN (SELECT ProductID FROM tblProducts WHERE ProductCode = 'CHEQUE CLEARING FEE');  
DELETE FROM tblProductPackage WHERE ProductID IN (SELECT ProductID FROM tblProducts WHERE ProductCode = 'CHEQUE CLEARING FEE');  
DELETE FROM tblProducts WHERE ProductCode = 'CHEQUE CLEARING FEE';  
INSERT INTO tblProducts(ProductCode, ProductDesc, ProductSubGroupID, BaseUnitID, SupplierID, Deleted, DateCreated) VALUES ('CHEQUE CLEARING FEE','CHEQUE CLEARING FEE',1,1,2,1,NOW());
INSERT INTO tblProductPackage (Barcode1, ProductID, UnitID, Price, PurchasePrice, Quantity)   SELECT '99016', ProductID, BaseUnitID, 0, 0, 1 FROM tblProducts WHERE ProductCode = 'CHEQUE CLEARING FEE';
INSERT INTO tblProductInventory(BranchID, ProductID, Quantity) SELECT 1, ProductID, 999999999 FROM tblProducts WHERE ProductCode = 'CHEQUE CLEARING FEE';
UPDATE tblProducts SET IsCreditChargeExcluded =1 WHERE ProductCode = 'CHEQUE CLEARING FEE'; 

DELETE FROM tblProductInventory WHERE ProductID IN (SELECT ProductID FROM tblProducts WHERE ProductCode = 'GIFT CARD FEE');  
DELETE FROM tblProductPackage WHERE ProductID IN (SELECT ProductID FROM tblProducts WHERE ProductCode = 'GIFT CARD FEE');  
DELETE FROM tblProducts WHERE ProductCode = 'GIFT CARD FEE';  
INSERT INTO tblProducts(ProductCode, ProductDesc, ProductSubGroupID, BaseUnitID, SupplierID, Deleted, DateCreated) VALUES ('GIFT CARD FEE','GIFT CARD FEE',1,1,2,1,NOW());
INSERT INTO tblProductPackage (Barcode1, ProductID, UnitID, Price, PurchasePrice, Quantity)   SELECT '99017', ProductID, BaseUnitID, 0, 0, 1 FROM tblProducts WHERE ProductCode = 'GIFT CARD FEE';
INSERT INTO tblProductInventory(BranchID, ProductID, Quantity) SELECT 1, ProductID, 999999999 FROM tblProducts WHERE ProductCode = 'GIFT CARD FEE';
UPDATE tblProducts SET IsCreditChargeExcluded =1 WHERE ProductCode = 'GIFT CARD FEE'; 

DELETE FROM tblProductInventory WHERE ProductID IN (SELECT ProductID FROM tblProducts WHERE ProductCode = 'GIFT CARD VALUE');  
DELETE FROM tblProductPackage WHERE ProductID IN (SELECT ProductID FROM tblProducts WHERE ProductCode = 'GIFT CARD VALUE');  
DELETE FROM tblProducts WHERE ProductCode = 'GIFT CARD VALUE';  
INSERT INTO tblProducts(ProductCode, ProductDesc, ProductSubGroupID, BaseUnitID, SupplierID, Deleted, DateCreated) VALUES ('GIFT CARD VALUE','GIFT CARD VALUE',1,1,2,1,NOW());
INSERT INTO tblProductPackage (Barcode1, ProductID, UnitID, Price, PurchasePrice, Quantity)   SELECT '99018', ProductID, BaseUnitID, 0, 0, 1 FROM tblProducts WHERE ProductCode = 'GIFT CARD VALUE';
INSERT INTO tblProductInventory(BranchID, ProductID, Quantity) SELECT 1, ProductID, 999999999 FROM tblProducts WHERE ProductCode = 'GIFT CARD VALUE';
UPDATE tblProducts SET IsCreditChargeExcluded =1 WHERE ProductCode = 'GIFT CARD VALUE'; 

DELETE FROM tblProductInventory WHERE ProductID IN (SELECT ProductID FROM tblProducts WHERE ProductCode = 'IC IMPORTED TRX');  
DELETE FROM tblProductPackage WHERE ProductID IN (SELECT ProductID FROM tblProducts WHERE ProductCode = 'IC IMPORTED TRX');  
DELETE FROM tblProducts WHERE ProductCode = 'IC IMPORTED TRX';  
INSERT INTO tblProducts(ProductCode, ProductDesc, ProductSubGroupID, BaseUnitID, SupplierID, Deleted, DateCreated) VALUES ('IC IMPORTED TRX','IC IMPORTED TRX',1,1,2,1,NOW());
INSERT INTO tblProductPackage (Barcode1, ProductID, UnitID, Price, PurchasePrice, Quantity)   SELECT '99019', ProductID, BaseUnitID, 0, 0, 1 FROM tblProducts WHERE ProductCode = 'IC IMPORTED TRX';
INSERT INTO tblProductInventory(BranchID, ProductID, Quantity) SELECT 1, ProductID, 999999999 FROM tblProducts WHERE ProductCode = 'IC IMPORTED TRX';
UPDATE tblProducts SET IsCreditChargeExcluded =1 WHERE ProductCode = 'IC IMPORTED TRX'; 

ALTER TABLE tblERPConfig MODIFY LastRewardCardNo VARCHAR(8);
UPDATE tblERPConfig SET LastRewardCardNo = '00000001';
UPDATE tblERPConfig SET LastCreditCardNo = '00000001';
UPDATE tblERPConfig SET LastGroupCreditCardNo = '00000001';
UPDATE tblERPConfig SET LastCustomerCode = '00000001';

ALTER TABLE tblERPConfig MODIFY LastRewardCardNo VARCHAR(8) NOT NULL DEFAULT '00000001';
ALTER TABLE tblERPConfig MODIFY LastCreditCardNo VARCHAR(8) NOT NULL DEFAULT '00000001';
ALTER TABLE tblERPConfig MODIFY LastGroupCreditCardNo VARCHAR(8) NOT NULL DEFAULT '00000001';
ALTER TABLE tblERPConfig MODIFY LastCustomerCode VARCHAR(8) NOT NULL DEFAULT '00000001';

UPDATE tblTerminal SET ItemVoidConfirmation = 1;

UPDATE tblTerminal SET WillPrintGrandTotal = 1;
UPDATE tblTerminal SET ReservedAndCommit = 1;
UPDATE tblTerminal SET TrustFund = 40;

UPDATE tblTerminal SET DBVersion = '4.0.1.2', FEVersion = '4.0.1.2', BEVersion = '2.0.1.5';

-- 21Nov2014: THIS HAS BEEN UPDATED IN THE LIVE DATABSE*******************************/

UPDATE tblTerminal SET MachineSerialNo = '14102713181270883' WHERE TerminalID >= 3;
UPDATE tblTerminal SET AccreditationNo = '0272297648012014100153' WHERE TerminalID >= 3;

INSERT INTO sysAccessGroups(GroupID, GroupName, Remarks)VALUES(7, '7', '7');
INSERT INTO sysAccessGroups(GroupID, GroupName, Remarks)VALUES(8, '8', '8');
INSERT INTO sysAccessGroups(GroupID, GroupName, Remarks)VALUES(8, '9', '9');
INSERT INTO sysAccessGroups(GroupID, GroupName, Remarks)VALUES(10, '10', '10');
INSERT INTO sysAccessGroups(GroupID, GroupName, Remarks)VALUES(11, '11', '11');
INSERT INTO sysAccessGroups(GroupID, GroupName, Remarks)VALUES(12, '12', '12');
INSERT INTO sysAccessGroups(GroupID, GroupName, Remarks)VALUES(13, '13', '13');
INSERT INTO sysAccessGroups(GroupID, GroupName, Remarks)VALUES(14, '14', '14');

UPDATE sysAccessGroups SET GroupName = 'MIS', Remarks = 'Default group for MIS' WHERE GroupID = 2;
UPDATE sysAccessGroups SET GroupName = 'Supervisors', Remarks = 'Default group for Supervisors' WHERE GroupID = 3;
UPDATE sysAccessGroups SET GroupName = 'Cashiers', Remarks = 'Default group for Cashiers' WHERE GroupID = 4;
UPDATE sysAccessGroups SET GroupName = 'Bagger', Remarks = 'Default group for Bagger' WHERE GroupID = 5;
UPDATE sysAccessGroups SET GroupName = 'Management', Remarks = 'Default group for Management' WHERE GroupID = 6;
UPDATE sysAccessGroups SET GroupName = 'Inventory Staff', Remarks = 'Inventory Staff' WHERE GroupID = 7;
UPDATE sysAccessGroups SET GroupName = 'Training Coordinator', Remarks = 'Training Coordinator' WHERE GroupID = 8;
UPDATE sysAccessGroups SET GroupName = 'Customer Service', Remarks = 'Customer Service' WHERE GroupID = 9;
UPDATE sysAccessGroups SET GroupName = 'Purchasing', Remarks = 'Purchasing' WHERE GroupID = 10;
UPDATE sysAccessGroups SET GroupName = 'Accounting Dept.', Remarks = 'Accounting Dept.' WHERE GroupID = 11;
UPDATE sysAccessGroups SET GroupName = 'Cash Section', Remarks = 'Cash Section' WHERE GroupID = 12;
UPDATE sysAccessGroups SET GroupName = 'Roving Promo', Remarks = 'Roving Promo' WHERE GroupID = 13;
UPDATE sysAccessGroups SET GroupName = 'Trainee', Remarks = 'Trainee' WHERE GroupID = 14;

-- SELECT CONCAT('UPDATE tblReceipt SET Text = ''',IFNULL(Text,''),''', Value=''',IFNULL(Value,''),''', Orientation=',Orientation,' WHERE Module=''',Module,''';') FROM tblReceipt;
UPDATE tblReceipt SET Text = '', Value='0', Orientation=0 WHERE Module='ReportHeaderSpacer';
UPDATE tblReceipt SET Text = '', Value='TIN: 229-764-801-000', Orientation=1 WHERE Module='ReportHeader1';
UPDATE tblReceipt SET Text = '', Value='', Orientation=1 WHERE Module='ReportHeader2';
UPDATE tblReceipt SET Text = '', Value='', Orientation=1 WHERE Module='ReportHeader3';
UPDATE tblReceipt SET Text = '', Value='', Orientation=1 WHERE Module='ReportHeader4';
UPDATE tblReceipt SET Text = '', Value='{DateNow}', Orientation=1 WHERE Module='ReportHeader5';
UPDATE tblReceipt SET Text = '', Value='', Orientation=1 WHERE Module='ReportHeader6';
UPDATE tblReceipt SET Text = '', Value='', Orientation=1 WHERE Module='ReportHeader7';
UPDATE tblReceipt SET Text = '', Value='', Orientation=1 WHERE Module='ReportHeader8';
UPDATE tblReceipt SET Text = '', Value='', Orientation=1 WHERE Module='ReportHeader9';
UPDATE tblReceipt SET Text = '', Value='', Orientation=1 WHERE Module='ReportHeader10';
UPDATE tblReceipt SET Text = 'Acc. No.', Value='{AccreditationNo}', Orientation=1 WHERE Module='PageHeader1';
UPDATE tblReceipt SET Text = 'MIN', Value='{MachineSerialNo}', Orientation=1 WHERE Module='PageHeader2';
UPDATE tblReceipt SET Text = 'Permit No: FP102014-064-0015149-00000', Value='', Orientation=1 WHERE Module='PageHeader3';
UPDATE tblReceipt SET Text = '', Value='{NewLine}', Orientation=0 WHERE Module='PageHeader4';
UPDATE tblReceipt SET Text = 'OFFICIAL RECEIPT', Value='{ORNo}', Orientation=1 WHERE Module='PageHeader5';
UPDATE tblReceipt SET Text = '', Value='', Orientation=0 WHERE Module='PageHeader6';
UPDATE tblReceipt SET Text = '', Value='', Orientation=0 WHERE Module='PageHeader7';
UPDATE tblReceipt SET Text = '', Value='', Orientation=0 WHERE Module='PageHeader8';
UPDATE tblReceipt SET Text = '', Value='', Orientation=0 WHERE Module='PageHeader9';
UPDATE tblReceipt SET Text = '', Value='', Orientation=0 WHERE Module='PageHeader10';
UPDATE tblReceipt SET Text = '', Value='----------------------------------------', Orientation=1 WHERE Module='PageFooterA1';
UPDATE tblReceipt SET Text = 'SUBTOTAL', Value='{SUBTOTAL}', Orientation=0 WHERE Module='PageFooterA2';
UPDATE tblReceipt SET Text = 'OTHER CHARGE', Value='{IN-HOUSE CREDIT CHARGE}', Orientation=0 WHERE Module='PageFooterA3';
UPDATE tblReceipt SET Text = 'DISCOUNT', Value='{DISCOUNT}', Orientation=0 WHERE Module='PageFooterA4';
UPDATE tblReceipt SET Text = 'AMOUNT DUE', Value='{AMOUNT DUE}', Orientation=0 WHERE Module='PageFooterA5';
UPDATE tblReceipt SET Text = 'AMOUNT TENDER', Value='{AMOUNT TENDER}', Orientation=0 WHERE Module='PageFooterA6';
UPDATE tblReceipt SET Text = 'CHANGE', Value='{CHANGE}', Orientation=0 WHERE Module='PageFooterA7';
UPDATE tblReceipt SET Text = '', Value='{NewLine}', Orientation=0 WHERE Module='PageFooterA8';
UPDATE tblReceipt SET Text = 'NON-VAT AMT.', Value='{NON-VAT AMT}', Orientation=0 WHERE Module='PageFooterA9';
UPDATE tblReceipt SET Text = 'VAT EXEMPT', Value='{VAT Exempt}', Orientation=0 WHERE Module='PageFooterA10';
UPDATE tblReceipt SET Text = 'VATABLE AMT.', Value='{VATABLE AMT}', Orientation=0 WHERE Module='PageFooterA11';
UPDATE tblReceipt SET Text = 'VAT', Value='{VAT}', Orientation=0 WHERE Module='PageFooterA12';
UPDATE tblReceipt SET Text = '', Value='----------------------------------------', Orientation=1 WHERE Module='PageFooterA13';
UPDATE tblReceipt SET Text = 'TTL ITEM SOLD', Value='{TTL ITEM SOLD}', Orientation=0 WHERE Module='PageFooterA14';
UPDATE tblReceipt SET Text = 'TTL QTY SOLD', Value='{TTL QTY SOLD}', Orientation=0 WHERE Module='PageFooterA15';
UPDATE tblReceipt SET Text = '', Value='', Orientation=0 WHERE Module='PageFooterA16';
UPDATE tblReceipt SET Text = 'CARD NO.', Value='{RewardCardNo}', Orientation=0 WHERE Module='PageFooterA17';
UPDATE tblReceipt SET Text = 'PRV POINTS', Value='{RewardPreviousPoints}', Orientation=0 WHERE Module='PageFooterA18';
UPDATE tblReceipt SET Text = 'EARND POINTS', Value='{RewardEarnedPoints}', Orientation=0 WHERE Module='PageFooterA19';
UPDATE tblReceipt SET Text = 'CRRNT POINTS', Value='{RewardCurrentPoints}', Orientation=0 WHERE Module='PageFooterA20';
UPDATE tblReceipt SET Text = 'Customer', Value='{Customer Name}', Orientation=0 WHERE Module='PageFooterB1';
UPDATE tblReceipt SET Text = 'Check Ctr.', Value='{Check Counter}', Orientation=0 WHERE Module='PageFooterB2';
UPDATE tblReceipt SET Text = '', Value='', Orientation=0 WHERE Module='PageFooterB3';
UPDATE tblReceipt SET Text = '', Value='', Orientation=0 WHERE Module='PageFooterB4';
UPDATE tblReceipt SET Text = '', Value='This serves as your official receipt.', Orientation=1 WHERE Module='PageFooterB5';
UPDATE tblReceipt SET Text = 'Cashier', Value='{Cashier}', Orientation=0 WHERE Module='ReportFooter1';
UPDATE tblReceipt SET Text = 'Terminal #', Value='{TerminalNo}', Orientation=0 WHERE Module='ReportFooter2';
UPDATE tblReceipt SET Text = '', Value='', Orientation=0 WHERE Module='ReportFooter3';
UPDATE tblReceipt SET Text = '', Value='', Orientation=1 WHERE Module='ReportFooter4';
UPDATE tblReceipt SET Text = '', Value='', Orientation=1 WHERE Module='ReportFooter5';
UPDATE tblReceipt SET Text = '', Value='7', Orientation=1 WHERE Module='ReportFooterSpacer';

INSERT INTO sysTerminalKey(HDSerialNo, RegistrationKey)VALUES('WD-WMAM9CFJ7518', '8kuvzaXVkPgaEcVehl3JqumR927nsDgnkIyY+ly/XB5ibkUqjWiJBu86hghF1c+U');
INSERT INTO sysTerminalKey(HDSerialNo, RegistrationKey)VALUES('S0UZJ9DQ503224', '60ix8Qw124+JPIgPt36NR6sptDhrmUM/FfTZ14as1V91Di5JI47zHtElU45cz/bB');
INSERT INTO sysTerminalKey(HDSerialNo, RegistrationKey)VALUES('4JX24A54', 'mMRIjg2D1P7HRUE1Ky39bQD0AvHZFA6yyLH9N3nFawo3O30DUbzPB3abbQfjqZPg');
INSERT INTO sysTerminalKey(HDSerialNo, RegistrationKey)VALUES('WD-WMAM9WV29427', '7ZPw75cmG4NSlgRz9vR0hxv/kCO9xI7syr2avGcIme65R+sEVwdxFL1Rmvo5HCgc');
INSERT INTO sysTerminalKey(HDSerialNo, RegistrationKey)VALUES('WD-WMAMA6514205', 'IyyTjpq1tk9DAPqW1DtpSqmajQ9z1h4HEP9voN2lG2OE4KdU6RGqqlOugRQ51CHf');
INSERT INTO sysTerminalKey(HDSerialNo, RegistrationKey)VALUES('WD-WMAV32936089', 'duEFWEmpFeGTaYgcHo1nUI4B57Mg5RbpXeXEdTHQyYApMLN9aNFVHdSfHwQTbXTr');
INSERT INTO sysTerminalKey(HDSerialNo, RegistrationKey)VALUES('6QZ3KDCK', 'xKeyA9EyacViLsUWDfRBHDSleHckhXKfphJx1Qui764tTMD8mQfDZqmlO0glzooT');
INSERT INTO sysTerminalKey(HDSerialNo, RegistrationKey)VALUES('6QZ3KEE1', 'Ibdd/QeiJt+HA/PHV4YAmeTjeRbOko+IkIJwnULQRGl2nQIP+X3lBFQShNCENvem');
INSERT INTO sysTerminalKey(HDSerialNo, RegistrationKey)VALUES('5JXACY7T', 'WU2gu6D7mFWlKYOZVmKQUIAUNbFdh+kxds74N4QFPB2L9/LGHBi3SOJd0s1+uxzU');
INSERT INTO sysTerminalKey(HDSerialNo, RegistrationKey)VALUES('20202020202020202020202032535641344B4E36', 'LUm8AyFjSE+tw8yq5LWsfbYBtC59l1nzYlJbg5TeWwR5kvMIre3u/NTj7vLbYelXOr9rU7VDvHSJMMUXmuNFG2IrgiRPf2T3CRnkSGkkbbw=');
INSERT INTO sysTerminalKey(HDSerialNo, RegistrationKey)VALUES('2020202020202020202020203357415446324C32', 'wrxlGt3cjhW1wp0UcRiw9YGxhsXMU2kF2Rs+W87pi8ac9mL60sf70H3WlXcvlWEXDnwglxXPuCKCc8CmoCoSqx8FIIMzU6JyhreMBvFx65Y=');
INSERT INTO sysTerminalKey(HDSerialNo, RegistrationKey)VALUES('S14DJ9BS102558', 's6tmoATGlwazl8MQKCdPGreQyPwGYRBPgjCVXCmmuov5ag4X9UJIGQV/UkjjIOMC');
INSERT INTO sysTerminalKey(HDSerialNo, RegistrationKey)VALUES('6Q23KDCJ', 'M4I5+HudB3OBL4FzYc1IcIq3+FqxRgsz32dHVrW6IojftiAqB+RsPxvZ5TaEhyiN');

INSERT INTO sysTerminalKey(HDSerialNo, RegistrationKey)VALUES('S0UZJ9DQ503223', '3Dcz30tB9ZTc1oAG8KokV/4SIJUac1P6cLH2Zj5/xC5gi59Y2hVRThXJf5NO4iEb');
INSERT INTO sysTerminalKey(HDSerialNo, RegistrationKey)VALUES('6QZ3KEBE', 'Q+uXUTtGfeCr3Caf/EyieSZksJzGiNwVztMKzOmOkMe7jhc7mhyX1R1JKPvUx0Cy');
INSERT INTO sysTerminalKey(HDSerialNo, RegistrationKey)VALUES('WD-WCAV35903706', 'NA5LVtLe8Sw0eIFF0auOGbhi1WFMP65XABgf9UZ+AMOBwosLSXKcJXWCrXMPs1z1');
INSERT INTO sysTerminalKey(HDSerialNo, RegistrationKey)VALUES('WD-WCAS22137627', '7R2c1DXp0TuEU0bT/6ywyyH9Wu3yLoMwPJWYhXfYJ+hj24GovRuH7zoUYCZt+06mpbw5gEYHRwFcJWBU0R+BCw==');
INSERT INTO sysTerminalKey(HDSerialNo, RegistrationKey)VALUES('5QZ2XTX7', 'ndBSFQKQDGf/l7tEyXrDawPZzNZlO4/9y7VWhlTaVV9CYAnO/5F1298cO6LPlyhI');
INSERT INTO sysTerminalKey(HDSerialNo, RegistrationKey)VALUES('4LR2G9XF', 'Zw1XnfZke9V3as2ZdaJOcvC5NZtMZH8epwovEVIIhu7xOHNfACIKbTJ6PM/s29mU');
INSERT INTO sysTerminalKey(HDSerialNo, RegistrationKey)VALUES('4JX0Y74Y', 'F1+GPMNN35j1EHW9rNjLUu+QT2urnVHn9mWOAKqnAL03xa7iEBkwkagIiZN6q7Zb');
INSERT INTO sysTerminalKey(HDSerialNo, RegistrationKey)VALUES('6QZ283LK', 'P1aqoaFP82Jajw0kfjAUvYDhHDxGdOtcT80TZXPLpWqdLOvXn0rqEOi46qF4RVfL');
INSERT INTO sysTerminalKey(HDSerialNo, RegistrationKey)VALUES('WD-WMAM9WV12839', 'gblNy/QOPT6a+hjfSGVWKZa6L3T1b8jhc79rocAdewp5VyZnrnSG/gnEO8+qVvb5');
INSERT INTO sysTerminalKey(HDSerialNo, RegistrationKey)VALUES('6QZ3JX4C', 'LJ8tyx3iCLz1mJASQcvTTwA3tenBLrIvJDjBzI6Jwb8fjVxkOwRtd+XE0XTkeTVf');

INSERT INTO sysTerminalKey(HDSerialNo, RegistrationKey)VALUES('6QZ3JV8F', 'cpb6s2DPseWYEFg7UsKlMAWHq5gvPd/7l/cZefELuuMQIrj+WIwnEQrC4mYLRHIt');

-- UPDATE tbTerminal SET PermitNo = 'FP102014-064-0015149-00000' WHERE TerminalID >= 3;

DROP TRIGGER trgtblTransactionsCreatedOn;
DROP TRIGGER trgtblTransactionItemsCreatedOn;

CREATE TRIGGER trgtblTransactionsCreatedOn BEFORE INSERT ON tblTransactions FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblTransactionItemsCreatedOn BEFORE INSERT ON tblTransactionItems FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;


/*********** Dec 2, 2014 updates ************************/

-- update the Dec 1, 2014 Transactions
UPDATE tbltransactions SET CreatedOn = TransactionDate WHERE CreatedOn <> TransactionDate;

UPDATE tbltransactionItems, tblTransactions
SET 
	tbltransactionItems.CreatedOn = tblTransactions.TransactionDate 
WHERE tblTransactionItems.CreatedOn <> tblTransactions.TransactionDate
AND tblTransactions.TransactionID = tblTransactionItems.TransactionID;

UPDATE tblTransactions SET SyncID = TransactionID WHERE SyncID=0;
UPDATE tblTransactionItems SET SyncID = TransactionItemsID WHERE SyncID=0;

CREATE TRIGGER trgtblTransactionsCreatedOn BEFORE INSERT ON tblTransactions FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblTransactionItemsCreatedOn BEFORE INSERT ON tblTransactionItems FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;

-- for rewards information in case inhouse credit is different from rewards
UPDATE tblReceipt SET Text = 'Reward CardNo.', Value='{RewardCardNo}', Orientation=0 WHERE Module='PageFooterA16';
UPDATE tblReceipt SET Text = '', Value='{RewardsCustomerName}', Orientation=1 WHERE Module='PageFooterA17';
UPDATE tblReceipt SET Text = 'PRV POINTS', Value='{RewardPreviousPoints}', Orientation=0 WHERE Module='PageFooterA18';
UPDATE tblReceipt SET Text = 'EARND POINTS', Value='{RewardEarnedPoints}', Orientation=0 WHERE Module='PageFooterA19';
UPDATE tblReceipt SET Text = 'CRRNT POINTS', Value='{RewardCurrentPoints}', Orientation=0 WHERE Module='PageFooterA20';
UPDATE tblReceipt SET Text = '', Value='', Orientation=0 WHERE Module='PageFooterB1';

DELETE FROM tblProductInventory WHERE ProductID IN (SELECT ProductID FROM tblProducts WHERE ProductCode = 'CREDIT REVERSAL');  
DELETE FROM tblProductPackage WHERE ProductID IN (SELECT ProductID FROM tblProducts WHERE ProductCode = 'CREDIT REVERSAL');  
DELETE FROM tblProducts WHERE ProductCode = 'CREDIT REVERSAL';  
INSERT INTO tblProducts(ProductCode, ProductDesc, ProductSubGroupID, BaseUnitID, SupplierID, Deleted, DateCreated) VALUES ('CREDIT REVERSAL','CREDIT REVERSAL',1,1,2,1,NOW());
INSERT INTO tblProductPackage (Barcode1, ProductID, UnitID, Price, PurchasePrice, Quantity)   SELECT '99020', ProductID, BaseUnitID, 0, 0, 1 FROM tblProducts WHERE ProductCode = 'CREDIT REVERSAL';
INSERT INTO tblProductInventory(BranchID, ProductID, Quantity) SELECT 1, ProductID, 999999999 FROM tblProducts WHERE ProductCode = 'CREDIT REVERSAL';
UPDATE tblProducts SET IsCreditChargeExcluded =1 WHERE ProductCode = 'CREDIT REVERSAL'; 

-- this is the setting for credit
UPDATE tblCardTypes SET CreditPurcStartDateToProcess	= '2014-10-06' WHERE CreditCardType=1 AND WithGuarantor=1;
UPDATE tblCardTypes SET CreditPurcEndDateToProcess		= '2014-12-05' WHERE CreditCardType=1 AND WithGuarantor=1;
UPDATE tblCardTypes SET CreditCutOffDate				= '2014-12-15' WHERE CreditCardType=1 AND WithGuarantor=1;
UPDATE tblCardTypes SET BillingDate						= '2014-12-06' WHERE CreditCardType=1 AND WithGuarantor=1;
UPDATE tblContactCreditCardInfo SET LastBillingDate		= '2014-12-06' WHERE GuarantorID <> 0;

UPDATE tblCardTypes SET CreditPurcStartDateToProcess	= '2014-11-10' WHERE CreditCardType=1 AND WithGuarantor=0;
UPDATE tblCardTypes SET CreditPurcEndDateToProcess		= '2014-12-09' WHERE CreditCardType=1 AND WithGuarantor=0;
UPDATE tblCardTypes SET CreditCutOffDate				= '2014-11-30' WHERE CreditCardType=1 AND WithGuarantor=0;
UPDATE tblCardTypes SET BillingDate						= '2014-12-10' WHERE CreditCardType=1 AND WithGuarantor=0;
UPDATE tblContactCreditCardInfo SET LastBillingDate		= '2014-11-10' WHERE GuarantorID = 0;

UPDATE tblCardTypes SET CreditPurcStartDateToProcess	= '2014-10-06' WHERE CreditCardType=1 AND WithGuarantor=1;
UPDATE tblCardTypes SET CreditPurcEndDateToProcess		= '2014-12-05' WHERE CreditCardType=1 AND WithGuarantor=1;
UPDATE tblCardTypes SET CreditCutOffDate				= '2014-12-15' WHERE CreditCardType=1 AND WithGuarantor=1;
UPDATE tblCardTypes SET BillingDate						= '2014-12-06' WHERE CreditCardType=1 AND WithGuarantor=1;
UPDATE tblContactCreditCardInfo SET LastBillingDate		= '2014-12-06' WHERE GuarantorID <> 0;


UPDATE tblTerminalReportHistory SET BeginningTransactionNo = '00000000000000', EndingTransactionNo = '00000000000000' 
WHERE BeginningTransactionNo = '00000000000001' AND EndingTransactionNo = '00000000000001';

UPDATE tblTerminalReportHistory SET BeginningTransactionNo = '00000000000000', EndingTransactionNo = '00000000000000' 
WHERE BeginningTransactionNo = '00000000000000' AND EndingTransactionNo = '00000000000001';

CALL procTerminalReportHistorySyncTransactionSales(1, '01', '2014-11-30 00:00');
CALL procTerminalReportHistorySyncTransactionSales(1, '02', '2014-11-30 00:00');
CALL procTerminalReportHistorySyncTransactionSales(1, '03', '2014-11-30 00:00');
CALL procTerminalReportHistorySyncTransactionSales(1, '04', '2014-11-30 00:00');
CALL procTerminalReportHistorySyncTransactionSales(1, '05', '2014-11-30 00:00');
CALL procTerminalReportHistorySyncTransactionSales(1, '06', '2014-11-30 00:00');
CALL procTerminalReportHistorySyncTransactionSales(1, '07', '2014-11-30 00:00');
CALL procTerminalReportHistorySyncTransactionSales(1, '08', '2014-11-30 00:00');
CALL procTerminalReportHistorySyncTransactionSales(1, '09', '2014-11-30 00:00');
CALL procTerminalReportHistorySyncTransactionSales(1, '10', '2014-11-30 00:00');

CALL procTerminalReportHistorySyncTransactionSales(1, '11', '2014-11-30 00:00');
CALL procTerminalReportHistorySyncTransactionSales(1, '12', '2014-11-30 00:00');
CALL procTerminalReportHistorySyncTransactionSales(1, '13', '2014-11-30 00:00');
CALL procTerminalReportHistorySyncTransactionSales(1, '14', '2014-11-30 00:00');
CALL procTerminalReportHistorySyncTransactionSales(1, '15', '2014-11-30 00:00');
CALL procTerminalReportHistorySyncTransactionSales(1, '16', '2014-11-30 00:00');
CALL procTerminalReportHistorySyncTransactionSales(1, '17', '2014-11-30 00:00');
CALL procTerminalReportHistorySyncTransactionSales(1, '18', '2014-11-30 00:00');
CALL procTerminalReportHistorySyncTransactionSales(1, '19', '2014-11-30 00:00');
CALL procTerminalReportHistorySyncTransactionSales(1, '20', '2014-11-30 00:00');

CALL procTerminalReportHistorySyncTransactionSales(1, '21', '2014-11-30 00:00');
CALL procTerminalReportHistorySyncTransactionSales(1, '22', '2014-11-30 00:00');

CALL procTerminalReportHistorySyncTransactionSales(1, '80', '2014-11-30 00:00');
CALL procTerminalReportHistorySyncTransactionSales(1, '81', '2014-11-30 00:00');
CALL procTerminalReportHistorySyncTransactionSales(1, '82', '2014-11-30 00:00');
CALL procTerminalReportHistorySyncTransactionSales(1, '83', '2014-11-30 00:00');
CALL procTerminalReportHistorySyncTransactionSales(1, '84', '2014-11-30 00:00');

CALL procTerminalReportHistorySyncTransactionSales(1, '90', '2014-11-30 00:00');


ALTER TABLE cc_b1s ENGINE=InnoDB;
ALTER TABLE cc_b2s ENGINE=InnoDB;
ALTER TABLE cc_b3s ENGINE=InnoDB;
ALTER TABLE cc_b4s ENGINE=InnoDB;
ALTER TABLE deleted_tblbranchinventory ENGINE=InnoDB;
ALTER TABLE deleted_tblbranchinventory_old ENGINE=InnoDB;
ALTER TABLE deleted_tblbranchinventorymatrix ENGINE=InnoDB;
ALTER TABLE deleted_tblbranchinventorymatrix_old ENGINE=InnoDB;
ALTER TABLE deleted_tblinvadjustmentitems ENGINE=InnoDB;
ALTER TABLE deleted_tblmatrixpackage ENGINE=InnoDB;
ALTER TABLE deleted_tblmatrixpackagepricehistory ENGINE=InnoDB;
ALTER TABLE deleted_tblproductbasevariationsmatrix ENGINE=InnoDB;
ALTER TABLE deleted_tblproductprices ENGINE=InnoDB;
ALTER TABLE deleted_tblproducts ENGINE=InnoDB;
ALTER TABLE deleted_tblreceiptformat ENGINE=InnoDB;
ALTER TABLE deleted_tblremotebranchinventory ENGINE=InnoDB;
ALTER TABLE deleted_tbltransactionnos ENGINE=InnoDB;
ALTER TABLE fe_dsc ENGINE=InnoDB;
ALTER TABLE ic_gua ENGINE=InnoDB;
ALTER TABLE ic_icc ENGINE=InnoDB;
ALTER TABLE ic_ipy ENGINE=InnoDB;
ALTER TABLE ic_itn ENGINE=InnoDB;
ALTER TABLE mp_cls ENGINE=InnoDB;
ALTER TABLE mp_mer ENGINE=InnoDB;
ALTER TABLE mp_pac ENGINE=InnoDB;
ALTER TABLE mp_sup ENGINE=InnoDB;
ALTER TABLE sm_usr ENGINE=InnoDB;
ALTER TABLE sysaccessgrouprights ENGINE=InnoDB;
ALTER TABLE sysaccessgroups ENGINE=InnoDB;
ALTER TABLE sysaccessrights ENGINE=InnoDB;
ALTER TABLE sysaccesstypes ENGINE=InnoDB;
ALTER TABLE sysaccessuserdetails ENGINE=InnoDB;
ALTER TABLE sysaccessusers ENGINE=InnoDB;
ALTER TABLE sysaudittrail ENGINE=InnoDB;
ALTER TABLE sysconfig ENGINE=InnoDB;
ALTER TABLE syscreditconfig ENGINE=InnoDB;
ALTER TABLE systerminalkey ENGINE=InnoDB;
ALTER TABLE tblaccountcategory ENGINE=InnoDB;
ALTER TABLE tblaccountclassification ENGINE=InnoDB;
ALTER TABLE tblaccountsummary ENGINE=InnoDB;
ALTER TABLE tbladv ENGINE=InnoDB;
ALTER TABLE tblagentscommision ENGINE=InnoDB;
ALTER TABLE tblbank ENGINE=InnoDB;
ALTER TABLE tblbankdeposit ENGINE=InnoDB;
ALTER TABLE tblbranch ENGINE=InnoDB;
ALTER TABLE tblbranchtransfer ENGINE=InnoDB;
ALTER TABLE tblbranchtransferitems ENGINE=InnoDB;
ALTER TABLE tblcaldate ENGINE=InnoDB;
ALTER TABLE tblcardtypes ENGINE=InnoDB;
ALTER TABLE tblcashcount ENGINE=InnoDB;
ALTER TABLE tblcashierlogs ENGINE=InnoDB;
ALTER TABLE tblcashierreport ENGINE=InnoDB;
ALTER TABLE tblcashierreporthistory ENGINE=InnoDB;
ALTER TABLE tblcashpayment ENGINE=InnoDB;
ALTER TABLE tblchargetype ENGINE=InnoDB;
ALTER TABLE tblchartofaccount ENGINE=InnoDB;
ALTER TABLE tblchequepayment ENGINE=InnoDB;
ALTER TABLE tblcontactaddon ENGINE=InnoDB;
ALTER TABLE tblcontactcreditcardinfo ENGINE=InnoDB;
ALTER TABLE tblcontactgroup ENGINE=InnoDB;
ALTER TABLE tblcontactrewards ENGINE=InnoDB;
ALTER TABLE tblcontactrewardsmovement ENGINE=InnoDB;
ALTER TABLE tblcontacts ENGINE=InnoDB;
ALTER TABLE tblcontactsaudit ENGINE=InnoDB;
ALTER TABLE tblcountingref ENGINE=InnoDB;
ALTER TABLE tblcountry ENGINE=InnoDB;
ALTER TABLE tblcreditbilldetail ENGINE=InnoDB;
ALTER TABLE tblcreditbillheader ENGINE=InnoDB;
ALTER TABLE tblcreditbills ENGINE=InnoDB;
ALTER TABLE tblcreditcardpayment ENGINE=InnoDB;
ALTER TABLE tblcreditpayment ENGINE=InnoDB;
ALTER TABLE tblcreditpaymentcash ENGINE=InnoDB;
ALTER TABLE tblcreditpaymentcheque ENGINE=InnoDB;
ALTER TABLE tbldebitpayment ENGINE=InnoDB;
ALTER TABLE tbldenomination ENGINE=InnoDB;
ALTER TABLE tbldepartments ENGINE=InnoDB;
ALTER TABLE tbldeposit ENGINE=InnoDB;
ALTER TABLE tbldisburse ENGINE=InnoDB;
ALTER TABLE tbldiscount ENGINE=InnoDB;
ALTER TABLE tbldiscounthistory ENGINE=InnoDB;
ALTER TABLE tblerpconfig ENGINE=InnoDB;
ALTER TABLE tblgjournal ENGINE=InnoDB;
ALTER TABLE tblgjournalcredit ENGINE=InnoDB;
ALTER TABLE tblgjournaldebit ENGINE=InnoDB;
ALTER TABLE tblgla_f_dtl_chk_headers ENGINE=InnoDB;
ALTER TABLE tblindividualcredit ENGINE=InnoDB;
ALTER TABLE tblinvadjustment ENGINE=InnoDB;
ALTER TABLE tblinventory ENGINE=InnoDB;
ALTER TABLE tblmerch ENGINE=InnoDB;
ALTER TABLE tblmerchweighted ENGINE=InnoDB;
ALTER TABLE tblmergetable ENGINE=InnoDB;
ALTER TABLE tblpaidout ENGINE=InnoDB;
ALTER TABLE tblparkingrates ENGINE=InnoDB;
ALTER TABLE tblpayment ENGINE=InnoDB;
ALTER TABLE tblpaymentcredit ENGINE=InnoDB;
ALTER TABLE tblpaymentdebit ENGINE=InnoDB;
ALTER TABLE tblpaymentpodetails ENGINE=InnoDB;
ALTER TABLE tblplureport ENGINE=InnoDB;
ALTER TABLE tblpo ENGINE=InnoDB;
ALTER TABLE tblpodebitmemo ENGINE=InnoDB;
ALTER TABLE tblpodebitmemoitems ENGINE=InnoDB;
ALTER TABLE tblpoitems ENGINE=InnoDB;
ALTER TABLE tblpositions ENGINE=InnoDB;
ALTER TABLE tblproductbasevariationsmatrix ENGINE=InnoDB;
ALTER TABLE tblproductcomposition ENGINE=InnoDB;
ALTER TABLE tblproductgroup ENGINE=InnoDB;
ALTER TABLE tblproductgroupbasevariationsmatrix ENGINE=InnoDB;
ALTER TABLE tblproductgroupcharges ENGINE=InnoDB;
ALTER TABLE tblproductgroupunitmatrix ENGINE=InnoDB;
ALTER TABLE tblproductgroupvariations ENGINE=InnoDB;
ALTER TABLE tblproductgroupvariationsmatrix ENGINE=InnoDB;
ALTER TABLE tblproducthistory ENGINE=InnoDB;
ALTER TABLE tblproductinventory ENGINE=InnoDB;
ALTER TABLE tblproductinventoryaudit ENGINE=InnoDB;
ALTER TABLE tblproductinventorydaily ENGINE=InnoDB;
ALTER TABLE tblproductinventorymonthly ENGINE=InnoDB;
ALTER TABLE tblproductmovement ENGINE=InnoDB;
ALTER TABLE tblproductpackage ENGINE=InnoDB;
ALTER TABLE tblproductpackagepricehistory ENGINE=InnoDB;
ALTER TABLE tblproductpurchasepricehistory ENGINE=InnoDB;
ALTER TABLE tblproducts ENGINE=InnoDB;
ALTER TABLE tblproductsubgroup ENGINE=InnoDB;
ALTER TABLE tblproductsubgroupbasevariationsmatrix ENGINE=InnoDB;
ALTER TABLE tblproductsubgroupcharges ENGINE=InnoDB;
ALTER TABLE tblproductsubgroupunitmatrix ENGINE=InnoDB;
ALTER TABLE tblproductsubgroupvariations ENGINE=InnoDB;
ALTER TABLE tblproductsubgroupvariationsmatrix ENGINE=InnoDB;
ALTER TABLE tblproductunitmatrix ENGINE=InnoDB;
ALTER TABLE tblproductvariations ENGINE=InnoDB;
ALTER TABLE tblproductvariationsmatrix ENGINE=InnoDB;
ALTER TABLE tblpromo ENGINE=InnoDB;
ALTER TABLE tblpromoitems ENGINE=InnoDB;
ALTER TABLE tblpromotype ENGINE=InnoDB;
ALTER TABLE tblreceipt ENGINE=InnoDB;
ALTER TABLE tblrewarditems ENGINE=InnoDB;
ALTER TABLE tblsalesperitem ENGINE=InnoDB;
ALTER TABLE tblsalutations ENGINE=InnoDB;
ALTER TABLE tblso ENGINE=InnoDB;
ALTER TABLE tblsocreditmemo ENGINE=InnoDB;
ALTER TABLE tblsocreditmemoitems ENGINE=InnoDB;
ALTER TABLE tblsoitems ENGINE=InnoDB;
ALTER TABLE tblstock ENGINE=InnoDB;
ALTER TABLE tblstockitems ENGINE=InnoDB;
ALTER TABLE tblstocktype ENGINE=InnoDB;
ALTER TABLE tblterminal ENGINE=InnoDB;
ALTER TABLE tblterminalreport ENGINE=InnoDB;
ALTER TABLE tblterminalreporthistory ENGINE=InnoDB;
ALTER TABLE tbltransactionitems ENGINE=InnoDB;
ALTER TABLE tbltransactionitemsbackup ENGINE=InnoDB;
ALTER TABLE tbltransactions ENGINE=InnoDB;
ALTER TABLE tbltransactionsbackup ENGINE=InnoDB;
ALTER TABLE tbltransferin ENGINE=InnoDB;
ALTER TABLE tbltransferinitems ENGINE=InnoDB;
ALTER TABLE tbltransferout ENGINE=InnoDB;
ALTER TABLE tbltransferoutitems ENGINE=InnoDB;
ALTER TABLE tblunit ENGINE=InnoDB;
ALTER TABLE tblvariations ENGINE=InnoDB;
ALTER TABLE tblwithhold ENGINE=InnoDB;

-- set as the last card no.
UPDATE tblERPConfig SET LastGroupCreditCardNo = '01159625';
UPDATE tblERPConfig SET LastCreditCardNo = '01159591';

DELETE FROM tblProductInventory WHERE ProductID IN (SELECT ProductID FROM tblProducts WHERE ProductCode = 'MAINSTORE OFFLINE TRX');  
DELETE FROM tblProductPackage WHERE ProductID IN (SELECT ProductID FROM tblProducts WHERE ProductCode = 'MAINSTORE OFFLINE TRX');  
DELETE FROM tblProducts WHERE ProductCode = 'MAINSTORE OFFLINE TRX';  
INSERT INTO tblProducts(ProductCode, ProductDesc, ProductSubGroupID, BaseUnitID, SupplierID, Deleted, DateCreated) VALUES ('MAINSTORE OFFLINE TRX','MAINSTORE OFFLINE TRX',1,1,2,1,NOW());
INSERT INTO tblProductPackage (Barcode1, ProductID, UnitID, Price, PurchasePrice, Quantity)   SELECT '99021', ProductID, BaseUnitID, 0, 0, 1 FROM tblProducts WHERE ProductCode = 'MAINSTORE OFFLINE TRX';
INSERT INTO tblProductInventory(BranchID, ProductID, Quantity) SELECT 1, ProductID, 999999999 FROM tblProducts WHERE ProductCode = 'MAINSTORE OFFLINE TRX';
UPDATE tblProducts SET IsCreditChargeExcluded =1 WHERE ProductCode = 'MAINSTORE OFFLINE TRX'; 

CALL procTerminalReportHistorySyncTransactionSales(1, '01', '2014-10-31 00:00');

UPDATE tblContactCreditCardInfo SET Last2BillingDate = '2014-11-20' WHERE LastBillingDate = '2014-12-06';
UPDATE tblContactCreditCardInfo SET Last2BillingDate = '2014-11-10' WHERE LastBillingDate = '2014-12-10';



-- Jan 12, 2015


 -- get the transactions that are deleted
 insert into poshp.tblcreditpaymentDec20
 select * from poshp.tblcreditpayment where creditpaymentid in (select distinct creditpaymentid from pos.tblcreditpaymentcash) and creditpaymentid not in (select distinct creditpaymentid from pos.tblcreditpayment);

 -- insert as backup in pos table in case poshp is refreshed
 insert into pos.tblcreditpaymentDec20
 select * from poshp.tblcreditpaymentDec20;

 -- insert the actual deleted transaction in tblcreditpayment
 insert into pos.tblcreditpayment
 select * from poshp.tblcreditpaymentDec20 where creditpaymentid not in (select distinct creditpaymentid from pos.tblcreditpayment);

 -- insert the actual deleted transaction in tbltransactions
 insert into pos.tbltransactions(TransactionID,	TransactionNo,	CustomerID,	CustomerName,	CashierID,	CashierName,	TerminalNo,	TransactionDate,	DateSuspended,	DateResumed,	TransactionStatus,	SubTotal,	Discount,	TransDiscount,	TransDiscountType,	VAT,	VatableAmount,	EVAT,	EVatableAmount,	LocalTax,	AmountPaid,	CashPayment,	ChequePayment,	CreditCardPayment,	CreditPayment,	BalanceAmount,	ChangeAmount,	DateClosed,	PaymentType,	DiscountCode,	DiscountRemarks,	DebitPayment,	ItemsDiscount,	Charge,	ChargeAmount,	ChargeCode,	ChargeRemarks,	WaiterID,	WaiterName,	Packed,	OrderType,	AgentID,	AgentName,	CreatedByID,	CreatedByName,	AgentDepartmentName,	AgentPositionName,	ReleaserID,	ReleaserName,	ReleasedDate,	RewardPointsPayment,	RewardConvertedPayment,	PaxNo,	CreditChargeAmount,	BranchID,	BranchCode,	TransactionType,	isConsignment,	DataSource,	CustomerGroupName,	CreatedOn,	LastModified,	ORNo,	SyncID,	NonVATableAmount,	VATExempt,	NonEVATableAmount,	SNRDiscount,	PWDDiscount,	OtherDiscount,	NetSales,	ChargeType,	ItemSold,	QuantitySold,	ContactCheckInDate,	SNRItemsDiscount,	PWDItemsDiscount,	OtherItemsDiscount,	GrossSales,	RewardsCustomerID,	RewardsCustomerName)
 select TransactionID,	TransactionNo,	CustomerID,	CustomerName,	CashierID,	CashierName,	TerminalNo,	TransactionDate,	DateSuspended,	DateResumed,	TransactionStatus,	SubTotal,	Discount,	TransDiscount,	TransDiscountType,	VAT,	VatableAmount,	EVAT,	EVatableAmount,	LocalTax,	AmountPaid,	CashPayment,	ChequePayment,	CreditCardPayment,	CreditPayment,	BalanceAmount,	ChangeAmount,	DateClosed,	PaymentType,	DiscountCode,	DiscountRemarks,	DebitPayment,	ItemsDiscount,	Charge,	ChargeAmount,	ChargeCode,	ChargeRemarks,	WaiterID,	WaiterName,	Packed,	OrderType,	AgentID,	AgentName,	CreatedByID,	CreatedByName,	AgentDepartmentName,	AgentPositionName,	ReleaserID,	ReleaserName,	ReleasedDate,	RewardPointsPayment,	RewardConvertedPayment,	PaxNo,	CreditChargeAmount,	BranchID,	BranchCode,	TransactionType,	isConsignment,	DataSource,	CustomerGroupName,	CreatedOn,	LastModified,	ORNo,	SyncID,	NonVATableAmount,	VATExempt,	NonEVATableAmount,	SNRDiscount,	PWDDiscount,	OtherDiscount,	NetSales,	ChargeType,	ItemSold,	QuantitySold,	ContactCheckInDate,	SNRItemsDiscount,	PWDItemsDiscount,	OtherItemsDiscount,	GrossSales,	RewardsCustomerID,	RewardsCustomerName
 from poshp.tbltransactions where transactionid in (select distinct transactionid from poshp.tblcreditpaymentDec20)
 and transactionid not in (select distinct transactionid from pos.tbltransactions);

 -- insert the actual deleted transaction in tbltransactionitems
 insert into pos.tbltransactionitems(TransactionItemsID,	TransactionID,	ProductID,	ProductCode,	BarCode,	Description,	ProductUnitID,	ProductUnitCode,	Quantity,	Price,	SellingPrice,	Discount,	ItemDiscount,	ItemDiscountType,	Amount,	VAT,	VatableAmount,	EVAT,	EVatableAmount,	LocalTax,	VariationsMatrixID,	MatrixDescription,	ProductGroup,	ProductSubGroup,	TransactionItemStatus,	DiscountCode,	DiscountRemarks,	ProductPackageID,	MatrixPackageID,	PackageQuantity,	PromoQuantity,	PromoValue,	PromoInPercent,	PromoType,	PromoApplied,	PurchasePrice,	PurchaseAmount,	IncludeInSubtotalDiscount,	OrderSlipPrinter,	OrderSlipPrinted,	PercentageCommision,	Commision,	PaxNo,	TransactionDiscount,	DataSource,	CreatedOn,	LastModified,	SyncID,	NonVATableAmount,	VATExempt,	NonEVATableAmount,	IsCreditChargeExcluded,	GrossSales,	RewardPoints)
 select TransactionItemsID,	TransactionID,	ProductID,	ProductCode,	BarCode,	Description,	ProductUnitID,	ProductUnitCode,	Quantity,	Price,	SellingPrice,	Discount,	ItemDiscount,	ItemDiscountType,	Amount,	VAT,	VatableAmount,	EVAT,	EVatableAmount,	LocalTax,	VariationsMatrixID,	MatrixDescription,	ProductGroup,	ProductSubGroup,	TransactionItemStatus,	DiscountCode,	DiscountRemarks,	ProductPackageID,	MatrixPackageID,	PackageQuantity,	PromoQuantity,	PromoValue,	PromoInPercent,	PromoType,	PromoApplied,	PurchasePrice,	PurchaseAmount,	IncludeInSubtotalDiscount,	OrderSlipPrinter,	OrderSlipPrinted,	PercentageCommision,	Commision,	PaxNo,	TransactionDiscount,	DataSource,	CreatedOn,	LastModified,	SyncID,	NonVATableAmount,	VATExempt,	NonEVATableAmount,	IsCreditChargeExcluded,	GrossSales,	RewardPoints
 from poshp.tbltransactionitems where transactionid in (select distinct transactionid from poshp.tblcreditpaymentDec20)
 and transactionitemsid not in (select distinct transactionitemsid from pos.tbltransactionitems);

CREATE TABLE `tblcreditpaymentDec20` (
 `TransactionID` bigint(20) unsigned NOT NULL DEFAULT '0',
 `Amount` decimal(18,2) NOT NULL DEFAULT '0.00',
 `ContactID` bigint(20) unsigned NOT NULL DEFAULT '0',
 `Remarks` varchar(8000) DEFAULT NULL,
 `AmountPaid` decimal(18,2) NOT NULL DEFAULT '0.00',
 `TransactionNo` varchar(30) DEFAULT NULL,
 `CreditDate` datetime NOT NULL DEFAULT '0001-01-01 12:00:00',
 `CreditBefore` decimal(18,3) NOT NULL DEFAULT '0.000',
 `CreditAfter` decimal(18,3) NOT NULL DEFAULT '0.000',
 `CreditReason` varchar(150) NOT NULL,
 `TerminalNo` varchar(10) NOT NULL,
 `CashierName` varchar(150) NOT NULL,
 `AmountPaidCuttOffMonth` decimal(18,3) NOT NULL DEFAULT '0.000',
 `CreatedOn` datetime NOT NULL DEFAULT '1900-01-01 12:00:00',
 `LastModified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `CreditPaymentID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
 `SyncID` bigint(20) NOT NULL DEFAULT '0',
 `BranchID` int(4) NOT NULL DEFAULT '0',
 `CreditCardPaymentID` bigint(20) NOT NULL DEFAULT '0',
 `CreditCardTypeID` int(10) NOT NULL DEFAULT '0',
 `CreditReasonID` tinyint(1) unsigned NOT NULL DEFAULT '0',
 PRIMARY KEY (`CreditPaymentID`),
 KEY `IX_tblcreditpaymentDec20` (`TransactionID`),
 KEY `IX1_tblcreditpaymentDec20` (`ContactID`),
 KEY `IX2_tblcreditpaymentDec20` (`Remarks`),
 KEY `IX_tblcreditpaymentDec20_IXSync` (`SyncID`))
 ENGINE=InnoDB;

-- Jan 31, 2015
UPDATE tblTerminal SET IncludeIneSales = 0 WHERE TerminalID >= 80;
UPDATE tblTerminalReport SET IncludeIneSales = 0 WHERE TerminalID >= 80;
UPDATE tblTerminalReportHistory SET IncludeIneSales = 0 WHERE TerminalID >= 80;