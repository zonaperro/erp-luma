
/*!40000 ALTER TABLE `tblProducts` DISABLE KEYS */;


TRUNCATE TABLE tblTerminal;
INSERT INTO tblTerminal (TerminalID, `TerminalNo`, `TerminalCode`, `TerminalName`, DateCreated, MachineSerialNo, AccreditationNo )
		VALUES		(1, '01', 'Terminal No. 01', 'Terminal No. 01', NOW(), 'AR-00000001', 'AC-00000001');
INSERT INTO tblTerminal (TerminalID, `TerminalNo`, `TerminalCode`, `TerminalName`, DateCreated, MachineSerialNo, AccreditationNo )
		VALUES		(2, '02', 'Terminal No. 02', 'Terminal No. 02', NOW(), 'AR-00000001', 'AC-00000001');
INSERT INTO tblTerminal (TerminalID, `TerminalNo`, `TerminalCode`, `TerminalName`, DateCreated, MachineSerialNo, AccreditationNo )
		VALUES		(3, '03', 'Terminal No. 03', 'Terminal No. 03', NOW(), 'AR-00000001', 'AC-00000001');
INSERT INTO tblTerminal (TerminalID, `TerminalNo`, `TerminalCode`, `TerminalName`, DateCreated, MachineSerialNo, AccreditationNo )
		VALUES		(4, '04', 'Terminal No. 04', 'Terminal No. 04', NOW(), 'AR-00000001', 'AC-00000001');
INSERT INTO tblTerminal (TerminalID, `TerminalNo`, `TerminalCode`, `TerminalName`, DateCreated, MachineSerialNo, AccreditationNo )
		VALUES		(5, '05', 'Terminal No. 05', 'Terminal No. 05', NOW(), 'AR-00000001', 'AC-00000001');
INSERT INTO tblTerminal (TerminalID, `TerminalNo`, `TerminalCode`, `TerminalName`, DateCreated, MachineSerialNo, AccreditationNo )
		VALUES		(6, '06', 'Terminal No. 06', 'Terminal No. 06', NOW(), 'AR-00000001', 'AC-00000001');
INSERT INTO tblTerminal (TerminalID, `TerminalNo`, `TerminalCode`, `TerminalName`, DateCreated, MachineSerialNo, AccreditationNo )
		VALUES		(7, '07', 'Terminal No. 07', 'Terminal No. 07', NOW(), 'AR-00000001', 'AC-00000001');
INSERT INTO tblTerminal (TerminalID, `TerminalNo`, `TerminalCode`, `TerminalName`, DateCreated, MachineSerialNo, AccreditationNo )
		VALUES		(8, '08', 'Terminal No. 08', 'Terminal No. 08', NOW(), 'AR-00000001', 'AC-00000001');
INSERT INTO tblTerminal (TerminalID, `TerminalNo`, `TerminalCode`, `TerminalName`, DateCreated, MachineSerialNo, AccreditationNo )
		VALUES		(9, '09', 'Terminal No. 09', 'Terminal No. 09', NOW(), 'AR-00000001', 'AC-00000001');

		
TRUNCATE TABLE tblTerminalReport;
INSERT INTO tblTerminalReport (`BeginningTransactionNo`, `EndingTransactionNo`, `ZReadCount`, `XReadCount`, `TerminalID`, `TerminalNo`, `DateLastInitialized`)
		VALUES		('00000000000001', '00000000000001', 1, 1, 1, '01', DATE_SUB(DATE(NOW()), INTERVAL 1 DAY));
INSERT INTO tblTerminalReport (`BeginningTransactionNo`, `EndingTransactionNo`, `ZReadCount`, `XReadCount`, `TerminalID`, `TerminalNo`, `DateLastInitialized`)
		VALUES		('00000000000001', '00000000000001', 1, 1, 2, '02', DATE_SUB(DATE(NOW()), INTERVAL 1 DAY));
INSERT INTO tblTerminalReport (`BeginningTransactionNo`, `EndingTransactionNo`, `ZReadCount`, `XReadCount`, `TerminalID`, `TerminalNo`, `DateLastInitialized`)
		VALUES		('00000000000001', '00000000000001', 1, 1, 3, '03', DATE_SUB(DATE(NOW()), INTERVAL 1 DAY));
INSERT INTO tblTerminalReport (`BeginningTransactionNo`, `EndingTransactionNo`, `ZReadCount`, `XReadCount`, `TerminalID`, `TerminalNo`, `DateLastInitialized`)
		VALUES		('00000000000001', '00000000000001', 1, 1, 4, '04', DATE_SUB(DATE(NOW()), INTERVAL 1 DAY));
INSERT INTO tblTerminalReport (`BeginningTransactionNo`, `EndingTransactionNo`, `ZReadCount`, `XReadCount`, `TerminalID`, `TerminalNo`, `DateLastInitialized`)
		VALUES		('00000000000001', '00000000000001', 1, 1, 5, '05', DATE_SUB(DATE(NOW()), INTERVAL 1 DAY));
INSERT INTO tblTerminalReport (`BeginningTransactionNo`, `EndingTransactionNo`, `ZReadCount`, `XReadCount`, `TerminalID`, `TerminalNo`, `DateLastInitialized`)
		VALUES		('00000000000001', '00000000000001', 1, 1, 6, '06', DATE_SUB(DATE(NOW()), INTERVAL 1 DAY));
INSERT INTO tblTerminalReport (`BeginningTransactionNo`, `EndingTransactionNo`, `ZReadCount`, `XReadCount`, `TerminalID`, `TerminalNo`, `DateLastInitialized`)
		VALUES		('00000000000001', '00000000000001', 1, 1, 7, '07', DATE_SUB(DATE(NOW()), INTERVAL 1 DAY));
INSERT INTO tblTerminalReport (`BeginningTransactionNo`, `EndingTransactionNo`, `ZReadCount`, `XReadCount`, `TerminalID`, `TerminalNo`, `DateLastInitialized`)
		VALUES		('00000000000001', '00000000000001', 1, 1, 8, '08', DATE_SUB(DATE(NOW()), INTERVAL 1 DAY));
INSERT INTO tblTerminalReport (`BeginningTransactionNo`, `EndingTransactionNo`, `ZReadCount`, `XReadCount`, `TerminalID`, `TerminalNo`, `DateLastInitialized`)
		VALUES		('00000000000001', '00000000000001', 1, 1, 9, '09', DATE_SUB(DATE(NOW()), INTERVAL 1 DAY));

		
TRUNCATE TABLE tblTerminalReportHistory;
INSERT INTO tblTerminalReportHistory (`BeginningTransactionNo`, `EndingTransactionNo`, `ZReadCount`, `XReadCount`, `TerminalID`, `TerminalNo`, `DateLastInitialized`)
		VALUES		('00000000000000', '00000000000000', 0, 0, 1, '01', DATE_SUB(DATE(NOW()), INTERVAL 2 DAY));
INSERT INTO tblTerminalReportHistory (`BeginningTransactionNo`, `EndingTransactionNo`, `ZReadCount`, `XReadCount`, `TerminalID`, `TerminalNo`, `DateLastInitialized`)
		VALUES		('00000000000000', '00000000000000', 0, 0, 2, '02', DATE_SUB(DATE(NOW()), INTERVAL 2 DAY));
INSERT INTO tblTerminalReportHistory (`BeginningTransactionNo`, `EndingTransactionNo`, `ZReadCount`, `XReadCount`, `TerminalID`, `TerminalNo`, `DateLastInitialized`)
		VALUES		('00000000000000', '00000000000000', 0, 0, 3, '03', DATE_SUB(DATE(NOW()), INTERVAL 2 DAY));
INSERT INTO tblTerminalReportHistory (`BeginningTransactionNo`, `EndingTransactionNo`, `ZReadCount`, `XReadCount`, `TerminalID`, `TerminalNo`, `DateLastInitialized`)
		VALUES		('00000000000000', '00000000000000', 0, 0, 4, '04', DATE_SUB(DATE(NOW()), INTERVAL 2 DAY));
INSERT INTO tblTerminalReportHistory (`BeginningTransactionNo`, `EndingTransactionNo`, `ZReadCount`, `XReadCount`, `TerminalID`, `TerminalNo`, `DateLastInitialized`)
		VALUES		('00000000000000', '00000000000000', 0, 0, 5, '05', DATE_SUB(DATE(NOW()), INTERVAL 2 DAY));
INSERT INTO tblTerminalReportHistory (`BeginningTransactionNo`, `EndingTransactionNo`, `ZReadCount`, `XReadCount`, `TerminalID`, `TerminalNo`, `DateLastInitialized`)
		VALUES		('00000000000000', '00000000000000', 0, 0, 6, '06', DATE_SUB(DATE(NOW()), INTERVAL 2 DAY));
INSERT INTO tblTerminalReportHistory (`BeginningTransactionNo`, `EndingTransactionNo`, `ZReadCount`, `XReadCount`, `TerminalID`, `TerminalNo`, `DateLastInitialized`)
		VALUES		('00000000000000', '00000000000000', 0, 0, 7, '07', DATE_SUB(DATE(NOW()), INTERVAL 2 DAY));
INSERT INTO tblTerminalReportHistory (`BeginningTransactionNo`, `EndingTransactionNo`, `ZReadCount`, `XReadCount`, `TerminalID`, `TerminalNo`, `DateLastInitialized`)
		VALUES		('00000000000000', '00000000000000', 0, 0, 8, '08', DATE_SUB(DATE(NOW()), INTERVAL 2 DAY));
INSERT INTO tblTerminalReportHistory (`BeginningTransactionNo`, `EndingTransactionNo`, `ZReadCount`, `XReadCount`, `TerminalID`, `TerminalNo`, `DateLastInitialized`)
		VALUES		('00000000000000', '00000000000000', 0, 0, 9, '09', DATE_SUB(DATE(NOW()), INTERVAL 2 DAY));


UPDATE tblTerminal SET FORM_Behavior = 'NON_MODAL';
UPDATE tblTerminal SET CashCountBeforeReport = 1;

UPDATE tblTerminal SET EnableRewardPoints = 1;		
UPDATE tblTerminal SET RoundDownRewardPoints = 1;	
UPDATE tblTerminal SET RewardPointsMinimum = 0;		
UPDATE tblTerminal SET RewardPointsEvery = 100;		
UPDATE tblTerminal SET RewardPoints = 1;			

UPDATE tblTerminal SET RewardPointsPaymentValue = 1;
UPDATE tblTerminal SET RewardPointsPaymentCashEquivalent = 0.50;

UPDATE tblTerminal SET IsPrinterAutoCutter = 1;
UPDATE tblDiscount SET DiscountCode = 'SNR', DiscountType = 'SENIOR CITIZEN', DiscountPrice = 5, InPercent = 1 WHERE DiscountCode = 'DEF';
UPDATE tblDiscount SET DiscountPrice = 5, InPercent = 1 WHERE DiscountCode = 'SNR';
UPDATE tblTerminal SET SeniorCitizenDiscountCode = 'SNR';

UPDATE tblTerminal SET ShowCustomerSelection = 0;	
UPDATE tblTerminal SET RewardsPermitNo = '1107-064-24317-000';
UPDATE tblTerminal SET InHouseIndividualCreditPermitNo = '1107-064-24313';
UPDATE tblTerminal SET InHouseGroupCreditPermitNo = '';

UPDATE tblProducts SET VAT = 0, Price = 150 WHERE ProductCode = 'ADVNTGE CARD - MEMBERSHIP FEE';
UPDATE tblProductPackage SET VAT = 12, Price = 150 WHERE ProductID = (Select ProductID FROM tblProducts WHERE ProductCode = 'ADVNTGE CARD - MEMBERSHIP FEE');

UPDATE tblProducts SET VAT = 0, Price = 100 WHERE ProductCode = 'ADVNTGE CARD - RENEWAL FEE';
UPDATE tblProductPackage SET VAT = 0, Price = 100 WHERE ProductID = (Select ProductID FROM tblProducts WHERE ProductCode = 'ADVNTGE CARD - RENEWAL FEE');

UPDATE tblProducts SET VAT = 0, Price = 50 WHERE ProductCode = 'ADVNTGE CARD - REPLACEMENT FEE';
UPDATE tblProductPackage SET VAT = 0, Price = 50 WHERE ProductID = (Select ProductID FROM tblProducts WHERE ProductCode = 'ADVNTGE CARD - REPLACEMENT FEE');

UPDATE tblProducts SET VAT = 0, Price = 300 WHERE ProductCode = 'CREDIT CARD - MEMBERSHIP FEE';
UPDATE tblProductPackage SET VAT = 0, Price = 300 WHERE ProductID = (Select ProductID FROM tblProducts WHERE ProductCode = 'CREDIT CARD - MEMBERSHIP FEE');

UPDATE tblProducts SET VAT = 0, Price = 300 WHERE ProductCode = 'CREDIT CARD - RENEWAL FEE';
UPDATE tblProductPackage SET VAT = 0, Price = 300 WHERE ProductID = (Select ProductID FROM tblProducts WHERE ProductCode = 'CREDIT CARD - RENEWAL FEE');

UPDATE tblProducts SET VAT = 0, Price = 250 WHERE ProductCode = 'SUPER CARD - MEMBERSHIP FEE';
UPDATE tblProductPackage SET VAT = 0, Price = 250 WHERE ProductID = (Select ProductID FROM tblProducts WHERE ProductCode = 'SUPER CARD - MEMBERSHIP FEE');

UPDATE tblProducts SET VAT = 0, Price = 250 WHERE ProductCode = 'SUPER CARD - RENEWAL FEE';
UPDATE tblProductPackage SET VAT = 0, Price = 250 WHERE ProductID = (Select ProductID FROM tblProducts WHERE ProductCode = 'SUPER CARD - RENEWAL FEE');

UPDATE tblProducts SET VAT = 0, Price = 200 WHERE ProductCode = 'SUPER CARD - REPLACEMENT FEE';
UPDATE tblProductPackage SET VAT = 0, Price = 200 WHERE ProductID = (Select ProductID FROM tblProducts WHERE ProductCode = 'SUPER CARD - REPLACEMENT FEE');




/*!40000 ALTER TABLE `tblProducts` ENABLE KEYS */;



/*****************************
**	tblMerch
DROP TABLE IF EXISTS tblMerch;
CREATE TABLE tblMerch (
`Barcode` varchar(100),
`Description` varchar(100),
`Price` DECIMAL(10,2) NOT NULL DEFAULT 0,
`purchaseprice` DECIMAL(10,2) NOT NULL DEFAULT 0,
`bottomunit` varchar(100),
`bottomunitcode` varchar(100),
`midunittemp` DECIMAL(10,2) NOT NULL DEFAULT 0,
`midunit` DECIMAL(10,2) NOT NULL DEFAULT 0,
`midunitcode` varchar(100),
`baseunit` DECIMAL(10,2) NOT NULL DEFAULT 0,
`baseunitcode` varchar(100),
`class` varchar(100),
`supplier` varchar(100),
`barcode2` varchar(100),
INDEX `IX_tblMerch`(`Barcode`),
INDEX `IX_tblMerch1`(`supplier`),
INDEX `IX_tblMerch2`(`class`),
UNIQUE `PK_tblMerch`(`Barcode`)
);
*****************************/




INSERT INTO sysTerminalkey VALUE ('JP1572JE083MAK', 'noKVJPxk+UfFMLod12VBUyBxJa5PQfmq6I2+tgy6XAkdDi0+nT9f3r138dkg5VBy');
INSERT INTO sysTerminalkey VALUE ('JP1572JE083XBK', 'wT96kf9How04IWjBeAnQ8FWfQpxfepKrQhZvI3vJZbeR645PHwhP40ak7gL0cZez');
INSERT INTO sysTerminalkey VALUE ('JP8521HR2LLHXV', 'mgVZjxKDvFQGDO1phcXuN2ZxJjx4QJfALNX/4GqCe9heOEnb2yMVggrPb1RKd+8u');
INSERT INTO sysTerminalkey VALUE ('JP8522HR3TWM7V', 'BQQznKqFsQZbjkiqY5AuMSgydBgkkOVCZU9ljvWb/RbqdU4tpU8w5Ekwgf9zN9ao');
INSERT INTO sysTerminalkey VALUE ('JP1572JE0870XK', 'BPA9ybXMX9aTEvfuL+f7q6hLDF0ooQ04ZiFfJvpt0cYZKJ+Tx/e14rEIlKA1vdMU');
INSERT INTO sysTerminalkey VALUE ('JP1572JE07W5KK', '87vfU3Xkh0soAhcArY/ruw3trTEq/a0jgf33hBXgyTdr5j8G30RO1ghf67Hn3hn2');
INSERT INTO sysTerminalkey VALUE ('Z2AAGBS2', '2DvTUYBuF/TNYWhT8PsejbvcrtDEvNRYRMqCbs11sm8=');
INSERT INTO sysTerminalkey VALUE ('Z2AAG3FR', 'RBshyofY6Nxv84OvuL9TOvEqhwIrEZLN2I8pfHa/I+E=');
INSERT INTO sysTerminalkey VALUE ('JP1572JE0K2P6K', 'CyFcgbb7kkLhC90Fc3s+AfgCYGvukg1T15EdfmZaevrHs4sV1mZQhnVbOcUGIHj5');


UPDATE tblDiscount SET DiscountCode = 'SNR', DiscountType = 'SENIOR CITIZEN', DiscountPrice = 12, InPercent = 1 WHERE DiscountID = 1;


UPDATE tblChargeType SET ChargeTypeCode = 'CRC', ChargeType = 'In-House Credit Charge', ChargeAmount = 7, InPercent = 1 WHERE ChargeTypeCode = 'PC';
UPDATE tblTerminal SET GroupChargeTypeID = (SELECT ChargeTypeID FROM tblChargeType WHERE ChargeTypeCode = 'CRC');












/*****************************
**	tblAdv
DROP TABLE IF EXISTS tblAdv;
CREATE TABLE tblAdv (
`Barcode` varchar(100),
`FULLNAME` varchar(150),
`CARDNO` varchar(150),
`BDAY` varchar(150),
`EXPIRY` varchar(150),
`ADDRESS` varchar(150),
`TELNO` varchar(150),
`STATUS` varchar(150),
INDEX `IX_tblAdv`(`Barcode`),
INDEX `IX_tblAdv1`(`CARDNO`)
);
*****************************/

select expiry, concat(right(expiry,4), '-', left(expiry,2), '-', right(left(expiry,5),2)) from tbladv  where length(expiry) <= 10 limit 10;
update tbladv set expiry = concat(right(expiry,4), '-', left(expiry,2), '-', right(left(expiry,5),2)) ;
select expiry from tbladv  where length(expiry) <= 10 limit 10;

select bday, concat(right(bday,4), '-', left(bday,2), '-', right(left(bday,5),2)) from tbladv  where length(bday) <= 10 limit 10;
update tbladv set bday = concat(right(bday,4), '-', left(bday,2), '-', right(left(bday,5),2)) ;
select bday from tbladv  where length(expiry) <= 10 limit 10;

-- contacts
DELETE FROM tblContacts WHERE CONTACTCODE IN (select concat('ADV-',cardno) from tbladv);

INSERT INTO tblContacts(ContactGroupID, ContactCode, ContactName, Address, TelephoneNo, DepartmentID, PositionID, DateCreated)
SELECT 1, concat('ADV-',cardno), FullName, Address, TelNo, 1, 1, NOW() FROM tblAdv group by concat('ADV-',cardno);

-- rewards card 
truncate table tblContactRewards;

INSERT INTO tblContactRewards
	(CustomerID, RewardCardNo, rewardActive, RewardAwardDate, RewardCardStatus, ExpiryDate, birthdate)
SELECT 
	ContactID, 
	Barcode, 
	CASE Status
		WHEN 'A' THEN 1
		WHEN 'L' THEN 0
		WHEN 'S' THEN 0
	END AS Status,
	now(),
	CASE Status
		WHEN 'A' THEN 5
		WHEN 'L' THEN 1
		WHEN 'S' THEN 2
	END AS RewardCardStatus,
	date(Expiry),
	date(bday)
FROM tblContacts a INNER JOIN tblAdv b ON a.contactcode = concat('ADV-',b.cardno) group by concat('ADV-',cardno);

SELECT ContactID FROM tblContacts WHERE ContactCode = 'ADV-#VALUE!';
DELETE FROM tblContactRewards Where CustomerID = (SELECT ContactID FROM tblContacts WHERE ContactCode = 'ADV-#VALUE!');
DELETE FROM tblCOntacts Where ContactCode = 'ADV-#VALUE!';


UPDATE tblContactRewards SET ExpiryDate = '1900-01-01' WHERE ExpiryDate = '1900-01-00';
UPDATE tblContactRewards SET BirthDate = '1900-01-01' WHERE BirthDate = '1900-01-00';


/*****************************
**	tblIndividualCredit
DROP TABLE IF EXISTS tblIndividualCredit;
CREATE TABLE tblIndividualCredit (
`Barcode` varchar(100),
`FULLNAME` varchar(150),
`CARDNO` varchar(150),
`EXPIRY` varchar(150),
`ADDRESS` varchar(150),
`TELNO` varchar(150),
`STATUS` varchar(150),
INDEX `IX_tblIndividualCredit`(`Barcode`),
INDEX `IX_tblIndividualCredit1`(`CARDNO`)
);
*****************************/

-- select expiry, concat(right(expiry,4), '-', left(expiry,2), '-', right(left(expiry,5),2)) from tblIndividualCredit  where length(expiry) <= 10 limit 10;
update tblIndividualCredit set expiry = concat(right(expiry,4), '-', left(expiry,2), '-', right(left(expiry,5),2)) ;
-- select expiry from tblIndividualCredit  where length(expiry) <= 10 limit 10;

DELETE FROM tblIndividualCredit Where FULLNAME = '#VALUE!';
update tblindividualcredit set barcode = '8888881125689' where fullname = 'CAROLINE S. 744 DE LEON';
update tblindividualcredit set barcode = '8888881003093' where fullname = 'W/ SAME BARCODE LEGARTO';
update tblindividualcredit set barcode = '8888881003192' where fullname = 'D) WITH SAME BARCODE (PARDO';
update tblindividualcredit set barcode = '8888881125672' where fullname = 'ARIEL N. 726 GARCIA';

DELETE FROM tblindividualcredit where fullname = 'VIRGINIA R. TEJARES' AND BARCODE = '8888801066746';
DELETE FROM tblindividualcredit where fullname = 'RONNEL V. ABANTE' AND BARCODE = '8888801004434';
DELETE FROM tblindividualcredit where fullname = 'ANABELLE B. ABA╤O' AND BARCODE = '8888801004427';
DELETE FROM tblindividualcredit where fullname = 'BLANCHE B. BAUTISTA' AND BARCODE = '8888801004489';
DELETE FROM tblindividualcredit where fullname = 'LORNA E. PALMERO' AND BARCODE = '8888801004083';
DELETE FROM tblindividualcredit where fullname = 'RANILO M. MABEZA' AND BARCODE = '8888801065695';
DELETE FROM tblindividualcredit where fullname = 'MARILYN B. OBLINA' AND BARCODE = '8888801004694';
DELETE FROM tblindividualcredit where fullname = 'PEDRO M. YABA' AND BARCODE = '8888801065596';



UPDATE tblContacts, tblIndividualCredit SET ContactCode = CONCAT(ContactCode, '-INC-',tblIndividualCredit.CardNo) WHERE tblContacts.ContactName = tblIndividualCredit.FullName;

DELETE FROM tblContacts WHERE ContactCode LIKE 'INC-%';

INSERT INTO tblContacts(ContactGroupID, ContactCode, ContactName, Address, TelephoneNo, DepartmentID, PositionID, DateCreated)
SELECT 1, concat('INC-',cardno), FullName, Address, TelNo, 1, 1, NOW() FROM tblIndividualCredit 
	WHERE FullName NOT IN (SELECT ContactName FROM tblContacts) group by concat('INC-',cardno);
	


truncate table tblContactCreditCardInfo;
INSERT INTO tblContactCreditCardInfo
	(CustomerID, GuarantorID, CreditType, CreditCardNo, CreditAwardDate, CreditCardStatus, ExpiryDate, EmbossedCardNo)
SELECT 
	ContactID, 
	ContactID, 
	0 AS CreditType,
	Barcode, 
	now() as CreditAwardDate,
	CASE Status
		WHEN 'A' THEN 0
		WHEN 'L' THEN 1
		WHEN 'S' THEN 2
		WHEN 'C' THEN 2
	END AS CreditCardStatus,
	date(Expiry),
	CardNo
FROM tblContacts a INNER JOIN tblIndividualCredit b ON a.ContactName = b.FULLNAME WHERE a.ContactCode LIKE '%INC-%' group by Barcode;

UPDATE tblContacts, tblIndividualCredit SET IsCreditAllowed = 1, CreditLimit = 2000 WHERE tblContacts.ContactName = tblIndividualCredit.FullName;

UPDATE tblContacts, tblContactCreditCardInfo SET IsCreditAllowed = 0 WHERE tblContacts.ContactID = tblContactCreditCardInfo.CustomerID AND (CreditCardStatus =1 or CreditCardStatus = 2);
UPDATE tblContactRewards SET RewardActive = 0 WHERE ExpiryDate < now();


/*****************************
**	tblMerchWeighted
*****************************/
DROP TABLE IF EXISTS tblMerchWeighted;
CREATE TABLE tblMerchWeighted (
`PLUNo` varchar(30),
`Name` varchar(100),
`BarCode` varchar(30),
`Price` DECIMAL(10,2) NOT NULL DEFAULT 0,
`Mode` TINYINT(1) NOT NULL DEFAULT 0,
`LabelNo` TINYINT(1) NOT NULL DEFAULT 0,
`GroupName` varchar(100)
);


-- SELECT * FROM tblMerchWeighted a INNER JOIN tblProductGroup b ON a.Group = b.ProductGroupName;

INSERT INTO tblProductGroup(ProductGroupCode, ProductGroupName, BaseUnitID)
VALUES ('WEIGHTED ITEMS', 'WEIGHTED ITEMS', 1 );
INSERT INTO tblProductGroup(ProductGroupCode, ProductGroupName, BaseUnitID)
VALUES ('COUNTED ITEMS', 'COUNTED ITEMS', 1 );

DELETE FROM tblProductSubGroup WHERE ProductGroupID = (SELECT ProductGroupID FROM tblProductGroup WHERE ProductGroupCode = 'WEIGHTED ITEMS');
DELETE FROM tblProductSubGroup WHERE ProductGroupID = (SELECT ProductGroupID FROM tblProductGroup WHERE ProductGroupCode = 'COUNTED ITEMS');

INSERT INTO tblProductSubGroup(ProductGroupID, ProductSubGroupCode, ProductSubGroupName, BaseUnitID)
SELECT (SELECT ProductGroupID FROM tblProductGroup WHERE ProductGroupCode = 'WEIGHTED ITEMS'), CONCAT('MODE:',MODE,':',GROUPNAME), CONCAT('MODE:',MODE,':',GROUPNAME), 1 FROM tblMerchWeighted WHERE mode = 0 GROUP BY GroupName;

INSERT INTO tblProductSubGroup(ProductGroupID, ProductSubGroupCode, ProductSubGroupName, BaseUnitID)
SELECT (SELECT ProductGroupID FROM tblProductGroup WHERE ProductGroupCode = 'COUNTED ITEMS'), CONCAT('MODE:',MODE,':',GROUPNAME), CONCAT('MODE:',MODE,':',GROUPNAME), 1 FROM tblMerchWeighted WHERE mode = 1 GROUP BY GroupName;

INSERT INTO tblProducts (ProductCode, ProductDesc, BarCode, BarCode2, ProductSubGroupID, BaseUnitID, Price, PurchasePrice, IsItemSold, IncludeInSubtotalDiscount)
SELECT Name, Name, BarCode, pluno,  ProductSubGroupID, 1, a.Price, a.Price, 1, 1 FROM tblMerchWeighted a INNER JOIN tblProductSubGroup b ON b.ProductSubGroupName  = CONCAT('MODE:',MODE,':',GROUPNAME)
WHERE NAME NOT IN (SELECT DISTINCT(ProductCode) FROM tblProducts) GROUP BY Name;

INSERT INTO tblProductPackage (ProductID, UnitID, Price, PurchasePrice, Quantity, Barcode1, BarCode2, BarCode3)   
SELECT ProductID, BaseUnitID, Price, PurchasePrice, 1, Barcode, BarCode2, BarCode3 FROM tblProducts WHERE ProductID NOT IN (SELECT DISTINCT(ProductID) FROM tblProductPackage);


UPDATE tblProducts, tblMerchWeighted, tblProductSubGroup SET
	tblProducts.BarCode = tblMerchWeighted.BarCode,
	tblProducts.BarCode2 = tblMerchWeighted.pluno,
	tblProducts.Price = tblMerchWeighted.Price,
	tblProducts.ProductSubGroupID = (SELECT ProductSubGroupID FROM tblProductSubGroup WHERE tblProductSubGroup.ProductSubGroupName  = CONCAT('MODE:',tblMerchWeighted.MODE,':',tblMerchWeighted.GROUPNAME))
WHERE tblProducts.ProductCode = tblMerchWeighted.Name;

UPDATE tblProducts SET 
	ProductSubGroupID = (select ProductSubGroupID from tblproductsubgroup where productgroupid = (select productgroupid from tblproductgroup  where productgroupcode LIKE 'FRUIT' LIMIT 1))
WHERE ProductSubGroupID = 0;

UPDATE tblProductPackage, tblProducts SET
	tblProductPackage.BarCode1 = tblProducts.BarCode,
	tblProductPackage.BarCode2 = tblProducts.BarCode2,
	tblProductPackage.BarCode3 = tblProducts.BarCode3,
	tblProductPackage.Price = tblProducts.Price,
	tblProductPackage.PurchasePrice = tblProducts.PurchasePrice
WHERE tblProducts.ProductID = tblProductPackage.ProductID
	AND tblProducts.BaseUnitID = tblProductPackage.UnitID
	AND tblProducts.ProductCode IN (SELECT DISTINCT(name) FROM tblMerchWeighted);


SELECT Name, Name, BarCode, pluno,  ProductSubGroupID, 1, a.Price, a.Price, 1, 1 FROM tblMerchWeighted a INNER JOIN tblProductSubGroup b ON b.ProductSubGroupName  = concat(a.GroupName, ' - mode=',mode) 
WHERE NAME IN (SELECT DISTINCT(ProductCode) FROM tblProducts) GROUP BY Name;


SELECT ProductCOde, Barcode, barcode2, price, ProductSubGroupID from tblproducts where ProductCode in
	(select distinct(name) from tblMerchWeighted)



-- 23Mar2015 : Fixed the OldGrandTotal as per request and given by Joanne.

select Terminalno, OldGrandTotal, ActualOldGrandTotal, newgrandtotal, datelastinitialized from tblterminalreporthistory where datelastinitialized >= '2015-01-30' 
order by date_format(datelastinitialized,'%y-%m-%d'), terminalno limit 20;

UPDATE tblterminalReporthistory SET OldGrandTotal = 44584144.05 WHERE date_format(datelastinitialized,'%y-%m-%d') = '2015-02-01' AND TerminalNo = 1;
UPDATE tblterminalReporthistory SET OldGrandTotal = 45236928.72 WHERE date_format(datelastinitialized,'%y-%m-%d') = '2015-02-01' AND TerminalNo = 2;
UPDATE tblterminalReporthistory SET OldGrandTotal = 46324453.99 WHERE date_format(datelastinitialized,'%y-%m-%d') = '2015-02-01' AND TerminalNo = 3;
UPDATE tblterminalReporthistory SET OldGrandTotal = 38137644.53 WHERE date_format(datelastinitialized,'%y-%m-%d') = '2015-02-01' AND TerminalNo = 4;
UPDATE tblterminalReporthistory SET OldGrandTotal = 30395591.26 WHERE date_format(datelastinitialized,'%y-%m-%d') = '2015-02-01' AND TerminalNo = 5;
UPDATE tblterminalReporthistory SET OldGrandTotal = 14190500.74 WHERE date_format(datelastinitialized,'%y-%m-%d') = '2015-02-01' AND TerminalNo = 6;
UPDATE tblterminalReporthistory SET OldGrandTotal = 7929856.04 WHERE date_format(datelastinitialized,'%y-%m-%d') = '2015-02-01' AND TerminalNo = 7;
UPDATE tblterminalReporthistory SET OldGrandTotal = 9702735.23 WHERE date_format(datelastinitialized,'%y-%m-%d') = '2015-02-01' AND TerminalNo = 8;
UPDATE tblterminalReporthistory SET OldGrandTotal =6867161.95 WHERE date_format(datelastinitialized,'%y-%m-%d') = '2015-02-01' AND TerminalNo = 9;