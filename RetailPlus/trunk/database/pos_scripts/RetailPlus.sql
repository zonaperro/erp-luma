/******************************************************************************
**		File: RetailPlus.sql
**		Name: RetailPlus
**		Desc: RetailPlus
**
**		Auth: Lem E. Aceron
**		Date: 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**    
*******************************************************************************/ 

USE mysql;


DROP DATABASE IF EXISTS pos;

CREATE DATABASE pos;

GRANT ALL PRIVILEGES ON pos.* TO POSAuditUser IDENTIFIED BY 'posauditpwd' WITH GRANT OPTION;
FLUSH PRIVILEGES;

GRANT ALL PRIVILEGES ON pos.* TO POSUser IDENTIFIED BY 'pospwd' WITH GRANT OPTION;
FLUSH PRIVILEGES;

DELETE FROM mysql.user WHERE user = '' OR user = null;
UPDATE mysql.user SET password = PASSWORD('pospwd') WHERE user = 'POSUser';

UPDATE mysql.user SET password = PASSWORD('pospwd') WHERE user = 'root';

UPDATE mysql.user SET host = '%' WHERE user = 'root' and host ='127.0.0.1';


DELETE FROM  mysql.user WHERE host = 'localhost';
FLUSH PRIVILEGES;

USE pos;

/*****************************
**	tblCountry
*****************************/
DROP TABLE IF EXISTS tblCountry;
CREATE TABLE tblCountry (
	`CountryID` TINYINT(1) UNSIGNED NOT NULL AUTO_INCREMENT,
	`CountryName` VARCHAR(120) NOT NULL,
	PRIMARY KEY (CountryID),
	INDEX `IX_tblCountry`(`CountryID`, `CountryName`),
	UNIQUE `PK_tblCountry`(`CountryName`)
);

/*****************************
**	sysAccessUser
*****************************/
DROP TABLE IF EXISTS sysAccessUsers;
CREATE TABLE sysAccessUsers (
	`UID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`UserName` VARCHAR(25) NOT NULL UNIQUE,
	`Password` VARCHAR(25) NOT NULL,
	`DateCreated` DATETIME NOT NULL,
	`Deleted` TINYINT(1) NOT NULL DEFAULT 0,
	PRIMARY KEY (UID),
	INDEX `IX_sysAccessUser`(`UID`, `UserName`),
	UNIQUE `PK_sysAccessUser`(`UserName`)
);

/*****************************
**	sysAccessGroups
*****************************/
DROP TABLE IF EXISTS sysAccessGroups;
CREATE TABLE sysAccessGroups (
	`GroupID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`GroupName` VARCHAR(20) NOT NULL,
	`Remarks` VARCHAR(200),
	PRIMARY KEY (GroupID),
	INDEX `IX_sysAccessGroups`(`GroupID`, `GroupName`),
	UNIQUE `PK_sysAccessGroups`(`GroupName`)
);

/*****************************
**	sysAccessDetails
*****************************/
DROP TABLE IF EXISTS sysAccessUserDetails;
CREATE TABLE sysAccessUserDetails (
	`UID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`Name` VARCHAR (160) NULL,
	`Address1` VARCHAR (150) NULL,
	`Address2` VARCHAR (150) NULL,
	`City` VARCHAR (30) NULL,
	`State` VARCHAR (30) NULL,
	`Zip` VARCHAR (15) NULL,
	`CountryID` TINYINT NOT NULL DEFAULT 0,
	`OfficePhone` VARCHAR (150) NOT NULL DEFAULT '---',
	`DirectPhone` VARCHAR (150) NOT NULL DEFAULT '---',
	`HomePhone` VARCHAR (150) NOT NULL DEFAULT '---',
	`FaxPhone` VARCHAR (150) NOT NULL DEFAULT '---',
	`MobilePhone` VARCHAR (150) NOT NULL DEFAULT '---',
	`EmailAddress` VARCHAR (150) NOT NULL DEFAULT '',
	`GroupID` INT(10) UNSIGNED NOT NULL DEFAULT 0,
	INDEX `IX_sysAccessUserDetails`(`UID`, `Name`),
	UNIQUE `PK_sysAccessUserDetails`(`Name`),
	INDEX `IX1_sysAccessUserDetails`(`UID`),
	INDEX `IX2_sysAccessUserDetails`(`GroupID`)
);

/*****************************
**	sysAccessTypes
*****************************/
DROP TABLE IF EXISTS sysAccessTypes;
CREATE TABLE sysAccessTypes (
	`TypeID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`TypeName` VARCHAR(80) NOT NULL,
	`Remarks` VARCHAR(120),
	PRIMARY KEY (TypeID),
	INDEX `IX_sysAccessTypes`(`TypeID`, `TypeName`),
	UNIQUE `PK_sysAccessTypes`(`TypeName`)
);

/*****************************
**	sysAccessRights
*****************************/
DROP TABLE IF EXISTS sysAccessRights;
CREATE TABLE sysAccessRights (
	`UID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`TranTypeID` INT(10) UNSIGNED NOT NULL DEFAULT 0,
	`AllowRead` TINYINT(1) NOT NULL DEFAULT 0,
	`AllowWrite` TINYINT(1) NOT NULL DEFAULT 0,
	INDEX `IX_sysAccessTypes`(`UID`, `TranTypeID`),
	UNIQUE `PK_sysAccessTypes`(`UID`, `TranTypeID`),
	INDEX `IX1_sysAccessTypes`(`UID`),
	INDEX `IX2_sysAccessTypes`(`TranTypeID`)
);

/*****************************
**	sysAccessGroupRights
*****************************/
DROP TABLE IF EXISTS sysAccessGroupRights;
CREATE TABLE sysAccessGroupRights (
	`GroupID` INT(10) UNSIGNED NOT NULL DEFAULT 0,
	`TranTypeID` INT(10) UNSIGNED NOT NULL DEFAULT 0,
	`AllowRead` TINYINT(1) NOT NULL DEFAULT 0,
	`AllowWrite` TINYINT(1) NOT NULL DEFAULT 0,
	INDEX `IX_sysAccessGroupRights`(`GroupID`, `TranTypeID`),
	UNIQUE `PK_ssysAccessGroupRights`(`GroupID`, `TranTypeID`),
	INDEX `IX1_sysAccessGroupRights`(`GroupID`),
	INDEX `IX2_sysAccessGroupRights`(`TranTypeID`)
);

/*****************************
**	sysAuditTrail
*****************************/
DROP TABLE IF EXISTS sysAuditTrail;
CREATE TABLE sysAuditTrail (
	`ActivityDate` DATETIME NOT NULL,
	`User` VARCHAR(80) NOT NULL,
	`Activity` VARCHAR(120),
	`IPAddress` VARCHAR(15),
	`Remarks` VARCHAR (8000),
	INDEX `IX_sysAuditTrail`(`ActivityDate`, `User`)
);

/*****************************
**	tblCashierLogs
*****************************/
DROP TABLE IF EXISTS tblCashierLogs;
CREATE TABLE tblCashierLogs (
	`CashierLogsID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`UID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`LoginDate` DATETIME NOT NULL,
	`TerminalNo` VARCHAR(5),
	`IPAddress` VARCHAR(15),
	`LogoutDate` DATETIME,
	`Status` TINYINT(3),
	PRIMARY KEY (`CashierLogsID`),
	INDEX `IX_tblCashierLogs`(`CashierLogsID`),
	UNIQUE `PK_tblCashierLogs`(`CashierLogsID`),
	INDEX `IX1_tblCashierLogs`(`UID`),
	INDEX `IX2_tblCashierLogs`(`UID`, `LoginDate`),
	INDEX `IX3_tblCashierLogs`(`UID`, `LoginDate`, `TerminalNo`),
	INDEX `IX4_tblCashierLogs`(`UID`, `TerminalNo`)
);

/*****************************
**	tblContactGroup
*****************************/
DROP TABLE IF EXISTS tblContactGroup;
CREATE TABLE tblContactGroup (
	`ContactGroupID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`ContactGroupCode` VARCHAR(3) NOT NULL,
	`ContactGroupName` VARCHAR(30) NOT NULL,
	`ContactGroupCategory` TINYINT(1) NOT NULL DEFAULT 3,
	PRIMARY KEY (`ContactGroupID`),
	INDEX `IX_tblContactGroup`(`ContactGroupID`, `ContactGroupCode`, `ContactGroupName`),
	UNIQUE `PK_tblContactGroup`(`ContactGroupCode`)
);

INSERT INTO tblContactGroup (ContactGroupCode, ContactGroupName, ContactGroupCategory) VALUES ('CUS', 'Default Customer Group', 1);
INSERT INTO tblContactGroup (ContactGroupCode, ContactGroupName, ContactGroupCategory) VALUES ('SUP', 'Default Supplier Group', 2);

/*****************************
**	tblContacts
*****************************/
DROP TABLE IF EXISTS tblContacts;
CREATE TABLE tblContacts (
	`ContactID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`ContactCode` VARCHAR(25) NOT NULL,
	`ContactName` VARCHAR(75) NOT NULL,
	`ContactGroupID` INT(10) UNSIGNED DEFAULT 0,
	`ModeOfTerms` INT(10) NOT NULL DEFAULT 0,
	`Terms` INT(10) NOT NULL DEFAULT 0,
	`Address` VARCHAR(150) NOT NULL DEFAULT '',
	`BusinessName` VARCHAR(75) NOT NULL DEFAULT '',
	`TelephoneNo` VARCHAR(75) NOT NULL DEFAULT '',
	`Remarks` VARCHAR(150) NOT NULL DEFAULT '',
	`Debit` decimal(18,3) NOT NULL DEFAULT 0,
	`Credit` decimal(18,3) NOT NULL DEFAULT 0,
	`CreditLimit` decimal(18,3) NOT NULL DEFAULT 0,
	`IsCreditAllowed` TINYINT(1) NOT NULL DEFAULT 0,
	`DateCreated` DATETIME NOT NULL,
	`Deleted` TINYINT(1) NOT NULL DEFAULT 0,
	PRIMARY KEY (ContactID),
	INDEX `IX_tblContacts`(`ContactID`, `ContactCode`, `ContactName`),
	UNIQUE `PK_tblContacts`(`ContactCode`),
	INDEX `IX1_tblContacts`(`ContactGroupID`)
) ;

INSERT INTO tblContacts (ContactID, ContactCode, ContactName, ContactGroupID, ModeOfTerms, Address, BusinessName, TelephoneNo, Remarks, DateCreated) VALUES
(1, 'RC', 'RetailPlus Customer �', 1, 0, 'RBS', 'RBS', '', '', NOW());
INSERT INTO tblContacts (ContactID, ContactCode, ContactName, ContactGroupID, ModeOfTerms, Address, BusinessName, TelephoneNo, Remarks, DateCreated) VALUES
(2, 'RS', 'RetailPlus Supplier �', 2, 0, 'RBS', 'RBS', '', '', NOW());
INSERT INTO tblContacts (ContactID, ContactCode, ContactName, ContactGroupID, ModeOfTerms, Address, BusinessName, TelephoneNo, Remarks, DateCreated) VALUES
(3, 'RA', 'RetailPlus Agent �', 3, 0, 'RBS', 'RBS', '', '', NOW());

/*****************************
**	tblUnit
*****************************/
DROP TABLE IF EXISTS tblUnit;
CREATE TABLE tblUnit (
	`UnitID` INT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
	`UnitCode` VARCHAR(3) NOT NULL,
	`UnitName` VARCHAR(30) NOT NULL,
	PRIMARY KEY (UnitID),
	INDEX `IX_tblUnit`(`UnitID`, `UnitCode`, `UnitName`),
	UNIQUE `PK_tblUnit`(`UnitCode`)
);

/*****************************
**	tblVariations
*****************************/
DROP TABLE IF EXISTS tblVariations;
CREATE TABLE tblVariations (
	`VariationID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`VariationCode` VARCHAR(3) NOT NULL,
	`VariationType` VARCHAR(20) NOT NULL,
	PRIMARY KEY (VariationID),
	INDEX `IX_tblVariations`(`VariationID`, `VariationCode`, `VariationType`),
	UNIQUE `PK_tblVariations`(`VariationCode`)
);

/*****************************
**	tblChargeType
*****************************/
DROP TABLE IF EXISTS tblChargeType;
CREATE TABLE tblChargeType (
	`ChargeTypeID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`ChargeTypeCode` VARCHAR(3) NOT NULL,
	`ChargeType` VARCHAR(20) NOT NULL,
	`ChargeAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`InPercent` TINYINT(1) NOT NULL DEFAULT 0,
	PRIMARY KEY (ChargeTypeID),
	INDEX `IX_tblChargeType`(`ChargeTypeID`, `ChargeTypeCode`, `ChargeType`),
	UNIQUE `PK_tblChargeType`(`ChargeTypeCode`),
	INDEX `IX1_tblChargeType`(`ChargeTypeID`),
	INDEX `IX2_tblChargeType`(`ChargeTypeCode`),
	INDEX `IX3_tblChargeType`(`ChargeType`),
	INDEX `IX4_tblChargeType`(`ChargeTypeCode`, `ChargeType`),
	INDEX `IX5_tblChargeType`(`InPercent`)
);

/*****************************
**	tblProductGroup
*****************************/
DROP TABLE IF EXISTS tblProductGroup;
CREATE TABLE tblProductGroup (
	`ProductGroupID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`ProductGroupCode` VARCHAR(20) NOT NULL,
	`ProductGroupName` VARCHAR(50) NOT NULL,
	`BaseUnitID` INT(10) UNSIGNED NOT NULL DEFAULT 0,
	`Price` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PurchasePrice` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`IncludeInSubtotalDiscount` TINYINT(1) NOT NULL DEFAULT 1,
	`VAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`LocalTax` DECIMAL(18,3) NOT NULL DEFAULT 0,
	PRIMARY KEY (ProductGroupID),
	INDEX `IX_tblProductGroup`(`ProductGroupID`, `ProductGroupCode`, `ProductGroupName`),
	UNIQUE `PK_tblProductGroup`(`ProductGroupCode`),
	INDEX `IX1_tblProductGroup`(`BaseUnitID`)
);

/*****************************
**	tblProductGroupVariations
*****************************/
DROP TABLE IF EXISTS tblProductGroupVariations;
CREATE TABLE tblProductGroupVariations (
	`GroupID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`VariationID` INT(10) UNSIGNED NOT NULL DEFAULT 0,
	INDEX `IX_tblProductGroupVariations`(`GroupID`, `VariationID`),
	UNIQUE `PK_tblProductGroupVariations`(`GroupID`, `VariationID`),
	INDEX `IX1_tblProductGroupVariations`(`VariationID`),
	INDEX `IX2_tblProductGroupVariations`(`GroupID`)
);


/*****************************
**	tblProductGroupBaseVariationsMatrix
*****************************/
DROP TABLE IF EXISTS tblProductGroupBaseVariationsMatrix;
CREATE TABLE tblProductGroupBaseVariationsMatrix (
	`MatrixID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`GroupID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`Description` VARCHAR(255) NOT NULL,
	`UnitID` INT(3) UNSIGNED NOT NULL DEFAULT 0,
	`Price` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PurchasePrice` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`IncludeInSubtotalDiscount` TINYINT(1) NOT NULL DEFAULT 1,
	`VAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`LocalTax` DECIMAL(18,3) NOT NULL DEFAULT 0,
	INDEX `IX_tblProductGroupBaseVariationsMatrix`(`MatrixID`,`GroupID`),
	UNIQUE `PK_tblProductGroupBaseVariationsMatrix`(`GroupID`,`Description`),
	INDEX `IX1_tblProductGroupBaseVariationsMatrix`(`GroupID`),
	INDEX `IX2_tblProductGroupBaseVariationsMatrix`(`UnitID`)
);


/*****************************
**	tblProductGroupVariationsMatrix
*****************************/
DROP TABLE IF EXISTS tblProductGroupVariationsMatrix;
CREATE TABLE tblProductGroupVariationsMatrix (
	`MatrixID` INT(10) UNSIGNED NOT NULL DEFAULT 0,
	`VariationID` INT(10) UNSIGNED NOT NULL DEFAULT 0,
	`Description` VARCHAR(150) NOT NULL,
	INDEX `IX_tblProductGroupVariationsMatrix`(`MatrixID`,`VariationID`),
	UNIQUE `PK_tblProductGroupVariationsMatrix`(`MatrixID`, `VariationID`, `Description`),
	INDEX `IX1_tblProductGroupVariationsMatrix`(`VariationID`),
	INDEX `IX2_tblProductGroupVariationsMatrix`(`MatrixID`)
);

/*****************************
**	tblProductGroupUnitMatrix
** Product Group Unit Matrix for inventoy purpose
*****************************/
DROP TABLE IF EXISTS tblProductGroupUnitMatrix;
CREATE TABLE tblProductGroupUnitMatrix (
	`MatrixID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`GroupID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`BaseUnitID` INT(10) UNSIGNED NOT NULL DEFAULT 0,
	`BaseUnitValue` DECIMAL(18,3) NOT NULL DEFAULT 1,
	`BottomUnitID` INT(10) UNSIGNED NOT NULL DEFAULT 0,
	`BottomUnitValue` DECIMAL(18,3) NOT NULL DEFAULT 1,
	INDEX `IX_tblProductGroupUnitMatrix`(`MatrixID`, `GroupID`, `BaseUnitID`, `BottomUnitID`),
	UNIQUE `PX_tblProductGroupUnitMatrix`(`GroupID`, `BaseUnitID`, `BottomUnitID`),
	INDEX `IX1_tblProductGroupUnitMatrix`(`BaseUnitID`),
	INDEX `IX2_tblProductGroupUnitMatrix`(`BottomUnitID`),
	INDEX `IX3_tblProductGroupUnitMatrix`(`GroupID`)
);

/*****************************
**	tblProductGroupCharges
*****************************/
DROP TABLE IF EXISTS tblProductGroupCharges;
CREATE TABLE tblProductGroupCharges (
	`ChargeID`		BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`GroupID`		BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`ChargeTypeID`	INT(10) UNSIGNED NOT NULL DEFAULT 0,
	`ChargeAmount`	DECIMAL(18,3) NOT NULL DEFAULT 0,
	`InPercent`		TINYINT(1) NOT NULL DEFAULT 0,
	INDEX `IX_tblProductGroupCharges`(`ChargeID`),
	UNIQUE `PK_tblProductGroupCharges`(`ChargeID`),
	INDEX `IX1_tblProductGroupCharges`(`GroupID`, `ChargeTypeID`),
	UNIQUE `PK1_tblProductGroupCharges`(`GroupID`, `ChargeTypeID`),
	INDEX `IX2_tblProductGroupCharges`(`ChargeTypeID`),
	INDEX `IX3_tblProductGroupCharges`(`GroupID`)
);

/*****************************
**	tblProductSubGroup
*****************************/
DROP TABLE IF EXISTS tblProductSubGroup;
CREATE TABLE tblProductSubGroup (
	`ProductSubGroupID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`ProductGroupID` INT(10) UNSIGNED NOT NULL,
	`ProductSubGroupCode` VARCHAR(20) NOT NULL,
	`ProductSubGroupName` VARCHAR(50) NOT NULL,
	`BaseUnitID` INT(10) UNSIGNED NOT NULL DEFAULT 0,
	`Price` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PurchasePrice` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`IncludeInSubtotalDiscount` TINYINT(1) NOT NULL DEFAULT 1,
	`VAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`LocalTax` DECIMAL(18,3) NOT NULL DEFAULT 0,
	PRIMARY KEY (ProductSubGroupID),
	INDEX `IX_tblProductSubGroup`(`ProductSubGroupID`, `ProductSubGroupCode`, `ProductSubGroupName`),
	UNIQUE `PK_tblProductSubGroup`(`ProductGroupID`, `ProductSubGroupCode`),
	INDEX `IX1_tblProductSubGroup`(`BaseUnitID`)
);

/*****************************
**	tblProductSubGroupVariations
*****************************/
DROP TABLE IF EXISTS tblProductSubGroupVariations;
CREATE TABLE tblProductSubGroupVariations (
	`SubGroupID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`VariationID` INT(10) UNSIGNED NOT NULL DEFAULT 0,
	INDEX `IX_tblProductSubGroupVariations`(`SubGroupID`, `VariationID`),
	UNIQUE `PK_tblProductSubGroupVariations`(`SubGroupID`, `VariationID`),
	INDEX `IX1_tblProductSubGroupVariations`(`VariationID`),
	INDEX `IX2_tblProductSubGroupVariations`(`SubGroupID`)
);

/*****************************
**	tblProductSubGroupBaseVariationsMatrix
*****************************/
DROP TABLE IF EXISTS tblProductSubGroupBaseVariationsMatrix;
CREATE TABLE tblProductSubGroupBaseVariationsMatrix (
	`MatrixID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`SubGroupID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`Description` VARCHAR(255) NOT NULL,
	`UnitID` INT(3) UNSIGNED NOT NULL DEFAULT 0,
	`Price` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PurchasePrice` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`IncludeInSubtotalDiscount` TINYINT(1) NOT NULL DEFAULT 1,
	`VAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`LocalTax` DECIMAL(18,3) NOT NULL DEFAULT 0,
	INDEX `IX_tblProductSubGroupBaseVariationsMatrix`(`MatrixID`,`SubGroupID`),
	UNIQUE `PK_tblProductSubGroupBaseVariationsMatrix`(`SubGroupID`,`Description`),
	INDEX `IX1_tblProductSubGroupBaseVariationsMatrix`(`SubGroupID`),
	INDEX `IX2_tblProductSubGroupBaseVariationsMatrix`(`UnitID`)
);

/*****************************
**	tblProductSubGroupVariationsMatrix
*****************************/
DROP TABLE IF EXISTS tblProductSubGroupVariationsMatrix;
CREATE TABLE tblProductSubGroupVariationsMatrix (
	`MatrixID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`VariationID` INT(10) UNSIGNED NOT NULL DEFAULT 0,
	`Description` VARCHAR(150) NOT NULL,
	INDEX `IX_tblProductSubGroupVariationsMatrix`(`MatrixID`,`VariationID`),
	UNIQUE `PK_tblProductSubGroupVariationsMatrix`(`MatrixID`, `VariationID`, `Description`),
	INDEX `IX1_tblProductSubGroupVariationsMatrix`(`VariationID`),
	INDEX `IX2_tblProductSubGroupVariationsMatrix`(`MatrixID`)
);

/*****************************
**	tblProductSubGroupUnitMatrix
*****************************/
DROP TABLE IF EXISTS tblProductSubGroupUnitMatrix;
CREATE TABLE tblProductSubGroupUnitMatrix (
	`MatrixID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`SubGroupID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`BaseUnitID` INT(10) UNSIGNED NOT NULL DEFAULT 0,
	`BaseUnitValue` DECIMAL(18,3) NOT NULL DEFAULT 1,
	`BottomUnitID` INT(10) UNSIGNED NOT NULL DEFAULT 0,
	`BottomUnitValue` DECIMAL(18,3) NOT NULL DEFAULT 1,
	INDEX `IX_tblProductSubGroupUnitMatrix`(`MatrixID`, `SubGroupID`, `BaseUnitID`, `BottomUnitID`),
	UNIQUE `PX_tblProductUnitMatrix`(`SubGroupID`, `BaseUnitID`, `BottomUnitID`),
	INDEX `IX1_tblProductSubGroupUnitMatrix`(`BaseUnitID`),
	INDEX `IX2_tblProductSubGroupUnitMatrix`(`BottomUnitID`),
	INDEX `IX3_tblProductSubGroupUnitMatrix`(`SubGroupID`)
);

/*****************************
**	tblProductSubGroupCharges
*****************************/
DROP TABLE IF EXISTS tblProductSubGroupCharges;
CREATE TABLE tblProductSubGroupCharges (
	`ChargeID`		BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`SubGroupID`	BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`ChargeTypeID`	INT(10) UNSIGNED NOT NULL DEFAULT 0,
	`ChargeAmount`	DECIMAL(18,3) NOT NULL DEFAULT 0,
	`InPercent`		TINYINT(1) NOT NULL DEFAULT 0,
	INDEX `IX_tblProductSubGroupCharges`(`ChargeID`),
	UNIQUE `PK_tblProductSubGroupCharges`(`ChargeID`),
	INDEX `IX1_tblProductSubGroupCharges`(`SubGroupID`, `ChargeTypeID`),
	UNIQUE `PK1_tblProductSubGroupCharges`(`SubGroupID`, `ChargeTypeID`),
	INDEX `IX2_tblProductSubGroupCharges`(`ChargeTypeID`),
	INDEX `IX3_tblProductSubGroupCharges`(`SubGroupID`)
);

/*****************************
**	tblProducts
*****************************/
DROP TABLE IF EXISTS tblProducts;
CREATE TABLE tblProducts (
	`ProductID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`ProductCode` VARCHAR(30) NOT NULL,
	`BarCode` VARCHAR(30) NOT NULL,
	`ProductDesc` VARCHAR(50) NOT NULL,
	`ProductSubGroupID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`BaseUnitID` INT(10) UNSIGNED NOT NULL DEFAULT 0,
	`DateCreated` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`Deleted` TINYINT(1) NOT NULL DEFAULT 0,
	`Price` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PurchasePrice` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`IncludeInSubtotalDiscount` TINYINT(1) NOT NULL DEFAULT 1,
	`Quantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`LocalTax` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`MinThreshold` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`MaxThreshold` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`SupplierID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 2,
	PRIMARY KEY (ProductID),
	INDEX `IX_tblProducts`(`ProductID`, `ProductCode`),
	UNIQUE `PK_tblProducts`(`ProductCode`),
	INDEX `IX1_tblProducts`(`BarCode`),
	UNIQUE `PK1_tblProducts`(`BarCode`),
	INDEX `IX2_tblProducts`(`ProductSubGroupID`),
	INDEX `IX3_tblProducts`(`BaseUnitID`),
	INDEX `IX4_tblProducts`(`SupplierID`)
);

/*****************************
**	tblProductVariations
*****************************/
DROP TABLE IF EXISTS tblProductVariations;
CREATE TABLE tblProductVariations (
	`ProductID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`VariationID` INT(10) UNSIGNED NOT NULL DEFAULT 0,
	INDEX `IX_tblProductVariations`(`ProductID`, `VariationID`),
	UNIQUE `PK_tblProductVariations`(`ProductID`, `VariationID`),
	INDEX `IX1_tblProductVariations`(`VariationID`)
);

/*****************************
**	tblProductBaseVariationsMatrix
*****************************/
DROP TABLE IF EXISTS tblProductBaseVariationsMatrix;
CREATE TABLE tblProductBaseVariationsMatrix (
	`MatrixID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`ProductID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`Description` VARCHAR(255) NOT NULL,
	`UnitID` INT(3) UNSIGNED NOT NULL DEFAULT 0,
	`Price` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PurchasePrice` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`IncludeInSubtotalDiscount` TINYINT(1) NOT NULL DEFAULT 1,
	`Quantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`LocalTax` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`MinThreshold` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`MaxThreshold` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`SupplierID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 2,
	INDEX `IX_tblProductBaseVariationsMatrix`(`MatrixID`,`ProductID`),
	UNIQUE `PK_tblProductBaseVariationsMatrix`(`ProductID`,`Description`),
	INDEX `IX1_tblProductBaseVariationsMatrix`(`ProductID`),
	INDEX `IX2_tblProductBaseVariationsMatrix`(`UnitID`),
	INDEX `IX3_tblProductBaseVariationsMatrix`(`SupplierID`)
);

/*****************************
**	tblProductVariationsMatrix
*****************************/
DROP TABLE IF EXISTS tblProductVariationsMatrix;
CREATE TABLE tblProductVariationsMatrix (
	`MatrixID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`VariationID` INT(10) UNSIGNED NOT NULL DEFAULT 0,
	`Description` VARCHAR(150) NOT NULL,
	INDEX `IX_tblProductVariationsMatrix`(`MatrixID`,`VariationID`),
	UNIQUE `PK_tblProductVariationsMatrix`(`MatrixID`, `VariationID`, `Description`),
	INDEX `IX1_tblProductVariationsMatrix`(`MatrixID`),
	INDEX `IX2_tblProductVariationsMatrix`(`VariationID`)
);

/*****************************
**	tblProductUnitMatrix
*****************************/
DROP TABLE IF EXISTS tblProductUnitMatrix;
CREATE TABLE tblProductUnitMatrix (
	`MatrixID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`ProductID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`BaseUnitID` INT(10) UNSIGNED NOT NULL DEFAULT 0,
	`BaseUnitValue` DECIMAL(18,3) NOT NULL DEFAULT 1,
	`BottomUnitID` INT(10) UNSIGNED NOT NULL DEFAULT 0,
	`BottomUnitValue` DECIMAL(18,3) NOT NULL DEFAULT 1,
	INDEX `IX_tblProductUnitMatrix`(`MatrixID`, `ProductID`, `BaseUnitID`, `BottomUnitID`),
	UNIQUE `PX_tblProductUnitMatrix`(`ProductID`, `BaseUnitID`, `BottomUnitID`),
	INDEX `IX1_tblProductUnitMatrix`(`ProductID`),
	INDEX `IX2_tblProductUnitMatrix`(`BaseUnitID`),
	INDEX `IX3_tblProductUnitMatrix`(`BottomUnitID`)
);

/*****************************
**	tblProductPackage
*****************************/
DROP TABLE IF EXISTS tblProductPackage;
CREATE TABLE tblProductPackage (
	`PackageID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`ProductID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`UnitID` INT(3) UNSIGNED NOT NULL DEFAULT 0,
	`Price` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PurchasePrice` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`Quantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`LocalTax` DECIMAL(18,3) NOT NULL DEFAULT 0,
	INDEX `IX_tblProductPackage`(`PackageID`,`ProductID`),
	UNIQUE `PK_tblProductPackage`(`ProductID`,`UnitID`,`Quantity`),
	INDEX `IX1_tblProductPackage`(`ProductID`),
	INDEX `IX2_tblProductPackage`(`UnitID`)
);

/*****************************
**	tblMatrixPackage
*****************************/
DROP TABLE IF EXISTS tblMatrixPackage;
CREATE TABLE tblMatrixPackage (
	`PackageID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`MatrixID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`UnitID` INT(3) UNSIGNED NOT NULL DEFAULT 0,
	`Price` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PurchasePrice` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`Quantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`LocalTax` DECIMAL(18,3) NOT NULL DEFAULT 0,
	INDEX `IX_tblMatrixPackage`(`PackageID`,`MatrixID`),
	UNIQUE `PK_tblMatrixPackage`(`MatrixID`,`UnitID`,`Quantity`),
	INDEX `IX1_tblMatrixPackage`(`MatrixID`),
	INDEX `IX2_tblMatrixPackage`(`UnitID`)
);

/*****************************
**	tblDiscount
*****************************/
DROP TABLE IF EXISTS tblDiscount;
CREATE TABLE tblDiscount (
	`DiscountID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`DiscountCode` VARCHAR(3) NOT NULL,
	`DiscountType` VARCHAR(30) NOT NULL,
	`DiscountPrice` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`InPercent` TINYINT(1) NOT NULL DEFAULT 0,
	PRIMARY KEY (DiscountID),
	INDEX `IX_tblDiscount`(`DiscountID`, `DiscountCode`, `DiscountType`),
	UNIQUE `PK_tblDiscount`(`DiscountCode`)
);

INSERT INTO tblDiscount(`DiscountCode`, `DiscountType`, `DiscountPrice`, `InPercent`)
		VALUES ('DEF', 'DEFAULT', 0, 0);

/*****************************
**	tblReceiptFormat
*****************************/
DROP TABLE IF EXISTS tblReceiptFormat;
CREATE TABLE tblReceiptFormat (
	`ReportHeaderSpacer` INT(10) NOT NULL DEFAULT 0,
	`ReportHeader1` VARCHAR(70) NOT NULL,
	`ReportHeader2` VARCHAR(70) NOT NULL,
	`ReportHeader3` VARCHAR(70) NOT NULL,
	`ReportHeader4` VARCHAR(70) NOT NULL,
	`PageHeader1` VARCHAR(70) NOT NULL,
	`PageHeader2` VARCHAR(70) NOT NULL,
	`PageHeader3` VARCHAR(70) NOT NULL,
	`PageFooter1` VARCHAR(70) NOT NULL,
	`PageFooter2` VARCHAR(70) NOT NULL,
	`PageFooter3` VARCHAR(70) NOT NULL,
	`ReportFooter1` VARCHAR(70) NOT NULL,
	`ReportFooter2` VARCHAR(70) NOT NULL,
	`ReportFooter3` VARCHAR(70) NOT NULL,
	`ReportFooterSpacer` INT(10) NOT NULL DEFAULT 1,
	INDEX `IX_tblReceiptFormat`(`ReportHeader1`, `ReportHeader2`, `ReportHeader3`, `ReportHeader4`)
);

/*****************************
**	insert the default values
*****************************/
INSERT INTO tblReceiptFormat VALUES (0, '6937 Rosal Street Guadalupe Viejo', 'Makati City, Phil', 
'{DateNow}', '-/-', 
'{InvoiceNo}', '',
'', 'Thank you for shopping.',
'Please Come Again.', '{AccreditationNo}',
'{Cashier}', '{TerminalNo}',
'{MachineSerialNo}',1);

/*****************************
**	tblStockType
*****************************/
DROP TABLE IF EXISTS tblStockType;
CREATE TABLE tblStockType (
	`StockTypeID` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
	`StockTypeCode` VARCHAR(30) NOT NULL,
	`Description` VARCHAR(150) NOT NULL,
	`StockDirection` TINYINT(1) NOT NULL DEFAULT 1,
	INDEX `IX_tblStockType`(`StockTypeID`, `Description`),
	UNIQUE `PX_tblStockType`(`StockTypeCode`),
	INDEX `IX1_tblStockType`(`StockTypeCode`),
	INDEX `IX2_tblStockType`(`Description`)
);

INSERT INTO tblStockType(`StockTypeCode`, `Description`, `StockDirection`)VALUES('Stock In', 'Stock In', 0);
INSERT INTO tblStockType(`StockTypeCode`, `Description`, `StockDirection`)VALUES('Stock Out', 'Stock Out', 1);
INSERT INTO tblStockType(`StockTypeCode`, `Description`, `StockDirection`)VALUES('Incremental Adjustment', 'Incremental Adjustment', 0);
INSERT INTO tblStockType(`StockTypeCode`, `Description`, `StockDirection`)VALUES('Decremental Adjustment', 'Decremental Adjustment', 1);

/*****************************
**	tblStock
*****************************/
DROP TABLE IF EXISTS tblStock;
CREATE TABLE tblStock (
	`StockID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`TransactionNo` VARCHAR(30) NOT NULL,
	`StockTypeID` TINYINT UNSIGNED NOT NULL DEFAULT 0,
	`StockDate` DATETIME NOT NULL,
	`SupplierID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 2,
	`Remarks` VARCHAR(150) NOT NULL,
	INDEX `IX_tblStock`(`StockID`),
	INDEX `IX1_tblStock`(`TransactionNo`),
	UNIQUE `PX_tblStock`(`TransactionNo`),
	INDEX `IX2_tblStock`(`StockDate`),
	INDEX `IX3_tblStock`(`SupplierID`)
);


/*****************************
**	tblStockItems
*****************************/
DROP TABLE IF EXISTS tblStockItems;
CREATE TABLE tblStockItems (
	`StockItemID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`StockID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`ProductID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`VariationMatrixID` INT(10) UNSIGNED NOT NULL DEFAULT 0,
	`ProductUnitID` INT(3) UNSIGNED NOT NULL DEFAULT 0,
	`StockTypeID` TINYINT UNSIGNED NOT NULL DEFAULT 0,
	`StockDate` DATETIME NOT NULL,
	`Quantity` DECIMAL(18,3) UNSIGNED NOT NULL DEFAULT 0,
	`Remarks` VARCHAR(150) NOT NULL,
	INDEX `IX_tblStockItems`(`StockItemID`),
	INDEX `IX1_tblStockItems`(`StockID`, `ProductID`, `ProductUnitID`, `VariationMatrixID`),
	UNIQUE `PX_tblStockItems`(`StockItemID`),
	INDEX `IX2_tblStockItems`(`ProductID`),
	INDEX `IX3_tblStockItems`(`VariationMatrixID`),
	INDEX `IX4_tblStockItems`(`ProductID`, `VariationMatrixID`),
	INDEX `IX5_tblStockItems`(`ProductUnitID`),
	INDEX `IX6_tblStockItems`(`StockID`)
);

/*****************************
**	tblPromoType
*****************************/
DROP TABLE IF EXISTS tblPromoType;
CREATE TABLE tblPromoType (
	`PromoTypeID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`PromoTypeCode` VARCHAR(60) NOT NULL,
	`PromoTypeName` VARCHAR(75) NOT NULL,
	PRIMARY KEY (`PromoTypeID`),
	INDEX `IX_tblPromoType`(`PromoTypeID`, `PromoTypeCode`, `PromoTypeName`),
	UNIQUE `PK_tblPromoType`(`PromoTypeCode`)
);

INSERT INTO tblPromoType VALUES(1, 'Value-Off after quantity reached.', 'Value-Off after quantity reached.');
INSERT INTO tblPromoType VALUES(2, 'Percent-Off after quantity reached.', 'Percent-Off after quantity reached.');


/*****************************
**	tblPromo
*****************************/
DROP TABLE IF EXISTS tblPromo;
CREATE TABLE tblPromo (
	`PromoID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`PromoCode` VARCHAR(60) NOT NULL,
	`PromoName` VARCHAR(75) NOT NULL,
	`StartDate` DATETIME NOT NULL,
	`EndDate` DATETIME NOT NULL,
	`PromoTypeID` INT(10) UNSIGNED NOT NULL DEFAULT 0,
	`Status` TINYINT(1) NOT NULL DEFAULT 0,
	PRIMARY KEY (`PromoID`),
	INDEX `IX_tblPromo`(`PromoID`, `PromoCode`, `PromoName`, `PromoTypeID`),
	UNIQUE `PK_tblPromo`(`PromoCode`),
	INDEX `IX_tblPromo1`(`PromoTypeID`)
);

/*****************************
**	tblPromoItems
*****************************/
DROP TABLE IF EXISTS tblPromoItems;
CREATE TABLE tblPromoItems (
	`PromoItemsID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`PromoID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`ContactID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`ProductGroupID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`ProductSubGroupID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`ProductID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`VariationMatrixID` INT(10) UNSIGNED NOT NULL DEFAULT 0,
	`Quantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PromoValue` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`InPercent` TINYINT(1) NOT NULL DEFAULT 0,
	PRIMARY KEY (`PromoItemsID`),
	INDEX `IX_tblPromoItems`(`PromoID`),
	UNIQUE `PK_tblPromoItems`(`PromoItemsID`),
	UNIQUE `PK_tblPromoItems1`(`PromoID`, `ContactID`, `ProductGroupID`, `ProductSubGroupID`, `ProductID`, `VariationMatrixID`),
	INDEX `IX_tblPromoItems1`(`VariationMatrixID`),
	INDEX `IX_tblPromoItems2`(`ProductGroupID`),
	INDEX `IX_tblPromoItems3`(`ProductSubGroupID`),
	INDEX `IX_tblPromoItems4`(`ProductID`),
	INDEX `IX_tblPromoItems5`(`VariationMatrixID`),
	INDEX `IX_tblPromoItems6`(`ContactID`)
);

/*****************************
**	tblTerminal
*****************************/
DROP TABLE IF EXISTS tblTerminal;
CREATE TABLE tblTerminal (
	`TerminalID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`TerminalNo` VARCHAR(10) NOT NULL,
	`TerminalCode` VARCHAR(20) NOT NULL,
	`TerminalName` VARCHAR(50) NOT NULL,
	`Status` TINYINT(1) NOT NULL DEFAULT 0,
	`DateCreated` DATETIME NOT NULL,
	`IsPrinterAutoCutter` TINYINT(1) NOT NULL DEFAULT 0,
	`MaxReceiptWidth` INT(10) NOT NULL DEFAULT 40,
	`TransactionNoLength` INT(2) NOT NULL DEFAULT 15,
	`AutoPrint` TINYINT(1) NOT NULL DEFAULT 0,
	`PrinterName` VARCHAR(20) NOT NULL DEFAULT 'RetailPlus',
	`TurretName` VARCHAR(20) NOT NULL DEFAULT 'RetailPlusTurret',
	`CashDrawerName` VARCHAR(20) NOT NULL DEFAULT 'RetailPlusDrawer',
	`MachineSerialNo` VARCHAR(20) NOT NULL,
	`AccreditationNo` VARCHAR(20) NOT NULL,
	`ItemVoidConfirmation` TINYINT (1) NOT NULL DEFAULT 1,
	`EnableEVAT` TINYINT(1) NOT NULL DEFAULT 0,
	`FORM_Behavior` VARCHAR(20) NOT NULL DEFAULT 'NON_MODAL',
	`MarqueeMessage` VARCHAR(255) NOT NULL DEFAULT ' Your suggestive selling message and/or description.',
	`TrustFund` DECIMAL(5,2) NOT NULL DEFAULT 0.00,
	PRIMARY KEY (TerminalID),
	INDEX `IX_tblTerminal`(`TerminalID`),
	UNIQUE `PK_tblTerminal`(`TerminalNo`, `MachineSerialNo`),
	INDEX `IX1_tblTerminal`(`TerminalNo`, `TerminalCode`),
	INDEX `IX2_tblTerminal`(`TerminalCode`, `TerminalName`),
	INDEX `IX3_tblTerminal`(`TerminalID`, `TerminalCode`, `TerminalName`)
);

INSERT INTO tblTerminal (`TerminalNo`, `TerminalCode`, `TerminalName`, DateCreated, MachineSerialNo, AccreditationNo )
		VALUES		('01', 'Terminal No. 01', 'Terminal No. 01', NOW(), '000000', '0000-000-00000-000');

/*****************************
**	tblWithHold
*****************************/
DROP TABLE IF EXISTS tblWithHold;
CREATE TABLE tblWithHold (
	`WithholdID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`Amount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PaymentType` INT(10) NOT NULL DEFAULT 0,
	`DateCreated` DATETIME NOT NULL,
	`TerminalNo` VARCHAR(30) NOT NULL,
	`CashierID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	PRIMARY KEY (`WithholdID`),
	INDEX `IX_tblWithHold`(`WithholdID`),
	INDEX `IX1_tblWithHold`(`DateCreated`),
	INDEX `IX2_tblWithHold`(`TerminalNo`),
	INDEX `IX3_tblWithHold`(`DateCreated`, `TerminalNo`),
	INDEX `IX4_tblWithHold`(`CashierID`)
);

/*****************************
**	tblDisburse
*****************************/
DROP TABLE IF EXISTS tblDisburse;
CREATE TABLE tblDisburse (
	`DisburseID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`Amount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PaymentType` INT(10) NOT NULL DEFAULT 0,
	`DateCreated` DATETIME NOT NULL,
	`TerminalNo` VARCHAR(30) NOT NULL,
	`CashierID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	PRIMARY KEY (`DisburseID`),
	INDEX `IX_tblDisburse`(`DisburseID`),
	INDEX `IX1_tblDisburse`(`DateCreated`),
	INDEX `IX2_tblDisburse`(`TerminalNo`),
	INDEX `IX3_tblDisburse`(`DateCreated`, `TerminalNo`),
	INDEX `IX4_tblDisburse`(`CashierID`)
);

/*****************************
**	tblPaidOut
*****************************/
DROP TABLE IF EXISTS tblPaidOut;
CREATE TABLE tblPaidOut (
	`PaidOutID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`Amount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PaymentType` INT(10) NOT NULL DEFAULT 0,
	`Remarks` VARCHAR(150) NOT NULL,
	`DateCreated` DATETIME NOT NULL,
	`TerminalNo` VARCHAR(30) NOT NULL,
	`CashierID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	PRIMARY KEY (`PaidOutID`),
	INDEX `IX_tblPaidOut`(`PaidOutID`),
	INDEX `IX1_tblPaidOut`(`DateCreated`),
	INDEX `IX2_tblPaidOut`(`TerminalNo`),
	INDEX `IX3_tblPaidOut`(`DateCreated`, `TerminalNo`),
	INDEX `IX4_tblPaidOut`(`CashierID`)
);

/*****************************
**	tblCardTypes
*****************************/
DROP TABLE IF EXISTS tblCardTypes;
CREATE TABLE tblCardTypes (
`CardTypeID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
`CardTypeCode` VARCHAR(30) NOT NULL,
`CardTypeName` VARCHAR(30) NOT NULL,
PRIMARY KEY (`CardTypeID`),
INDEX `IX_tblCardTypes`(`CardTypeID`, `CardTypeCode`, `CardTypeName`),
UNIQUE `PK_tblCardTypes`(`CardTypeCode`),
INDEX `IX1_tblCardTypes`(`CardTypeID`),
INDEX `IX2_tblCardTypes`(`CardTypeCode`),
INDEX `IX3_tblCardTypes`(`CardTypeName`)
);

/*****************************
**	tblCashPayment
*****************************/
DROP TABLE IF EXISTS tblCashPayment;
CREATE TABLE tblCashPayment (
`TransactionID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
`Amount`  DECIMAL(18,3) NOT NULL DEFAULT 0,
`Remarks` VARCHAR(255) NOT NULL,
INDEX `IX_tblCashPayment`(`TransactionID`),
INDEX `IX1_tblCashPayment`(`Remarks`)
);

/*****************************
**	tblChequePayment
*****************************/
DROP TABLE IF EXISTS tblChequePayment;
CREATE TABLE tblChequePayment (
`TransactionID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
`ChequeNo` VARCHAR(30) NOT NULL,
`Amount`  DECIMAL(18,3) NOT NULL DEFAULT 0,
`ValidityDate`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
`Remarks` VARCHAR(255) NOT NULL,
INDEX `IX_tblChequePayment`(`TransactionID`),
INDEX `IX1_tblChequePayment`(`ChequeNo`),
INDEX `IX2_tblChequePayment`(`ValidityDate`),
INDEX `IX3_tblChequePayment`(`Remarks`)
);

/*****************************
**	tblCreditCardPayment
*****************************/
DROP TABLE IF EXISTS tblCreditCardPayment;
CREATE TABLE tblCreditCardPayment (
`TransactionID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
`Amount`  DECIMAL(18,3) NOT NULL DEFAULT 0,
`CardTypeID` INT(10) UNSIGNED NOT NULL DEFAULT 0,
`CardTypeCode` VARCHAR(30) NOT NULL,
`CardTypeName` VARCHAR(30) NOT NULL,
`CardNo` VARCHAR(30) NOT NULL,
`CardHolder` VARCHAR(150) NOT NULL,
`ValidityDates` VARCHAR(14) NOT NULL,
`Remarks` VARCHAR(255) NOT NULL,
INDEX `IX_tblCreditCardPayment`(`TransactionID`),
INDEX `IX1_tblCreditCardPayment`(`CardTypeID`),
INDEX `IX2_tblCreditCardPayment`(`CardTypeCode`),
INDEX `IX3_tblCreditCardPayment`(`CardTypeName`),
INDEX `IX4_tblCreditCardPayment`(`CardNo`),
INDEX `IX5_tblCreditCardPayment`(`CardHolder`),
INDEX `IX6_tblCreditCardPayment`(`Remarks`)
);

/*****************************
**	tblCreditPayment
*****************************/
DROP TABLE IF EXISTS tblCreditPayment;
CREATE TABLE tblCreditPayment (
	`TransactionID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`Amount`  DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ContactID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`Remarks` VARCHAR(255) NOT NULL,
	`AmountPaid`  DECIMAL(18,3) NOT NULL DEFAULT 0,
	INDEX `IX_tblCreditPayment`(`TransactionID`),
	INDEX `IX1_tblCreditPayment`(`ContactID`),
	INDEX `IX2_tblCreditPayment`(`Remarks`)
);

/*****************************
**	tblDenomination
*****************************/
DROP TABLE IF EXISTS tblDenomination;
CREATE TABLE tblDenomination (
	`DenominationID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`DenominationCode` VARCHAR(100) NOT NULL,
	`DenominationValue` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ImagePath` VARCHAR(100) NOT NULL,
	PRIMARY KEY (`DenominationID`),
	INDEX `IX_tblDenomination`(`DenominationID`),
	UNIQUE `PX_tblDenomination`(`DenominationCode`),
	INDEX `IX1_tblDenomination`(`DenominationCode`)
);

/*****************************
**	tblCashCount
*****************************/
DROP TABLE IF EXISTS tblCashCount;
CREATE TABLE tblCashCount (
	`CashCountID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`CashierID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`CashierName` VARCHAR(100) NOT NULL,
	`TerminalNo` VARCHAR(30) NOT NULL,
	`DateCreated` DATETIME NOT NULL,
	`DenominationID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`DenominationCount` INT(10) NOT NULL DEFAULT 0,
	`DenominationAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	PRIMARY KEY (`CashCountID`),
	INDEX `IX_tblCashCount`(`CashCountID`),
	UNIQUE `PK_tblCashCount`(`CashCountID`),
	INDEX `IX1_tblCashCount`(`DenominationID`)
);

/*****************************
**	tblTransactionNos
*****************************/
DROP TABLE IF EXISTS tblTransactionNos;
CREATE TABLE tblTransactionNos (
`TransactionNo` VARCHAR(30) NOT NULL,
PRIMARY KEY (`TransactionNo`),
INDEX `IX_tblTransactionNos`(`TransactionNo`),
UNIQUE `PK_tblTransactionNos`(`TransactionNo`)
);

/*****************************
**	tblTransactions01
*****************************/
DROP TABLE IF EXISTS tblTransactions01;
CREATE TABLE tblTransactions01 (
	`TransactionID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`TransactionNo` VARCHAR(30) NOT NULL,
	`CustomerID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`CustomerName` VARCHAR(100) NOT NULL,
	`CashierID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`CashierName` VARCHAR(100) NOT NULL,
	`TerminalNo` VARCHAR(30) NOT NULL,
	`TransactionDate`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00' ,
	`DateSuspended`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`DateResumed`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`TransactionStatus` SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
	`SubTotal` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`Discount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`TransDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`TransDiscountType` INT(10) NOT NULL DEFAULT 0,
	`VAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`LocalTax` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`AmountPaid` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CashPayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ChequePayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CreditCardPayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CreditPayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`BalanceAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ChangeAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`DateClosed`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`PaymentType` INT(10) UNSIGNED NOT NULL DEFAULT 4,
	`DiscountCode` VARCHAR(30),
	`DiscountRemarks` VARCHAR(255),
	PRIMARY KEY (TransactionID),
	INDEX `IX_tblTransactions01`(`TransactionID`, `TransactionNo`),
	UNIQUE `PK_tblTransactions01`(`TransactionID`, `TransactionNo`),
	INDEX `IX1_tblTransactions01`(`TransactionNo`),
	INDEX `IX2_tblTransactions01`(`CustomerID`),
	INDEX `IX3_tblTransactions01`(`CashierID`)
);

/*****************************
**	tblTransactions02
*****************************/
DROP TABLE IF EXISTS tblTransactions02;
CREATE TABLE tblTransactions02 (
	`TransactionID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`TransactionNo` VARCHAR(30) NOT NULL,
	`CustomerID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`CustomerName` VARCHAR(100) NOT NULL,
	`CashierID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`CashierName` VARCHAR(100) NOT NULL,
	`TerminalNo` VARCHAR(30) NOT NULL,
	`TransactionDate`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00' ,
	`DateSuspended`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`DateResumed`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`TransactionStatus` SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
	`SubTotal` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`Discount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`TransDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`TransDiscountType` INT(10) NOT NULL DEFAULT 0,
	`VAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`LocalTax` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`AmountPaid` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CashPayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ChequePayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CreditCardPayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CreditPayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`BalanceAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ChangeAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`DateClosed`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`PaymentType` INT(10) UNSIGNED NOT NULL DEFAULT 4,
	`DiscountCode` VARCHAR(30),
	`DiscountRemarks` VARCHAR(255),
	PRIMARY KEY (TransactionID),
	INDEX `IX_tblTransactions02`(`TransactionID`, `TransactionNo`),
	UNIQUE `PK_tblTransactions02`(`TransactionID`, `TransactionNo`),
	INDEX `IX1_tblTransactions02`(`TransactionNo`),
	INDEX `IX2_tblTransactions02`(`CustomerID`),
	INDEX `IX3_tblTransactions02`(`CashierID`)
);

/*****************************
**	tblTransactions03
*****************************/
DROP TABLE IF EXISTS tblTransactions03;
CREATE TABLE tblTransactions03 (
	`TransactionID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`TransactionNo` VARCHAR(30) NOT NULL,
	`CustomerID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`CustomerName` VARCHAR(100) NOT NULL,
	`CashierID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`CashierName` VARCHAR(100) NOT NULL,
	`TerminalNo` VARCHAR(30) NOT NULL,
	`TransactionDate`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00' ,
	`DateSuspended`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`DateResumed`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`TransactionStatus` SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
	`SubTotal` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`Discount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`TransDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`TransDiscountType` INT(10) NOT NULL DEFAULT 0,
	`VAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`LocalTax` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`AmountPaid` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CashPayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ChequePayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CreditCardPayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CreditPayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`BalanceAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ChangeAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`DateClosed`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`PaymentType` INT(10) UNSIGNED NOT NULL DEFAULT 4,
	`DiscountCode` VARCHAR(30),
	`DiscountRemarks` VARCHAR(255),
	PRIMARY KEY (TransactionID),
	INDEX `IX_tblTransactions03`(`TransactionID`, `TransactionNo`),
	UNIQUE `PK_tblTransactions03`(`TransactionID`, `TransactionNo`),
	INDEX `IX1_tblTransactions03`(`TransactionNo`),
	INDEX `IX2_tblTransactions03`(`CustomerID`),
	INDEX `IX3_tblTransactions03`(`CashierID`)
);

/*****************************
**	tblTransactions04
*****************************/
DROP TABLE IF EXISTS tblTransactions04;
CREATE TABLE tblTransactions04 (
	`TransactionID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`TransactionNo` VARCHAR(30) NOT NULL,
	`CustomerID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`CustomerName` VARCHAR(100) NOT NULL,
	`CashierID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`CashierName` VARCHAR(100) NOT NULL,
	`TerminalNo` VARCHAR(30) NOT NULL,
	`TransactionDate`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00' ,
	`DateSuspended`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`DateResumed`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`TransactionStatus` SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
	`SubTotal` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`Discount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`TransDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`TransDiscountType` INT(10) NOT NULL DEFAULT 0,
	`VAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`LocalTax` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`AmountPaid` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CashPayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ChequePayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CreditCardPayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CreditPayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`BalanceAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ChangeAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`DateClosed`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`PaymentType` INT(10) UNSIGNED NOT NULL DEFAULT 4,
	`DiscountCode` VARCHAR(30),
	`DiscountRemarks` VARCHAR(255),
	PRIMARY KEY (TransactionID),
	INDEX `IX_tblTransactions04`(`TransactionID`, `TransactionNo`),
	UNIQUE `PK_tblTransactions04`(`TransactionID`, `TransactionNo`),
	INDEX `IX1_tblTransactions04`(`TransactionNo`),
	INDEX `IX2_tblTransactions04`(`CustomerID`),
	INDEX `IX3_tblTransactions04`(`CashierID`)
);

/*****************************
**	tblTransactions05
*****************************/
DROP TABLE IF EXISTS tblTransactions05;
CREATE TABLE tblTransactions05 (
	`TransactionID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`TransactionNo` VARCHAR(30) NOT NULL,
	`CustomerID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`CustomerName` VARCHAR(100) NOT NULL,
	`CashierID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`CashierName` VARCHAR(100) NOT NULL,
	`TerminalNo` VARCHAR(30) NOT NULL,
	`TransactionDate`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00' ,
	`DateSuspended`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`DateResumed`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`TransactionStatus` SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
	`SubTotal` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`Discount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`TransDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`TransDiscountType` INT(10) NOT NULL DEFAULT 0,
	`VAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`LocalTax` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`AmountPaid` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CashPayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ChequePayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CreditCardPayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CreditPayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`BalanceAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ChangeAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`DateClosed`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`PaymentType` INT(10) UNSIGNED NOT NULL DEFAULT 4,
	`DiscountCode` VARCHAR(30),
	`DiscountRemarks` VARCHAR(255),
	PRIMARY KEY (TransactionID),
	INDEX `IX_tblTransactions05`(`TransactionID`, `TransactionNo`),
	UNIQUE `PK_tblTransactions05`(`TransactionID`, `TransactionNo`),
	INDEX `IX1_tblTransactions05`(`TransactionNo`),
	INDEX `IX2_tblTransactions05`(`CustomerID`),
	INDEX `IX3_tblTransactions05`(`CashierID`)
);


/*****************************
**	tblTransactions06
*****************************/
DROP TABLE IF EXISTS tblTransactions06;
CREATE TABLE tblTransactions06 (
	`TransactionID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`TransactionNo` VARCHAR(30) NOT NULL,
	`CustomerID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`CustomerName` VARCHAR(100) NOT NULL,
	`CashierID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`CashierName` VARCHAR(100) NOT NULL,
	`TerminalNo` VARCHAR(30) NOT NULL,
	`TransactionDate`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00' ,
	`DateSuspended`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`DateResumed`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`TransactionStatus` SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
	`SubTotal` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`Discount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`TransDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`TransDiscountType` INT(10) NOT NULL DEFAULT 0,
	`VAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`LocalTax` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`AmountPaid` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CashPayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ChequePayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CreditCardPayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CreditPayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`BalanceAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ChangeAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`DateClosed`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`PaymentType` INT(10) UNSIGNED NOT NULL DEFAULT 4,
	`DiscountCode` VARCHAR(30),
	`DiscountRemarks` VARCHAR(255),
	PRIMARY KEY (TransactionID),
	INDEX `IX_tblTransactions06`(`TransactionID`, `TransactionNo`),
	UNIQUE `PK_tblTransactions06`(`TransactionID`, `TransactionNo`),
	INDEX `IX1_tblTransactions06`(`TransactionNo`),
	INDEX `IX2_tblTransactions06`(`CustomerID`),
	INDEX `IX3_tblTransactions06`(`CashierID`)
);

/*****************************
**	tblTransactions07
*****************************/
DROP TABLE IF EXISTS tblTransactions07;
CREATE TABLE tblTransactions07 (
	`TransactionID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`TransactionNo` VARCHAR(30) NOT NULL,
	`CustomerID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`CustomerName` VARCHAR(100) NOT NULL,
	`CashierID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`CashierName` VARCHAR(100) NOT NULL,
	`TerminalNo` VARCHAR(30) NOT NULL,
	`TransactionDate`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00' ,
	`DateSuspended`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`DateResumed`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`TransactionStatus` SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
	`SubTotal` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`Discount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`TransDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`TransDiscountType` INT(10) NOT NULL DEFAULT 0,
	`VAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`LocalTax` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`AmountPaid` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CashPayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ChequePayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CreditCardPayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CreditPayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`BalanceAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ChangeAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`DateClosed`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`PaymentType` INT(10) UNSIGNED NOT NULL DEFAULT 4,
	`DiscountCode` VARCHAR(30),
	`DiscountRemarks` VARCHAR(255),
	PRIMARY KEY (TransactionID),
	INDEX `IX_tblTransactions07`(`TransactionID`, `TransactionNo`),
	UNIQUE `PK_tblTransactions07`(`TransactionID`, `TransactionNo`),
	INDEX `IX1_tblTransactions07`(`TransactionNo`),
	INDEX `IX2_tblTransactions07`(`CustomerID`),
	INDEX `IX3_tblTransactions07`(`CashierID`)
);

/*****************************
**	tblTransactions08
*****************************/
DROP TABLE IF EXISTS tblTransactions08;
CREATE TABLE tblTransactions08 (
	`TransactionID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`TransactionNo` VARCHAR(30) NOT NULL,
	`CustomerID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`CustomerName` VARCHAR(100) NOT NULL,
	`CashierID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`CashierName` VARCHAR(100) NOT NULL,
	`TerminalNo` VARCHAR(30) NOT NULL,
	`TransactionDate`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00' ,
	`DateSuspended`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`DateResumed`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`TransactionStatus` SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
	`SubTotal` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`Discount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`TransDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`TransDiscountType` INT(10) NOT NULL DEFAULT 0,
	`VAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`LocalTax` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`AmountPaid` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CashPayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ChequePayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CreditCardPayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CreditPayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`BalanceAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ChangeAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`DateClosed`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`PaymentType` INT(10) UNSIGNED NOT NULL DEFAULT 4,
	`DiscountCode` VARCHAR(30),
	`DiscountRemarks` VARCHAR(255),
	PRIMARY KEY (TransactionID),
	INDEX `IX_tblTransactions08`(`TransactionID`, `TransactionNo`),
	UNIQUE `PK_tblTransactions08`(`TransactionID`, `TransactionNo`),
	INDEX `IX1_tblTransactions08`(`TransactionNo`),
	INDEX `IX2_tblTransactions08`(`CustomerID`),
	INDEX `IX3_tblTransactions08`(`CashierID`)
);

/*****************************
**	tblTransactions09
*****************************/
DROP TABLE IF EXISTS tblTransactions09;
CREATE TABLE tblTransactions09 (
	`TransactionID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`TransactionNo` VARCHAR(30) NOT NULL,
	`CustomerID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`CustomerName` VARCHAR(100) NOT NULL,
	`CashierID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`CashierName` VARCHAR(100) NOT NULL,
	`TerminalNo` VARCHAR(30) NOT NULL,
	`TransactionDate`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00' ,
	`DateSuspended`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`DateResumed`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`TransactionStatus` SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
	`SubTotal` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`Discount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`TransDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`TransDiscountType` INT(10) NOT NULL DEFAULT 0,
	`VAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`LocalTax` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`AmountPaid` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CashPayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ChequePayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CreditCardPayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CreditPayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`BalanceAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ChangeAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`DateClosed`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`PaymentType` INT(10) UNSIGNED NOT NULL DEFAULT 4,
	`DiscountCode` VARCHAR(30),
	`DiscountRemarks` VARCHAR(255),
	PRIMARY KEY (TransactionID),
	INDEX `IX_tblTransactions09`(`TransactionID`, `TransactionNo`),
	UNIQUE `PK_tblTransactions09`(`TransactionID`, `TransactionNo`),
	INDEX `IX1_tblTransactions09`(`TransactionNo`),
	INDEX `IX2_tblTransactions09`(`CustomerID`),
	INDEX `IX3_tblTransactions09`(`CashierID`)
);

/*****************************
**	tblTransactions10
*****************************/
DROP TABLE IF EXISTS tblTransactions10;
CREATE TABLE tblTransactions10 (
	`TransactionID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`TransactionNo` VARCHAR(30) NOT NULL,
	`CustomerID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`CustomerName` VARCHAR(100) NOT NULL,
	`CashierID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`CashierName` VARCHAR(100) NOT NULL,
	`TerminalNo` VARCHAR(30) NOT NULL,
	`TransactionDate`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00' ,
	`DateSuspended`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`DateResumed`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`TransactionStatus` SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
	`SubTotal` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`Discount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`TransDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`TransDiscountType` INT(10) NOT NULL DEFAULT 0,
	`VAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`LocalTax` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`AmountPaid` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CashPayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ChequePayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CreditCardPayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CreditPayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`BalanceAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ChangeAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`DateClosed`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`PaymentType` INT(10) UNSIGNED NOT NULL DEFAULT 4,
	`DiscountCode` VARCHAR(30),
	`DiscountRemarks` VARCHAR(255),
	PRIMARY KEY (TransactionID),
	INDEX `IX_tblTransactions10`(`TransactionID`, `TransactionNo`),
	UNIQUE `PK_tblTransactions10`(`TransactionID`, `TransactionNo`),
	INDEX `IX1_tblTransactions10`(`TransactionNo`),
	INDEX `IX2_tblTransactions10`(`CustomerID`),
	INDEX `IX3_tblTransactions10`(`CashierID`)
);

/*****************************
**	tblTransactions11
*****************************/
DROP TABLE IF EXISTS tblTransactions11;
CREATE TABLE tblTransactions11 (
	`TransactionID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`TransactionNo` VARCHAR(30) NOT NULL,
	`CustomerID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`CustomerName` VARCHAR(100) NOT NULL,
	`CashierID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`CashierName` VARCHAR(100) NOT NULL,
	`TerminalNo` VARCHAR(30) NOT NULL,
	`TransactionDate`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00' ,
	`DateSuspended`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`DateResumed`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`TransactionStatus` SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
	`SubTotal` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`Discount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`TransDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`TransDiscountType` INT(10) NOT NULL DEFAULT 0,
	`VAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`LocalTax` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`AmountPaid` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CashPayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ChequePayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CreditCardPayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CreditPayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`BalanceAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ChangeAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`DateClosed`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`PaymentType` INT(10) UNSIGNED NOT NULL DEFAULT 4,
	`DiscountCode` VARCHAR(30),
	`DiscountRemarks` VARCHAR(255),
	PRIMARY KEY (TransactionID),
	INDEX `IX_tblTransactions11`(`TransactionID`, `TransactionNo`),
	UNIQUE `PK_tblTransactions11`(`TransactionID`, `TransactionNo`),
	INDEX `IX1_tblTransactions11`(`TransactionNo`),
	INDEX `IX2_tblTransactions11`(`CustomerID`),
	INDEX `IX3_tblTransactions11`(`CashierID`)
);

/*****************************
**	tblTransactions12
*****************************/
DROP TABLE IF EXISTS tblTransactions12;
CREATE TABLE tblTransactions12 (
	`TransactionID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`TransactionNo` VARCHAR(30) NOT NULL,
	`CustomerID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`CustomerName` VARCHAR(100) NOT NULL,
	`CashierID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`CashierName` VARCHAR(100) NOT NULL,
	`TerminalNo` VARCHAR(30) NOT NULL,
	`TransactionDate`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00' ,
	`DateSuspended`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`DateResumed`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`TransactionStatus` SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
	`SubTotal` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`Discount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`TransDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`TransDiscountType` INT(10) NOT NULL DEFAULT 0,
	`VAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`LocalTax` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`AmountPaid` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CashPayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ChequePayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CreditCardPayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CreditPayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`BalanceAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ChangeAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`DateClosed`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`PaymentType` INT(10) UNSIGNED NOT NULL DEFAULT 4,
	`DiscountCode` VARCHAR(30),
	`DiscountRemarks` VARCHAR(255),
	PRIMARY KEY (TransactionID),
	INDEX `IX_tblTransactions12`(`TransactionID`, `TransactionNo`),
	UNIQUE `PK_tblTransactions12`(`TransactionID`, `TransactionNo`),
	INDEX `IX1_tblTransactions12`(`TransactionNo`),
	INDEX `IX2_tblTransactions12`(`CustomerID`),
	INDEX `IX3_tblTransactions12`(`CashierID`)
);

/*****************************
**	tblTransactionItems01
*****************************/
DROP TABLE IF EXISTS tblTransactionItems01;
CREATE TABLE tblTransactionItems01 (
	`TransactionItemsID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`TransactionID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`ProductID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`ProductCode` VARCHAR(30) NOT NULL,
	`BarCode` VARCHAR(30) NOT NULL,
	`Description` VARCHAR(100) NOT NULL,
	`ProductUnitID` INT(3) UNSIGNED NOT NULL DEFAULT 0,
	`ProductUnitCode` VARCHAR(3) NOT NULL,
	`Quantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`Price` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`SellingPrice` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`Discount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ItemDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ItemDiscountType` TINYINT(1) NOT NULL DEFAULT 0,
	`Amount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`LocalTax` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VariationsMatrixID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`MatrixDescription` VARCHAR(150) NULL,
	`ProductGroup` VARCHAR(20) NULL,
	`ProductSubGroup` VARCHAR(20) NULL,
	`TransactionItemStatus` SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
	`DiscountCode` VARCHAR(30),
	`DiscountRemarks` VARCHAR(255),
	`ProductPackageID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0 ,
	`MatrixPackageID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0 ,
	`PackageQuantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PromoQuantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PromoValue` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PromoInPercent` TINYINT(1) NOT NULL DEFAULT 0,
	`PromoType` TINYINT(1) NOT NULL DEFAULT 0,
	`PromoApplied` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PurchasePrice` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PurchaseAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`IncludeInSubtotalDiscount` TINYINT(1) NOT NULL DEFAULT 1,
	PRIMARY KEY (TransactionItemsID),
	INDEX `IX_tblTransactionItems01`(`TransactionItemsID`),
	INDEX `IX0_tblTransactionItems01`(`TransactionID`, `ProductID`),
	INDEX `IX1_tblTransactionItems01`(`TransactionID`, `ProductID`,`VariationsMatrixID`),
	INDEX `IX2_tblTransactionItems01`(`ProductCode`),
	INDEX `IX3_tblTransactionItems01`(`TransactionID`),
	INDEX `IX4_tblTransactionItems01`(`ProductUnitID`)
);

/*****************************
**	tblTransactionItems02
*****************************/
DROP TABLE IF EXISTS tblTransactionItems02;
CREATE TABLE tblTransactionItems02 (
	`TransactionItemsID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`TransactionID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`ProductID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`ProductCode` VARCHAR(30) NOT NULL,
	`BarCode` VARCHAR(30) NOT NULL,
	`Description` VARCHAR(100) NOT NULL,
	`ProductUnitID` INT(3) UNSIGNED NOT NULL DEFAULT 0,
	`ProductUnitCode` VARCHAR(3) NOT NULL,
	`Quantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`Price` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`SellingPrice` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`Discount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ItemDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ItemDiscountType` TINYINT(1) NOT NULL DEFAULT 0,
	`Amount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`LocalTax` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VariationsMatrixID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`MatrixDescription` VARCHAR(150) NULL,
	`ProductGroup` VARCHAR(20) NULL,
	`ProductSubGroup` VARCHAR(20) NULL,
	`TransactionItemStatus` SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
	`DiscountCode` VARCHAR(30),
	`DiscountRemarks` VARCHAR(255),
	`ProductPackageID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0 ,
	`MatrixPackageID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0 ,
	`PackageQuantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PromoQuantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PromoValue` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PromoInPercent` TINYINT(1) NOT NULL DEFAULT 0,
	`PromoType` TINYINT(1) NOT NULL DEFAULT 0,
	`PromoApplied` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PurchasePrice` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PurchaseAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`IncludeInSubtotalDiscount` TINYINT(1) NOT NULL DEFAULT 1,
	PRIMARY KEY (TransactionItemsID),
	INDEX `IX_tblTransactionItems02`(`TransactionItemsID`),
	INDEX `IX0_tblTransactionItems02`(`TransactionID`, `ProductID`),
	INDEX `IX1_tblTransactionItems02`(`TransactionID`, `ProductID`,`VariationsMatrixID`),
	INDEX `IX2_tblTransactionItems02`(`ProductCode`),
	INDEX `IX3_tblTransactionItems02`(`TransactionID`),
	INDEX `IX4_tblTransactionItems02`(`ProductUnitID`)
);

/*****************************
**	tblTransactionItems03
*****************************/
DROP TABLE IF EXISTS tblTransactionItems03;
CREATE TABLE tblTransactionItems03 (
	`TransactionItemsID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`TransactionID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`ProductID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`ProductCode` VARCHAR(30) NOT NULL,
	`BarCode` VARCHAR(30) NOT NULL,
	`Description` VARCHAR(100) NOT NULL,
	`ProductUnitID` INT(3) UNSIGNED NOT NULL DEFAULT 0,
	`ProductUnitCode` VARCHAR(3) NOT NULL,
	`Quantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`Price` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`SellingPrice` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`Discount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ItemDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ItemDiscountType` TINYINT(1) NOT NULL DEFAULT 0,
	`Amount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`LocalTax` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VariationsMatrixID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`MatrixDescription` VARCHAR(150) NULL,
	`ProductGroup` VARCHAR(20) NULL,
	`ProductSubGroup` VARCHAR(20) NULL,
	`TransactionItemStatus` SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
	`DiscountCode` VARCHAR(30),
	`DiscountRemarks` VARCHAR(255),
	`ProductPackageID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0 ,
	`MatrixPackageID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0 ,
	`PackageQuantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PromoQuantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PromoValue` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PromoInPercent` TINYINT(1) NOT NULL DEFAULT 0,
	`PromoType` TINYINT(1) NOT NULL DEFAULT 0,
	`PromoApplied` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PurchasePrice` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PurchaseAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`IncludeInSubtotalDiscount` TINYINT(1) NOT NULL DEFAULT 1,
	PRIMARY KEY (TransactionItemsID),
	INDEX `IX_tblTransactionItems03`(`TransactionItemsID`),
	INDEX `IX0_tblTransactionItems03`(`TransactionID`, `ProductID`),
	INDEX `IX1_tblTransactionItems03`(`TransactionID`, `ProductID`,`VariationsMatrixID`),
	INDEX `IX2_tblTransactionItems03`(`ProductCode`),
	INDEX `IX3_tblTransactionItems03`(`TransactionID`),
	INDEX `IX4_tblTransactionItems03`(`ProductUnitID`)
);

/*****************************
**	tblTransactionItems04
*****************************/
DROP TABLE IF EXISTS tblTransactionItems04;
CREATE TABLE tblTransactionItems04 (
	`TransactionItemsID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`TransactionID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`ProductID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`ProductCode` VARCHAR(30) NOT NULL,
	`BarCode` VARCHAR(30) NOT NULL,
	`Description` VARCHAR(100) NOT NULL,
	`ProductUnitID` INT(3) UNSIGNED NOT NULL DEFAULT 0,
	`ProductUnitCode` VARCHAR(3) NOT NULL,
	`Quantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`Price` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`SellingPrice` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`Discount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ItemDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ItemDiscountType` TINYINT(1) NOT NULL DEFAULT 0,
	`Amount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`LocalTax` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VariationsMatrixID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`MatrixDescription` VARCHAR(150) NULL,
	`ProductGroup` VARCHAR(20) NULL,
	`ProductSubGroup` VARCHAR(20) NULL,
	`TransactionItemStatus` SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
	`DiscountCode` VARCHAR(30),
	`DiscountRemarks` VARCHAR(255),
	`ProductPackageID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0 ,
	`MatrixPackageID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0 ,
	`PackageQuantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PromoQuantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PromoValue` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PromoInPercent` TINYINT(1) NOT NULL DEFAULT 0,
	`PromoType` TINYINT(1) NOT NULL DEFAULT 0,
	`PromoApplied` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PurchasePrice` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PurchaseAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`IncludeInSubtotalDiscount` TINYINT(1) NOT NULL DEFAULT 1,
	PRIMARY KEY (TransactionItemsID),
	INDEX `IX_tblTransactionItems04`(`TransactionItemsID`),
	INDEX `IX0_tblTransactionItems04`(`TransactionID`, `ProductID`),
	INDEX `IX1_tblTransactionItems04`(`TransactionID`, `ProductID`,`VariationsMatrixID`),
	INDEX `IX2_tblTransactionItems04`(`ProductCode`),
	INDEX `IX3_tblTransactionItems04`(`TransactionID`),
	INDEX `IX4_tblTransactionItems04`(`ProductUnitID`)
);

/*****************************
**	tblTransactionItems05
*****************************/
DROP TABLE IF EXISTS tblTransactionItems05;
CREATE TABLE tblTransactionItems05 (
	`TransactionItemsID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`TransactionID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`ProductID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`ProductCode` VARCHAR(30) NOT NULL,
	`BarCode` VARCHAR(30) NOT NULL,
	`Description` VARCHAR(100) NOT NULL,
	`ProductUnitID` INT(3) UNSIGNED NOT NULL DEFAULT 0,
	`ProductUnitCode` VARCHAR(3) NOT NULL,
	`Quantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`Price` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`SellingPrice` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`Discount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ItemDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ItemDiscountType` TINYINT(1) NOT NULL DEFAULT 0,
	`Amount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`LocalTax` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VariationsMatrixID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`MatrixDescription` VARCHAR(150) NULL,
	`ProductGroup` VARCHAR(20) NULL,
	`ProductSubGroup` VARCHAR(20) NULL,
	`TransactionItemStatus` SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
	`DiscountCode` VARCHAR(30),
	`DiscountRemarks` VARCHAR(255),
	`ProductPackageID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0 ,
	`MatrixPackageID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0 ,
	`PackageQuantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PromoQuantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PromoValue` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PromoInPercent` TINYINT(1) NOT NULL DEFAULT 0,
	`PromoType` TINYINT(1) NOT NULL DEFAULT 0,
	`PromoApplied` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PurchasePrice` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PurchaseAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`IncludeInSubtotalDiscount` TINYINT(1) NOT NULL DEFAULT 1,
	PRIMARY KEY (TransactionItemsID),
	INDEX `IX_tblTransactionItems05`(`TransactionItemsID`),
	INDEX `IX0_tblTransactionItems05`(`TransactionID`, `ProductID`),
	INDEX `IX1_tblTransactionItems05`(`TransactionID`, `ProductID`,`VariationsMatrixID`),
	INDEX `IX2_tblTransactionItems05`(`ProductCode`),
	INDEX `IX3_tblTransactionItems05`(`TransactionID`),
	INDEX `IX4_tblTransactionItems05`(`ProductUnitID`)
);

/*****************************
**	tblTransactionItems06
*****************************/
DROP TABLE IF EXISTS tblTransactionItems06;
CREATE TABLE tblTransactionItems06 (
	`TransactionItemsID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`TransactionID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`ProductID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`ProductCode` VARCHAR(30) NOT NULL,
	`BarCode` VARCHAR(30) NOT NULL,
	`Description` VARCHAR(100) NOT NULL,
	`ProductUnitID` INT(3) UNSIGNED NOT NULL DEFAULT 0,
	`ProductUnitCode` VARCHAR(3) NOT NULL,
	`Quantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`Price` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`SellingPrice` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`Discount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ItemDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ItemDiscountType` TINYINT(1) NOT NULL DEFAULT 0,
	`Amount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`LocalTax` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VariationsMatrixID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`MatrixDescription` VARCHAR(150) NULL,
	`ProductGroup` VARCHAR(20) NULL,
	`ProductSubGroup` VARCHAR(20) NULL,
	`TransactionItemStatus` SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
	`DiscountCode` VARCHAR(30),
	`DiscountRemarks` VARCHAR(255),
	`ProductPackageID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0 ,
	`MatrixPackageID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0 ,
	`PackageQuantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PromoQuantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PromoValue` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PromoInPercent` TINYINT(1) NOT NULL DEFAULT 0,
	`PromoType` TINYINT(1) NOT NULL DEFAULT 0,
	`PromoApplied` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PurchasePrice` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PurchaseAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`IncludeInSubtotalDiscount` TINYINT(1) NOT NULL DEFAULT 1,
	PRIMARY KEY (TransactionItemsID),
	INDEX `IX_tblTransactionItems06`(`TransactionItemsID`),
	INDEX `IX0_tblTransactionItems06`(`TransactionID`, `ProductID`),
	INDEX `IX1_tblTransactionItems06`(`TransactionID`, `ProductID`,`VariationsMatrixID`),
	INDEX `IX2_tblTransactionItems06`(`ProductCode`),
	INDEX `IX3_tblTransactionItems06`(`TransactionID`),
	INDEX `IX4_tblTransactionItems06`(`ProductUnitID`)
);

/*****************************
**	tblTransactionItems07
*****************************/
DROP TABLE IF EXISTS tblTransactionItems07;
CREATE TABLE tblTransactionItems07 (
	`TransactionItemsID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`TransactionID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`ProductID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`ProductCode` VARCHAR(30) NOT NULL,
	`BarCode` VARCHAR(30) NOT NULL,
	`Description` VARCHAR(100) NOT NULL,
	`ProductUnitID` INT(3) UNSIGNED NOT NULL DEFAULT 0,
	`ProductUnitCode` VARCHAR(3) NOT NULL,
	`Quantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`Price` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`SellingPrice` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`Discount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ItemDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ItemDiscountType` TINYINT(1) NOT NULL DEFAULT 0,
	`Amount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`LocalTax` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VariationsMatrixID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`MatrixDescription` VARCHAR(150) NULL,
	`ProductGroup` VARCHAR(20) NULL,
	`ProductSubGroup` VARCHAR(20) NULL,
	`TransactionItemStatus` SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
	`DiscountCode` VARCHAR(30),
	`DiscountRemarks` VARCHAR(255),
	`ProductPackageID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0 ,
	`MatrixPackageID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0 ,
	`PackageQuantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PromoQuantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PromoValue` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PromoInPercent` TINYINT(1) NOT NULL DEFAULT 0,
	`PromoType` TINYINT(1) NOT NULL DEFAULT 0,
	`PromoApplied` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PurchasePrice` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PurchaseAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`IncludeInSubtotalDiscount` TINYINT(1) NOT NULL DEFAULT 1,
	PRIMARY KEY (TransactionItemsID),
	INDEX `IX_tblTransactionItems07`(`TransactionItemsID`),
	INDEX `IX0_tblTransactionItems07`(`TransactionID`, `ProductID`),
	INDEX `IX1_tblTransactionItems07`(`TransactionID`, `ProductID`,`VariationsMatrixID`),
	INDEX `IX2_tblTransactionItems07`(`ProductCode`),
	INDEX `IX3_tblTransactionItems07`(`TransactionID`),
	INDEX `IX4_tblTransactionItems07`(`ProductUnitID`)
);

/*****************************
**	tblTransactionItems08
*****************************/
DROP TABLE IF EXISTS tblTransactionItems08;
CREATE TABLE tblTransactionItems08 (
	`TransactionItemsID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`TransactionID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`ProductID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`ProductCode` VARCHAR(30) NOT NULL,
	`BarCode` VARCHAR(30) NOT NULL,
	`Description` VARCHAR(100) NOT NULL,
	`ProductUnitID` INT(3) UNSIGNED NOT NULL DEFAULT 0,
	`ProductUnitCode` VARCHAR(3) NOT NULL,
	`Quantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`Price` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`SellingPrice` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`Discount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ItemDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ItemDiscountType` TINYINT(1) NOT NULL DEFAULT 0,
	`Amount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`LocalTax` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VariationsMatrixID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`MatrixDescription` VARCHAR(150) NULL,
	`ProductGroup` VARCHAR(20) NULL,
	`ProductSubGroup` VARCHAR(20) NULL,
	`TransactionItemStatus` SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
	`DiscountCode` VARCHAR(30),
	`DiscountRemarks` VARCHAR(255),
	`ProductPackageID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0 ,
	`MatrixPackageID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0 ,
	`PackageQuantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PromoQuantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PromoValue` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PromoInPercent` TINYINT(1) NOT NULL DEFAULT 0,
	`PromoType` TINYINT(1) NOT NULL DEFAULT 0,
	`PromoApplied` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PurchasePrice` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PurchaseAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`IncludeInSubtotalDiscount` TINYINT(1) NOT NULL DEFAULT 1,
	PRIMARY KEY (TransactionItemsID),
	INDEX `IX_tblTransactionItems08`(`TransactionItemsID`),
	INDEX `IX0_tblTransactionItems08`(`TransactionID`, `ProductID`),
	INDEX `IX1_tblTransactionItems08`(`TransactionID`, `ProductID`,`VariationsMatrixID`),
	INDEX `IX2_tblTransactionItems08`(`ProductCode`),
	INDEX `IX3_tblTransactionItems08`(`TransactionID`),
	INDEX `IX4_tblTransactionItems08`(`ProductUnitID`)
);

/*****************************
**	tblTransactionItems09
*****************************/
DROP TABLE IF EXISTS tblTransactionItems09;
CREATE TABLE tblTransactionItems09 (
	`TransactionItemsID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`TransactionID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`ProductID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`ProductCode` VARCHAR(30) NOT NULL,
	`BarCode` VARCHAR(30) NOT NULL,
	`Description` VARCHAR(100) NOT NULL,
	`ProductUnitID` INT(3) UNSIGNED NOT NULL DEFAULT 0,
	`ProductUnitCode` VARCHAR(3) NOT NULL,
	`Quantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`Price` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`SellingPrice` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`Discount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ItemDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ItemDiscountType` TINYINT(1) NOT NULL DEFAULT 0,
	`Amount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`LocalTax` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VariationsMatrixID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`MatrixDescription` VARCHAR(150) NULL,
	`ProductGroup` VARCHAR(20) NULL,
	`ProductSubGroup` VARCHAR(20) NULL,
	`TransactionItemStatus` SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
	`DiscountCode` VARCHAR(30),
	`DiscountRemarks` VARCHAR(255),
	`ProductPackageID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0 ,
	`MatrixPackageID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0 ,
	`PackageQuantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PromoQuantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PromoValue` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PromoInPercent` TINYINT(1) NOT NULL DEFAULT 0,
	`PromoType` TINYINT(1) NOT NULL DEFAULT 0,
	`PromoApplied` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PurchasePrice` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PurchaseAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`IncludeInSubtotalDiscount` TINYINT(1) NOT NULL DEFAULT 1,
	PRIMARY KEY (TransactionItemsID),
	INDEX `IX_tblTransactionItems09`(`TransactionItemsID`),
	INDEX `IX0_tblTransactionItems09`(`TransactionID`, `ProductID`),
	INDEX `IX1_tblTransactionItems09`(`TransactionID`, `ProductID`,`VariationsMatrixID`),
	INDEX `IX2_tblTransactionItems09`(`ProductCode`),
	INDEX `IX3_tblTransactionItems09`(`TransactionID`),
	INDEX `IX4_tblTransactionItems09`(`ProductUnitID`)
);

/*****************************
**	tblTransactionItems10
*****************************/
DROP TABLE IF EXISTS tblTransactionItems10;
CREATE TABLE tblTransactionItems10 (
	`TransactionItemsID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`TransactionID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`ProductID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`ProductCode` VARCHAR(30) NOT NULL,
	`BarCode` VARCHAR(30) NOT NULL,
	`Description` VARCHAR(100) NOT NULL,
	`ProductUnitID` INT(3) UNSIGNED NOT NULL DEFAULT 0,
	`ProductUnitCode` VARCHAR(3) NOT NULL,
	`Quantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`Price` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`SellingPrice` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`Discount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ItemDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ItemDiscountType` TINYINT(1) NOT NULL DEFAULT 0,
	`Amount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`LocalTax` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VariationsMatrixID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`MatrixDescription` VARCHAR(150) NULL,
	`ProductGroup` VARCHAR(20) NULL,
	`ProductSubGroup` VARCHAR(20) NULL,
	`TransactionItemStatus` SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
	`DiscountCode` VARCHAR(30),
	`DiscountRemarks` VARCHAR(255),
	`ProductPackageID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0 ,
	`MatrixPackageID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0 ,
	`PackageQuantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PromoQuantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PromoValue` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PromoInPercent` TINYINT(1) NOT NULL DEFAULT 0,
	`PromoType` TINYINT(1) NOT NULL DEFAULT 0,
	`PromoApplied` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PurchasePrice` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PurchaseAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`IncludeInSubtotalDiscount` TINYINT(1) NOT NULL DEFAULT 1,
	PRIMARY KEY (TransactionItemsID),
	INDEX `IX_tblTransactionItems10`(`TransactionItemsID`),
	INDEX `IX0_tblTransactionItems10`(`TransactionID`, `ProductID`),
	INDEX `IX1_tblTransactionItems10`(`TransactionID`, `ProductID`,`VariationsMatrixID`),
	INDEX `IX2_tblTransactionItems10`(`ProductCode`),
	INDEX `IX3_tblTransactionItems10`(`TransactionID`),
	INDEX `IX4_tblTransactionItems10`(`ProductUnitID`)
);

/*****************************
**	tblTransactionItems11
*****************************/
DROP TABLE IF EXISTS tblTransactionItems11;
CREATE TABLE tblTransactionItems11 (
	`TransactionItemsID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`TransactionID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`ProductID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`ProductCode` VARCHAR(30) NOT NULL,
	`BarCode` VARCHAR(30) NOT NULL,
	`Description` VARCHAR(100) NOT NULL,
	`ProductUnitID` INT(3) UNSIGNED NOT NULL DEFAULT 0,
	`ProductUnitCode` VARCHAR(3) NOT NULL,
	`Quantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`Price` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`SellingPrice` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`Discount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ItemDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ItemDiscountType` TINYINT(1) NOT NULL DEFAULT 0,
	`Amount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`LocalTax` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VariationsMatrixID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`MatrixDescription` VARCHAR(150) NULL,
	`ProductGroup` VARCHAR(20) NULL,
	`ProductSubGroup` VARCHAR(20) NULL,
	`TransactionItemStatus` SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
	`DiscountCode` VARCHAR(30),
	`DiscountRemarks` VARCHAR(255),
	`ProductPackageID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0 ,
	`MatrixPackageID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0 ,
	`PackageQuantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PromoQuantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PromoValue` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PromoInPercent` TINYINT(1) NOT NULL DEFAULT 0,
	`PromoType` TINYINT(1) NOT NULL DEFAULT 0,
	`PromoApplied` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PurchasePrice` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PurchaseAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`IncludeInSubtotalDiscount` TINYINT(1) NOT NULL DEFAULT 1,
	PRIMARY KEY (TransactionItemsID),
	INDEX `IX_tblTransactionItems11`(`TransactionItemsID`),
	INDEX `IX0_tblTransactionItems11`(`TransactionID`, `ProductID`),
	INDEX `IX1_tblTransactionItems11`(`TransactionID`, `ProductID`,`VariationsMatrixID`),
	INDEX `IX2_tblTransactionItems11`(`ProductCode`),
	INDEX `IX3_tblTransactionItems11`(`TransactionID`),
	INDEX `IX4_tblTransactionItems11`(`ProductUnitID`)
);

/*****************************
**	tblTransactionItems12
*****************************/
DROP TABLE IF EXISTS tblTransactionItems12;
CREATE TABLE tblTransactionItems12 (
	`TransactionItemsID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`TransactionID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`ProductID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`ProductCode` VARCHAR(30) NOT NULL,
	`BarCode` VARCHAR(30) NOT NULL,
	`Description` VARCHAR(100) NOT NULL,
	`ProductUnitID` INT(3) UNSIGNED NOT NULL DEFAULT 0,
	`ProductUnitCode` VARCHAR(3) NOT NULL,
	`Quantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`Price` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`SellingPrice` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`Discount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ItemDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ItemDiscountType` TINYINT(1) NOT NULL DEFAULT 0,
	`Amount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`LocalTax` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VariationsMatrixID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`MatrixDescription` VARCHAR(150) NULL,
	`ProductGroup` VARCHAR(20) NULL,
	`ProductSubGroup` VARCHAR(20) NULL,
	`TransactionItemStatus` SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
	`DiscountCode` VARCHAR(30),
	`DiscountRemarks` VARCHAR(255),
	`ProductPackageID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0 ,
	`MatrixPackageID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0 ,
	`PackageQuantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PromoQuantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PromoValue` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PromoInPercent` TINYINT(1) NOT NULL DEFAULT 0,
	`PromoType` TINYINT(1) NOT NULL DEFAULT 0,
	`PromoApplied` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PurchasePrice` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PurchaseAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`IncludeInSubtotalDiscount` TINYINT(1) NOT NULL DEFAULT 1,
	PRIMARY KEY (TransactionItemsID),
	INDEX `IX_tblTransactionItems12`(`TransactionItemsID`),
	INDEX `IX9_tblTransactionItems12`(`TransactionID`, `ProductID`),
	INDEX `IX1_tblTransactionItems12`(`TransactionID`, `ProductID`,`VariationsMatrixID`),
	INDEX `IX2_tblTransactionItems12`(`ProductCode`),
	INDEX `IX3_tblTransactionItems12`(`TransactionID`),
	INDEX `IX4_tblTransactionItems12`(`ProductUnitID`)
);

/*****************************
**	tblTerminalReport
*****************************/
DROP TABLE IF EXISTS tblTerminalReport;
CREATE TABLE tblTerminalReport (
	`TerminalID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`TerminalNo` VARCHAR(10) NOT NULL,
	`BeginningTransactionNo` VARCHAR(30) NOT NULL,
	`EndingTransactionNo` VARCHAR(30) NOT NULL,
	`ZReadCount` INT(10) NOT NULL DEFAULT 0,
	`XReadCount` INT(10) NOT NULL DEFAULT 0,
	`GrossSales` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`TotalDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`DailySales` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`QuantitySold` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`GroupSales` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`OldGrandTotal` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`NewGrandTotal` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VATableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`NonVATableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVATableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`NonEVATableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`LocalTax` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CashSales` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ChequeSales` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CreditCardSales` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CreditSales` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CreditPayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CashInDrawer` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`TotalDisburse` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CashDisburse` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ChequeDisburse` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CreditCardDisburse` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`TotalWithhold` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CashWithhold` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ChequeWithhold` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CreditCardWithhold` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`TotalPaidOut` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CashPaidOut` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ChequePaidOut` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CreditCardPaidOut` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`BeginningBalance` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VoidSales` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`RefundSales` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ItemsDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`SubtotalDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`NoOfCashTransactions` INT(10) NOT NULL DEFAULT 0,
	`NoOfChequeTransactions` INT(10) NOT NULL DEFAULT 0,
	`NoOfCreditCardTransactions` INT(10) NOT NULL DEFAULT 0,
	`NoOfCreditTransactions` INT(10) NOT NULL DEFAULT 0,
	`NoOfCombinationPaymentTransactions` INT(10) NOT NULL DEFAULT 0,
	`NoOfCreditPaymentTransactions` INT(10) NOT NULL DEFAULT 0,
	`NoOfClosedTransactions` INT(10) NOT NULL DEFAULT 0,
	`NoOfRefundTransactions` INT(10) NOT NULL DEFAULT 0,
	`NoOfVoidTransactions` INT(10) NOT NULL DEFAULT 0,
	`NoOfTotalTransactions` INT(10) NOT NULL DEFAULT 0,
	`DateLastInitialized` DATETIME NOT NULL,
	PRIMARY KEY (TerminalNo),
	INDEX `IX_tblTerminalReport`(`TerminalNo`),
	UNIQUE `PK_tblTerminalReport`(`TerminalNo`),
	INDEX `IX1_tblTerminalReport`(`ZReadCount`),
	INDEX `IX2_tblTerminalReport`(`XReadCount`)
);

/*****************************
**	tblTerminalReportHistory
*****************************/
DROP TABLE IF EXISTS tblTerminalReportHistory;
CREATE TABLE tblTerminalReportHistory (
	`TerminalID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`TerminalNo` VARCHAR(10) NOT NULL,
	`BeginningTransactionNo` VARCHAR(30) NOT NULL,
	`EndingTransactionNo` VARCHAR(30) NOT NULL,
	`ZReadCount` INT(10) NOT NULL DEFAULT 0,
	`XReadCount` INT(10) NOT NULL DEFAULT 0,
	`GrossSales` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`TotalDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`DailySales` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`QuantitySold` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`GroupSales` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`OldGrandTotal` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`NewGrandTotal` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VATableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`NonVATableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVATableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`NonEVATableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`LocalTax` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CashSales` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ChequeSales` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CreditCardSales` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CreditSales` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CreditPayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CashInDrawer` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`TotalDisburse` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CashDisburse` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ChequeDisburse` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CreditCardDisburse` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`TotalWithhold` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CashWithhold` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ChequeWithhold` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CreditCardWithhold` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`TotalPaidOut` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CashPaidOut` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ChequePaidOut` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CreditCardPaidOut` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`BeginningBalance` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VoidSales` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`RefundSales` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ItemsDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`SubtotalDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`NoOfCashTransactions` INT(10) NOT NULL DEFAULT 0,
	`NoOfChequeTransactions` INT(10) NOT NULL DEFAULT 0,
	`NoOfCreditCardTransactions` INT(10) NOT NULL DEFAULT 0,
	`NoOfCreditTransactions` INT(10) NOT NULL DEFAULT 0,
	`NoOfCombinationPaymentTransactions` INT(10) NOT NULL DEFAULT 0,
	`NoOfCreditPaymentTransactions` INT(10) NOT NULL DEFAULT 0,
	`NoOfClosedTransactions` INT(10) NOT NULL DEFAULT 0,
	`NoOfRefundTransactions` INT(10) NOT NULL DEFAULT 0,
	`NoOfVoidTransactions` INT(10) NOT NULL DEFAULT 0,
	`NoOfTotalTransactions` INT(10) NOT NULL DEFAULT 0,
	`DateLastInitialized` DATETIME NOT NULL,
	INDEX `IX_tblTerminalReport`(`TerminalNo`),
	INDEX `IX1_tblTerminalReport`(`ZReadCount`),
	INDEX `IX2_tblTerminalReport`(`XReadCount`)
);

/*****************************
**	tblCashierReport
*****************************/
DROP TABLE IF EXISTS tblCashierReport;
CREATE TABLE tblCashierReport (
	`CashierID` BIGINT(20) NOT NULL DEFAULT 0,
	`TerminalID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`TerminalNo` VARCHAR(10) NOT NULL,
	`GrossSales` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`TotalDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`DailySales` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`QuantitySold` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`GroupSales` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`LocalTax` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CashSales` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ChequeSales` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CreditCardSales` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CreditSales` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CreditPayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CashInDrawer` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`TotalDisburse` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CashDisburse` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ChequeDisburse` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CreditCardDisburse` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`TotalWithhold` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CashWithhold` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ChequeWithhold` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CreditCardWithhold` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`TotalPaidOut` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CashPaidOut` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ChequePaidOut` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CreditCardPaidOut` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`BeginningBalance` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VoidSales` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`RefundSales` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ItemsDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`SubtotalDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`NoOfCashTransactions` INT(10) NOT NULL DEFAULT 0,
	`NoOfChequeTransactions` INT(10) NOT NULL DEFAULT 0,
	`NoOfCreditCardTransactions` INT(10) NOT NULL DEFAULT 0,
	`NoOfCreditTransactions` INT(10) NOT NULL DEFAULT 0,
	`NoOfCombinationPaymentTransactions` INT(10) NOT NULL DEFAULT 0,
	`NoOfCreditPaymentTransactions` INT(10) NOT NULL DEFAULT 0,
	`NoOfClosedTransactions` INT(10) NOT NULL DEFAULT 0,
	`NoOfRefundTransactions` INT(10) NOT NULL DEFAULT 0,
	`NoOfVoidTransactions` INT(10) NOT NULL DEFAULT 0,
	`NoOfTotalTransactions` INT(10) NOT NULL DEFAULT 0,
	`CashCount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`LastLoginDate` DATETIME NOT NULL,
	PRIMARY KEY (`CashierID`, `TerminalNo`),
	INDEX `IX_tblCashierReport`(`CashierID`, `TerminalNo`),
	UNIQUE `PK_tblCashierReport`(`CashierID`, `TerminalNo`),
	INDEX `IX1_tblCashierReport`(`CashierID`),
	INDEX `IX2_tblCashierReport`(`TerminalNo`),
	INDEX `IX3_tblCashierReport`(`TerminalID`)
);

/*****************************
**	tblCashierReportHistory
*****************************/
DROP TABLE IF EXISTS tblCashierReportHistory;
CREATE TABLE tblCashierReportHistory (
`CashierID` BIGINT(20) NOT NULL DEFAULT 0,
`TerminalID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
`TerminalNo` VARCHAR(10) NOT NULL,
`GrossSales` DECIMAL(18,3) NOT NULL DEFAULT 0,
`TotalDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0,
`DailySales` DECIMAL(18,3) NOT NULL DEFAULT 0,
`QuantitySold` DECIMAL(18,3) NOT NULL DEFAULT 0,
`GroupSales` DECIMAL(18,3) NOT NULL DEFAULT 0,
`VAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
`EVAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
`LocalTax` DECIMAL(18,3) NOT NULL DEFAULT 0,
`CashSales` DECIMAL(18,3) NOT NULL DEFAULT 0,
`ChequeSales` DECIMAL(18,3) NOT NULL DEFAULT 0,
`CreditCardSales` DECIMAL(18,3) NOT NULL DEFAULT 0,
`CreditSales` DECIMAL(18,3) NOT NULL DEFAULT 0,
`CreditPayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
`CashInDrawer` DECIMAL(18,3) NOT NULL DEFAULT 0,
`TotalDisburse` DECIMAL(18,3) NOT NULL DEFAULT 0,
`CashDisburse` DECIMAL(18,3) NOT NULL DEFAULT 0,
`ChequeDisburse` DECIMAL(18,3) NOT NULL DEFAULT 0,
`CreditCardDisburse` DECIMAL(18,3) NOT NULL DEFAULT 0,
`TotalWithhold` DECIMAL(18,3) NOT NULL DEFAULT 0,
`CashWithhold` DECIMAL(18,3) NOT NULL DEFAULT 0,
`ChequeWithhold` DECIMAL(18,3) NOT NULL DEFAULT 0,
`CreditCardWithhold` DECIMAL(18,3) NOT NULL DEFAULT 0,
`TotalPaidOut` DECIMAL(18,3) NOT NULL DEFAULT 0,
`CashPaidOut` DECIMAL(18,3) NOT NULL DEFAULT 0,
`ChequePaidOut` DECIMAL(18,3) NOT NULL DEFAULT 0,
`CreditCardPaidOut` DECIMAL(18,3) NOT NULL DEFAULT 0,
`BeginningBalance` DECIMAL(18,3) NOT NULL DEFAULT 0,
`VoidSales` DECIMAL(18,3) NOT NULL DEFAULT 0,
`RefundSales` DECIMAL(18,3) NOT NULL DEFAULT 0,
`ItemsDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0,
`SubtotalDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0,
`NoOfCashTransactions` INT(10) NOT NULL DEFAULT 0,
`NoOfChequeTransactions` INT(10) NOT NULL DEFAULT 0,
`NoOfCreditCardTransactions` INT(10) NOT NULL DEFAULT 0,
`NoOfCreditTransactions` INT(10) NOT NULL DEFAULT 0,
`NoOfCombinationPaymentTransactions` INT(10) NOT NULL DEFAULT 0,
`NoOfCreditPaymentTransactions` INT(10) NOT NULL DEFAULT 0,
`NoOfClosedTransactions` INT(10) NOT NULL DEFAULT 0,
`NoOfRefundTransactions` INT(10) NOT NULL DEFAULT 0,
`NoOfVoidTransactions` INT(10) NOT NULL DEFAULT 0,
`NoOfTotalTransactions` INT(10) NOT NULL DEFAULT 0,
`CashCount` DECIMAL(18,3) NOT NULL DEFAULT 0,
`LastLoginDate` DATETIME NOT NULL,
INDEX `IX_tblCashierReport`(`CashierID`, `TerminalNo`),
INDEX `IX1_tblCashierReport`(`CashierID`),
INDEX `IX2_tblCashierReport`(`TerminalNo`),
INDEX `IX3_tblCashierReport`(`TerminalID`)
);

TRUNCATE TABLE tblDenomination;
INSERT INTO tblDenomination (DenominationCode, `DenominationValue`, ImagePath) VALUES ('One Thousand Pesos', 1000.00, '');
INSERT INTO tblDenomination (DenominationCode, `DenominationValue`, ImagePath) VALUES ('Five Hundred Pesos', 500.00, '');
INSERT INTO tblDenomination (DenominationCode, `DenominationValue`, ImagePath) VALUES ('Two Hundred Pesos', 200.00, '');
INSERT INTO tblDenomination (DenominationCode, `DenominationValue`, ImagePath) VALUES ('One Hundred Pesos', 100.00, '');
INSERT INTO tblDenomination (DenominationCode, `DenominationValue`, ImagePath) VALUES ('Fifty Pesos', 50.00, '');
INSERT INTO tblDenomination (DenominationCode, `DenominationValue`, ImagePath) VALUES ('Twenty Pesos', 20.00, '');
INSERT INTO tblDenomination (DenominationCode, `DenominationValue`, ImagePath) VALUES ('Ten Pesos', 10.00, '');
INSERT INTO tblDenomination (DenominationCode, `DenominationValue`, ImagePath) VALUES ('Five Pesos', 5.00, '');
INSERT INTO tblDenomination (DenominationCode, `DenominationValue`, ImagePath) VALUES ('One Peso', 1.00, '');
INSERT INTO tblDenomination (DenominationCode, `DenominationValue`, ImagePath) VALUES ('Fifty Cents', 0.5, '');
INSERT INTO tblDenomination (DenominationCode, `DenominationValue`, ImagePath) VALUES ('25 Cents', 0.25, '');
INSERT INTO tblDenomination (DenominationCode, `DenominationValue`, ImagePath) VALUES ('10 Cents', 0.10, '');
INSERT INTO tblDenomination (DenominationCode, `DenominationValue`, ImagePath) VALUES ('5 Cents', 0.05, '');
INSERT INTO tblDenomination (DenominationCode, `DenominationValue`, ImagePath) VALUES ('1 Cent', 0.01, '');

INSERT INTO tblCountry(countryname) values ('Philippines');
INSERT INTO tblCountry(countryname) values ('USA');

INSERT INTO sysAccessGroups (GroupName, Remarks) VALUES ('Administrators', 'Default group for administrators. Has access on all rights.');
INSERT INTO sysAccessGroups (GroupName, Remarks) VALUES ('Managers', 'Default group for managers.');
INSERT INTO sysAccessGroups (GroupName, Remarks) VALUES ('Supervisors', 'Default group for supervisors.');
INSERT INTO sysAccessGroups (GroupName, Remarks) VALUES ('Cashiers', 'Default group for cashiers.');

INSERT INTO sysAccessUsers (Username, Password, DateCreated ) VALUES ('admin', 'admin', '2004-10-17 13:37:45.293');

INSERT INTO sysAccessUserDetails (UID ,Name, CountryID, GroupID) VALUES (1, 'Lem E. Aceron', 1, 1);


INSERT INTO sysAccessTypes (TypeName) VALUES ('LoginBE');
INSERT INTO sysAccessTypes (TypeName) VALUES ('Home');
INSERT INTO sysAccessTypes (TypeName) VALUES ('MasterFilesMenu');
INSERT INTO sysAccessTypes (TypeName) VALUES ('CardType');
INSERT INTO sysAccessTypes (TypeName) VALUES ('ChargeType');
INSERT INTO sysAccessTypes (TypeName) VALUES ('Variations');
INSERT INTO sysAccessTypes (TypeName) VALUES ('UnitMeasurement');
INSERT INTO sysAccessTypes (TypeName) VALUES ('ProductGroups');
INSERT INTO sysAccessTypes (TypeName) VALUES ('ProductGroupVariations');
INSERT INTO sysAccessTypes (TypeName) VALUES ('ProductSubGroups');
INSERT INTO sysAccessTypes (TypeName) VALUES ('ProductSubGroupVariations');
INSERT INTO sysAccessTypes (TypeName) VALUES ('Products');
INSERT INTO sysAccessTypes (TypeName) VALUES ('ProductVariations');
INSERT INTO sysAccessTypes (TypeName) VALUES ('ProductPackage');
INSERT INTO sysAccessTypes (TypeName) VALUES ('ProductVariationsPackage');
INSERT INTO sysAccessTypes (TypeName) VALUES ('Discounts');
INSERT INTO sysAccessTypes (TypeName) VALUES ('Promos');
INSERT INTO sysAccessTypes (TypeName) VALUES ('Contacts');
INSERT INTO sysAccessTypes (TypeName) VALUES ('ContactGroups');
INSERT INTO sysAccessTypes (TypeName) VALUES ('InventoryMenu');
INSERT INTO sysAccessTypes (TypeName) VALUES ('InventoryList');
INSERT INTO sysAccessTypes (TypeName) VALUES ('StockTypes');
INSERT INTO sysAccessTypes (TypeName) VALUES ('StockTransactions');
INSERT INTO sysAccessTypes (TypeName) VALUES ('ReportsMenu');
INSERT INTO sysAccessTypes (TypeName) VALUES ('ProductsListReport');
INSERT INTO sysAccessTypes (TypeName) VALUES ('InventoryReport');
INSERT INTO sysAccessTypes (TypeName) VALUES ('ReorderReport');
INSERT INTO sysAccessTypes (TypeName) VALUES ('OverStockReport');
INSERT INTO sysAccessTypes (TypeName) VALUES ('PricesReport');
INSERT INTO sysAccessTypes (TypeName) VALUES ('SalesTransactionReport');
INSERT INTO sysAccessTypes (TypeName) VALUES ('ContactsReport');
INSERT INTO sysAccessTypes (TypeName) VALUES ('CustomerCreditReport');
INSERT INTO sysAccessTypes (TypeName) VALUES ('CustomersWithCreditReport');
INSERT INTO sysAccessTypes (TypeName) VALUES ('MostSalableItemsReport');
INSERT INTO sysAccessTypes (TypeName) VALUES ('WorstSalableItemsReport');
INSERT INTO sysAccessTypes (TypeName) VALUES ('DiscountsReport');
INSERT INTO sysAccessTypes (TypeName) VALUES ('PrintReceiptsReport');
INSERT INTO sysAccessTypes (TypeName) VALUES ('ReturnedItemsReport');
INSERT INTO sysAccessTypes (TypeName) VALUES ('VoidedItemsReport');
INSERT INTO sysAccessTypes (TypeName) VALUES ('RefundedItemsReport');
INSERT INTO sysAccessTypes (TypeName) VALUES ('SalesReports');
INSERT INTO sysAccessTypes (TypeName) VALUES ('AdministrationFilesMenu');
INSERT INTO sysAccessTypes (TypeName) VALUES ('CompanyInfo');
INSERT INTO sysAccessTypes (TypeName) VALUES ('AccessGroups');
INSERT INTO sysAccessTypes (TypeName) VALUES ('AccessUsers');
INSERT INTO sysAccessTypes (TypeName) VALUES ('AccessRights');
INSERT INTO sysAccessTypes (TypeName) VALUES ('ReportFormat');
INSERT INTO sysAccessTypes (TypeName) VALUES ('Terminal');

INSERT INTO sysAccessTypes (TypeName) VALUES ('LoginFE');
INSERT INTO sysAccessTypes (TypeName) VALUES ('InitializeXRead');
INSERT INTO sysAccessTypes (TypeName) VALUES ('InitializeZRead');
INSERT INTO sysAccessTypes (TypeName) VALUES ('CreateTransaction');
INSERT INTO sysAccessTypes (TypeName) VALUES ('CloseTransaction');
INSERT INTO sysAccessTypes (TypeName) VALUES ('SuspendTransaction');
INSERT INTO sysAccessTypes (TypeName) VALUES ('ResumeTransaction');
INSERT INTO sysAccessTypes (TypeName) VALUES ('VoidTransaction');
INSERT INTO sysAccessTypes (TypeName) VALUES ('RefundTransaction');
INSERT INTO sysAccessTypes (TypeName) VALUES ('ReprintTransaction');
INSERT INTO sysAccessTypes (TypeName) VALUES ('Withhold');
INSERT INTO sysAccessTypes (TypeName) VALUES ('Disburse');
INSERT INTO sysAccessTypes (TypeName) VALUES ('PaidOut');
INSERT INTO sysAccessTypes (TypeName) VALUES ('Denomination');
INSERT INTO sysAccessTypes (TypeName) VALUES ('CashCount');
INSERT INTO sysAccessTypes (TypeName) VALUES ('CreditPayment');
INSERT INTO sysAccessTypes (TypeName) VALUES ('OpenDrawer');
INSERT INTO sysAccessTypes (TypeName) VALUES ('VoidItem');
INSERT INTO sysAccessTypes (TypeName) VALUES ('ChangePrice');
INSERT INTO sysAccessTypes (TypeName) VALUES ('ChangeQuantity');
INSERT INTO sysAccessTypes (TypeName) VALUES ('PrintXRead');
INSERT INTO sysAccessTypes (TypeName) VALUES ('PrintZRead');
INSERT INTO sysAccessTypes (TypeName) VALUES ('PrintTerminalReport');
INSERT INTO sysAccessTypes (TypeName) VALUES ('PrintCashierReport');
INSERT INTO sysAccessTypes (TypeName) VALUES ('PrintHourlyReport');
INSERT INTO sysAccessTypes (TypeName) VALUES ('PrintGroupReport');
INSERT INTO sysAccessTypes (TypeName) VALUES ('PrintPLUReport');
INSERT INTO sysAccessTypes (TypeName) VALUES ('PrintElectronicJournal');
INSERT INTO sysAccessTypes (TypeName) VALUES ('LogoutFE');
INSERT INTO sysAccessTypes (TypeName) VALUES ('ApplyItemDiscount');
INSERT INTO sysAccessTypes (TypeName) VALUES ('ApplyTransDiscount');
INSERT INTO sysAccessTypes (TypeName) VALUES ('EnterCreditPayment');
INSERT INTO sysAccessTypes (TypeName) VALUES ('PrintTransactionHeader');
INSERT INTO sysAccessTypes (TypeName) VALUES ('AyalaInfo');
INSERT INTO sysAccessTypes (TypeName) VALUES ('LockTerminal');
INSERT INTO sysAccessTypes (TypeName) VALUES ('UnlockTerminal');
INSERT INTO sysAccessTypes (TypeName) VALUES ('EnterFloat');
INSERT INTO sysAccessTypes (TypeName) VALUES ('LoginLogoutReport');
INSERT INTO sysAccessTypes (TypeName) VALUES ('ReturnItem');

/*****************************
**	Administrator Default Access
*****************************/
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 1,  1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 2,  1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 3,  1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 4,  1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 5,  1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 6,  1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 7,  1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 8,  1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 9,  1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 10, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 11, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 12, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 13, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 14, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 15, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 16, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 17, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 18, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 19, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 20, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 21, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 22, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 23, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 24, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 25, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 26, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 27, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 28, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 29, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 30, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 31, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 32, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 33, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 34, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 35, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 36, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 37, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 38, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 39, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 40, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 41, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 42, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 43, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 44, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 45, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 46, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 47, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 48, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 49, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 50, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 51, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 52, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 53, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 54, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 55, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 56, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 57, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 58, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 59, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 60, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 61, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 62, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 63, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 64, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 65, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 66, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 67, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 68, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 69, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 70, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 71, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 72, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 73, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 74, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 75, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 76, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 77, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 78, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 79, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 80, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 81, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 82, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 83, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 84, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 85, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 86, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 87, 1, 1);

/*****************************
**	Managers Default Access
*****************************/
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 1,  1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 2,  1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 3,  1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 4,  1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 5,  1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 6,  1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 7,  1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 8,  1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 9,  1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 10, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 11, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 12, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 13, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 14, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 15, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 16, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 17, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 18, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 19, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 20, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 21, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 22, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 23, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 24, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 25, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 26, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 27, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 28, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 29, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 30, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 31, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 32, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 33, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 34, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 35, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 36, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 37, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 38, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 39, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 40, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 41, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 42, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 43, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 44, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 45, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 46, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 47, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 48, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 49, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 50, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 51, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 52, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 53, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 54, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 55, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 56, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 57, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 58, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 59, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 60, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 61, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 62, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 63, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 64, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 65, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 66, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 67, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 68, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 69, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 70, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 71, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 72, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 73, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 74, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 75, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 76, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 77, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 78, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 79, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 80, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 82, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 83, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 84, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 85, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 86, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 87, 1, 1);

/*****************************
**	Supervisors Default Access
*****************************/
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 1,  1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 2,  1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 3,  1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 4,  1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 5,  1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 6,  1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 7,  1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 8,  1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 9,  1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 10, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 11, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 12, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 13, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 14, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 15, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 16, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 17, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 18, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 19, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 20, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 21, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 22, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 23, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 24, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 25, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 26, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 27, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 28, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 29, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 30, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 31, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 32, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 33, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 34, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 35, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 36, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 37, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 38, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 39, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 40, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 41, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 42, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 43, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 44, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 45, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 46, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 47, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 48, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 49, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 50, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 51, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 52, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 53, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 54, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 55, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 56, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 57, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 58, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 59, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 60, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 61, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 62, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 63, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 64, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 65, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 66, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 67, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 68, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 69, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 70, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 71, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 72, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 73, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 74, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 75, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 76, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 77, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 78, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 79, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 80, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 81, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 82, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 83, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 84, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 85, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 86, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 87, 1, 1);

/*****************************
**	Cashiers Default Access
*****************************/
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 4,  1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 5,  1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 6,  1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 7,  1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 8,  1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 9,  1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 10, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 11, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 12, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 13, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 14, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 15, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 16, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 17, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 18, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 19, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 20, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 21, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 22, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 23, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 24, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 25, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 26, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 27, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 28, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 29, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 30, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 31, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 32, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 33, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 34, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 35, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 36, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 37, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 38, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 39, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 40, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 41, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 42, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 43, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 44, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 45, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 46, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 47, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 48, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 49, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 50, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 51, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 52, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 53, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 54, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 55, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 56, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 57, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 58, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 59, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 60, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 61, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 62, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 63, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 64, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 65, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 66, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 67, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 68, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 69, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 70, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 71, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 72, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 73, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 74, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 75, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 76, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 77, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 78, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 79, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 80, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 81, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 82, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 83, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 84, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 85, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 86, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 87, 1, 1);


INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 1,  1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 2,  1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 3,  1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 4,  1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 5,  1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 6,  1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 7,  1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 8,  1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 9,  1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 10, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 11, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 12, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 13, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 14, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 15, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 16, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 17, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 18, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 19, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 20, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 21, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 22, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 23, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 24, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 25, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 26, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 27, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 28, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 29, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 30, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 31, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 32, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 33, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 34, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 35, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 36, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 37, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 38, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 39, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 40, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 41, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 42, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 43, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 44, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 45, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 46, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 47, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 48, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 49, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 50, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 51, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 52, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 53, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 54, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 55, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 56, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 57, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 58, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 59, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 60, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 61, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 62, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 63, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 64, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 65, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 66, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 67, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 68, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 69, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 70, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 71, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 72, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 73, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 74, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 75, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 76, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 77, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 78, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 79, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 80, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 81, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 82, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 83, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 84, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 85, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 86, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 87, 1, 1);


/*****************************
**	Products Default Definition
*****************************/
INSERT INTO tblVariations (VariationID, VariationCode, VariationType) VALUES (1, 'EXP', 'EXPIRATION');
INSERT INTO tblVariations (VariationID, VariationCode, VariationType) VALUES (2, 'SZE', 'SIZE');
INSERT INTO tblVariations (VariationID, VariationCode, VariationType) VALUES (3, 'COL', 'COLOR');
INSERT INTO tblVariations (VariationID, VariationCode, VariationType) VALUES (4, 'LEN', 'LENGTH');
INSERT INTO tblVariations (VariationID, VariationCode, VariationType) VALUES (5, 'WID', 'WIDTH');

INSERT INTO tblUnit (UnitCode, UnitName) VALUES ('PC', 'PIECE (S)');
INSERT INTO tblUnit (UnitCode, UnitName) VALUES ('CTN', 'CARTON');
INSERT INTO tblUnit (UnitCode, UnitName) VALUES ('BAG', 'BAG');
INSERT INTO tblUnit (UnitCode, UnitName) VALUES ('BTL', 'BOTTLE');
INSERT INTO tblUnit (UnitCode, UnitName) VALUES ('BOX', 'BOX');
INSERT INTO tblUnit (UnitCode, UnitName) VALUES ('CAN', 'CAN');
INSERT INTO tblUnit (UnitCode, UnitName) VALUES ('CTR', 'CONTAINER');
INSERT INTO tblUnit (UnitCode, UnitName) VALUES ('CSE', 'CASE');
INSERT INTO tblUnit (UnitCode, UnitName) VALUES ('DRM', 'DRUM');
INSERT INTO tblUnit (UnitCode, UnitName) VALUES ('GAL', 'GALLON');
INSERT INTO tblUnit (UnitCode, UnitName) VALUES ('KL', 'KILO');
INSERT INTO tblUnit (UnitCode, UnitName) VALUES ('LTR', 'LITER');
INSERT INTO tblUnit (UnitCode, UnitName) VALUES ('ROL', 'ROLL');
INSERT INTO tblUnit (UnitCode, UnitName) VALUES ('SCK', 'SACK');
INSERT INTO tblUnit (UnitCode, UnitName) VALUES ('YRD', 'YARD');
INSERT INTO tblUnit (UnitCode, UnitName) VALUES ('DOZ', 'DOZEN');
INSERT INTO tblUnit (UnitCode, UnitName) VALUES ('QRT', 'QUART');
INSERT INTO tblUnit (UnitCode, UnitName) VALUES ('BDL', 'BUNDLE');
INSERT INTO tblUnit (UnitCode, UnitName) VALUES ('MTR', 'METER');

/*****************************
**	Added on March 8, 2007
**	Lem E. Aceron
*****************************/

INSERT INTO sysAccessTypes (TypeName) VALUES ('Branch');
INSERT INTO sysAccessTypes (TypeName) VALUES ('BranchTransfer');
INSERT INTO sysAccessTypes (TypeName) VALUES ('BranchUpload');
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 88, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 88, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 88, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 88, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 89, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 89, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 89, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 89, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 90, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 90, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 90, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 90, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 88, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 89, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 90, 1, 1);

/*****************************
**	tblBranch
*****************************/
DROP TABLE IF EXISTS tblBranch;
CREATE TABLE tblBranch (
	`BranchID` INT(4) UNSIGNED NOT NULL AUTO_INCREMENT,
	`BranchCode` VARCHAR(30) NOT NULL,
	`BranchName` VARCHAR(50) NOT NULL,
	`DBIP` VARCHAR(20),
	`DBPort` VARCHAR(4),
	`Address` VARCHAR(120),
	`Remarks` VARCHAR(120),
	PRIMARY KEY (BranchID),
	INDEX `IX_tblBranch`(`BranchID`),
	INDEX `IX_tblBranch1`(`BranchID`, `BranchCode`),
	UNIQUE `PK_tblBranch`(`BranchCode`)
);

INSERT INTO tblBranch(BranchID, BranchCode, BranchName, DBIP, DBPort, Address, Remarks)VALUES(0, 'Main','Main Branch','localhost','3306','Main branch','Main branch wherein all stocks comes in');

INSERT INTO tblStockType(`StockTypeCode`, `Description`, `StockDirection`)VALUES('Transfer To Branch', 'Transfer To Branch', 0);
INSERT INTO tblStockType(`StockTypeCode`, `Description`, `StockDirection`)VALUES('Transfer From Branch', 'Transfer From Branch', 1);

UPDATE tblTerminal SET AccreditationNo = '0000-000-00000-000', MachineSerialNo = '000000';

/*****************************
**	tblDeposit
*****************************/
DROP TABLE IF EXISTS tblDeposit;
CREATE TABLE tblDeposit (
	`DepositID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`Amount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PaymentType` INT(10) NOT NULL DEFAULT 0,
	`DateCreated` DATETIME NOT NULL,
	`TerminalNo` VARCHAR(30) NOT NULL,
	`CashierID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`ContactID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	PRIMARY KEY (`DepositID`),
	INDEX `IX_tblDeposit`(`DepositID`),
	INDEX `IX1_tblDeposit`(`DateCreated`),
	INDEX `IX2_tblDeposit`(`TerminalNo`),
	INDEX `IX3_tblDeposit`(`DateCreated`, `TerminalNo`),
	INDEX `IX4_tblDeposit`(`CashierID`)
);


ALTER TABLE tblTerminalReport ADD `TotalDeposit` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReport ADD `CashDeposit` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReport ADD `ChequeDeposit` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReport ADD `CreditCardDeposit` DECIMAL(18,3) NOT NULL DEFAULT 0;

ALTER TABLE tblTerminalReportHistory ADD `TotalDeposit` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReportHistory ADD `CashDeposit` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReportHistory ADD `ChequeDeposit` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReportHistory ADD `CreditCardDeposit` DECIMAL(18,3) NOT NULL DEFAULT 0;

ALTER TABLE tblCashierReport ADD `TotalDeposit` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReport ADD `CashDeposit` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReport ADD `ChequeDeposit` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReport ADD `CreditCardDeposit` DECIMAL(18,3) NOT NULL DEFAULT 0;

ALTER TABLE tblCashierReportHistory ADD `TotalDeposit` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReportHistory ADD `CashDeposit` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReportHistory ADD `ChequeDeposit` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReportHistory ADD `CreditCardDeposit` DECIMAL(18,3) NOT NULL DEFAULT 0;

INSERT INTO sysAccessTypes (TypeName) VALUES ('Deposit');
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 91, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 91, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 91, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 91, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 91, 1, 1);

/*****************************
**	tblDebitPayment
*****************************/
DROP TABLE IF EXISTS tblDebitPayment;
CREATE TABLE tblDebitPayment (
	`TransactionID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`Amount`  DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ContactID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`Remarks` VARCHAR(255) NOT NULL,
	`AmountPaid`  DECIMAL(18,3) NOT NULL DEFAULT 0,
	INDEX `IX_tblDebitPayment`(`TransactionID`),
	INDEX `IX1_tblDebitPayment`(`ContactID`),
	INDEX `IX2_tblDebitPayment`(`Remarks`)
);

ALTER TABLE tblTransactions01 ADD `DebitPayment` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions02 ADD `DebitPayment` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions03 ADD `DebitPayment` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions04 ADD `DebitPayment` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions05 ADD `DebitPayment` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions06 ADD `DebitPayment` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions07 ADD `DebitPayment` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions08 ADD `DebitPayment` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions09 ADD `DebitPayment` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions10 ADD `DebitPayment` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions11 ADD `DebitPayment` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions12 ADD `DebitPayment` DECIMAL(18,3) NOT NULL DEFAULT 0;

ALTER TABLE tblTerminalReport ADD `DebitPayment` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReportHistory ADD `DebitPayment` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReport ADD `DebitPayment` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReportHistory ADD `DebitPayment` DECIMAL(18,3) NOT NULL DEFAULT 0;

ALTER TABLE tblTerminalReport ADD `NoOfDebitPaymentTransactions` INT(10) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReportHistory ADD `NoOfDebitPaymentTransactions` INT(10) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReport ADD `NoOfDebitPaymentTransactions` INT(10) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReportHistory ADD `NoOfDebitPaymentTransactions` INT(10) NOT NULL DEFAULT 0;

/*****************************
**	Added on April 25, 2007
**	Lem E. Aceron
*****************************/ 

ALTER TABLE tblTransactions01 ADD `ItemsDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions02 ADD `ItemsDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions03 ADD `ItemsDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions04 ADD `ItemsDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions05 ADD `ItemsDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions06 ADD `ItemsDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions07 ADD `ItemsDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions08 ADD `ItemsDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions09 ADD `ItemsDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions10 ADD `ItemsDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions11 ADD `ItemsDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions12 ADD `ItemsDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0;


/*****************************
**	Added on April 30, 2007
**	Lem E. Aceron
*****************************/ 

ALTER TABLE tblTransactions01 ADD `Charge` DECIMAL(18,3) NOT NULL DEFAULT 0, ADD `ChargeAmount` DECIMAL(18,3) NOT NULL DEFAULT 0, ADD `ChargeCode` VARCHAR(30), ADD `ChargeRemarks` VARCHAR(255);
ALTER TABLE tblTransactions02 ADD `Charge` DECIMAL(18,3) NOT NULL DEFAULT 0, ADD `ChargeAmount` DECIMAL(18,3) NOT NULL DEFAULT 0, ADD `ChargeCode` VARCHAR(30), ADD `ChargeRemarks` VARCHAR(255);
ALTER TABLE tblTransactions03 ADD `Charge` DECIMAL(18,3) NOT NULL DEFAULT 0, ADD `ChargeAmount` DECIMAL(18,3) NOT NULL DEFAULT 0, ADD `ChargeCode` VARCHAR(30), ADD `ChargeRemarks` VARCHAR(255);
ALTER TABLE tblTransactions04 ADD `Charge` DECIMAL(18,3) NOT NULL DEFAULT 0, ADD `ChargeAmount` DECIMAL(18,3) NOT NULL DEFAULT 0, ADD `ChargeCode` VARCHAR(30), ADD `ChargeRemarks` VARCHAR(255);
ALTER TABLE tblTransactions05 ADD `Charge` DECIMAL(18,3) NOT NULL DEFAULT 0, ADD `ChargeAmount` DECIMAL(18,3) NOT NULL DEFAULT 0, ADD `ChargeCode` VARCHAR(30), ADD `ChargeRemarks` VARCHAR(255);
ALTER TABLE tblTransactions06 ADD `Charge` DECIMAL(18,3) NOT NULL DEFAULT 0, ADD `ChargeAmount` DECIMAL(18,3) NOT NULL DEFAULT 0, ADD `ChargeCode` VARCHAR(30), ADD `ChargeRemarks` VARCHAR(255);
ALTER TABLE tblTransactions07 ADD `Charge` DECIMAL(18,3) NOT NULL DEFAULT 0, ADD `ChargeAmount` DECIMAL(18,3) NOT NULL DEFAULT 0, ADD `ChargeCode` VARCHAR(30), ADD `ChargeRemarks` VARCHAR(255);
ALTER TABLE tblTransactions08 ADD `Charge` DECIMAL(18,3) NOT NULL DEFAULT 0, ADD `ChargeAmount` DECIMAL(18,3) NOT NULL DEFAULT 0, ADD `ChargeCode` VARCHAR(30), ADD `ChargeRemarks` VARCHAR(255);
ALTER TABLE tblTransactions09 ADD `Charge` DECIMAL(18,3) NOT NULL DEFAULT 0, ADD `ChargeAmount` DECIMAL(18,3) NOT NULL DEFAULT 0, ADD `ChargeCode` VARCHAR(30), ADD `ChargeRemarks` VARCHAR(255);
ALTER TABLE tblTransactions10 ADD `Charge` DECIMAL(18,3) NOT NULL DEFAULT 0, ADD `ChargeAmount` DECIMAL(18,3) NOT NULL DEFAULT 0, ADD `ChargeCode` VARCHAR(30), ADD `ChargeRemarks` VARCHAR(255);
ALTER TABLE tblTransactions11 ADD `Charge` DECIMAL(18,3) NOT NULL DEFAULT 0, ADD `ChargeAmount` DECIMAL(18,3) NOT NULL DEFAULT 0, ADD `ChargeCode` VARCHAR(30), ADD `ChargeRemarks` VARCHAR(255);
ALTER TABLE tblTransactions12 ADD `Charge` DECIMAL(18,3) NOT NULL DEFAULT 0, ADD `ChargeAmount` DECIMAL(18,3) NOT NULL DEFAULT 0, ADD `ChargeCode` VARCHAR(30), ADD `ChargeRemarks` VARCHAR(255);

ALTER TABLE tblTerminalReport ADD `TotalCharge` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReportHistory ADD `TotalCharge` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReport ADD `TotalCharge` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReportHistory ADD `TotalCharge` DECIMAL(18,3) NOT NULL DEFAULT 0;

alter table tblTerminal add `IsVATInclusive` TINYINT (1) NOT NULL DEFAULT 1;
alter table tblTerminal add `VAT` INT (2) NOT NULL DEFAULT 12;
alter table tblTerminal add `EVAT` INT (2) NOT NULL DEFAULT 0;
alter table tblTerminal add `LocalTax` INT (2) NOT NULL DEFAULT 0;

/*****************************
**	Added on November 22, 2007
**	Lem E. Aceron
**	
**	UPDATES:
**	1. Add product composition to enable inventory of RAW PRODUCTS.
**	2. Add TrustFund in the tblTerminalReport to identify how much trustfund is applied during ZREAD.
*****************************/ 

/*****************************
**	tblProductComposition
*****************************/
DROP TABLE IF EXISTS tblProductComposition;
CREATE TABLE tblProductComposition (
	`CompositionID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`MainProductID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`ProductID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`VariationMatrixID` INT(20) UNSIGNED NOT NULL DEFAULT 0,
	`UnitID` INT(3) UNSIGNED NOT NULL DEFAULT 0,
	`Quantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	INDEX `IX_tblProductComposition`(`CompositionID`,`ProductID`),
	UNIQUE `PK_tblProductComposition`(`MainProductID`, `ProductID`,`UnitID`,`Quantity`),
	INDEX `IX1_tblProductComposition`(`MainProductID`),
	INDEX `IX2_tblProductComposition`(`UnitID`)
);

/*!40000 ALTER TABLE `sysAccessTypes` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysAccessGroupRights` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysAccessRights` DISABLE KEYS */;


INSERT INTO sysAccessTypes (TypeID, TypeName) VALUES (92, 'Product Composition');
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 92, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 92, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 92, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (4, 92, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 92, 1, 1);

/*!40000 ALTER TABLE `sysAccessTypes` ENABLE KEYS */; 
/*!40000 ALTER TABLE `sysAccessGroupRights` ENABLE KEYS */; 
/*!40000 ALTER TABLE `sysAccessRights` ENABLE KEYS */; 

ALTER TABLE tblTerminalReportHistory ADD `TrustFund` DECIMAL(5,2) NOT NULL DEFAULT 0.00;

/*****************************
**	Added on December 10, 2007
**	Lem E. Aceron
**	Parameterized the display of items in Front-End if items with Quantity 
**	to display only Items with more than zero quantity
**		0 - means false [display all items]
**		1 - means true  [display only more than zero items]
*****************************/ 
alter table tblTerminal add `ShowItemMoreThanZeroQty` TINYINT (1) NOT NULL DEFAULT 0;

ALTER TABLE sysAccessUserDetails ADD PageSize INT(5) NOT NULL DEFAULT 10; 

/*****************************
**	Added on Feb 07, 2008
**	Lem E. Aceron
**	Include Waiter in all installations
*****************************/
INSERT INTO sysAccessGroups (GroupName, Remarks) VALUES ('Waiters', 'Default group for waiters.');

INSERT INTO sysAccessUsers (UID, Username, Password, DateCreated ) VALUES (2, 'waiter', 'waiter', now());

INSERT INTO sysAccessUserDetails (UID ,Name, CountryID, GroupID) VALUES (2, 'RetailPlus Waiter', 1, 5);

ALTER TABLE tblTransactions01 ADD `WaiterID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 2;
ALTER TABLE tblTransactions01 ADD `WaiterName` VARCHAR(100) NOT NULL;
ALTER TABLE tblTransactions02 ADD `WaiterID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 2;
ALTER TABLE tblTransactions02 ADD `WaiterName` VARCHAR(100) NOT NULL;
ALTER TABLE tblTransactions03 ADD `WaiterID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 2;
ALTER TABLE tblTransactions03 ADD `WaiterName` VARCHAR(100) NOT NULL;
ALTER TABLE tblTransactions04 ADD `WaiterID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 2;
ALTER TABLE tblTransactions04 ADD `WaiterName` VARCHAR(100) NOT NULL;
ALTER TABLE tblTransactions05 ADD `WaiterID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 2;
ALTER TABLE tblTransactions05 ADD `WaiterName` VARCHAR(100) NOT NULL;
ALTER TABLE tblTransactions06 ADD `WaiterID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 2;
ALTER TABLE tblTransactions06 ADD `WaiterName` VARCHAR(100) NOT NULL;
ALTER TABLE tblTransactions07 ADD `WaiterID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 2;
ALTER TABLE tblTransactions07 ADD `WaiterName` VARCHAR(100) NOT NULL;
ALTER TABLE tblTransactions08 ADD `WaiterID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 2;
ALTER TABLE tblTransactions08 ADD `WaiterName` VARCHAR(100) NOT NULL;
ALTER TABLE tblTransactions09 ADD `WaiterID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 2;
ALTER TABLE tblTransactions09 ADD `WaiterName` VARCHAR(100) NOT NULL;
ALTER TABLE tblTransactions10 ADD `WaiterID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 2;
ALTER TABLE tblTransactions10 ADD `WaiterName` VARCHAR(100) NOT NULL;
ALTER TABLE tblTransactions11 ADD `WaiterID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 2;
ALTER TABLE tblTransactions11 ADD `WaiterName` VARCHAR(100) NOT NULL;
ALTER TABLE tblTransactions12 ADD `WaiterID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 2;
ALTER TABLE tblTransactions12 ADD `WaiterName` VARCHAR(100) NOT NULL;

/*****************************
**	tblReceipt
*****************************/
DROP TABLE IF EXISTS tblReceipt;
CREATE TABLE tblReceipt (
	`Module` VARCHAR(40) NOT NULL,
	`Text` VARCHAR(40),
	`Value` VARCHAR(40),
	`Orientation` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
	INDEX `IX_tblReceipt`(`Text`),
	INDEX `IX1_tblReceipt`(`Value`)
);


INSERT INTO tblReceipt VALUES ('ReportHeaderSpacer', '','0',0);

INSERT INTO tblReceipt VALUES ('ReportHeader1', '','6937 Rosal Street Guadalupe Viejo',1);
INSERT INTO tblReceipt VALUES ('ReportHeader2', '','Makati City, Phil',1);
INSERT INTO tblReceipt VALUES ('ReportHeader3', '','{DateNow}',1);
INSERT INTO tblReceipt VALUES ('ReportHeader4', '','',1);
INSERT INTO tblReceipt VALUES ('ReportHeader5', '','',1);
INSERT INTO tblReceipt VALUES ('ReportHeader6', '','',1);
INSERT INTO tblReceipt VALUES ('ReportHeader7', '','',1);
INSERT INTO tblReceipt VALUES ('ReportHeader8', '','',1);
INSERT INTO tblReceipt VALUES ('ReportHeader9', '','',1);
INSERT INTO tblReceipt VALUES ('ReportHeader10', '','',1);



INSERT INTO tblReceipt VALUES ('PageHeader1', '',	'TIN: 007-094-991-000',0);
INSERT INTO tblReceipt VALUES ('PageHeader2', 'OFFICIAL RECEIPT','{InvoiceNo}',1);
INSERT INTO tblReceipt VALUES ('PageHeader3', '','',0);
INSERT INTO tblReceipt VALUES ('PageHeader4', '','',0);
INSERT INTO tblReceipt VALUES ('PageHeader5', '','',0);
INSERT INTO tblReceipt VALUES ('PageHeader6', '','',0);
INSERT INTO tblReceipt VALUES ('PageHeader7', '','',0);
INSERT INTO tblReceipt VALUES ('PageHeader8', '','',0);
INSERT INTO tblReceipt VALUES ('PageHeader9', '','',0);
INSERT INTO tblReceipt VALUES ('PageHeader10', '','',0);

INSERT INTO tblReceipt VALUES ('PageFooterA1',	'','',0);
INSERT INTO tblReceipt VALUES ('PageFooterA2',	'','----------------------------------------',1);
INSERT INTO tblReceipt VALUES ('PageFooterA3',	'SUBTOTAL',			'{SUBTOTAL}',0);
INSERT INTO tblReceipt VALUES ('PageFooterA4',	'OTH CHARGE',		'{OTH CHARGE}',0);
INSERT INTO tblReceipt VALUES ('PageFooterA5',	'DISCOUNT',			'{DISCOUNT}',0);
INSERT INTO tblReceipt VALUES ('PageFooterA6',	'AMOUNT DUE',		'{AMOUNT DUE}',0);
INSERT INTO tblReceipt VALUES ('PageFooterA7',	'AMOUNT TENDER',	'{AMOUNT TENDER}',0);
INSERT INTO tblReceipt VALUES ('PageFooterA8',	'CHANGE',			'{CHANGE}',0);
INSERT INTO tblReceipt VALUES ('PageFooterA9', '','{NewLine}',0);
INSERT INTO tblReceipt VALUES ('PageFooterA10', 'NON-VAT AMT.',		'{NON-VAT AMT}',0);
INSERT INTO tblReceipt VALUES ('PageFooterA11', 'VATABLE AMT.',		'{VATABLE AMT}',0);
INSERT INTO tblReceipt VALUES ('PageFooterA12', 'VAT',				'{VAT}',0);
INSERT INTO tblReceipt VALUES ('PageFooterA13', '','----------------------------------------',1);
INSERT INTO tblReceipt VALUES ('PageFooterA14', '','',0);
INSERT INTO tblReceipt VALUES ('PageFooterA15', '','',0);
INSERT INTO tblReceipt VALUES ('PageFooterA16', '','',0);
INSERT INTO tblReceipt VALUES ('PageFooterA17', '','',0);
INSERT INTO tblReceipt VALUES ('PageFooterA18', '','',0);
INSERT INTO tblReceipt VALUES ('PageFooterA19', '','',0);
INSERT INTO tblReceipt VALUES ('PageFooterA20', '','',0);

INSERT INTO tblReceipt VALUES ('PageFooterB1', '', '{NewLine}',0);
INSERT INTO tblReceipt VALUES ('PageFooterB2', 'TTL ITEM SOLD','{TTL ITEM SOLD}',0);
INSERT INTO tblReceipt VALUES ('PageFooterB3', 'TTL QTY SOLD','{TTL QTY SOLD}',0);
INSERT INTO tblReceipt VALUES ('PageFooterB4', 'Customer','{Customer Name}',0);
INSERT INTO tblReceipt VALUES ('PageFooterB5', 'Acc. No.:', '{AccreditationNo}',0);


INSERT INTO tblReceipt VALUES ('ReportFooter1', 'Cashier','{Cashier}',1);
INSERT INTO tblReceipt VALUES ('ReportFooter2', 'Terminal #','{TerminalNo}',1);
INSERT INTO tblReceipt VALUES ('ReportFooter3', 'MIN','{MachineSerialNo}',1);
INSERT INTO tblReceipt VALUES ('ReportFooter4', '','',1);
INSERT INTO tblReceipt VALUES ('ReportFooter5', '','',1);

INSERT INTO tblReceipt VALUES ('ReportFooterSpacer', '','4',1);

/*****************************
**	tblInvAdjustment
*****************************/
DROP TABLE IF EXISTS tblInvAdjustmentItems;
DROP TABLE IF EXISTS tblInvAdjustment;
CREATE TABLE tblInvAdjustment (
	`InvAdjustmentID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`InvAdjustmentNo` VARCHAR(30) NOT NULL,
	`InvAdjustmentDate` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`SupplierID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 2,
	`SupplierCode` VARCHAR(25) NOT NULL,
	`SupplierContact` VARCHAR(75) NOT NULL,
	`SupplierAddress` VARCHAR(150) NOT NULL DEFAULT '',
	`SupplierTelephoneNo` VARCHAR(75) NOT NULL DEFAULT '',
	`SupplierModeOfTerms` INT(10) NOT NULL DEFAULT 0,
	`SupplierTerms` INT(10) NOT NULL DEFAULT 0,
	`RequiredDeliveryDate` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`BranchID` INT(4) UNSIGNED NOT NULL DEFAULT 2,
	`TransferredByID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`InvAdjustmentSubTotal` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`InvAdjustmentDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`InvAdjustmentVAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`InvAdjustmentVatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`InvAdjustmentStatus` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
	`InvAdjustmentRemarks` VARCHAR(150),
	`SupplierDRNo` VARCHAR(30) NOT NULL,
	`DeliveryDate` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`PaymentID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`CancelledDate` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`CancelledRemarks` VARCHAR(150),
	`CancelledByID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	PRIMARY KEY (InvAdjustmentID),
	INDEX `IX_tblInvAdjustment`(`InvAdjustmentID`),
	UNIQUE `PK_tblInvAdjustment`(`InvAdjustmentNo`),
	INDEX `IX1_tblInvAdjustment`(`SupplierID`),
	INDEX `IX2_tblInvAdjustment`(`BranchID`),
	INDEX `IX3_tblInvAdjustment`(`TransferredByID`)
);

/*****************************
**	tblInvAdjustmentItems
*****************************/
DROP TABLE IF EXISTS tblInvAdjustmentItems;
CREATE TABLE tblInvAdjustmentItems (
`InvAdjustmentItemID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
`InvAdjustmentID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
`ProductID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
`ProductCode` VARCHAR(30) NOT NULL,
`BarCode` VARCHAR(30) NOT NULL,
`Description` VARCHAR(100) NOT NULL,
`ProductUnitID` INT(3) UNSIGNED NOT NULL DEFAULT 0,
`ProductUnitCode` VARCHAR(30) NOT NULL,
`Quantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
`UnitCost` DECIMAL(18,3) NOT NULL DEFAULT 0,
`Discount` DECIMAL(18,3) NOT NULL DEFAULT 0,
`InPercent` TINYINT(1) NOT NULL DEFAULT 1,
`TotalDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0,
`Amount` DECIMAL(18,3) NOT NULL DEFAULT 0,
`VAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
`VatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
`EVAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
`EVatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
`LocalTax` DECIMAL(18,3) NOT NULL DEFAULT 0,
`VariationMatrixID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
`MatrixDescription` VARCHAR(150) NULL,
`ProductGroup` VARCHAR(20) NULL,
`ProductSubGroup` VARCHAR(20) NULL,
`InvAdjustmentItemStatus` SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
`IsVatable` TINYINT(1) NOT NULL DEFAULT 1,
`Remarks` VARCHAR(150),
PRIMARY KEY (`InvAdjustmentItemID`),
INDEX `IX_tblInvAdjustmentItems`(`InvAdjustmentItemID`),
INDEX `IX0_tblInvAdjustmentItems`(`InvAdjustmentID`, `ProductID`),
INDEX `IX1_tblInvAdjustmentItems`(`InvAdjustmentID`, `ProductID`,`VariationMatrixID`),
INDEX `IX2_tblInvAdjustmentItems`(`ProductCode`),
INDEX `IX3_tblInvAdjustmentItems`(`InvAdjustmentID`),
INDEX `IX4_tblInvAdjustmentItems`(`ProductUnitID`)
); 


/*****************************
**	tblInvAdjustment
*****************************/
DROP TABLE IF EXISTS tblInvAdjustmentItems;
DROP TABLE IF EXISTS tblInvAdjustment;
CREATE TABLE tblInvAdjustment (
	`InvAdjustmentID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`InvAdjustmentNo` VARCHAR(30) NOT NULL,
	`InvAdjustmentDate` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`SupplierID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 2,
	`SupplierCode` VARCHAR(25) NOT NULL,
	`SupplierContact` VARCHAR(75) NOT NULL,
	`SupplierAddress` VARCHAR(150) NOT NULL DEFAULT '',
	`SupplierTelephoneNo` VARCHAR(75) NOT NULL DEFAULT '',
	`SupplierModeOfTerms` INT(10) NOT NULL DEFAULT 0,
	`SupplierTerms` INT(10) NOT NULL DEFAULT 0,
	`RequiredDeliveryDate` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`BranchID` INT(4) UNSIGNED NOT NULL DEFAULT 2,
	`TransferredByID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`InvAdjustmentSubTotal` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`InvAdjustmentDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`InvAdjustmentVAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`InvAdjustmentVatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`InvAdjustmentStatus` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
	`InvAdjustmentRemarks` VARCHAR(150),
	`SupplierDRNo` VARCHAR(30) NOT NULL,
	`DeliveryDate` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`PaymentID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`CancelledDate` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`CancelledRemarks` VARCHAR(150),
	`CancelledByID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	PRIMARY KEY (InvAdjustmentID),
	INDEX `IX_tblInvAdjustment`(`InvAdjustmentID`),
	UNIQUE `PK_tblInvAdjustment`(`InvAdjustmentNo`),
	INDEX `IX1_tblInvAdjustment`(`SupplierID`),
	INDEX `IX2_tblInvAdjustment`(`BranchID`),
	INDEX `IX3_tblInvAdjustment`(`TransferredByID`)
);

/*****************************
**	tblInvAdjustmentItems
*****************************/
DROP TABLE IF EXISTS tblInvAdjustmentItems;
CREATE TABLE tblInvAdjustmentItems (
	`InvAdjustmentItemID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`InvAdjustmentID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`ProductID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`ProductCode` VARCHAR(30) NOT NULL,
	`BarCode` VARCHAR(30) NOT NULL,
	`Description` VARCHAR(100) NOT NULL,
	`ProductUnitID` INT(3) UNSIGNED NOT NULL DEFAULT 0,
	`ProductUnitCode` VARCHAR(30) NOT NULL,
	`Quantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`UnitCost` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`Discount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`InPercent` TINYINT(1) NOT NULL DEFAULT 1,
	`TotalDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`Amount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`EVatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`LocalTax` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`VariationMatrixID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`MatrixDescription` VARCHAR(150) NULL,
	`ProductGroup` VARCHAR(20) NULL,
	`ProductSubGroup` VARCHAR(20) NULL,
	`InvAdjustmentItemStatus` SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
	`IsVatable` TINYINT(1) NOT NULL DEFAULT 1,
	`Remarks` VARCHAR(150),
	PRIMARY KEY (`InvAdjustmentItemID`),
	INDEX `IX_tblInvAdjustmentItems`(`InvAdjustmentItemID`),
	INDEX `IX0_tblInvAdjustmentItems`(`InvAdjustmentID`, `ProductID`),
	INDEX `IX1_tblInvAdjustmentItems`(`InvAdjustmentID`, `ProductID`,`VariationMatrixID`),
	INDEX `IX2_tblInvAdjustmentItems`(`ProductCode`),
	INDEX `IX3_tblInvAdjustmentItems`(`InvAdjustmentID`),
	INDEX `IX4_tblInvAdjustmentItems`(`ProductUnitID`)
); 

/*****************************
**	tblPLUReport
**  PLU Report Extraction
*****************************/
DROP TABLE IF EXISTS tblPLUReport;
CREATE TABLE tblPLUReport (
`PLUReportID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
`TerminalNo` VARCHAR(10) NOT NULL,
`ProductID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
`ProductCode` VARCHAR(30) NOT NULL,
`Quantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
`Amount` DECIMAL(18,3) NOT NULL DEFAULT 0,
PRIMARY KEY (PLUReportID),
INDEX `IX_tblPLUReport`(`TerminalNo`, `ProductCode`),
INDEX `IX1_tblPLUReport`(`TerminalNo`)
);


/*****************************
**	tblPLUReport
**  PLU Report Extraction
*****************************/
DROP TABLE IF EXISTS tblPLUReport;
CREATE TABLE tblPLUReport (
`PLUReportID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
`TerminalNo` VARCHAR(10) NOT NULL,
`ProductID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
`ProductCode` VARCHAR(30) NOT NULL,
`Quantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
`Amount` DECIMAL(18,3) NOT NULL DEFAULT 0,
PRIMARY KEY (PLUReportID),
INDEX `IX_tblPLUReport`(`TerminalNo`, `ProductCode`),
INDEX `IX1_tblPLUReport`(`TerminalNo`)
);

/*****************************
**	tblRemoteBranchInventory
*****************************/
DROP TABLE IF EXISTS tblRemoteBranchInventory;
CREATE TABLE tblRemoteBranchInventory (
	`BranchInventoryID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`ProductID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`ProductCode` VARCHAR(30) NOT NULL,
	`VariationMatrixID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`MatrixDescription` VARCHAR(150) NULL,
	`Quantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`BranchID` INT(4) UNSIGNED NOT NULL DEFAULT 0,
	PRIMARY KEY (BranchInventoryID),
	INDEX `IX_tblRemoteBranchInventory`(`ProductCode`, `BranchID`),
	INDEX `IX1_tblRemoteBranchInventory`(`BranchID`)
); 

/*****************************
**	Added on November 28, 2008 for packing terminal
**	Lem E. Aceron
*****************************/

ALTER TABLE tblTransactions01 ADD `Packed` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions02 ADD `Packed` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions03 ADD `Packed` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions04 ADD `Packed` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions05 ADD `Packed` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions06 ADD `Packed` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions07 ADD `Packed` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions08 ADD `Packed` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions09 ADD `Packed` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions10 ADD `Packed` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions11 ADD `Packed` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions12 ADD `Packed` TINYINT(1) NOT NULL DEFAULT 0;

ALTER TABLE tblTerminal ADD `ShowOneTerminalSuspendedTransactions` TINYINT(1) NOT NULL DEFAULT 1;
ALTER TABLE tblTerminal ADD `ShowOnlyPackedTransactions` TINYINT(1) NOT NULL DEFAULT 0;

/************************************
**	TerminalReceiptType
**	0 = POS terminal report
**	1 = Sales Invoice or Cash Invoice
************************************/
ALTER TABLE tblTerminal ADD `TerminalReceiptType` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminal ADD `SalesInvoicePrinterName` varchar(30) NOT NULL DEFAULT 'RetailPlus';
ALTER TABLE tblTerminal ADD `CashCountBeforeReport` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminal ADD `PreviewTerminalReport` TINYINT(1) NOT NULL DEFAULT 1;


INSERT INTO sysAccessTypes (TypeID, TypeName) VALUES (120, 'PackUnpackTransaction');

INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 120, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 120, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 120, 1, 1);

INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 120, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 120, 1, 1);

/*****************************
**	Added on Dec 01, 2008 for cas count
**	Lem E. Aceron
*****************************/

ALTER TABLE tblCashierReport ADD `IsCashCountInitialized` TINYINT(1) NOT NULL DEFAULT 0; 

/******************************************************************
**	Added on Dec 09, 2008 for OrderSlipPrinter
**	Lem E. Aceron
**
** OrderSlipPrinter Types
** 0 = Print to 1st printer PrinterName=RetailPlusOSPrinter1
** 1 = Print to 2nd printer PrinterName=RetailPlusOSPrinter2
** 2 = Print to 2nd printer PrinterName=RetailPlusOSPrinter3
** 3 = print to 4th printer PrinterName=RetailPlusOSPrinter4
** 4 = print to 5th printer PrinterName=RetailPlusOSPrinter5

******************************************************************/

ALTER TABLE tblProductGroup ADD `OrderSlipPrinter` TINYINT(1) NOT NULL DEFAULT 0;

ALTER TABLE tblTerminal ADD `OrderSlipPrinter` TINYINT(1) NOT NULL DEFAULT 0;

ALTER TABLE tblTransactionItems01 ADD `OrderSlipPrinter` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems02 ADD `OrderSlipPrinter` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems03 ADD `OrderSlipPrinter` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems04 ADD `OrderSlipPrinter` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems05 ADD `OrderSlipPrinter` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems06 ADD `OrderSlipPrinter` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems07 ADD `OrderSlipPrinter` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems08 ADD `OrderSlipPrinter` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems09 ADD `OrderSlipPrinter` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems10 ADD `OrderSlipPrinter` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems11 ADD `OrderSlipPrinter` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems12 ADD `OrderSlipPrinter` TINYINT(1) NOT NULL DEFAULT 0;

/******************************************************************
**	Added on Dec 18, 2008 for OrderSlipPrinted
**	Lem E. Aceron
**
** OrderSlipPrinted Types
** 0 = not yet printed
** 1 = printed

******************************************************************/
ALTER TABLE tblTransactionItems01 ADD `OrderSlipPrinted` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems02 ADD `OrderSlipPrinted` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems03 ADD `OrderSlipPrinted` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems04 ADD `OrderSlipPrinted` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems05 ADD `OrderSlipPrinted` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems06 ADD `OrderSlipPrinted` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems07 ADD `OrderSlipPrinted` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems08 ADD `OrderSlipPrinted` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems09 ADD `OrderSlipPrinted` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems10 ADD `OrderSlipPrinted` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems11 ADD `OrderSlipPrinted` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems12 ADD `OrderSlipPrinted` TINYINT(1) NOT NULL DEFAULT 0; 

/*****************************
**	Added on December 26, 2008 Total Stock Report
**	Lem E. Aceron
*****************************/ 

INSERT INTO sysAccessTypes (TypeID, TypeName) VALUES (121, 'TotalStockReport');

INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 121, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 121, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (3, 121, 1, 1);

INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 121, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (2, 121, 1, 1);


INSERT INTO sysAccessTypes (TypeID, TypeName) VALUES (122, 'ItemSetupFinancial');
INSERT INTO sysAccessTypes (TypeID, TypeName) VALUES (123, 'APLinkConfig');

INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 122, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 123, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 122, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 123, 1, 1);

ALTER TABLE tblProducts ADD ChartOfAccountIDPurchase INT(4) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE tblProducts ADD ChartOfAccountIDTaxPurchase INT(4) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE tblProducts ADD ChartOfAccountIDSold INT(4) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE tblProducts ADD ChartOfAccountIDTaxSold INT(4) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE tblProducts ADD ChartOfAccountIDInventory INT(4) UNSIGNED NOT NULL DEFAULT 0;

ALTER TABLE tblProductGroup ADD ChartOfAccountIDPurchase INT(4) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE tblProductGroup ADD ChartOfAccountIDTaxPurchase INT(4) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE tblProductGroup ADD ChartOfAccountIDSold INT(4) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE tblProductGroup ADD ChartOfAccountIDTaxSold INT(4) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE tblProductGroup ADD ChartOfAccountIDInventory INT(4) UNSIGNED NOT NULL DEFAULT 0; 

ALTER TABLE tblProductSubGroup ADD ChartOfAccountIDPurchase INT(4) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE tblProductSubGroup ADD ChartOfAccountIDTaxPurchase INT(4) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE tblProductSubGroup ADD ChartOfAccountIDSold INT(4) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE tblProductSubGroup ADD ChartOfAccountIDTaxSold INT(4) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE tblProductSubGroup ADD ChartOfAccountIDInventory INT(4) UNSIGNED NOT NULL DEFAULT 0; 



/**************************************************************
** February 7. 2009
** Lem E. Aceron
**
** 1.Add OrderSlipPrinter for printing PLU Report group by
**   OrderSlipPrinter
**
**************************************************************/
ALTER TABLE tblPLUReport ADD `OrderSlipPrinter` TINYINT(1) NOT NULL DEFAULT 0;

INSERT INTO sysAccessTypes (TypeID, TypeName) VALUES (124, 'ReprintZRead');
INSERT INTO sysAccessTypes (TypeID, TypeName) VALUES (125, 'PLUReportPerOrderSlipPrinter');

INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 124, 1, 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 125, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 124, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 125, 1, 1);

/**************************************************************
** March 14, 2009
** Lem E. Aceron
**
** 1. Add table to hold temporary records for sales per item
** 2. Add stored procedure to insert the records
** 3. Add stored procedure to select the records
**
**************************************************************/

DROP TABLE IF EXISTS tblSalesPerItem;
CREATE TABLE tblSalesPerItem (
`SessionID` VARCHAR(30) NOT NULL,
`ProductCode` VARCHAR(100) NOT NULL,
`Quantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
`Amount` DECIMAL(18,3) NOT NULL DEFAULT 0,
`PurchaseAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
INDEX `IX_tblSalesPerItem`(`SessionID`),
INDEX `IX_tblSalesPerItem1`(`ProductCode`)
);


/********************************************
Lem E. Aceron

Cater the requirement of RLC

********************************************/
ALTER TABLE tblProducts ADD `IsItemSold` TINYINT(1) NOT NULL DEFAULT 1;

ALTER TABLE tblTerminalReport ADD `NoOfDiscountedTransactions` INT(4) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReport ADD `NegativeAdjustments` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReport ADD `NoOfNegativeAdjustmentTransactions` INT(4) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReport ADD `PromotionalItems` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReport ADD `CreditSalesTax` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReport ADD `BatchCounter` INT(4) NOT NULL DEFAULT 1;

ALTER TABLE tblTerminalReportHistory ADD `NoOfDiscountedTransactions` INT(4) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReportHistory ADD `NegativeAdjustments` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReportHistory ADD `NoOfNegativeAdjustmentTransactions` INT(4) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReportHistory ADD `PromotionalItems` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReportHistory ADD `CreditSalesTax` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReportHistory ADD `BatchCounter` INT(4) NOT NULL DEFAULT 1;

ALTER TABLE tblCashierReport ADD `NoOfDiscountedTransactions` INT(4) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReport ADD `NegativeAdjustments` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReport ADD `NoOfNegativeAdjustmentTransactions` INT(4) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReport ADD `PromotionalItems` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReport ADD `CreditSalesTax` DECIMAL(18,3) NOT NULL DEFAULT 0;

ALTER TABLE tblCashierReportHistory ADD `NoOfDiscountedTransactions` INT(4) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReportHistory ADD `NegativeAdjustments` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReportHistory ADD `NoOfNegativeAdjustmentTransactions` INT(4) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReportHistory ADD `PromotionalItems` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReportHistory ADD `CreditSalesTax` DECIMAL(18,3) NOT NULL DEFAULT 0;

/**************************************************************
** March 14, 2009
** Lem E. Aceron
**
** 1. Add table to hold temporary records for sales per item
** 2. Add stored procedure to insert the records
** 3. Add stored procedure to select the records
**
**************************************************************/

DROP TABLE IF EXISTS tblProductHistory;
CREATE TABLE tblProductHistory (
`SessionID` VARCHAR(30) NOT NULL,
`HistoryID` BIGINT NOT NULL DEFAULT 0,
`ProductID` BIGINT NOT NULL DEFAULT 0,
`MatrixID` BIGINT NOT NULL DEFAULT 0,
`MatrixDescription` VARCHAR(100) NOT NULL,
`Quantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
`UnitCode` VARCHAR(100) NOT NULL,
`Remarks` VARCHAR(100) NOT NULL,
`TransactionDate` DateTime NOT NULL,
`TransactionNo` VARCHAR(100) NOT NULL,
INDEX `IX_tblProductHistory`(`SessionID`),
INDEX `IX_tblProductHistory1`(`MatrixDescription`)
);

ALTER TABLE tblProducts ADD `WillPrintProductComposition` TINYINT(1) NOT NULL DEFAULT 1;

/*********************************  v_2.0.0.0.sql START  *******************************************************/

INSERT INTO sysAccessTypes (TypeID, TypeName) VALUES (126, 'MallForwarder');

INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 126, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 126, 1, 1);


/*********************************  v_2.0.0.0.sql END  *******************************************************/

/*********************************  v_2.0.0.1.sql START  *******************************************************/
	
/*********************************
Lem E. Aceron
April 22, 2009
*********************************/
ALTER TABLE tblTerminal ADD DBVersion varchar(15) NOT NULL DEFAULT 'v_2.0.0.1'; 
ALTER TABLE tblTerminal ADD FEVersion varchar(15) NOT NULL DEFAULT 'v_2.0.0.1'; 
ALTER TABLE tblTerminal ADD BEVersion varchar(15) NOT NULL DEFAULT 'v_2.0.0.1'; 

/*********************************  v_2.0.0.1.sql END  *******************************************************/

/*********************************  v_2.0.0.2.sql START  *******************************************************/

UPDATE tblTerminal SET DBVersion = 'v_2.0.0.2';

ALTER TABLE tblReceipt MODIFY `TEXT` varchar(20);
	
/*********************************
Lem E. Aceron
May 1, 2009

OrderType values:
	0 = DINEIN
	1 = TAKE OUT
	2 = DELIVERY
*********************************/
ALTER TABLE tblTransactions01 ADD OrderType smallint NOT NULL DEFAULT 0; 
ALTER TABLE tblTransactions02 ADD OrderType smallint NOT NULL DEFAULT 0; 
ALTER TABLE tblTransactions03 ADD OrderType smallint NOT NULL DEFAULT 0; 
ALTER TABLE tblTransactions04 ADD OrderType smallint NOT NULL DEFAULT 0; 
ALTER TABLE tblTransactions05 ADD OrderType smallint NOT NULL DEFAULT 0; 
ALTER TABLE tblTransactions06 ADD OrderType smallint NOT NULL DEFAULT 0; 
ALTER TABLE tblTransactions07 ADD OrderType smallint NOT NULL DEFAULT 0; 
ALTER TABLE tblTransactions08 ADD OrderType smallint NOT NULL DEFAULT 0; 
ALTER TABLE tblTransactions09 ADD OrderType smallint NOT NULL DEFAULT 0; 
ALTER TABLE tblTransactions10 ADD OrderType smallint NOT NULL DEFAULT 0; 
ALTER TABLE tblTransactions11 ADD OrderType smallint NOT NULL DEFAULT 0; 
ALTER TABLE tblTransactions12 ADD OrderType smallint NOT NULL DEFAULT 0; 


/*********************************
Create table for discount
*********************************/
ALTER TABLE tblDiscount MODIFY DiscountCode varchar(5);
ALTER TABLE tblTransactions01 MODIFY DiscountCode varchar(5);
ALTER TABLE tblTransactions02 MODIFY DiscountCode varchar(5);
ALTER TABLE tblTransactions03 MODIFY DiscountCode varchar(5);
ALTER TABLE tblTransactions04 MODIFY DiscountCode varchar(5);
ALTER TABLE tblTransactions05 MODIFY DiscountCode varchar(5);
ALTER TABLE tblTransactions06 MODIFY DiscountCode varchar(5);
ALTER TABLE tblTransactions07 MODIFY DiscountCode varchar(5);
ALTER TABLE tblTransactions08 MODIFY DiscountCode varchar(5);
ALTER TABLE tblTransactions09 MODIFY DiscountCode varchar(5);
ALTER TABLE tblTransactions10 MODIFY DiscountCode varchar(5);
ALTER TABLE tblTransactions11 MODIFY DiscountCode varchar(5);
ALTER TABLE tblTransactions12 MODIFY DiscountCode varchar(5);

ALTER TABLE tblTransactionItems01 MODIFY DiscountCode varchar(5);
ALTER TABLE tblTransactionItems02 MODIFY DiscountCode varchar(5);
ALTER TABLE tblTransactionItems03 MODIFY DiscountCode varchar(5);
ALTER TABLE tblTransactionItems04 MODIFY DiscountCode varchar(5);
ALTER TABLE tblTransactionItems05 MODIFY DiscountCode varchar(5);
ALTER TABLE tblTransactionItems06 MODIFY DiscountCode varchar(5);
ALTER TABLE tblTransactionItems07 MODIFY DiscountCode varchar(5);
ALTER TABLE tblTransactionItems08 MODIFY DiscountCode varchar(5);
ALTER TABLE tblTransactionItems09 MODIFY DiscountCode varchar(5);
ALTER TABLE tblTransactionItems10 MODIFY DiscountCode varchar(5);
ALTER TABLE tblTransactionItems11 MODIFY DiscountCode varchar(5);
ALTER TABLE tblTransactionItems12 MODIFY DiscountCode varchar(5);

-- This fields are from .config file, moved to database.
ALTER TABLE tblTerminal ADD IsPrinterDotmatrix TINYINT(1) NOT NULL DEFAULT 1;
ALTER TABLE tblTerminal ADD IsChargeEditable TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminal ADD IsDiscountEditable TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminal ADD CheckCutOffTime TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminal ADD StartCutOffTime VARCHAR(5) NOT NULL DEFAULT '00:00';
ALTER TABLE tblTerminal ADD EndCutOffTime VARCHAR(5) NOT NULL DEFAULT '23:59';
ALTER TABLE tblTerminal ADD WithRestaurantFeatures TINYINT(1) NOT NULL DEFAULT 0;
		
-- Make a default DiscountCode for Senior Citizen Discount.
ALTER TABLE tblTerminal ADD SeniorCitizenDiscountCode VARCHAR(5);

UPDATE tblTerminal SET SeniorCitizenDiscountCode = 'SENCZ';

DROP TABLE IF EXISTS tblDiscountHistory;
CREATE TABLE tblDiscountHistory (
	`SessionID` VARCHAR(30) NOT NULL,
	`TerminalNo` VARCHAR(30) NOT NULL,
	`DiscountCode` VARCHAR(5) NOT NULL,
	`DiscountCount` BIGINT(20) NOT NULL DEFAULT 0,
	`Discount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	INDEX `IX_tblDiscount`(`SessionID`),
	INDEX `IX_tblDiscount1`(`DiscountCode`)
);

/*********************************  v_2.0.0.2.sql END  *******************************************************/

/*********************************  v_2.0.0.3.sql START  *****************************************************/

-- Added procGenerateSalesPerItemByGroup for P&L per item., run retailplus_proc.sql

DELETE FROM tblSalesPerItem;

UPDATE tblTerminal SET DBVersion = 'v_2.0.0.3';

ALTER TABLE tblTerminal ADD `IsTouchScreen` TINYINT(1) NOT NULL DEFAULT 0; 

ALTER TABLE tblTerminalReportHistory ADD `MallFileName` VARCHAR(30); 
ALTER TABLE tblTerminalReportHistory ADD `IsMallFileUploadComplete` TINYINT(1) NOT NULL DEFAULT 0; 

UPDATE tblTerminalReportHistory SET IsMallFileUploadComplete = 1 WHERE MallFileName IS NOT NULL;

ALTER TABLE tblDeposit ADD `Remarks` VARCHAR(255); 
ALTER TABLE tblWithHold ADD `Remarks` VARCHAR(255); 
ALTER TABLE tblDisburse ADD `Remarks` VARCHAR(255); 

/*********************************  v_2.0.0.3.sql END  *******************************************************/

/*********************************  v_2.0.0.4.sql START  *****************************************************/

-- Added procProductPackageUpdate for P&L per item., run retailplus_proc.sql

UPDATE tblTerminal SET DBVersion = 'v_2.0.0.4';

/*****************************
**	tblProductPackagePriceHistory
*****************************/
DROP TABLE IF EXISTS tblProductPackagePriceHistory;
CREATE TABLE tblProductPackagePriceHistory (
	`HistoryID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`UID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`PackageID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`ChangeDate` DATETIME NOT NULL,
	`PurchasePriceBefore` DECIMAL(18,3),
	`PurchasePriceNow` DECIMAL(18,3),
	`SellingPriceBefore` DECIMAL(18,3),
	`SellingPriceNow` DECIMAL(18,3),
	`VATBefore` DECIMAL(18,3),
	`VATNow` DECIMAL(18,3),
	`EVATBefore` DECIMAL(18,3),
	`EVATNow` DECIMAL(18,3),
	`LocalTaxBefore` DECIMAL(18,3),
	`LocalTaxNow` DECIMAL(18,3),
PRIMARY KEY (`HistoryID`),
INDEX `IX_tblProductPackagePriceHistory`(`HistoryID`),
INDEX `IX1_tblProductPackagePriceHistory`(`UID`),
INDEX `IX2_tblProductPackagePriceHistory`(`ChangeDate`)
);

/*****************************
**	tblMatrixPackagePriceHistory
*****************************/
DROP TABLE IF EXISTS tblMatrixPackagePriceHistory;
CREATE TABLE tblMatrixPackagePriceHistory (
	`HistoryID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`UID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`PackageID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`ChangeDate` DATETIME NOT NULL,
	`PurchasePriceBefore` DECIMAL(18,3),
	`PurchasePriceNow` DECIMAL(18,3),
	`SellingPriceBefore` DECIMAL(18,3),
	`SellingPriceNow` DECIMAL(18,3),
	`VATBefore` DECIMAL(18,3),
	`VATNow` DECIMAL(18,3),
	`EVATBefore` DECIMAL(18,3),
	`EVATNow` DECIMAL(18,3),
	`LocalTaxBefore` DECIMAL(18,3),
	`LocalTaxNow` DECIMAL(18,3),
PRIMARY KEY (`HistoryID`),
INDEX `IX_tblMatrixPackagePriceHistory`(`HistoryID`),
INDEX `IX1_tblMatrixPackagePriceHistory`(`UID`),
INDEX `IX2_tblMatrixPackagePriceHistory`(`ChangeDate`)
);

INSERT INTO sysAccessTypes (TypeID, TypeName) VALUES (127, 'Change Product Price');

INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 127, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 127, 1, 1);

/*********************************  v_2.0.0.4.sql END  *******************************************************/

/*********************************  v_2.0.0.5.sql START  *****************************************************/
-- SELECT IFNULL(AllowRead,0) as 'Read', IFNULL(AllowWrite,0) as 'Write'
-- FROM sysAccessRights a INNER JOIN sysAccessTypes b ON a.TranTypeID = b.TypeID
-- WHERE UID = 1 AND TranTypeID = 3 AND Enabled=1


UPDATE tblTerminal SET DBVersion = 'v_2.0.0.5';

ALTER TABLE sysAccessTypes ADD Enabled smallint NOT NULL DEFAULT 1; 

-- Added August 2, 2009 to monitor if product still has/have variations
ALTER TABLE tblProducts ADD VariationCount BIGINT NOT NULL DEFAULT 0;

UPDATE tblProducts SET VariationCount = (SELECT COUNT(MatrixID) FROM tblProductBaseVariationsMatrix z WHERE tblProducts.ProductID = z.ProductID);

/*****************************
**	tblProductPrices
*****************************/
DROP TABLE IF EXISTS tblProductPrices;
CREATE TABLE tblProductPrices (
	`SessionID` VARCHAR(30) NOT NULL,
	`ProductID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`ProductCode` VARCHAR(30) NOT NULL,
	`ProductDescription` VARCHAR(30) NOT NULL,
	`MatrixDescription` VARCHAR(100) NOT NULL,
	`ProductGroupID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`ProductGroupName` VARCHAR(30) NOT NULL,
	`ProductSubGroupID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`ProductSubGroupName` VARCHAR(30) NOT NULL,
	`Quantity` DECIMAL(18,3),
	`UnitCode` VARCHAR(10) NOT NULL,
	`UnitName` VARCHAR(30) NOT NULL,
	`PurchasePrice` DECIMAL(18,3),
	`Price` DECIMAL(18,3),
	`VAT` DECIMAL(18,3),
	`EVAT` DECIMAL(18,3),
	`LocalTax` DECIMAL(18,3),
INDEX `IX_tblProductPrices`(`SessionID`),
INDEX `IX1_tblProductPrices`(`ProductID`),
INDEX `IX2_tblProductPrices`(`ProductGroupID`),
INDEX `IX3_tblProductPrices`(`ProductSubGroupID`)
);

/*********************************  v_2.0.0.5.sql END  *******************************************************/

/*********************************  v_2.0.0.6.sql START  *****************************************************/

UPDATE tblTerminal SET DBVersion = 'v_2.0.0.6';

/*********************************
**
** May 29, 2011
** Lem E. Aceron
** Remove the 2 codes below to support the mysql version 5 and above
** No warning should be displayed from fresh install

ALTER TABLE sysAccessTypes DROP SequenceNo; 
ALTER TABLE sysAccessTypes DROP Category;
*********************************/

ALTER TABLE sysAccessTypes ADD SequenceNo INT NOT NULL DEFAULT 0; 
ALTER TABLE sysAccessTypes ADD Category VARCHAR(50) NOT NULL DEFAULT '01: System Configurations'; 

UPDATE sysAccessTypes SET SequenceNo = 1, Category = '01: System Configurations' WHERE TypeID = 1;
UPDATE sysAccessTypes SET SequenceNo = 2, Category = '01: System Configurations' WHERE TypeID = 43;
UPDATE sysAccessTypes SET SequenceNo = 3, Category = '01: System Configurations' WHERE TypeID = 48;
UPDATE sysAccessTypes SET SequenceNo = 4, Category = '01: System Configurations' WHERE TypeID = 123;
UPDATE sysAccessTypes SET SequenceNo = 5, Category = '01: System Configurations' WHERE TypeID = 47;
UPDATE sysAccessTypes SET SequenceNo = 6, Category = '01: System Configurations' WHERE TypeID = 82;
UPDATE sysAccessTypes SET SequenceNo = 7, Category = '01: System Configurations' WHERE TypeID = 49;
UPDATE sysAccessTypes SET SequenceNo = 8, Category = '01: System Configurations' WHERE TypeID = 77;
UPDATE sysAccessTypes SET SequenceNo = 1, Category = '02: Backend - Administration' WHERE TypeID = 46;
UPDATE sysAccessTypes SET SequenceNo = 2, Category = '02: Backend - Administration' WHERE TypeID = 44;
UPDATE sysAccessTypes SET SequenceNo = 3, Category = '02: Backend - Administration' WHERE TypeID = 45;
UPDATE sysAccessTypes SET SequenceNo = 1, Category = '03: Backend - Menu' WHERE TypeID = 2;
UPDATE sysAccessTypes SET SequenceNo = 2, Category = '03: Backend - Menu' WHERE TypeID = 3;
UPDATE sysAccessTypes SET SequenceNo = 3, Category = '03: Backend - Menu' WHERE TypeID = 93;
UPDATE sysAccessTypes SET SequenceNo = 4, Category = '03: Backend - Menu' WHERE TypeID = 104;
UPDATE sysAccessTypes SET SequenceNo = 5, Category = '03: Backend - Menu' WHERE TypeID = 111;
UPDATE sysAccessTypes SET SequenceNo = 6, Category = '03: Backend - Menu' WHERE TypeID = 103;
UPDATE sysAccessTypes SET SequenceNo = 7, Category = '03: Backend - Menu' WHERE TypeID = 20;
UPDATE sysAccessTypes SET SequenceNo = 8, Category = '03: Backend - Menu' WHERE TypeID = 24;
UPDATE sysAccessTypes SET SequenceNo = 9, Category = '03: Backend - Menu' WHERE TypeID = 42;
UPDATE sysAccessTypes SET SequenceNo = 1, Category = '04: Backend - MasterFiles' WHERE TypeID = 4;
UPDATE sysAccessTypes SET SequenceNo = 2, Category = '04: Backend - MasterFiles' WHERE TypeID = 5;
UPDATE sysAccessTypes SET SequenceNo = 3, Category = '04: Backend - MasterFiles' WHERE TypeID = 16;
UPDATE sysAccessTypes SET SequenceNo = 4, Category = '04: Backend - MasterFiles' WHERE TypeID = 17;
UPDATE sysAccessTypes SET SequenceNo = 5, Category = '04: Backend - MasterFiles' WHERE TypeID = 18;
UPDATE sysAccessTypes SET SequenceNo = 6, Category = '04: Backend - MasterFiles' WHERE TypeID = 19;
UPDATE sysAccessTypes SET SequenceNo = 7, Category = '04: Backend - MasterFiles' WHERE TypeID = 88;
UPDATE sysAccessTypes SET SequenceNo = 8, Category = '04: Backend - MasterFiles' WHERE TypeID = 119;
UPDATE sysAccessTypes SET SequenceNo = 1, Category = '05: Backend - MasterFiles - Products' WHERE TypeID = 12;
UPDATE sysAccessTypes SET SequenceNo = 2, Category = '05: Backend - MasterFiles - Products' WHERE TypeID = 13;
UPDATE sysAccessTypes SET SequenceNo = 3, Category = '05: Backend - MasterFiles - Products' WHERE TypeID = 14;
UPDATE sysAccessTypes SET SequenceNo = 4, Category = '05: Backend - MasterFiles - Products' WHERE TypeID = 15;
UPDATE sysAccessTypes SET SequenceNo = 5, Category = '05: Backend - MasterFiles - Products' WHERE TypeID = 10;
UPDATE sysAccessTypes SET SequenceNo = 6, Category = '05: Backend - MasterFiles - Products' WHERE TypeID = 11;
UPDATE sysAccessTypes SET SequenceNo = 7, Category = '05: Backend - MasterFiles - Products' WHERE TypeID = 8;
UPDATE sysAccessTypes SET SequenceNo = 8, Category = '05: Backend - MasterFiles - Products' WHERE TypeID = 9;
UPDATE sysAccessTypes SET SequenceNo = 9, Category = '05: Backend - MasterFiles - Products' WHERE TypeID = 7;
UPDATE sysAccessTypes SET SequenceNo = 10, Category = '05: Backend - MasterFiles - Products' WHERE TypeID = 6;
UPDATE sysAccessTypes SET SequenceNo = 11, Category = '05: Backend - MasterFiles - Products' WHERE TypeID = 92;
UPDATE sysAccessTypes SET SequenceNo = 12, Category = '05: Backend - MasterFiles - Products' WHERE TypeID = 122;
UPDATE sysAccessTypes SET SequenceNo = 13, Category = '05: Backend - MasterFiles - Products' WHERE TypeID = 127;
UPDATE sysAccessTypes SET SequenceNo = 1, Category = '06: Backend - Purchase And Payables' WHERE TypeID = 94;
UPDATE sysAccessTypes SET SequenceNo = 2, Category = '06: Backend - Purchase And Payables' WHERE TypeID = 105;
UPDATE sysAccessTypes SET SequenceNo = 3, Category = '06: Backend - Purchase And Payables' WHERE TypeID = 106;
UPDATE sysAccessTypes SET SequenceNo = 1, Category = '07: Backend - Sales And Receivables' WHERE TypeID = 107;
UPDATE sysAccessTypes SET SequenceNo = 2, Category = '07: Backend - Sales And Receivables' WHERE TypeID = 109;
UPDATE sysAccessTypes SET SequenceNo = 3, Category = '07: Backend - Sales And Receivables' WHERE TypeID = 108;
UPDATE sysAccessTypes SET SequenceNo = 4, Category = '07: Backend - Sales And Receivables' WHERE TypeID = 110;
UPDATE sysAccessTypes SET SequenceNo = 1, Category = '09: Backend - Inventory' WHERE TypeID = 21;
UPDATE sysAccessTypes SET SequenceNo = 2, Category = '09: Backend - Inventory' WHERE TypeID = 22;
UPDATE sysAccessTypes SET SequenceNo = 3, Category = '09: Backend - Inventory' WHERE TypeID = 23;
UPDATE sysAccessTypes SET SequenceNo = 4, Category = '09: Backend - Inventory' WHERE TypeID = 89;
UPDATE sysAccessTypes SET SequenceNo = 5, Category = '09: Backend - Inventory' WHERE TypeID = 90;
UPDATE sysAccessTypes SET SequenceNo = 6, Category = '09: Backend - Inventory' WHERE TypeID = 112;
UPDATE sysAccessTypes SET SequenceNo = 7, Category = '09: Backend - Inventory' WHERE TypeID = 113;
UPDATE sysAccessTypes SET SequenceNo = 8, Category = '09: Backend - Inventory' WHERE TypeID = 114;
UPDATE sysAccessTypes SET SequenceNo = 9, Category = '09: Backend - Inventory' WHERE TypeID = 115;
UPDATE sysAccessTypes SET SequenceNo = 10, Category = '09: Backend - Inventory' WHERE TypeID = 116;
UPDATE sysAccessTypes SET SequenceNo = 11, Category = '09: Backend - Inventory' WHERE TypeID = 117;
UPDATE sysAccessTypes SET SequenceNo = 12, Category = '09: Backend - Inventory' WHERE TypeID = 118;
UPDATE sysAccessTypes SET SequenceNo = 1, Category = '09: Backend - General Ledger' WHERE TypeID = 99;
UPDATE sysAccessTypes SET SequenceNo = 2, Category = '09: Backend - General Ledger' WHERE TypeID = 100;
UPDATE sysAccessTypes SET SequenceNo = 3, Category = '09: Backend - General Ledger' WHERE TypeID = 101;
UPDATE sysAccessTypes SET SequenceNo = 4, Category = '09: Backend - General Ledger' WHERE TypeID = 97;
UPDATE sysAccessTypes SET SequenceNo = 5, Category = '09: Backend - General Ledger' WHERE TypeID = 102;
UPDATE sysAccessTypes SET SequenceNo = 6, Category = '09: Backend - General Ledger' WHERE TypeID = 98;
UPDATE sysAccessTypes SET SequenceNo = 7, Category = '09: Backend - General Ledger' WHERE TypeID = 96;
UPDATE sysAccessTypes SET SequenceNo = 8, Category = '09: Backend - General Ledger' WHERE TypeID = 95;
UPDATE sysAccessTypes SET SequenceNo = 1, Category = '11: Backend - Inventory Reports' WHERE TypeID = 25;
UPDATE sysAccessTypes SET SequenceNo = 2, Category = '11: Backend - Inventory Reports' WHERE TypeID = 26;
UPDATE sysAccessTypes SET SequenceNo = 3, Category = '11: Backend - Inventory Reports' WHERE TypeID = 27;
UPDATE sysAccessTypes SET SequenceNo = 4, Category = '11: Backend - Inventory Reports' WHERE TypeID = 28;
UPDATE sysAccessTypes SET SequenceNo = 5, Category = '11: Backend - Inventory Reports' WHERE TypeID = 29;
UPDATE sysAccessTypes SET SequenceNo = 6, Category = '11: Backend - Inventory Reports' WHERE TypeID = 34;
UPDATE sysAccessTypes SET SequenceNo = 7, Category = '11: Backend - Inventory Reports' WHERE TypeID = 35;
UPDATE sysAccessTypes SET SequenceNo = 8, Category = '11: Backend - Inventory Reports' WHERE TypeID = 121;
UPDATE sysAccessTypes SET SequenceNo = 9, Category = '11: Backend - Inventory Reports' WHERE TypeID = 38;
UPDATE sysAccessTypes SET SequenceNo = 10, Category = '11: Backend - Inventory Reports' WHERE TypeID = 39;
UPDATE sysAccessTypes SET SequenceNo = 11, Category = '11: Backend - Inventory Reports' WHERE TypeID = 40;
UPDATE sysAccessTypes SET SequenceNo = 1, Category = '11: Backend - Sales Reports' WHERE TypeID = 41;
UPDATE sysAccessTypes SET SequenceNo = 2, Category = '11: Backend - Sales Reports' WHERE TypeID = 30;
UPDATE sysAccessTypes SET SequenceNo = 3, Category = '11: Backend - Sales Reports' WHERE TypeID = 36;
UPDATE sysAccessTypes SET SequenceNo = 1, Category = '12: Backend - Admin Reports' WHERE TypeID = 31;
UPDATE sysAccessTypes SET SequenceNo = 2, Category = '12: Backend - Admin Reports' WHERE TypeID = 32;
UPDATE sysAccessTypes SET SequenceNo = 3, Category = '12: Backend - Admin Reports' WHERE TypeID = 33;
UPDATE sysAccessTypes SET SequenceNo = 4, Category = '12: Backend - Admin Reports' WHERE TypeID = 86;
UPDATE sysAccessTypes SET SequenceNo = 1, Category = '13: Frontend - Administration' WHERE TypeID = 50;
UPDATE sysAccessTypes SET SequenceNo = 2, Category = '13: Frontend - Administration' WHERE TypeID = 51;
UPDATE sysAccessTypes SET SequenceNo = 3, Category = '13: Frontend - Administration' WHERE TypeID = 78;
UPDATE sysAccessTypes SET SequenceNo = 4, Category = '13: Frontend - Administration' WHERE TypeID = 79;
UPDATE sysAccessTypes SET SequenceNo = 5, Category = '13: Frontend - Administration' WHERE TypeID = 67;
UPDATE sysAccessTypes SET SequenceNo = 6, Category = '13: Frontend - Administration' WHERE TypeID = 126;
UPDATE sysAccessTypes SET SequenceNo = 7, Category = '13: Frontend - Administration' WHERE TypeID = 81;
UPDATE sysAccessTypes SET SequenceNo = 1, Category = '14: Frontend - Cashiering' WHERE TypeID = 52;
UPDATE sysAccessTypes SET SequenceNo = 2, Category = '14: Frontend - Cashiering' WHERE TypeID = 53;
UPDATE sysAccessTypes SET SequenceNo = 3, Category = '14: Frontend - Cashiering' WHERE TypeID = 54;
UPDATE sysAccessTypes SET SequenceNo = 4, Category = '14: Frontend - Cashiering' WHERE TypeID = 55;
UPDATE sysAccessTypes SET SequenceNo = 5, Category = '14: Frontend - Cashiering' WHERE TypeID = 56;
UPDATE sysAccessTypes SET SequenceNo = 6, Category = '14: Frontend - Cashiering' WHERE TypeID = 57;
UPDATE sysAccessTypes SET SequenceNo = 7, Category = '14: Frontend - Cashiering' WHERE TypeID = 58;
UPDATE sysAccessTypes SET SequenceNo = 8, Category = '14: Frontend - Cashiering' WHERE TypeID = 59;
UPDATE sysAccessTypes SET SequenceNo = 9, Category = '14: Frontend - Cashiering' WHERE TypeID = 60;
UPDATE sysAccessTypes SET SequenceNo = 10, Category = '14: Frontend - Cashiering' WHERE TypeID = 61;
UPDATE sysAccessTypes SET SequenceNo = 11, Category = '14: Frontend - Cashiering' WHERE TypeID = 62;
UPDATE sysAccessTypes SET SequenceNo = 12, Category = '14: Frontend - Cashiering' WHERE TypeID = 63;
UPDATE sysAccessTypes SET SequenceNo = 13, Category = '14: Frontend - Cashiering' WHERE TypeID = 64;
UPDATE sysAccessTypes SET SequenceNo = 14, Category = '14: Frontend - Cashiering' WHERE TypeID = 65;
UPDATE sysAccessTypes SET SequenceNo = 15, Category = '14: Frontend - Cashiering' WHERE TypeID = 66;
UPDATE sysAccessTypes SET SequenceNo = 16, Category = '14: Frontend - Cashiering' WHERE TypeID = 68;
UPDATE sysAccessTypes SET SequenceNo = 17, Category = '14: Frontend - Cashiering' WHERE TypeID = 80;
UPDATE sysAccessTypes SET SequenceNo = 18, Category = '14: Frontend - Cashiering' WHERE TypeID = 83;
UPDATE sysAccessTypes SET SequenceNo = 19, Category = '14: Frontend - Cashiering' WHERE TypeID = 84;
UPDATE sysAccessTypes SET SequenceNo = 20, Category = '14: Frontend - Cashiering' WHERE TypeID = 85;
UPDATE sysAccessTypes SET SequenceNo = 21, Category = '14: Frontend - Cashiering' WHERE TypeID = 87;
UPDATE sysAccessTypes SET SequenceNo = 22, Category = '14: Frontend - Cashiering' WHERE TypeID = 91;
UPDATE sysAccessTypes SET SequenceNo = 23, Category = '14: Frontend - Cashiering' WHERE TypeID = 120;
UPDATE sysAccessTypes SET SequenceNo = 1, Category = '15: Frontend - Reports' WHERE TypeID = 69;
UPDATE sysAccessTypes SET SequenceNo = 2, Category = '15: Frontend - Reports' WHERE TypeID = 70;
UPDATE sysAccessTypes SET SequenceNo = 3, Category = '15: Frontend - Reports' WHERE TypeID = 71;
UPDATE sysAccessTypes SET SequenceNo = 4, Category = '15: Frontend - Reports' WHERE TypeID = 72;
UPDATE sysAccessTypes SET SequenceNo = 5, Category = '15: Frontend - Reports' WHERE TypeID = 73;
UPDATE sysAccessTypes SET SequenceNo = 6, Category = '15: Frontend - Reports' WHERE TypeID = 74;
UPDATE sysAccessTypes SET SequenceNo = 7, Category = '15: Frontend - Reports' WHERE TypeID = 75;
UPDATE sysAccessTypes SET SequenceNo = 8, Category = '15: Frontend - Reports' WHERE TypeID = 76;
UPDATE sysAccessTypes SET SequenceNo = 9, Category = '15: Frontend - Reports' WHERE TypeID = 124;
UPDATE sysAccessTypes SET SequenceNo = 10, Category = '15: Frontend - Reports' WHERE TypeID = 125;
UPDATE sysAccessTypes SET SequenceNo = 11, Category = '15: Frontend - Reports' WHERE TypeID = 37;

		
/*********************************  v_2.0.0.6.sql END  *******************************************************/ 

/*********************************  v_2.0.0.7.sql START  *****************************************************/

UPDATE tblTerminal SET DBVersion = 'v_2.0.0.7';


ALTER TABLE tblProductPackagePriceHistory ADD Remarks VARCHAR(75) NOT NULL DEFAULT 'Change Price Module';
ALTER TABLE tblMatrixPackagePriceHistory ADD Remarks VARCHAR(75) NOT NULL DEFAULT 'Change Price Module';

UPDATE tblProductPackagePriceHistory SET Remarks = 'Change Price Module';
UPDATE tblMatrixPackagePriceHistory SET Remarks = 'Change Price Module';
		
/*********************************  v_2.0.0.7.sql END  *******************************************************/ 

 /*********************************  v_2.0.0.8.sql START  *****************************************************/

UPDATE tblTerminal SET DBVersion = 'v_2.0.0.8';


ALTER TABLE tblCashPayment ADD TransactionNo VARCHAR(30);
ALTER TABLE tblChequePayment ADD TransactionNo VARCHAR(30);
ALTER TABLE tblCreditCardPayment ADD TransactionNo VARCHAR(30);
ALTER TABLE tblCreditPayment ADD TransactionNo VARCHAR(30);
ALTER TABLE tblDebitPayment ADD TransactionNo VARCHAR(30);

ALTER TABLE tblCashPayment MODIFY Remarks VARCHAR(255);
ALTER TABLE tblChequePayment MODIFY Remarks VARCHAR(255);
ALTER TABLE tblCreditPayment MODIFY Remarks VARCHAR(255);
ALTER TABLE tblDebitPayment MODIFY Remarks VARCHAR(255);
	   
/*********************************
**
** May 29, 2011
** Lem E. Aceron
** Remove the codes below to support the mysql version 5 and above
** No warning should be displayed from fresh install
** Below code should be run if upgraded from lower version.

CALL procCreditPaymentSyncTransactionNo();
*********************************/

/*********************************  v_2.0.0.8.sql END  *******************************************************/  

 /*********************************  v_2.0.0.81.sql START  *****************************************************/

UPDATE tblTerminal SET DBVersion = 'v_2.0.0.81';

ALTER TABLE tblSalesPerItem ADD `ProductGroup` VARCHAR(100) NOT NULL;
ALTER TABLE tblSalesPerItem ADD `ProductUnitCode` VARCHAR(30) NOT NULL;

/*********************************  v_2.0.0.81.sql END  *******************************************************/  

 /*********************************  v_2.0.0.9.sql START  *****************************************************/

UPDATE tblTerminal SET DBVersion = 'v_2.0.0.9';

ALTER TABLE tblProducts DROP INDEX `IX_tblProducts`;
ALTER TABLE tblProducts DROP INDEX `PK_tblProducts`;

ALTER TABLE tblProducts ADD INDEX `IX_tblProducts` (`ProductID`, `ProductCode`,`ProductDesc`);
ALTER TABLE tblProducts ADD UNIQUE INDEX `PK_tblProducts` (`ProductCode`,`ProductDesc`);

ALTER TABLE tblProducts ADD `Active` TINYINT(1) NOT NULL DEFAULT 1;

/*********************************  v_2.0.0.9.sql END  *******************************************************/  

 /*********************************  v_2.0.1.1.sql START  *****************************************************/

UPDATE tblTerminal SET DBVersion = 'v_2.0.1.1';

ALTER TABLE tblProducts ADD `PercentageCommision` DECIMAL(18,3) NOT NULL DEFAULT 0;
UPDATE tblProducts SET `PercentageCommision` = 2 WHERE ProductID > 1;

ALTER TABLE tblTransactions01 ADD `AgentID` BIGINT(20) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactions01 ADD `AgentName` VARCHAR(100) DEFAULT 'RetailPlus Customer �';
ALTER TABLE tblTransactions02 ADD `AgentID` BIGINT(20) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactions02 ADD `AgentName` VARCHAR(100) DEFAULT 'RetailPlus Customer �';
ALTER TABLE tblTransactions03 ADD `AgentID` BIGINT(20) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactions03 ADD `AgentName` VARCHAR(100) DEFAULT 'RetailPlus Customer �';
ALTER TABLE tblTransactions04 ADD `AgentID` BIGINT(20) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactions04 ADD `AgentName` VARCHAR(100) DEFAULT 'RetailPlus Customer �';
ALTER TABLE tblTransactions05 ADD `AgentID` BIGINT(20) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactions05 ADD `AgentName` VARCHAR(100) DEFAULT 'RetailPlus Customer �';
ALTER TABLE tblTransactions06 ADD `AgentID` BIGINT(20) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactions06 ADD `AgentName` VARCHAR(100) DEFAULT 'RetailPlus Customer �';
ALTER TABLE tblTransactions07 ADD `AgentID` BIGINT(20) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactions07 ADD `AgentName` VARCHAR(100) DEFAULT 'RetailPlus Customer �';
ALTER TABLE tblTransactions08 ADD `AgentID` BIGINT(20) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactions08 ADD `AgentName` VARCHAR(100) DEFAULT 'RetailPlus Customer �';
ALTER TABLE tblTransactions09 ADD `AgentID` BIGINT(20) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactions09 ADD `AgentName` VARCHAR(100) DEFAULT 'RetailPlus Customer �';
ALTER TABLE tblTransactions10 ADD `AgentID` BIGINT(20) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactions10 ADD `AgentName` VARCHAR(100) DEFAULT 'RetailPlus Customer �';
ALTER TABLE tblTransactions11 ADD `AgentID` BIGINT(20) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactions11 ADD `AgentName` VARCHAR(100) DEFAULT 'RetailPlus Customer �';
ALTER TABLE tblTransactions12 ADD `AgentID` BIGINT(20) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactions12 ADD `AgentName` VARCHAR(100) DEFAULT 'RetailPlus Customer �';

ALTER TABLE tblTransactionItems01 ADD `PercentageCommision` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems01 ADD `Commision` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems02 ADD `PercentageCommision` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems02 ADD `Commision` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems03 ADD `PercentageCommision` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems03 ADD `Commision` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems04 ADD `PercentageCommision` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems04 ADD `Commision` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems05 ADD `PercentageCommision` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems05 ADD `Commision` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems06 ADD `PercentageCommision` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems06 ADD `Commision` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems07 ADD `PercentageCommision` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems07 ADD `Commision` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems08 ADD `PercentageCommision` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems08 ADD `Commision` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems09 ADD `PercentageCommision` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems09 ADD `Commision` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems10 ADD `PercentageCommision` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems10 ADD `Commision` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems11 ADD `PercentageCommision` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems11 ADD `Commision` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems12 ADD `PercentageCommision` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems12 ADD `Commision` DECIMAL(18,3) NOT NULL DEFAULT 0;

DROP TABLE IF EXISTS tblAgentsCommision;
CREATE TABLE tblAgentsCommision (
	`SessionID` VARCHAR(30) NOT NULL,
	`TransactionNo` VARCHAR(30) NOT NULL,
	`TransactionDate` DATETIME NOT NULL,
	`Description` VARCHAR(100) NOT NULL,
	`Quantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`Amount` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`PercentageCommision` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`Commision` DECIMAL(18,3) NOT NULL DEFAULT 0,
	INDEX `IX_tblAgentsCommision`(`SessionID`),
	INDEX `IX_tblAgentsCommision1`(`Description`)
);

/*********************************
**
** May 29, 2011 
** Lem E. Aceron
** Remove the drop command since this is a new update version to mysql 5
** 

ALTER TABLE tblTransactions01 DROP `Commision`;
ALTER TABLE tblTransactions02 DROP `Commision`;
ALTER TABLE tblTransactions03 DROP `Commision`;
ALTER TABLE tblTransactions04 DROP `Commision`;
ALTER TABLE tblTransactions05 DROP `Commision`;
ALTER TABLE tblTransactions06 DROP `Commision`;
ALTER TABLE tblTransactions07 DROP `Commision`;
ALTER TABLE tblTransactions08 DROP `Commision`;
ALTER TABLE tblTransactions09 DROP `Commision`;
ALTER TABLE tblTransactions10 DROP `Commision`;
ALTER TABLE tblTransactions11 DROP `Commision`;
ALTER TABLE tblTransactions12 DROP `Commision`;
*********************************/

/*********************************  v_2.0.1.1.sql END  *******************************************************/    

 /*********************************  v_2.0.1.2.sql START  *****************************************************/

UPDATE tblTerminal SET DBVersion = 'v_2.0.1.2';

DROP TABLE IF EXISTS tblProductPurchasePriceHistory;
CREATE TABLE tblProductPurchasePriceHistory (
`ProductPurchasePriceHistoryID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
`ProductID` BIGINT(20) NOT NULL DEFAULT 1,
`MatrixID` BIGINT(20) NOT NULL DEFAULT 0,
`SupplierID` BIGINT(20) NOT NULL DEFAULT 0,
`PurchasePrice` DECIMAL(18,3) NOT NULL DEFAULT 0,
`PurchaseDate` DATETIME NOT NULL,
`Remarks` VARCHAR(50),
PRIMARY KEY (ProductPurchasePriceHistoryID),
INDEX `IX_tblProductPurchasePriceHistory`(`ProductID`),
INDEX `IX_tblProductPurchasePriceHistory1`(`SupplierID`)
);

ALTER TABLE tblStock ADD `Active` TINYINT(1) NOT NULL DEFAULT 1;

/*********************************  v_2.0.1.2.sql END  *******************************************************/    

/*********************************  v_2.0.1.3.sql START  *****************************************************/

UPDATE tblTerminal SET DBVersion = 'v_2.0.1.3';

ALTER TABLE tblTransactions01 ADD `CreatedByID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions01 ADD `CreatedByName` VARCHAR(100);
ALTER TABLE tblTransactions02 ADD `CreatedByID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions02 ADD `CreatedByName` VARCHAR(100);
ALTER TABLE tblTransactions03 ADD `CreatedByID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions03 ADD `CreatedByName` VARCHAR(100);
ALTER TABLE tblTransactions04 ADD `CreatedByID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions04 ADD `CreatedByName` VARCHAR(100);
ALTER TABLE tblTransactions05 ADD `CreatedByID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions05 ADD `CreatedByName` VARCHAR(100);
ALTER TABLE tblTransactions06 ADD `CreatedByID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions06 ADD `CreatedByName` VARCHAR(100);
ALTER TABLE tblTransactions07 ADD `CreatedByID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions07 ADD `CreatedByName` VARCHAR(100);
ALTER TABLE tblTransactions08 ADD `CreatedByID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions08 ADD `CreatedByName` VARCHAR(100);
ALTER TABLE tblTransactions09 ADD `CreatedByID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions09 ADD `CreatedByName` VARCHAR(100);
ALTER TABLE tblTransactions10 ADD `CreatedByID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions10 ADD `CreatedByName` VARCHAR(100);
ALTER TABLE tblTransactions11 ADD `CreatedByID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions11 ADD `CreatedByName` VARCHAR(100);
ALTER TABLE tblTransactions12 ADD `CreatedByID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions12 ADD `CreatedByName` VARCHAR(100);

UPDATE tblTransactions01 SET `CreatedByID` = CashierID	WHERE CashierName = NULL OR CashierName = '';
UPDATE tblTransactions01 SET `CreatedByName` = CashierName WHERE CashierName = NULL OR CashierName = '';
UPDATE tblTransactions02 SET `CreatedByID` = CashierID WHERE CashierName = NULL OR CashierName = '';
UPDATE tblTransactions02 SET `CreatedByName` = CashierName WHERE CashierName = NULL OR CashierName = '';
UPDATE tblTransactions03 SET `CreatedByID` = CashierID WHERE CashierName = NULL OR CashierName = '';
UPDATE tblTransactions03 SET `CreatedByName` = CashierName WHERE CashierName = NULL OR CashierName = '';
UPDATE tblTransactions04 SET `CreatedByID` = CashierID WHERE CashierName = NULL OR CashierName = '';
UPDATE tblTransactions04 SET `CreatedByName` = CashierName WHERE CashierName = NULL OR CashierName = '';
UPDATE tblTransactions05 SET `CreatedByID` = CashierID WHERE CashierName = NULL OR CashierName = '';
UPDATE tblTransactions05 SET `CreatedByName` = CashierName WHERE CashierName = NULL OR CashierName = '';
UPDATE tblTransactions06 SET `CreatedByID` = CashierID WHERE CashierName = NULL OR CashierName = '';
UPDATE tblTransactions06 SET `CreatedByName` = CashierName WHERE CashierName = NULL OR CashierName = '';
UPDATE tblTransactions07 SET `CreatedByID` = CashierID WHERE CashierName = NULL OR CashierName = '';
UPDATE tblTransactions07 SET `CreatedByName` = CashierName WHERE CashierName = NULL OR CashierName = '';
UPDATE tblTransactions08 SET `CreatedByID` = CashierID WHERE CashierName = NULL OR CashierName = '';
UPDATE tblTransactions08 SET `CreatedByName` = CashierName WHERE CashierName = NULL OR CashierName = '';
UPDATE tblTransactions09 SET `CreatedByID` = CashierID WHERE CashierName = NULL OR CashierName = '';
UPDATE tblTransactions09 SET `CreatedByName` = CashierName WHERE CashierName = NULL OR CashierName = '';
UPDATE tblTransactions10 SET `CreatedByID` = CashierID WHERE CashierName = NULL OR CashierName = '';
UPDATE tblTransactions10 SET `CreatedByName` = CashierName WHERE CashierName = NULL OR CashierName = '';
UPDATE tblTransactions11 SET `CreatedByID` = CashierID WHERE CashierName = NULL OR CashierName = '';
UPDATE tblTransactions11 SET `CreatedByName` = CashierName WHERE CashierName = NULL OR CashierName = '';
UPDATE tblTransactions12 SET `CreatedByID` = CashierID WHERE CashierName = NULL OR CashierName = ''; 
UPDATE tblTransactions12 SET `CreatedByName` = CashierName WHERE CashierName = NULL OR CashierName = '';

ALTER TABLE tblProducts ADD `QuantityIN` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblProducts ADD `QuantityOUT` DECIMAL(18,3) NOT NULL DEFAULT 0;

ALTER TABLE tblProductBaseVariationsMatrix ADD `QuantityIN` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblProductBaseVariationsMatrix ADD `QuantityOUT` DECIMAL(18,3) NOT NULL DEFAULT 0;

UPDATE tblProducts SET `QuantityIN` = `Quantity`;
UPDATE tblProductBaseVariationsMatrix SET `QuantityIN` = `Quantity`;

INSERT INTO sysAccessTypes (TypeID, TypeName) VALUES (133, 'Synchronize Branch Products');

ALTER TABLE tblTerminal add `WillContinueSelectionVariation` TINYINT (1) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminal add `WillContinueSelectionProduct` TINYINT (1) NOT NULL DEFAULT 0;
/*********************************  v_2.0.1.3.sql END  *******************************************************/    


/*********************************  v_2.0.1.4.sql START  *******************************************************/


UPDATE tblTerminal SET DBVersion = 'v_2.0.1.4';

ALTER TABLE tblTerminal ADD `RETPriceMarkUp` DECIMAL(18,3) NOT NULL DEFAULT 5;
ALTER TABLE tblTerminal ADD `WSPriceMarkUp` DECIMAL(18,3) NOT NULL DEFAULT 2;

ALTER TABLE tblProducts ADD `WSPrice` DECIMAL(18,3) NOT NULL DEFAULT 0;
UPDATE tblProducts SET `WSPrice` = PurchasePrice * (1 + ((SELECT WSPriceMarkUp FROM tblTerminal LIMIT 1) / 100));

ALTER TABLE tblProductPackage ADD `WSPrice` DECIMAL(18,3) NOT NULL DEFAULT 0;
UPDATE tblProductPackage SET `WSPrice` = PurchasePrice * (1 + ((SELECT WSPriceMarkUp FROM tblTerminal LIMIT 1) / 100));

ALTER TABLE tblProductBaseVariationsMatrix ADD `WSPrice` DECIMAL(18,3) NOT NULL DEFAULT 0;
UPDATE tblProductBaseVariationsMatrix SET `WSPrice` = PurchasePrice * (1 + ((SELECT WSPriceMarkUp FROM tblTerminal LIMIT 1) / 100));

ALTER TABLE tblMatrixPackage ADD `WSPrice` DECIMAL(18,3) NOT NULL DEFAULT 0;
UPDATE tblMatrixPackage SET `WSPrice` = PurchasePrice * (1 + ((SELECT WSPriceMarkUp FROM tblTerminal LIMIT 1) / 100));


/*********************************  v_2.0.1.4.sql END  *******************************************************/
	

/*********************************  v_2.0.1.5.sql START  *******************************************************/

ALTER TABLE tblAgentsCommision ADD `AgentID` BIGINT(20) NOT NULL DEFAULT 0;
ALTER TABLE tblAgentsCommision ADD `AgentName` VARCHAR(100);

/*****************************
**	Added on September 21, 2010 for Agent Commision Access
**	Lem E. Aceron
*****************************/
INSERT INTO sysAccessTypes (TypeID, TypeName) VALUES (134, 'Agents Commision Report');
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 134, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 134, 1, 1);
UPDATE sysAccessTypes SET SequenceNo = 5, Category = '11: Backend - Sales Reports' WHERE TypeID = 134;

ALTER TABLE tblTerminal ADD `WillPrintGrandTotal` TINYINT(1) NOT NULL DEFAULT 1;

INSERT INTO sysAccessTypes (TypeID, TypeName) VALUES (135, 'Position');
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 135, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 135, 1, 1);
UPDATE sysAccessTypes SET SequenceNo = 9, Category = '04: Backend - MasterFiles' WHERE TypeID = 135;

INSERT INTO sysAccessTypes (TypeID, TypeName) VALUES (136, 'Department');
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 136, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 136, 1, 1);
UPDATE sysAccessTypes SET SequenceNo = 10, Category = '04: Backend - MasterFiles' WHERE TypeID = 136;

INSERT INTO sysAccessTypes (TypeID, TypeName) VALUES (137, 'Agents Sales Report');
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 137, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 137, 1, 1);
UPDATE sysAccessTypes SET SequenceNo = 4, Category = '11: Backend - Sales Reports' WHERE TypeID = 137;

/*****************************
**	tblPositions
*****************************/
DROP TABLE IF EXISTS tblPositions;
CREATE TABLE tblPositions (
	`PositionID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`PositionCode` VARCHAR(30) NOT NULL,
	`PositionName` VARCHAR(30) NOT NULL,
	PRIMARY KEY (`PositionID`),
	INDEX `IX_tblPositions`(`PositionID`, `PositionCode`, `PositionName`),
	UNIQUE `PK_tblPositions`(`PositionCode`),
	INDEX `IX1_tblPositions`(`PositionID`),
	INDEX `IX2_tblPositions`(`PositionCode`),
	INDEX `IX3_tblPositions`(`PositionName`)
);

/*****************************
**	tblDepartments
*****************************/
DROP TABLE IF EXISTS tblDepartments;
CREATE TABLE tblDepartments (
	`DepartmentID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`DepartmentCode` VARCHAR(30) NOT NULL,
	`DepartmentName` VARCHAR(30) NOT NULL,
	PRIMARY KEY (`DepartmentID`),
	INDEX `IX_tblDepartments`(`DepartmentID`, `DepartmentCode`, `DepartmentName`),
	UNIQUE `PK_tblDepartments`(`DepartmentCode`),
	INDEX `IX1_tblDepartments`(`DepartmentID`),
	INDEX `IX2_tblDepartments`(`DepartmentCode`),
	INDEX `IX3_tblDepartments`(`DepartmentName`)
);

INSERT INTO tblDepartments VALUES(1, 'System Default Department', 'System Default Department');

ALTER TABLE tblContacts ADD `DepartmentID` INT(10) UNSIGNED NOT NULL DEFAULT 1;
ALTER TABLE tblContacts ADD `PositionID` INT(10) UNSIGNED NOT NULL DEFAULT 1;

ALTER TABLE tblAgentsCommision ADD `DepartmentName` VARCHAR(30) NOT NULL;
ALTER TABLE tblAgentsCommision ADD `PositionName` VARCHAR(30) NOT NULL;

ALTER TABLE tblTransactions01 ADD `AgentDepartmentName` VARCHAR(30) NOT NULL DEFAULT 'System Default Department';
ALTER TABLE tblTransactions01 ADD `AgentPositionName` VARCHAR(30) NOT NULL DEFAULT 'System Default Position';
ALTER TABLE tblTransactions02 ADD `AgentDepartmentName` VARCHAR(30) NOT NULL DEFAULT 'System Default Department';
ALTER TABLE tblTransactions02 ADD `AgentPositionName` VARCHAR(30) NOT NULL DEFAULT 'System Default Position';
ALTER TABLE tblTransactions03 ADD `AgentDepartmentName` VARCHAR(30) NOT NULL DEFAULT 'System Default Department';
ALTER TABLE tblTransactions03 ADD `AgentPositionName` VARCHAR(30) NOT NULL DEFAULT 'System Default Position';
ALTER TABLE tblTransactions04 ADD `AgentDepartmentName` VARCHAR(30) NOT NULL DEFAULT 'System Default Department';
ALTER TABLE tblTransactions04 ADD `AgentPositionName` VARCHAR(30) NOT NULL DEFAULT 'System Default Position';
ALTER TABLE tblTransactions05 ADD `AgentDepartmentName` VARCHAR(30) NOT NULL DEFAULT 'System Default Department';
ALTER TABLE tblTransactions05 ADD `AgentPositionName` VARCHAR(30) NOT NULL DEFAULT 'System Default Position';
ALTER TABLE tblTransactions06 ADD `AgentDepartmentName` VARCHAR(30) NOT NULL DEFAULT 'System Default Department';
ALTER TABLE tblTransactions06 ADD `AgentPositionName` VARCHAR(30) NOT NULL DEFAULT 'System Default Position';
ALTER TABLE tblTransactions07 ADD `AgentDepartmentName` VARCHAR(30) NOT NULL DEFAULT 'System Default Department';
ALTER TABLE tblTransactions07 ADD `AgentPositionName` VARCHAR(30) NOT NULL DEFAULT 'System Default Position';
ALTER TABLE tblTransactions08 ADD `AgentDepartmentName` VARCHAR(30) NOT NULL DEFAULT 'System Default Department';
ALTER TABLE tblTransactions08 ADD `AgentPositionName` VARCHAR(30) NOT NULL DEFAULT 'System Default Position';
ALTER TABLE tblTransactions09 ADD `AgentDepartmentName` VARCHAR(30) NOT NULL DEFAULT 'System Default Department';
ALTER TABLE tblTransactions09 ADD `AgentPositionName` VARCHAR(30) NOT NULL DEFAULT 'System Default Position';
ALTER TABLE tblTransactions10 ADD `AgentDepartmentName` VARCHAR(30) NOT NULL DEFAULT 'System Default Department';
ALTER TABLE tblTransactions10 ADD `AgentPositionName` VARCHAR(30) NOT NULL DEFAULT 'System Default Position';
ALTER TABLE tblTransactions11 ADD `AgentDepartmentName` VARCHAR(30) NOT NULL DEFAULT 'System Default Department';
ALTER TABLE tblTransactions11 ADD `AgentPositionName` VARCHAR(30) NOT NULL DEFAULT 'System Default Position';
ALTER TABLE tblTransactions12 ADD `AgentDepartmentName` VARCHAR(30) NOT NULL DEFAULT 'System Default Department';
ALTER TABLE tblTransactions12 ADD `AgentPositionName` VARCHAR(30) NOT NULL DEFAULT 'System Default Position';

UPDATE tblTransactions01 SET AgentDepartmentName = 'System Default Department';
UPDATE tblTransactions01 SET AgentPositionName = 'System Default Position';
UPDATE tblTransactions02 SET AgentDepartmentName = 'System Default Department';
UPDATE tblTransactions02 SET AgentPositionName = 'System Default Position';
UPDATE tblTransactions03 SET AgentDepartmentName = 'System Default Department';
UPDATE tblTransactions03 SET AgentPositionName = 'System Default Position';
UPDATE tblTransactions04 SET AgentDepartmentName = 'System Default Department';
UPDATE tblTransactions04 SET AgentPositionName = 'System Default Position';
UPDATE tblTransactions05 SET AgentDepartmentName = 'System Default Department';
UPDATE tblTransactions05 SET AgentPositionName = 'System Default Position';
UPDATE tblTransactions06 SET AgentDepartmentName = 'System Default Department';
UPDATE tblTransactions06 SET AgentPositionName = 'System Default Position';
UPDATE tblTransactions07 SET AgentDepartmentName = 'System Default Department';
UPDATE tblTransactions07 SET AgentPositionName = 'System Default Position';
UPDATE tblTransactions08 SET AgentDepartmentName = 'System Default Department';
UPDATE tblTransactions08 SET AgentPositionName = 'System Default Position';
UPDATE tblTransactions09 SET AgentDepartmentName = 'System Default Department';
UPDATE tblTransactions09 SET AgentPositionName = 'System Default Position';
UPDATE tblTransactions10 SET AgentDepartmentName = 'System Default Department';
UPDATE tblTransactions10 SET AgentPositionName = 'System Default Position';
UPDATE tblTransactions11 SET AgentDepartmentName = 'System Default Department';
UPDATE tblTransactions11 SET AgentPositionName = 'System Default Position';
UPDATE tblTransactions12 SET AgentDepartmentName = 'System Default Department';
UPDATE tblTransactions12 SET AgentPositionName = 'System Default Position';


/*********************************  v_2.0.1.5.sql END  *******************************************************/

/*********************************  v_3.0.0.0.sql START  *******************************************************/
/*****************************
**	  
**	Added: May 29, 2011 
**	Lem E. Aceron
**
**  Start supporting the new MySQL 5.5 and higher version
**  Remove the unsupported 'TYPE=INNODB COMMENT = '
**  
*****************************/

/*****************************
**	For Releasing of Items
**	Added: April 7, 2011 
**	Lem E. Aceron
*****************************/

UPDATE tblTerminal SET DBVersion = 'v_3.0.0.0';

DELETE FROM sysAccessGroupRights WHERE TranTypeID = 138;
DELETE FROM sysAccessRights WHERE TranTypeID = 138;
DELETE FROM sysAccessTypes WHERE TypeID = 138;

INSERT INTO sysAccessTypes (TypeID, TypeName) VALUES (138, 'Releasing of Items');
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 138, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 138, 1, 1);
UPDATE sysAccessTypes SET SequenceNo = 24, Category = '14: Frontend - Cashiering' WHERE TypeID = 138;


/*****************************
**	Added on May 3, 2011 for releasing
**	Lem E. Aceron
*****************************/

ALTER TABLE tblTransactions01 ADD `ReleaserID` BIGINT(20) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions02 ADD `ReleaserID` BIGINT(20) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions03 ADD `ReleaserID` BIGINT(20) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions04 ADD `ReleaserID` BIGINT(20) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions05 ADD `ReleaserID` BIGINT(20) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions06 ADD `ReleaserID` BIGINT(20) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions07 ADD `ReleaserID` BIGINT(20) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions08 ADD `ReleaserID` BIGINT(20) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions09 ADD `ReleaserID` BIGINT(20) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions10 ADD `ReleaserID` BIGINT(20) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions11 ADD `ReleaserID` BIGINT(20) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions12 ADD `ReleaserID` BIGINT(20) NOT NULL DEFAULT 0;

ALTER TABLE tblTransactions01 ADD `ReleaserName` VARCHAR(100);
ALTER TABLE tblTransactions02 ADD `ReleaserName` VARCHAR(100);
ALTER TABLE tblTransactions03 ADD `ReleaserName` VARCHAR(100);
ALTER TABLE tblTransactions04 ADD `ReleaserName` VARCHAR(100);
ALTER TABLE tblTransactions05 ADD `ReleaserName` VARCHAR(100);
ALTER TABLE tblTransactions06 ADD `ReleaserName` VARCHAR(100);
ALTER TABLE tblTransactions07 ADD `ReleaserName` VARCHAR(100);
ALTER TABLE tblTransactions08 ADD `ReleaserName` VARCHAR(100);
ALTER TABLE tblTransactions09 ADD `ReleaserName` VARCHAR(100);
ALTER TABLE tblTransactions10 ADD `ReleaserName` VARCHAR(100);
ALTER TABLE tblTransactions11 ADD `ReleaserName` VARCHAR(100);
ALTER TABLE tblTransactions12 ADD `ReleaserName` VARCHAR(100);

ALTER TABLE tblTransactions01 ADD `ReleasedDate` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblTransactions02 ADD `ReleasedDate` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblTransactions03 ADD `ReleasedDate` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblTransactions04 ADD `ReleasedDate` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblTransactions05 ADD `ReleasedDate` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblTransactions06 ADD `ReleasedDate` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblTransactions07 ADD `ReleasedDate` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblTransactions08 ADD `ReleasedDate` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblTransactions09 ADD `ReleasedDate` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblTransactions10 ADD `ReleasedDate` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblTransactions11 ADD `ReleasedDate` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblTransactions12 ADD `ReleasedDate` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';

UPDATE tblTransactions01 SET `ReleasedDate` = '1900-01-01 12:00:00';
UPDATE tblTransactions02 SET `ReleasedDate` = '1900-01-01 12:00:00';
UPDATE tblTransactions03 SET `ReleasedDate` = '1900-01-01 12:00:00';
UPDATE tblTransactions04 SET `ReleasedDate` = '1900-01-01 12:00:00';
UPDATE tblTransactions05 SET `ReleasedDate` = '1900-01-01 12:00:00';
UPDATE tblTransactions06 SET `ReleasedDate` = '1900-01-01 12:00:00';
UPDATE tblTransactions07 SET `ReleasedDate` = '1900-01-01 12:00:00';
UPDATE tblTransactions08 SET `ReleasedDate` = '1900-01-01 12:00:00';
UPDATE tblTransactions09 SET `ReleasedDate` = '1900-01-01 12:00:00';
UPDATE tblTransactions10 SET `ReleasedDate` = '1900-01-01 12:00:00';
UPDATE tblTransactions11 SET `ReleasedDate` = '1900-01-01 12:00:00';
UPDATE tblTransactions12 SET `ReleasedDate` = '1900-01-01 12:00:00';

ALTER TABLE tblTerminal ADD `ReservedAndCommit` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReport ADD `DebitDeposit` DECIMAL NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReportHistory ADD `DebitDeposit` DECIMAL NOT NULL DEFAULT 0;

ALTER TABLE tblCashierReport ADD `DebitDeposit` DECIMAL NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReportHistory ADD `DebitDeposit` DECIMAL NOT NULL DEFAULT 0;

ALTER TABLE tblProducts ADD `ActualQuantity` DECIMAL NOT NULL DEFAULT 0;

ALTER TABLE tblProducts ADD `LastModified` TIMESTAMP DEFAULT NOW() ON UPDATE CURRENT_TIMESTAMP;

UPDATE tblTransactions01 SET TransactionStatus = 9 WHERE TransactionStatus IN (1, 5, 7, 8);
UPDATE tblTransactions02 SET TransactionStatus = 9 WHERE TransactionStatus IN (1, 5, 7, 8);
UPDATE tblTransactions03 SET TransactionStatus = 9 WHERE TransactionStatus IN (1, 5, 7, 8);
UPDATE tblTransactions04 SET TransactionStatus = 9 WHERE TransactionStatus IN (1, 5, 7, 8);
UPDATE tblTransactions05 SET TransactionStatus = 9 WHERE TransactionStatus IN (1, 5, 7, 8);
UPDATE tblTransactions06 SET TransactionStatus = 9 WHERE TransactionStatus IN (1, 5, 7, 8);
UPDATE tblTransactions07 SET TransactionStatus = 9 WHERE TransactionStatus IN (1, 5, 7, 8);
UPDATE tblTransactions08 SET TransactionStatus = 9 WHERE TransactionStatus IN (1, 5, 7, 8);
UPDATE tblTransactions09 SET TransactionStatus = 9 WHERE TransactionStatus IN (1, 5, 7, 8);
UPDATE tblTransactions10 SET TransactionStatus = 9 WHERE TransactionStatus IN (1, 5, 7, 8);
UPDATE tblTransactions11 SET TransactionStatus = 9 WHERE TransactionStatus IN (1, 5, 7, 8);
UPDATE tblTransactions12 SET TransactionStatus = 9 WHERE TransactionStatus IN (1, 5, 7, 8);

/*********************************  v_3.0.0.0.sql END  *******************************************************/
	
/*********************************  v_3.0.0.1.sql START  *******************************************************/ 

UPDATE tblTerminal SET DBVersion = 'v_3.0.0.1';

/**************************************************************
** July 26, 2011
** Lem E. Aceron
**
**************************************************************/

DROP TABLE IF EXISTS tblProductMovement;
CREATE TABLE tblProductMovement (
	`ProductID` BIGINT NOT NULL DEFAULT 0,
	`ProductCode` VARCHAR(30) NOT NULL,
	`ProductDescription` VARCHAR(50) NOT NULL,
	`MatrixID` BIGINT NOT NULL DEFAULT 0,
	`MatrixDescription` VARCHAR(100),
	`QuantityFrom` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`Quantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`QuantityTo` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`MatrixQuantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`UnitCode` VARCHAR(100) NOT NULL,
	`Remarks` VARCHAR(100) NOT NULL,
	`TransactionDate` DateTime NOT NULL,
	`TransactionNo` VARCHAR(100) NOT NULL,
INDEX `IX_tblProductMovement`(`ProductID`),
INDEX `IX_tblProductMovement1`(`MatrixDescription`)
);

DROP TABLE IF EXISTS sysTerminalkey;
CREATE TABLE sysTerminalkey (
	`HDSerialNo` VARCHAR(30) NOT NULL,
	`RegistrationKey` VARCHAR(255) NOT NULL,
INDEX `IX_sysTerminalkey`(`HDSerialNo`),
INDEX `IX_sysTerminalkey1`(`HDSerialNo`, `RegistrationKey`)
);

/*********************************  v_3.0.0.1.sql END  *******************************************************/

/*********************************  v_3.0.0.2.sql START  *******************************************************/ 

UPDATE tblTerminal SET DBVersion = '3.0.0.2';

ALTER TABLE tblProductMovement ADD `CreatedBy` VARCHAR(100) NOT NULL DEFAULT '';

DROP TABLE IF EXISTS sysTerminalkey;
CREATE TABLE sysTerminalkey (
	`HDSerialNo` VARCHAR(200) NOT NULL,
	`RegistrationKey` VARCHAR(255) NOT NULL,
INDEX `IX_sysTerminalkey`(`HDSerialNo`),
INDEX `IX_sysTerminalkey1`(`HDSerialNo`, `RegistrationKey`)
);

INSERT INTO sysTerminalkey VALUE ('K10HT77258WN', '3ZQXU3PxyN3/z1IiNNKIF41lzvqlIQ/YANXPgddDv5NjhvHLOMIvK6sggTT3dKE8');
INSERT INTO sysTerminalkey VALUE ('K834T9A2BJNB', 'VWHt9ZteRBNQZb9gBbnOGZDpjD70UL19Dzv6dZzEy5LmUJFI7i7zP4wQZ/G07hHs');
INSERT INTO sysTerminalkey VALUE ('WD-WXEY08TPJ153', 'XzdDZGO4tkW2IfafQSh7kXs8JEeCK0r2Qqc7yI9arTtPtcLG5r874HU4uaX/pEAq');
INSERT INTO sysTerminalkey VALUE ('587OCI98T', 'lLJPu/BhLTcF0XpSVZ/p3JH3Hp/zbCwy+5rUF/kj/YpVaZwDBjOxgzaT15jJY8Qu');
INSERT INTO sysTerminalkey VALUE ('9VP7QL84', 'VuQyYqBleUyCjuWIonIDCnxS3dBaZOsV0/0mn3znbktrXn4EfKsOTpxVOAxVw+Jw');
INSERT INTO sysTerminalkey VALUE ('081117FB0F06LLCXX95', 'jvqH+QDO7AqRo3e1h7PJAe0eHZkaHGVhl7MLylqmWvzLVRiM9C+UiamWfYNogI+nj9B6Y74heJHmalUoHvOw6A==');

ALTER TABLE tblProducts ADD `RID` BIGINT NOT NULL DEFAULT 0;

/*********************************  v_3.0.0.2.sql END  *********************************************************/ 

/*********************************  v_3.0.0.3.sql START  *******************************************************/ 

UPDATE tblTerminal SET DBVersion = '3.0.0.3';

DROP TABLE IF EXISTS tblCountingRef;
CREATE TABLE tblCountingRef (
	`SessionID` VARCHAR(15) NOT NULL,
	`Counter` BIGINT NOT NULL DEFAULT 0,
	`ReferenceDate` DATE,
INDEX `IX_tblCountingRef`(`Counter`),
INDEX `IX_tblCountingRef1`(`SessionID`),
INDEX `IX_tblCountingRef2`(`ReferenceDate`)
);

/*********************************  v_3.0.0.3.sql END  *******************************************************/ 

/*********************************  v_3.0.3.4.sql START  *******************************************************/ 

UPDATE tblTerminal SET DBVersion = '3.0.3.4';

INSERT INTO sysAccessTypes (TypeID, TypeName) VALUES (139, 'Inventory Analyst');
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 139, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 139, 1, 1);
UPDATE sysAccessTypes SET SequenceNo = 6, Category = '09: Backend - Inventory' WHERE TypeID = 139;

ALTER TABLE tblProducts ADD RIDMinThreshold DECIMAL(18,3) DEFAULT 0;
ALTER TABLE tblProducts ADD RIDMaxThreshold DECIMAL(18,3) DEFAULT 0;
ALTER TABLE tblProductBaseVariationsMatrix ADD RIDMinThreshold DECIMAL(18,3) DEFAULT 0;
ALTER TABLE tblProductBaseVariationsMatrix ADD RIDMaxThreshold DECIMAL(18,3) DEFAULT 0;

/*********************************  v_3.0.3.4.sql END  *******************************************************/ 

/*********************************  v_3.0.3.5.sql START  *******************************************************/ 

UPDATE tblTerminal SET DBVersion = '3.0.3.5';

DROP TABLE IF EXISTS tblContactRewards;
CREATE TABLE tblContactRewards (
	`CustomerID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`RewardCardNo` VARCHAR(15) DEFAULT '',
	`RewardActive` TINYINT(1) NOT NULL DEFAULT 0,
	`RewardPoints` DECIMAL (10,2) NOT NULL DEFAULT 0,
	`RewardAwardDate` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
INDEX `IX_tblContactRewards`(`CustomerID`),
INDEX `IX_tblContactRewards1`(`RewardCardNo`),
INDEX `IX_tblContactRewards2`(`CustomerID`, `RewardCardNo`),
UNIQUE `PK_tblContactRewards1`(`CustomerID`),
UNIQUE `PK_tblContactRewards2`(`RewardCardNo`)
);

DELETE FROM tblContactRewards WHERE CustomerID = 1;
INSERT INTO tblContactRewards VALUES(1, '', 1, 0, NOW());

ALTER TABLE tblTerminal ADD ShowCustomerSelection TINYINT (1) NOT NULL DEFAULT 1;
UPDATE tblTerminal SET ShowCustomerSelection = 0;

ALTER TABLE tblTerminal ADD EnableRewardPoints TINYINT (1) NOT NULL DEFAULT 1;
ALTER TABLE tblTerminal ADD RewardPointsMinimum DECIMAL(18,3) DEFAULT 0;
ALTER TABLE tblTerminal ADD RewardPointsEvery DECIMAL(18,3) DEFAULT 0;
ALTER TABLE tblTerminal ADD RewardPoints DECIMAL(18,3) DEFAULT 0;

ALTER TABLE tblProducts ADD RewardPoints DECIMAL(18,3) DEFAULT 0;

DROP TABLE IF EXISTS tblContactRewardsMovement;
CREATE TABLE tblContactRewardsMovement (
	`CustomerID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 1,
	`RewardDate` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`RewardPointsBefore` BIGINT NOT NULL DEFAULT 0,
	`RewardPointsAdjustment` BIGINT NOT NULL DEFAULT 0,
	`RewardPointsAfter` BIGINT NOT NULL DEFAULT 0,
	`RewardExpiryDate` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`RewardReason` VARCHAR(150) NOT NULL,
	`TerminalNo` VARCHAR(10) NOT NULL,
	`CashierName` VARCHAR(150) NOT NULL,
	`TransactionNo` VARCHAR(15) NOT NULL,
INDEX `IX_tblContactRewardsMovement`(`CustomerID`),
INDEX `IX_tblContactRewardsMovement1`(`RewardDate`),
INDEX `IX_tblContactRewardsMovement2`(`CustomerID`, `RewardDate`)
);


DROP TABLE IF EXISTS tblRewardItems;
CREATE TABLE tblRewardItems (
	`ProductID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 1,
	`RewardPoints` DECIMAL (10,2) NOT NULL DEFAULT 0,
INDEX `IX_tblRewardItems`(`ProductID`)
);

DELETE FROM sysAccessRights WHERE TranTypeID = 140; DELETE FROM sysAccessGroupRights WHERE TranTypeID = 140;
DELETE FROM sysAccessTypes WHERE TypeID = 140;
INSERT INTO sysAccessTypes (TypeID, TypeName) VALUES (140, 'Reward Points Setup');
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 140, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 140, 1, 1);
UPDATE sysAccessTypes SET SequenceNo = 6, Category = '08: Backend - Customer Rewards' WHERE TypeID = 140;

DELETE FROM sysAccessRights WHERE TranTypeID = 141; DELETE FROM sysAccessGroupRights WHERE TranTypeID = 141;
DELETE FROM sysAccessTypes WHERE TypeID = 141;
INSERT INTO sysAccessTypes (TypeID, TypeName) VALUES (141, 'Reward Cards Issuance');
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 141, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 141, 1, 1);
UPDATE sysAccessTypes SET SequenceNo = 7, Category = '08: Backend - Customer Rewards' WHERE TypeID = 141;

DELETE FROM sysAccessRights WHERE TranTypeID = 142; DELETE FROM sysAccessGroupRights WHERE TranTypeID = 142;
DELETE FROM sysAccessTypes WHERE TypeID = 142;
INSERT INTO sysAccessTypes (TypeID, TypeName) VALUES (142, 'Reward Cards Change');
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 142, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 142, 1, 1);
UPDATE sysAccessTypes SET SequenceNo = 7, Category = '08: Backend - Customer Rewards' WHERE TypeID = 142;

DELETE FROM sysAccessRights WHERE TranTypeID = 143; DELETE FROM sysAccessGroupRights WHERE TranTypeID = 143; 
DELETE FROM sysAccessTypes WHERE TypeID = 143;
INSERT INTO sysAccessTypes (TypeID, TypeName) VALUES (143, 'Reward Points Redeemption');
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 143, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 143, 1, 1);
UPDATE sysAccessTypes SET SequenceNo = 8, Category = '08: Backend - Customer Rewards' WHERE TypeID = 143;

DELETE FROM sysAccessRights WHERE TranTypeID = 144; DELETE FROM sysAccessGroupRights WHERE TranTypeID = 144;
DELETE FROM sysAccessTypes WHERE TypeID = 144;
INSERT INTO sysAccessTypes (TypeID, TypeName) VALUES (144, 'Reward Items Setup');
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 144, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 144, 1, 1);
UPDATE sysAccessTypes SET SequenceNo = 8, Category = '08: Backend - Customer Rewards' WHERE TypeID = 144;


-- For ClosingInventory
ALTER TABLE tblProductBaseVariationsMatrix ADD ActualQuantity DECIMAL(18,3) DEFAULT 0;
ALTER TABLE tblProductBaseVariationsMatrix ADD Deleted TINYINT (1) NOT NULL DEFAULT 0;

/*********************************  v_3.0.3.5.sql END  *******************************************************/ 

/*********************************  v_3.0.3.6.sql START  *******************************************************/ 

UPDATE tblTerminal SET DBVersion = '3.0.3.6';


ALTER TABLE tblStock ADD `BranchID` INT(4) NOT NULL DEFAULT 1;
ALTER TABLE tblProductMovement ADD `BranchIDFrom` INT(4) NOT NULL DEFAULT 1;
ALTER TABLE tblProductMovement ADD `BranchIDTo` INT(4) NOT NULL DEFAULT 1;

/*****************************
**	tblBranchInventory
*****************************/
DROP TABLE IF EXISTS tblBranchInventory;
CREATE TABLE tblBranchInventory (
	`BranchID` INT(4) UNSIGNED NOT NULL DEFAULT 0,
	`ProductID` BIGINT NOT NULL DEFAULT 0,
	`Quantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`QuantityIn` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`QuantityOut` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ActualQuantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	INDEX `IX_tblBranchInventory`(`BranchID`, `ProductID`),
	UNIQUE `PK_tblBranchInventory`(`BranchID`, `ProductID`)
);

/*****************************
**	tblBranchInventoryMatrix
*****************************/
DROP TABLE IF EXISTS tblBranchInventoryMatrix;
CREATE TABLE tblBranchInventoryMatrix (
	`BranchID` INT(4) UNSIGNED NOT NULL DEFAULT 0,
	`ProductID` BIGINT NOT NULL DEFAULT 0,
	`MatrixID` BIGINT NOT NULL DEFAULT 0,
	`Quantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`QuantityIn` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`QuantityOut` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ActualQuantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	INDEX `IX_tblBranchInventoryMatrix`(`BranchID`, `ProductID`),
	UNIQUE `PK_tblBranchInventoryMatrix`(`BranchID`, `ProductID`, `MatrixID`)
);

ALTER TABLE tblTerminal ADD RoundDownRewardPoints TINYINT (1) NOT NULL DEFAULT 0;
ALTER TABLE tblContactRewards ADD TotalPurchases DECIMAL (10,2) NOT NULL DEFAULT 0;
ALTER TABLE tblContactRewards ADD RedeemedPoints DECIMAL (10,2) NOT NULL DEFAULT 0;
ALTER TABLE tblContactRewards ADD `RewardCardStatus` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblContactRewards ADD `ExpiryDate` DATE NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblContactRewards ADD `BirthDate` DATE NOT NULL DEFAULT '1900-01-01 12:00:00';


DROP TABLE IF EXISTS tblContactRewardsMovement;
CREATE TABLE tblContactRewardsMovement (
	`CustomerID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 1,
	`RewardDate` DATE NOT NULL DEFAULT '1900-01-01',
	`RewardPointsBefore` BIGINT NOT NULL DEFAULT 0,
	`RewardPointsAdjustment` BIGINT NOT NULL DEFAULT 0,
	`RewardPointsAfter` BIGINT NOT NULL DEFAULT 0,
	`RewardExpiryDate` DATE NOT NULL DEFAULT '1900-01-01',
	`RewardReason` VARCHAR(150) NOT NULL,
	`TerminalNo` VARCHAR(10) NOT NULL,
	`CashierName` VARCHAR(150) NOT NULL,
	`TransactionNo` VARCHAR(15) NOT NULL,
INDEX `IX_tblContactRewardsMovement`(`CustomerID`),
INDEX `IX_tblContactRewardsMovement1`(`RewardDate`),
INDEX `IX_tblContactRewardsMovement2`(`CustomerID`, `RewardDate`)
);


DROP TABLE IF EXISTS tblContactCreditCardInfo;
CREATE TABLE tblContactCreditCardInfo (
	`CustomerID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`GuarantorID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`CreditType` TINYINT(1) NOT NULL DEFAULT 0,
	`CreditCardNo` VARCHAR(16) DEFAULT '',
	`CreditAwardDate` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`TotalPurchases` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CreditPaid` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CreditCardStatus` TINYINT(1) NOT NULL DEFAULT 0,
	`ExpiryDate` DATE NOT NULL DEFAULT '1900-01-01',
INDEX `IX_tblContactCreditCardInfo`(`CustomerID`),
INDEX `IX_tblContactCreditCardInfo1`(`CreditCardNo`),
INDEX `IX_tblContactCreditCardInfo2`(`CustomerID`, `CreditCardNo`),
UNIQUE `PK_tblContactCreditCardInfo1`(`CustomerID`),
UNIQUE `PK_tblContactCreditCardInfo2`(`CreditCardNo`)
);

DROP TABLE IF EXISTS tblContactCreditCardMovement;
-- CREATE TABLE tblContactCreditCardMovement (
--	`CustomerID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
--	`GuarantorID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
--	`CreditType` TINYINT(1) NOT NULL DEFAULT 0,
--	`CreditDate` DATE NOT NULL DEFAULT '1900-01-01 12:00:00',
--	`CreditBefore` DECIMAL(18,3) NOT NULL DEFAULT 0,
--	`Credit` DECIMAL(18,3) NOT NULL DEFAULT 0,
--	`CreditAfter` DECIMAL(18,3) NOT NULL DEFAULT 0,
--	`CreditExpiryDate` DATE NOT NULL DEFAULT '1900-01-01 12:00:00',
--	`CreditReason` VARCHAR(150) NOT NULL,
--	`TerminalNo` VARCHAR(10) NOT NULL,
--	`CashierName` VARCHAR(150) NOT NULL,
--	`TransactionNo` VARCHAR(15) NOT NULL,
-- INDEX `IX_tblContactCreditCardMovement`(`CustomerID`),
-- INDEX `IX_tblContactCreditCardMovement1`(`CreditDate`),
-- INDEX `IX_tblContactCreditCardMovement2`(`CustomerID`, `CreditDate`)
-- );

ALTER TABLE tblTerminal ADD AutoGenerateRewardCardNo TINYINT (1) NOT NULL DEFAULT 1;
ALTER TABLE tblTerminal ADD EnableRewardPointsAsPayment TINYINT (1) NOT NULL DEFAULT 1;
ALTER TABLE tblTerminal ADD RewardPointsMaxPercentageForPayment DECIMAL(5,2) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminal ADD RewardPointsPaymentValue DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminal ADD RewardPointsPaymentCashEquivalent DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminal ADD RewardsPermitNo VARCHAR(30);
ALTER TABLE tblTerminal ADD InHouseIndividualCreditPermitNo VARCHAR(30);
ALTER TABLE tblTerminal ADD InHouseGroupCreditPermitNo VARCHAR(30);

ALTER TABLE tblTransactions01 ADD RewardPointsPayment DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions01 ADD RewardConvertedPayment DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions02 ADD RewardPointsPayment DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions02 ADD RewardConvertedPayment DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions03 ADD RewardPointsPayment DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions03 ADD RewardConvertedPayment DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions04 ADD RewardPointsPayment DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions04 ADD RewardConvertedPayment DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions05 ADD RewardPointsPayment DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions05 ADD RewardConvertedPayment DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions06 ADD RewardPointsPayment DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions06 ADD RewardConvertedPayment DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions07 ADD RewardPointsPayment DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions07 ADD RewardConvertedPayment DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions08 ADD RewardPointsPayment DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions08 ADD RewardConvertedPayment DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions09 ADD RewardPointsPayment DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions09 ADD RewardConvertedPayment DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions10 ADD RewardPointsPayment DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions10 ADD RewardConvertedPayment DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions11 ADD RewardPointsPayment DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions11 ADD RewardConvertedPayment DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions12 ADD RewardPointsPayment DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions12 ADD RewardConvertedPayment DECIMAL(18,3) NOT NULL DEFAULT 0;

ALTER TABLE tblTerminalReport ADD RewardPointsPayment DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReport ADD RewardConvertedPayment DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReport ADD NoOfRewardPointsPayment INT(10) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReportHistory ADD RewardPointsPayment DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReportHistory ADD RewardConvertedPayment DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReportHistory ADD NoOfRewardPointsPayment INT(10) NOT NULL DEFAULT 0;

ALTER TABLE tblCashierReport ADD RewardPointsPayment DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReport ADD RewardConvertedPayment DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReport ADD NoOfRewardPointsPayment INT(10) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReportHistory ADD RewardPointsPayment DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReportHistory ADD RewardConvertedPayment DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReportHistory ADD NoOfRewardPointsPayment INT(10) NOT NULL DEFAULT 0;

/*********************************  v_3.0.3.6.sql END  *******************************************************/ 

/*********************************  v_3.0.3.7.sql START  *******************************************************/ 

UPDATE tblTerminal SET DBVersion = '3.0.3.7';

ALTER TABLE tblTerminal ADD `IsFineDining` INT(1) NOT NULL DEFAULT 1;

ALTER TABLE tblProductGroup ADD `SequenceNo` BIGINT NOT NULL DEFAULT 1;
ALTER TABLE tblProductSubGroup ADD `SequenceNo` BIGINT NOT NULL DEFAULT 1;
ALTER TABLE tblProducts ADD `SequenceNo` BIGINT NOT NULL DEFAULT 1;

UPDATE tblProductGroup SET SequenceNo = ProductGroupID;
UPDATE tblProductSubGroup SET SequenceNo = ProductSubGroupID;
UPDATE tblProducts SET SequenceNo = ProductID;

ALTER TABLE tblTransactions01 ADD PaxNo INT(4) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactions02 ADD PaxNo INT(4) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactions03 ADD PaxNo INT(4) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactions04 ADD PaxNo INT(4) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactions05 ADD PaxNo INT(4) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactions06 ADD PaxNo INT(4) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactions07 ADD PaxNo INT(4) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactions08 ADD PaxNo INT(4) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactions09 ADD PaxNo INT(4) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactions10 ADD PaxNo INT(4) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactions11 ADD PaxNo INT(4) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactions12 ADD PaxNo INT(4) NOT NULL DEFAULT 1;

ALTER TABLE tblTransactionItems01 ADD PaxNo INT(4) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactionItems02 ADD PaxNo INT(4) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactionItems03 ADD PaxNo INT(4) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactionItems04 ADD PaxNo INT(4) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactionItems05 ADD PaxNo INT(4) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactionItems06 ADD PaxNo INT(4) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactionItems07 ADD PaxNo INT(4) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactionItems08 ADD PaxNo INT(4) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactionItems09 ADD PaxNo INT(4) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactionItems10 ADD PaxNo INT(4) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactionItems11 ADD PaxNo INT(4) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactionItems12 ADD PaxNo INT(4) NOT NULL DEFAULT 1;

ALTER TABLE tblProducts ADD `Barcode2` VARCHAR(30);
ALTER TABLE tblProducts ADD `Barcode3` VARCHAR(30);

CREATE INDEX IX_tblProducts_Barcode2 ON tblProducts (Barcode2);
CREATE INDEX IX_tblProducts_Barcode3 ON tblProducts (Barcode3);

ALTER TABLE tblUnit MODIFY `UnitCode` VARCHAR(5);
ALTER TABLE tblTransactionItems01 MODIFY `ProductUnitCode` VARCHAR(5);
ALTER TABLE tblTransactionItems02 MODIFY `ProductUnitCode` VARCHAR(5);
ALTER TABLE tblTransactionItems03 MODIFY `ProductUnitCode` VARCHAR(5);
ALTER TABLE tblTransactionItems04 MODIFY `ProductUnitCode` VARCHAR(5);
ALTER TABLE tblTransactionItems05 MODIFY `ProductUnitCode` VARCHAR(5);
ALTER TABLE tblTransactionItems06 MODIFY `ProductUnitCode` VARCHAR(5);
ALTER TABLE tblTransactionItems07 MODIFY `ProductUnitCode` VARCHAR(5);
ALTER TABLE tblTransactionItems08 MODIFY `ProductUnitCode` VARCHAR(5);
ALTER TABLE tblTransactionItems09 MODIFY `ProductUnitCode` VARCHAR(5);
ALTER TABLE tblTransactionItems10 MODIFY `ProductUnitCode` VARCHAR(5);
ALTER TABLE tblTransactionItems11 MODIFY `ProductUnitCode` VARCHAR(5);
ALTER TABLE tblTransactionItems12 MODIFY `ProductUnitCode` VARCHAR(5);


ALTER TABLE tblProducts MODIFY `Quantity` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems01 MODIFY `Quantity` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems02 MODIFY `Quantity` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems03 MODIFY `Quantity` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems04 MODIFY `Quantity` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems05 MODIFY `Quantity` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems06 MODIFY `Quantity` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems07 MODIFY `Quantity` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems08 MODIFY `Quantity` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems09 MODIFY `Quantity` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems10 MODIFY `Quantity` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems11 MODIFY `Quantity` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems12 MODIFY `Quantity` DECIMAL(18,3) NOT NULL DEFAULT 0;

UPDATE tblTerminal SET DBVersion = '3.0.3.71';


ALTER TABLE tblTerminal ADD `PersonalChargeTypeID` INT(10) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminal ADD `GroupChargeTypeID` INT(10) NOT NULL DEFAULT 0;

ALTER TABLE tblTransactions01 ADD `CreditChargeAmount` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions02 ADD `CreditChargeAmount` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions03 ADD `CreditChargeAmount` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions04 ADD `CreditChargeAmount` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions05 ADD `CreditChargeAmount` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions06 ADD `CreditChargeAmount` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions07 ADD `CreditChargeAmount` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions08 ADD `CreditChargeAmount` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions09 ADD `CreditChargeAmount` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions10 ADD `CreditChargeAmount` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions11 ADD `CreditChargeAmount` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions12 ADD `CreditChargeAmount` DECIMAL(18,3) NOT NULL DEFAULT 0;

UPDATE tblTerminal SET DBVersion = '3.0.3.72';

ALTER TABLE tblContactRewards ADD EmbossedCardNo VARCHAR(15);
ALTER TABLE tblContactCreditCardInfo ADD EmbossedCardNo VARCHAR(15);

UPDATE tblContactRewards SET EmbossedCardNo = NULL;

UPDATE tblContactRewards, tblContacts SET 
	EmbossedCardNo = REPLACE(ContactCode,'ADV-','')
WHERE tblContactRewards.CustomerID = tblContacts.ContactID AND ContactCode LIKE 'ADV-%';

UPDATE tblTerminal SET DBVersion = '3.0.3.73';

/****************************Dec 01, 2011****************************************************/

ALTER TABLE tblProductPackage ADD `Barcode1` VARCHAR(30);
ALTER TABLE tblProductPackage ADD `Barcode2` VARCHAR(30);
ALTER TABLE tblProductPackage ADD `Barcode3` VARCHAR(30);

CREATE INDEX IX_tblProductPackage_Barcode1 ON tblProductPackage (Barcode1);
CREATE INDEX IX_tblProductPackage_Barcode2 ON tblProductPackage (Barcode2);
CREATE INDEX IX_tblProductPackage_Barcode3 ON tblProductPackage (Barcode3);

CREATE INDEX IX_tblProductPackage_Barcode ON tblProductPackage (Barcode1, Barcode2, Barcode3);

-- UPDATE tblProducts SET BaseUnitID = 1 where BaseUnitID <> 1;
-- UPDATE tblProductUnitMatrix SET bottomunitid = 48 where BottomUnitID = 1;

UPDATE tblProductPackage, tblProducts SET 
	tblProductPackage.BarCode1 = tblProducts.BarCode,
	tblProductPackage.BarCode2 = tblProducts.BarCode2,
	tblProductPackage.BarCode3 = tblProducts.BarCode3
WHERE tblProductPackage.ProductID = tblProducts.ProductID 
	AND tblProductPackage.UnitID = tblProducts.BaseUnitID 
	AND tblProductPackage.Quantity = 1;
	
INSERT INTO tblProductPackage (ProductID, UnitID, Price, WSPrice, PurchasePrice, Quantity, VAT, EVAT, LocalTax, BarCode1, BarCode2, BarCode3) SELECT a.ProductID, b.BottomUnitID, a.Price * b.BaseUnitValue, a.WSPrice * b.BaseUnitValue, a.PurchasePrice * b.BaseUnitValue, 1, a.VAT, a.EVAT, a.LocalTax, '', '', '' FROM tblProducts a INNER JOIN tblProductUnitMatrix b ON a.ProductID = b.ProductID;

UPDATE tblTerminal SET DBVersion = '3.0.3.74';


/*********************************  v_3.0.3.7.sql END  *******************************************************/ 

/*********************************  v_3.0.4.0.sql START  *******************************************************/ 

UPDATE tblTerminal SET DBVersion = '3.0.4.0';

ALTER TABLE tblTerminalReportHistory ADD `InitializedBy` VARCHAR(150);

UPDATE tblTerminalReportHistory SET InitializedBy = (SELECT User FROM sysAuditTrail where Activity = 'InitializeZRead' AND tblTerminalReportHistory.DateLastInitialized < sysAuditTrail.ActivityDate ORDER BY ActivityDate DESC limit 1);


/*********************************  v_3.0.4.0.sql END  *******************************************************/ 

/*********************************  v_3.0.5.0.sql START  *******************************************************/ 

UPDATE tblTerminal SET DBVersion = '3.0.5.0';


/*********************************  v_3.0.5.0.sql END  *******************************************************/ 


UPDATE tblTerminal SET DBVersion = '4.0.0.0';

ALTER TABLE tblTransactions01 ADD `BranchID` INT(4) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactions02 ADD `BranchID` INT(4) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactions03 ADD `BranchID` INT(4) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactions04 ADD `BranchID` INT(4) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactions05 ADD `BranchID` INT(4) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactions06 ADD `BranchID` INT(4) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactions07 ADD `BranchID` INT(4) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactions08 ADD `BranchID` INT(4) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactions09 ADD `BranchID` INT(4) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactions10 ADD `BranchID` INT(4) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactions11 ADD `BranchID` INT(4) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactions12 ADD `BranchID` INT(4) NOT NULL DEFAULT 1;

ALTER TABLE tblTerminal ADD `BranchID` INT(4) NOT NULL DEFAULT 1;
ALTER TABLE tblTerminalReport ADD `BranchID` INT(4) NOT NULL DEFAULT 1;
ALTER TABLE tblTerminalReportHistory ADD `BranchID` INT(4) NOT NULL DEFAULT 1;

ALTER TABLE tblTerminalReport DROP PRIMARY KEY;
ALTER TABLE tblTerminalReport ADD PRIMARY KEY (TerminalNo, BranchID);
ALTER TABLE tblTerminalReport DROP KEY PK_tblTerminalReport;
ALTER TABLE tblTerminalReport ADD UNIQUE KEY PK_tblTerminalReport (TerminalNo, BranchID);


ALTER TABLE tblCashierReport ADD `BranchID` INT(4) NOT NULL DEFAULT 1;
ALTER TABLE tblCashierReportHistory ADD `BranchID` INT(4) NOT NULL DEFAULT 1;

ALTER TABLE tblCashierReport DROP PRIMARY KEY;
ALTER TABLE tblCashierReport ADD PRIMARY KEY (CashierID, TerminalNo, BranchID);
ALTER TABLE tblCashierReport DROP KEY PK_tblCashierReport;
ALTER TABLE tblCashierReport ADD UNIQUE KEY PK_tblCashierReport (CashierID, TerminalNo, BranchID);


ALTER TABLE tblCashierLogs ADD `BranchID` INT(4) NOT NULL DEFAULT 1;
ALTER TABLE tblCashierLogs ADD `BranchCode` VARCHAR(30);
UPDATE tblCashierLogs, tblBranch SET tblCashierLogs.BranchCode = tblBranch.BranchCode WHERE tblCashierLogs.BranchID = tblBranch.BranchID AND tblCashierLogs.BranchCode IS NULL;
ALTER TABLE tblCashCount ADD `BranchID` INT(4) NOT NULL DEFAULT 1;
ALTER TABLE tblCashCount ADD `BranchCode` VARCHAR(30);
UPDATE tblCashCount, tblBranch SET tblCashCount.BranchCode = tblBranch.BranchCode WHERE tblCashCount.BranchID = tblBranch.BranchID AND tblCashCount.BranchCode IS NULL;
ALTER TABLE tblWithHold ADD `BranchID` INT(4) NOT NULL DEFAULT 1;
ALTER TABLE tblWithHold ADD `BranchCode` VARCHAR(30);
UPDATE tblWithHold, tblBranch SET tblWithHold.BranchCode = tblBranch.BranchCode WHERE tblWithHold.BranchID = tblBranch.BranchID AND tblWithHold.BranchCode IS NULL;
ALTER TABLE tblDeposit ADD `BranchID` INT(4) NOT NULL DEFAULT 1;
ALTER TABLE tblDeposit ADD `BranchCode` VARCHAR(30);
UPDATE tblDeposit, tblBranch SET tblDeposit.BranchCode = tblBranch.BranchCode WHERE tblDeposit.BranchID = tblBranch.BranchID AND tblDeposit.BranchCode IS NULL;
ALTER TABLE tblDisburse ADD `BranchID` INT(4) NOT NULL DEFAULT 1;
ALTER TABLE tblDisburse ADD `BranchCode` VARCHAR(30);
UPDATE tblDisburse, tblBranch SET tblDisburse.BranchCode = tblBranch.BranchCode WHERE tblDisburse.BranchID = tblBranch.BranchID AND tblDisburse.BranchCode IS NULL;
ALTER TABLE tblPaidOut ADD `BranchID` INT(4) NOT NULL DEFAULT 1;
ALTER TABLE tblPaidOut ADD `BranchCode` VARCHAR(30);
UPDATE tblPaidOut, tblBranch SET tblPaidOut.BranchCode = tblBranch.BranchCode WHERE tblPaidOut.BranchID = tblBranch.BranchID AND tblPaidOut.BranchCode IS NULL;



/*****************************
**	tblTransactions
*****************************/
DROP TABLE IF EXISTS tblTransactions;
CREATE TABLE tblTransactions (
`TransactionID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
`TransactionNo` VARCHAR(30) NOT NULL,
`CustomerID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
`CustomerName` VARCHAR(100) NOT NULL,
`CashierID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
`CashierName` VARCHAR(100) NOT NULL,
`TerminalNo` VARCHAR(30) NOT NULL,
`TransactionDate`	DATETIME NOT NULL,
`DateSuspended`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
`DateResumed`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
`TransactionStatus` SMALLINT(1) UNSIGNED NOT NULL DEFAULT 0,
`SubTotal` DECIMAL(18,3) NOT NULL DEFAULT 0,
`Discount` DECIMAL(18,3) NOT NULL DEFAULT 0,
`TransDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0,
`TransDiscountType` INT(10) NOT NULL DEFAULT 0,
`VAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
`VatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
`EVAT` DECIMAL(18,3) NOT NULL DEFAULT 0,
`EVatableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
`LocalTax` DECIMAL(18,3) NOT NULL DEFAULT 0,
`AmountPaid` DECIMAL(18,3) NOT NULL DEFAULT 0,
`CashPayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
`ChequePayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
`CreditCardPayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
`CreditPayment` DECIMAL(18,3) NOT NULL DEFAULT 0,
`BalanceAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
`ChangeAmount` DECIMAL(18,3) NOT NULL DEFAULT 0,
`DateClosed`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
`PaymentType` INT(10) UNSIGNED NOT NULL DEFAULT 4,
`DiscountCode` VARCHAR(30),
`DiscountRemarks` VARCHAR(255),
INDEX `IXU_tblTransactions`(`TransactionDate`),
INDEX `IX0_tblTransactions`(`TransactionID`),
INDEX `IX1_tblTransactions`(`TransactionNo`),
INDEX `IX2_tblTransactions`(`CustomerID`),
INDEX `IX3_tblTransactions`(`CashierID`)
);


ALTER TABLE tblTransactions ADD `DebitPayment` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions ADD `ItemsDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions ADD `Charge` DECIMAL(18,3) NOT NULL DEFAULT 0, ADD `ChargeAmount` DECIMAL(18,3) NOT NULL DEFAULT 0, ADD `ChargeCode` VARCHAR(30), ADD `ChargeRemarks` VARCHAR(255);
ALTER TABLE tblTransactions ADD `WaiterID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 2;
ALTER TABLE tblTransactions ADD `WaiterName` VARCHAR(100) NOT NULL;
ALTER TABLE tblTransactions ADD `Packed` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions ADD OrderType smallint NOT NULL DEFAULT 0; 
ALTER TABLE tblTransactions MODIFY DiscountCode varchar(5);
ALTER TABLE tblTransactions ADD `AgentID` BIGINT(20) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactions ADD `AgentName` VARCHAR(100) DEFAULT 'RetailPlus Customer �';
ALTER TABLE tblTransactions ADD `CreatedByID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions ADD `CreatedByName` VARCHAR(100);
ALTER TABLE tblTransactions ADD `AgentDepartmentName` VARCHAR(30) NOT NULL DEFAULT 'System Default Department';
ALTER TABLE tblTransactions ADD `AgentPositionName` VARCHAR(30) NOT NULL DEFAULT 'System Default Position';
ALTER TABLE tblTransactions ADD `ReleaserID` BIGINT(20) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions ADD `ReleaserName` VARCHAR(100);
ALTER TABLE tblTransactions ADD `ReleasedDate` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblTransactions ADD RewardPointsPayment DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions ADD RewardConvertedPayment DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions ADD PaxNo INT(4) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactions ADD `CreditChargeAmount` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions ADD `BranchID` INT(4) NOT NULL DEFAULT 1;
ALTER TABLE tblTransactions ADD `BranchCode` VARCHAR(30);
UPDATE tblTransactions, tblBranch SET tblTransactions.BranchCode = tblBranch.BranchCode WHERE tblTransactions.BranchID = tblBranch.BranchID AND tblTransactions.BranchCode IS NULL;

ALTER TABLE tblTransactions PARTITION BY RANGE( YEAR(TransactionDate) )
	SUBPARTITION BY HASH( MONTH(TransactionDate) ) (
		PARTITION p2010 VALUES LESS THAN (2010) (
			SUBPARTITION sJan2010,
			SUBPARTITION sFeb2010,
			SUBPARTITION sMar2010,
			SUBPARTITION sApr2010,
			SUBPARTITION sMay2010,
			SUBPARTITION sJun2010,
			SUBPARTITION sJul2010,
			SUBPARTITION sAug2010,
			SUBPARTITION sSep2010,
			SUBPARTITION sOct2010,
			SUBPARTITION sNov2010,
			SUBPARTITION sDec2010
		),
		PARTITION p2011 VALUES LESS THAN (2011) (
			SUBPARTITION sJan2011,
			SUBPARTITION sFeb2011,
			SUBPARTITION sMar2011,
			SUBPARTITION sApr2011,
			SUBPARTITION sMay2011,
			SUBPARTITION sJun2011,
			SUBPARTITION sJul2011,
			SUBPARTITION sAug2011,
			SUBPARTITION sSep2011,
			SUBPARTITION sOct2011,
			SUBPARTITION sNov2011,
			SUBPARTITION sDec2011
		) );


ALTER TABLE tblTransactions ADD PARTITION (
		PARTITION p2012 VALUES LESS THAN (2012) (
			SUBPARTITION sJan2012,
			SUBPARTITION sFeb2012,
			SUBPARTITION sMar2012,
			SUBPARTITION sApr2012,
			SUBPARTITION sMay2012,
			SUBPARTITION sJun2012,
			SUBPARTITION sJul2012,
			SUBPARTITION sAug2012,
			SUBPARTITION sSep2012,
			SUBPARTITION sOct2012,
			SUBPARTITION sNov2012,
			SUBPARTITION sDec2012) ) ;

ALTER TABLE tblTransactions ADD PARTITION (
		PARTITION p2013 VALUES LESS THAN (2013) (
			SUBPARTITION sJan2013,
			SUBPARTITION sFeb2013,
			SUBPARTITION sMar2013,
			SUBPARTITION sApr2013,
			SUBPARTITION sMay2013,
			SUBPARTITION sJun2013,
			SUBPARTITION sJul2013,
			SUBPARTITION sAug2013,
			SUBPARTITION sSep2013,
			SUBPARTITION sOct2013,
			SUBPARTITION sNov2013,
			SUBPARTITION sDec2013) ) ;

INSERT INTO tblTransactions (TransactionNo, CustomerID, CustomerName, CashierID, CashierName, TerminalNo, TransactionDate, 
							DateSuspended, DateResumed, TransactionStatus, SubTotal, Discount, TransDiscount, TransDiscountType, 
							VAT, VatableAmount, EVAT, EVatableAmount, LocalTax, AmountPaid, CashPayment, ChequePayment, 
							CreditCardPayment, CreditPayment, BalanceAmount, ChangeAmount, DateClosed, PaymentType, DiscountCode, 
							DiscountRemarks, DebitPayment, ItemsDiscount, Charge, ChargeAmount, ChargeCode, ChargeRemarks, 
							WaiterID, WaiterName, Packed, OrderType, AgentID, AgentName, CreatedByID, CreatedByName, 
							AgentDepartmentName, AgentPositionName, ReleaserID, ReleaserName, ReleasedDate, RewardPointsPayment, 
							RewardConvertedPayment, PaxNo, CreditChargeAmount, BranchID)
					SELECT	TransactionNo, CustomerID, CustomerName, CashierID, CashierName, TerminalNo, TransactionDate, 
							DateSuspended, DateResumed, TransactionStatus, SubTotal, Discount, TransDiscount, TransDiscountType, 
							VAT, VatableAmount, EVAT, EVatableAmount, LocalTax, AmountPaid, CashPayment, ChequePayment, 
							CreditCardPayment, CreditPayment, BalanceAmount, ChangeAmount, DateClosed, PaymentType, DiscountCode, 
							DiscountRemarks, DebitPayment, ItemsDiscount, Charge, ChargeAmount, ChargeCode, ChargeRemarks, 
							WaiterID, WaiterName, Packed, OrderType, AgentID, AgentName, CreatedByID, CreatedByName, 
							AgentDepartmentName, AgentPositionName, ReleaserID, ReleaserName, ReleasedDate, RewardPointsPayment, 
							RewardConvertedPayment, PaxNo, CreditChargeAmount, BranchID FROM tblTransactions01;
							
INSERT INTO tblTransactions (TransactionNo, CustomerID, CustomerName, CashierID, CashierName, TerminalNo, TransactionDate, 
							DateSuspended, DateResumed, TransactionStatus, SubTotal, Discount, TransDiscount, TransDiscountType, 
							VAT, VatableAmount, EVAT, EVatableAmount, LocalTax, AmountPaid, CashPayment, ChequePayment, 
							CreditCardPayment, CreditPayment, BalanceAmount, ChangeAmount, DateClosed, PaymentType, DiscountCode, 
							DiscountRemarks, DebitPayment, ItemsDiscount, Charge, ChargeAmount, ChargeCode, ChargeRemarks, 
							WaiterID, WaiterName, Packed, OrderType, AgentID, AgentName, CreatedByID, CreatedByName, 
							AgentDepartmentName, AgentPositionName, ReleaserID, ReleaserName, ReleasedDate, RewardPointsPayment, 
							RewardConvertedPayment, PaxNo, CreditChargeAmount, BranchID)
					SELECT	TransactionNo, CustomerID, CustomerName, CashierID, CashierName, TerminalNo, TransactionDate, 
							DateSuspended, DateResumed, TransactionStatus, SubTotal, Discount, TransDiscount, TransDiscountType, 
							VAT, VatableAmount, EVAT, EVatableAmount, LocalTax, AmountPaid, CashPayment, ChequePayment, 
							CreditCardPayment, CreditPayment, BalanceAmount, ChangeAmount, DateClosed, PaymentType, DiscountCode, 
							DiscountRemarks, DebitPayment, ItemsDiscount, Charge, ChargeAmount, ChargeCode, ChargeRemarks, 
							WaiterID, WaiterName, Packed, OrderType, AgentID, AgentName, CreatedByID, CreatedByName, 
							AgentDepartmentName, AgentPositionName, ReleaserID, ReleaserName, ReleasedDate, RewardPointsPayment, 
							RewardConvertedPayment, PaxNo, CreditChargeAmount, BranchID FROM tblTransactions02;
							
INSERT INTO tblTransactions (TransactionNo, CustomerID, CustomerName, CashierID, CashierName, TerminalNo, TransactionDate, 
							DateSuspended, DateResumed, TransactionStatus, SubTotal, Discount, TransDiscount, TransDiscountType, 
							VAT, VatableAmount, EVAT, EVatableAmount, LocalTax, AmountPaid, CashPayment, ChequePayment, 
							CreditCardPayment, CreditPayment, BalanceAmount, ChangeAmount, DateClosed, PaymentType, DiscountCode, 
							DiscountRemarks, DebitPayment, ItemsDiscount, Charge, ChargeAmount, ChargeCode, ChargeRemarks, 
							WaiterID, WaiterName, Packed, OrderType, AgentID, AgentName, CreatedByID, CreatedByName, 
							AgentDepartmentName, AgentPositionName, ReleaserID, ReleaserName, ReleasedDate, RewardPointsPayment, 
							RewardConvertedPayment, PaxNo, CreditChargeAmount, BranchID)
					SELECT	TransactionNo, CustomerID, CustomerName, CashierID, CashierName, TerminalNo, TransactionDate, 
							DateSuspended, DateResumed, TransactionStatus, SubTotal, Discount, TransDiscount, TransDiscountType, 
							VAT, VatableAmount, EVAT, EVatableAmount, LocalTax, AmountPaid, CashPayment, ChequePayment, 
							CreditCardPayment, CreditPayment, BalanceAmount, ChangeAmount, DateClosed, PaymentType, DiscountCode, 
							DiscountRemarks, DebitPayment, ItemsDiscount, Charge, ChargeAmount, ChargeCode, ChargeRemarks, 
							WaiterID, WaiterName, Packed, OrderType, AgentID, AgentName, CreatedByID, CreatedByName, 
							AgentDepartmentName, AgentPositionName, ReleaserID, ReleaserName, ReleasedDate, RewardPointsPayment, 
							RewardConvertedPayment, PaxNo, CreditChargeAmount, BranchID FROM tblTransactions03;
							
INSERT INTO tblTransactions (TransactionNo, CustomerID, CustomerName, CashierID, CashierName, TerminalNo, TransactionDate, 
							DateSuspended, DateResumed, TransactionStatus, SubTotal, Discount, TransDiscount, TransDiscountType, 
							VAT, VatableAmount, EVAT, EVatableAmount, LocalTax, AmountPaid, CashPayment, ChequePayment, 
							CreditCardPayment, CreditPayment, BalanceAmount, ChangeAmount, DateClosed, PaymentType, DiscountCode, 
							DiscountRemarks, DebitPayment, ItemsDiscount, Charge, ChargeAmount, ChargeCode, ChargeRemarks, 
							WaiterID, WaiterName, Packed, OrderType, AgentID, AgentName, CreatedByID, CreatedByName, 
							AgentDepartmentName, AgentPositionName, ReleaserID, ReleaserName, ReleasedDate, RewardPointsPayment, 
							RewardConvertedPayment, PaxNo, CreditChargeAmount, BranchID)
					SELECT	TransactionNo, CustomerID, CustomerName, CashierID, CashierName, TerminalNo, TransactionDate, 
							DateSuspended, DateResumed, TransactionStatus, SubTotal, Discount, TransDiscount, TransDiscountType, 
							VAT, VatableAmount, EVAT, EVatableAmount, LocalTax, AmountPaid, CashPayment, ChequePayment, 
							CreditCardPayment, CreditPayment, BalanceAmount, ChangeAmount, DateClosed, PaymentType, DiscountCode, 
							DiscountRemarks, DebitPayment, ItemsDiscount, Charge, ChargeAmount, ChargeCode, ChargeRemarks, 
							WaiterID, WaiterName, Packed, OrderType, AgentID, AgentName, CreatedByID, CreatedByName, 
							AgentDepartmentName, AgentPositionName, ReleaserID, ReleaserName, ReleasedDate, RewardPointsPayment, 
							RewardConvertedPayment, PaxNo, CreditChargeAmount, BranchID FROM tblTransactions04;
							
INSERT INTO tblTransactions (TransactionNo, CustomerID, CustomerName, CashierID, CashierName, TerminalNo, TransactionDate, 
							DateSuspended, DateResumed, TransactionStatus, SubTotal, Discount, TransDiscount, TransDiscountType, 
							VAT, VatableAmount, EVAT, EVatableAmount, LocalTax, AmountPaid, CashPayment, ChequePayment, 
							CreditCardPayment, CreditPayment, BalanceAmount, ChangeAmount, DateClosed, PaymentType, DiscountCode, 
							DiscountRemarks, DebitPayment, ItemsDiscount, Charge, ChargeAmount, ChargeCode, ChargeRemarks, 
							WaiterID, WaiterName, Packed, OrderType, AgentID, AgentName, CreatedByID, CreatedByName, 
							AgentDepartmentName, AgentPositionName, ReleaserID, ReleaserName, ReleasedDate, RewardPointsPayment, 
							RewardConvertedPayment, PaxNo, CreditChargeAmount, BranchID)
					SELECT	TransactionNo, CustomerID, CustomerName, CashierID, CashierName, TerminalNo, TransactionDate, 
							DateSuspended, DateResumed, TransactionStatus, SubTotal, Discount, TransDiscount, TransDiscountType, 
							VAT, VatableAmount, EVAT, EVatableAmount, LocalTax, AmountPaid, CashPayment, ChequePayment, 
							CreditCardPayment, CreditPayment, BalanceAmount, ChangeAmount, DateClosed, PaymentType, DiscountCode, 
							DiscountRemarks, DebitPayment, ItemsDiscount, Charge, ChargeAmount, ChargeCode, ChargeRemarks, 
							WaiterID, WaiterName, Packed, OrderType, AgentID, AgentName, CreatedByID, CreatedByName, 
							AgentDepartmentName, AgentPositionName, ReleaserID, ReleaserName, ReleasedDate, RewardPointsPayment, 
							RewardConvertedPayment, PaxNo, CreditChargeAmount, BranchID FROM tblTransactions05;
							
INSERT INTO tblTransactions (TransactionNo, CustomerID, CustomerName, CashierID, CashierName, TerminalNo, TransactionDate, 
							DateSuspended, DateResumed, TransactionStatus, SubTotal, Discount, TransDiscount, TransDiscountType, 
							VAT, VatableAmount, EVAT, EVatableAmount, LocalTax, AmountPaid, CashPayment, ChequePayment, 
							CreditCardPayment, CreditPayment, BalanceAmount, ChangeAmount, DateClosed, PaymentType, DiscountCode, 
							DiscountRemarks, DebitPayment, ItemsDiscount, Charge, ChargeAmount, ChargeCode, ChargeRemarks, 
							WaiterID, WaiterName, Packed, OrderType, AgentID, AgentName, CreatedByID, CreatedByName, 
							AgentDepartmentName, AgentPositionName, ReleaserID, ReleaserName, ReleasedDate, RewardPointsPayment, 
							RewardConvertedPayment, PaxNo, CreditChargeAmount, BranchID)
					SELECT	TransactionNo, CustomerID, CustomerName, CashierID, CashierName, TerminalNo, TransactionDate, 
							DateSuspended, DateResumed, TransactionStatus, SubTotal, Discount, TransDiscount, TransDiscountType, 
							VAT, VatableAmount, EVAT, EVatableAmount, LocalTax, AmountPaid, CashPayment, ChequePayment, 
							CreditCardPayment, CreditPayment, BalanceAmount, ChangeAmount, DateClosed, PaymentType, DiscountCode, 
							DiscountRemarks, DebitPayment, ItemsDiscount, Charge, ChargeAmount, ChargeCode, ChargeRemarks, 
							WaiterID, WaiterName, Packed, OrderType, AgentID, AgentName, CreatedByID, CreatedByName, 
							AgentDepartmentName, AgentPositionName, ReleaserID, ReleaserName, ReleasedDate, RewardPointsPayment, 
							RewardConvertedPayment, PaxNo, CreditChargeAmount, BranchID FROM tblTransactions06;
							
INSERT INTO tblTransactions (TransactionNo, CustomerID, CustomerName, CashierID, CashierName, TerminalNo, TransactionDate, 
							DateSuspended, DateResumed, TransactionStatus, SubTotal, Discount, TransDiscount, TransDiscountType, 
							VAT, VatableAmount, EVAT, EVatableAmount, LocalTax, AmountPaid, CashPayment, ChequePayment, 
							CreditCardPayment, CreditPayment, BalanceAmount, ChangeAmount, DateClosed, PaymentType, DiscountCode, 
							DiscountRemarks, DebitPayment, ItemsDiscount, Charge, ChargeAmount, ChargeCode, ChargeRemarks, 
							WaiterID, WaiterName, Packed, OrderType, AgentID, AgentName, CreatedByID, CreatedByName, 
							AgentDepartmentName, AgentPositionName, ReleaserID, ReleaserName, ReleasedDate, RewardPointsPayment, 
							RewardConvertedPayment, PaxNo, CreditChargeAmount, BranchID)
					SELECT	TransactionNo, CustomerID, CustomerName, CashierID, CashierName, TerminalNo, TransactionDate, 
							DateSuspended, DateResumed, TransactionStatus, SubTotal, Discount, TransDiscount, TransDiscountType, 
							VAT, VatableAmount, EVAT, EVatableAmount, LocalTax, AmountPaid, CashPayment, ChequePayment, 
							CreditCardPayment, CreditPayment, BalanceAmount, ChangeAmount, DateClosed, PaymentType, DiscountCode, 
							DiscountRemarks, DebitPayment, ItemsDiscount, Charge, ChargeAmount, ChargeCode, ChargeRemarks, 
							WaiterID, WaiterName, Packed, OrderType, AgentID, AgentName, CreatedByID, CreatedByName, 
							AgentDepartmentName, AgentPositionName, ReleaserID, ReleaserName, ReleasedDate, RewardPointsPayment, 
							RewardConvertedPayment, PaxNo, CreditChargeAmount, BranchID FROM tblTransactions07;
							
INSERT INTO tblTransactions (TransactionNo, CustomerID, CustomerName, CashierID, CashierName, TerminalNo, TransactionDate, 
							DateSuspended, DateResumed, TransactionStatus, SubTotal, Discount, TransDiscount, TransDiscountType, 
							VAT, VatableAmount, EVAT, EVatableAmount, LocalTax, AmountPaid, CashPayment, ChequePayment, 
							CreditCardPayment, CreditPayment, BalanceAmount, ChangeAmount, DateClosed, PaymentType, DiscountCode, 
							DiscountRemarks, DebitPayment, ItemsDiscount, Charge, ChargeAmount, ChargeCode, ChargeRemarks, 
							WaiterID, WaiterName, Packed, OrderType, AgentID, AgentName, CreatedByID, CreatedByName, 
							AgentDepartmentName, AgentPositionName, ReleaserID, ReleaserName, ReleasedDate, RewardPointsPayment, 
							RewardConvertedPayment, PaxNo, CreditChargeAmount, BranchID)
					SELECT	TransactionNo, CustomerID, CustomerName, CashierID, CashierName, TerminalNo, TransactionDate, 
							DateSuspended, DateResumed, TransactionStatus, SubTotal, Discount, TransDiscount, TransDiscountType, 
							VAT, VatableAmount, EVAT, EVatableAmount, LocalTax, AmountPaid, CashPayment, ChequePayment, 
							CreditCardPayment, CreditPayment, BalanceAmount, ChangeAmount, DateClosed, PaymentType, DiscountCode, 
							DiscountRemarks, DebitPayment, ItemsDiscount, Charge, ChargeAmount, ChargeCode, ChargeRemarks, 
							WaiterID, WaiterName, Packed, OrderType, AgentID, AgentName, CreatedByID, CreatedByName, 
							AgentDepartmentName, AgentPositionName, ReleaserID, ReleaserName, ReleasedDate, RewardPointsPayment, 
							RewardConvertedPayment, PaxNo, CreditChargeAmount, BranchID FROM tblTransactions08;
							
INSERT INTO tblTransactions (TransactionNo, CustomerID, CustomerName, CashierID, CashierName, TerminalNo, TransactionDate, 
							DateSuspended, DateResumed, TransactionStatus, SubTotal, Discount, TransDiscount, TransDiscountType, 
							VAT, VatableAmount, EVAT, EVatableAmount, LocalTax, AmountPaid, CashPayment, ChequePayment, 
							CreditCardPayment, CreditPayment, BalanceAmount, ChangeAmount, DateClosed, PaymentType, DiscountCode, 
							DiscountRemarks, DebitPayment, ItemsDiscount, Charge, ChargeAmount, ChargeCode, ChargeRemarks, 
							WaiterID, WaiterName, Packed, OrderType, AgentID, AgentName, CreatedByID, CreatedByName, 
							AgentDepartmentName, AgentPositionName, ReleaserID, ReleaserName, ReleasedDate, RewardPointsPayment, 
							RewardConvertedPayment, PaxNo, CreditChargeAmount, BranchID)
					SELECT	TransactionNo, CustomerID, CustomerName, CashierID, CashierName, TerminalNo, TransactionDate, 
							DateSuspended, DateResumed, TransactionStatus, SubTotal, Discount, TransDiscount, TransDiscountType, 
							VAT, VatableAmount, EVAT, EVatableAmount, LocalTax, AmountPaid, CashPayment, ChequePayment, 
							CreditCardPayment, CreditPayment, BalanceAmount, ChangeAmount, DateClosed, PaymentType, DiscountCode, 
							DiscountRemarks, DebitPayment, ItemsDiscount, Charge, ChargeAmount, ChargeCode, ChargeRemarks, 
							WaiterID, WaiterName, Packed, OrderType, AgentID, AgentName, CreatedByID, CreatedByName, 
							AgentDepartmentName, AgentPositionName, ReleaserID, ReleaserName, ReleasedDate, RewardPointsPayment, 
							RewardConvertedPayment, PaxNo, CreditChargeAmount, BranchID FROM tblTransactions09;
							   
INSERT INTO tblTransactions (TransactionNo, CustomerID, CustomerName, CashierID, CashierName, TerminalNo, TransactionDate, 
							DateSuspended, DateResumed, TransactionStatus, SubTotal, Discount, TransDiscount, TransDiscountType, 
							VAT, VatableAmount, EVAT, EVatableAmount, LocalTax, AmountPaid, CashPayment, ChequePayment, 
							CreditCardPayment, CreditPayment, BalanceAmount, ChangeAmount, DateClosed, PaymentType, DiscountCode, 
							DiscountRemarks, DebitPayment, ItemsDiscount, Charge, ChargeAmount, ChargeCode, ChargeRemarks, 
							WaiterID, WaiterName, Packed, OrderType, AgentID, AgentName, CreatedByID, CreatedByName, 
							AgentDepartmentName, AgentPositionName, ReleaserID, ReleaserName, ReleasedDate, RewardPointsPayment, 
							RewardConvertedPayment, PaxNo, CreditChargeAmount, BranchID)
					SELECT	TransactionNo, CustomerID, CustomerName, CashierID, CashierName, TerminalNo, TransactionDate, 
							DateSuspended, DateResumed, TransactionStatus, SubTotal, Discount, TransDiscount, TransDiscountType, 
							VAT, VatableAmount, EVAT, EVatableAmount, LocalTax, AmountPaid, CashPayment, ChequePayment, 
							CreditCardPayment, CreditPayment, BalanceAmount, ChangeAmount, DateClosed, PaymentType, DiscountCode, 
							DiscountRemarks, DebitPayment, ItemsDiscount, Charge, ChargeAmount, ChargeCode, ChargeRemarks, 
							WaiterID, WaiterName, Packed, OrderType, AgentID, AgentName, CreatedByID, CreatedByName, 
							AgentDepartmentName, AgentPositionName, ReleaserID, ReleaserName, ReleasedDate, RewardPointsPayment, 
							RewardConvertedPayment, PaxNo, CreditChargeAmount, BranchID FROM tblTransactions10;
									 
INSERT INTO tblTransactions (TransactionNo, CustomerID, CustomerName, CashierID, CashierName, TerminalNo, TransactionDate, 
							DateSuspended, DateResumed, TransactionStatus, SubTotal, Discount, TransDiscount, TransDiscountType, 
							VAT, VatableAmount, EVAT, EVatableAmount, LocalTax, AmountPaid, CashPayment, ChequePayment, 
							CreditCardPayment, CreditPayment, BalanceAmount, ChangeAmount, DateClosed, PaymentType, DiscountCode, 
							DiscountRemarks, DebitPayment, ItemsDiscount, Charge, ChargeAmount, ChargeCode, ChargeRemarks, 
							WaiterID, WaiterName, Packed, OrderType, AgentID, AgentName, CreatedByID, CreatedByName, 
							AgentDepartmentName, AgentPositionName, ReleaserID, ReleaserName, ReleasedDate, RewardPointsPayment, 
							RewardConvertedPayment, PaxNo, CreditChargeAmount, BranchID)
					SELECT	TransactionNo, CustomerID, CustomerName, CashierID, CashierName, TerminalNo, TransactionDate, 
							DateSuspended, DateResumed, TransactionStatus, SubTotal, Discount, TransDiscount, TransDiscountType, 
							VAT, VatableAmount, EVAT, EVatableAmount, LocalTax, AmountPaid, CashPayment, ChequePayment, 
							CreditCardPayment, CreditPayment, BalanceAmount, ChangeAmount, DateClosed, PaymentType, DiscountCode, 
							DiscountRemarks, DebitPayment, ItemsDiscount, Charge, ChargeAmount, ChargeCode, ChargeRemarks, 
							WaiterID, WaiterName, Packed, OrderType, AgentID, AgentName, CreatedByID, CreatedByName, 
							AgentDepartmentName, AgentPositionName, ReleaserID, ReleaserName, ReleasedDate, RewardPointsPayment, 
							RewardConvertedPayment, PaxNo, CreditChargeAmount, BranchID FROM tblTransactions11;
										
INSERT INTO tblTransactions (TransactionNo, CustomerID, CustomerName, CashierID, CashierName, TerminalNo, TransactionDate, 
							DateSuspended, DateResumed, TransactionStatus, SubTotal, Discount, TransDiscount, TransDiscountType, 
							VAT, VatableAmount, EVAT, EVatableAmount, LocalTax, AmountPaid, CashPayment, ChequePayment, 
							CreditCardPayment, CreditPayment, BalanceAmount, ChangeAmount, DateClosed, PaymentType, DiscountCode, 
							DiscountRemarks, DebitPayment, ItemsDiscount, Charge, ChargeAmount, ChargeCode, ChargeRemarks, 
							WaiterID, WaiterName, Packed, OrderType, AgentID, AgentName, CreatedByID, CreatedByName, 
							AgentDepartmentName, AgentPositionName, ReleaserID, ReleaserName, ReleasedDate, RewardPointsPayment, 
							RewardConvertedPayment, PaxNo, CreditChargeAmount, BranchID)
					SELECT	TransactionNo, CustomerID, CustomerName, CashierID, CashierName, TerminalNo, TransactionDate, 
							DateSuspended, DateResumed, TransactionStatus, SubTotal, Discount, TransDiscount, TransDiscountType, 
							VAT, VatableAmount, EVAT, EVatableAmount, LocalTax, AmountPaid, CashPayment, ChequePayment, 
							CreditCardPayment, CreditPayment, BalanceAmount, ChangeAmount, DateClosed, PaymentType, DiscountCode, 
							DiscountRemarks, DebitPayment, ItemsDiscount, Charge, ChargeAmount, ChargeCode, ChargeRemarks, 
							WaiterID, WaiterName, Packed, OrderType, AgentID, AgentName, CreatedByID, CreatedByName, 
							AgentDepartmentName, AgentPositionName, ReleaserID, ReleaserName, ReleasedDate, RewardPointsPayment, 
							RewardConvertedPayment, PaxNo, CreditChargeAmount, BranchID FROM tblTransactions12;


ALTER TABLE tblTransactionItems01 ADD TransactionNo VARCHAR(30);
ALTER TABLE tblTransactionItems02 ADD TransactionNo VARCHAR(30);
ALTER TABLE tblTransactionItems03 ADD TransactionNo VARCHAR(30);
ALTER TABLE tblTransactionItems04 ADD TransactionNo VARCHAR(30);
ALTER TABLE tblTransactionItems05 ADD TransactionNo VARCHAR(30);
ALTER TABLE tblTransactionItems06 ADD TransactionNo VARCHAR(30);
ALTER TABLE tblTransactionItems07 ADD TransactionNo VARCHAR(30);
ALTER TABLE tblTransactionItems08 ADD TransactionNo VARCHAR(30);
ALTER TABLE tblTransactionItems09 ADD TransactionNo VARCHAR(30);
ALTER TABLE tblTransactionItems10 ADD TransactionNo VARCHAR(30);
ALTER TABLE tblTransactionItems11 ADD TransactionNo VARCHAR(30);
ALTER TABLE tblTransactionItems12 ADD TransactionNo VARCHAR(30);

UPDATE tblTransactionItems01, tblTransactions01 SET tblTransactionItems01.TransactionNo = tblTransactions01.TransactionNo WHERE tblTransactionItems01.TransactionID = tblTransactions01.TransactionID;
UPDATE tblTransactionItems02, tblTransactions02 SET tblTransactionItems02.TransactionNo = tblTransactions02.TransactionNo WHERE tblTransactionItems02.TransactionID = tblTransactions02.TransactionID;
UPDATE tblTransactionItems03, tblTransactions03 SET tblTransactionItems03.TransactionNo = tblTransactions03.TransactionNo WHERE tblTransactionItems03.TransactionID = tblTransactions03.TransactionID;
UPDATE tblTransactionItems04, tblTransactions04 SET tblTransactionItems04.TransactionNo = tblTransactions04.TransactionNo WHERE tblTransactionItems04.TransactionID = tblTransactions04.TransactionID;
UPDATE tblTransactionItems05, tblTransactions05 SET tblTransactionItems05.TransactionNo = tblTransactions05.TransactionNo WHERE tblTransactionItems05.TransactionID = tblTransactions05.TransactionID;
UPDATE tblTransactionItems06, tblTransactions06 SET tblTransactionItems06.TransactionNo = tblTransactions06.TransactionNo WHERE tblTransactionItems06.TransactionID = tblTransactions06.TransactionID;
UPDATE tblTransactionItems07, tblTransactions07 SET tblTransactionItems07.TransactionNo = tblTransactions07.TransactionNo WHERE tblTransactionItems07.TransactionID = tblTransactions07.TransactionID;
UPDATE tblTransactionItems08, tblTransactions08 SET tblTransactionItems08.TransactionNo = tblTransactions08.TransactionNo WHERE tblTransactionItems08.TransactionID = tblTransactions08.TransactionID;
UPDATE tblTransactionItems09, tblTransactions09 SET tblTransactionItems09.TransactionNo = tblTransactions09.TransactionNo WHERE tblTransactionItems09.TransactionID = tblTransactions09.TransactionID;
UPDATE tblTransactionItems10, tblTransactions10 SET tblTransactionItems10.TransactionNo = tblTransactions10.TransactionNo WHERE tblTransactionItems10.TransactionID = tblTransactions10.TransactionID;
UPDATE tblTransactionItems11, tblTransactions11 SET tblTransactionItems11.TransactionNo = tblTransactions11.TransactionNo WHERE tblTransactionItems11.TransactionID = tblTransactions11.TransactionID;
UPDATE tblTransactionItems12, tblTransactions12 SET tblTransactionItems12.TransactionNo = tblTransactions12.TransactionNo WHERE tblTransactionItems12.TransactionID = tblTransactions12.TransactionID;


/*****************************
**	tblTransactionItems
*****************************/
DROP TABLE IF EXISTS tblTransactionItems;
CREATE TABLE `tblTransactionItems` (
  `TransactionItemsID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `TransactionID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `ProductID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `ProductCode` varchar(30) NOT NULL,
  `BarCode` varchar(30) NOT NULL,
  `Description` varchar(100) NOT NULL,
  `ProductUnitID` int(3) unsigned NOT NULL DEFAULT '0',
  `ProductUnitCode` varchar(5) DEFAULT NULL,
  `Quantity` decimal(12,3) NOT NULL DEFAULT '0.000',
  `Price` decimal(18,3) NOT NULL DEFAULT '0.00',
  `SellingPrice` decimal(18,3) NOT NULL DEFAULT '0.00',
  `Discount` decimal(18,3) NOT NULL DEFAULT '0.00',
  `ItemDiscount` decimal(18,3) NOT NULL DEFAULT '0.00',
  `ItemDiscountType` tinyint(1) NOT NULL DEFAULT '0',
  `Amount` decimal(18,3) NOT NULL DEFAULT '0.00',
  `VAT` decimal(18,3) NOT NULL DEFAULT '0.00',
  `VatableAmount` decimal(18,3) NOT NULL DEFAULT '0.00',
  `EVAT` decimal(18,3) NOT NULL DEFAULT '0.00',
  `EVatableAmount` decimal(18,3) NOT NULL DEFAULT '0.00',
  `LocalTax` decimal(18,3) NOT NULL DEFAULT '0.00',
  `VariationsMatrixID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `MatrixDescription` varchar(150) DEFAULT NULL,
  `ProductGroup` varchar(20) DEFAULT NULL,
  `ProductSubGroup` varchar(20) DEFAULT NULL,
  `TransactionItemStatus` smallint(1) unsigned NOT NULL DEFAULT '0',
  `DiscountCode` varchar(5) DEFAULT NULL,
  `DiscountRemarks` varchar(255) DEFAULT NULL,
  `ProductPackageID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `MatrixPackageID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `PackageQuantity` decimal(18,3) NOT NULL DEFAULT '0.00',
  `PromoQuantity` decimal(18,3) NOT NULL DEFAULT '0.00',
  `PromoValue` decimal(18,3) NOT NULL DEFAULT '0.00',
  `PromoInPercent` tinyint(1) NOT NULL DEFAULT '0',
  `PromoType` tinyint(1) NOT NULL DEFAULT '0',
  `PromoApplied` decimal(18,3) NOT NULL DEFAULT '0.00',
  `PurchasePrice` decimal(18,3) NOT NULL DEFAULT '0.00',
  `PurchaseAmount` decimal(18,3) NOT NULL DEFAULT '0.00',
  `IncludeInSubtotalDiscount` tinyint(1) NOT NULL DEFAULT '1',
  `OrderSlipPrinter` tinyint(1) NOT NULL DEFAULT '0',
  `OrderSlipPrinted` tinyint(1) NOT NULL DEFAULT '0',
  `PercentageCommision` decimal(18,3) NOT NULL DEFAULT '0.00',
  `Commision` decimal(18,3) NOT NULL DEFAULT '0.00',
  `PaxNo` int(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`TransactionItemsID`),
  KEY `IX_tblTransactionItems01` (`TransactionItemsID`),
  KEY `IX0_tblTransactionItems01` (`TransactionID`,`ProductID`),
  KEY `IX1_tblTransactionItems01` (`TransactionID`,`ProductID`,`VariationsMatrixID`),
  KEY `IX2_tblTransactionItems01` (`ProductCode`),
  KEY `IX3_tblTransactionItems01` (`TransactionID`),
  KEY `IX4_tblTransactionItems01` (`ProductUnitID`)
);

ALTER TABLE tblTransactionItems01 ADD NewTransactionID bigint(20) unsigned NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems02 ADD NewTransactionID bigint(20) unsigned NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems03 ADD NewTransactionID bigint(20) unsigned NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems04 ADD NewTransactionID bigint(20) unsigned NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems05 ADD NewTransactionID bigint(20) unsigned NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems06 ADD NewTransactionID bigint(20) unsigned NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems07 ADD NewTransactionID bigint(20) unsigned NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems08 ADD NewTransactionID bigint(20) unsigned NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems09 ADD NewTransactionID bigint(20) unsigned NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems10 ADD NewTransactionID bigint(20) unsigned NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems11 ADD NewTransactionID bigint(20) unsigned NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems12 ADD NewTransactionID bigint(20) unsigned NOT NULL DEFAULT 0;


UPDATE tblTransactionItems01, tblTransactions SET tblTransactionItems01.NewTransactionID = tblTransactions.TransactionID WHERE tblTransactionItems01.TransactionNo = tblTransactions.TransactionNo;
UPDATE tblTransactionItems02, tblTransactions SET tblTransactionItems02.NewTransactionID = tblTransactions.TransactionID WHERE tblTransactionItems02.TransactionNo = tblTransactions.TransactionNo;
UPDATE tblTransactionItems03, tblTransactions SET tblTransactionItems03.NewTransactionID = tblTransactions.TransactionID WHERE tblTransactionItems03.TransactionNo = tblTransactions.TransactionNo;
UPDATE tblTransactionItems04, tblTransactions SET tblTransactionItems04.NewTransactionID = tblTransactions.TransactionID WHERE tblTransactionItems04.TransactionNo = tblTransactions.TransactionNo;
UPDATE tblTransactionItems05, tblTransactions SET tblTransactionItems05.NewTransactionID = tblTransactions.TransactionID WHERE tblTransactionItems05.TransactionNo = tblTransactions.TransactionNo;
UPDATE tblTransactionItems06, tblTransactions SET tblTransactionItems06.NewTransactionID = tblTransactions.TransactionID WHERE tblTransactionItems06.TransactionNo = tblTransactions.TransactionNo;
UPDATE tblTransactionItems07, tblTransactions SET tblTransactionItems07.NewTransactionID = tblTransactions.TransactionID WHERE tblTransactionItems07.TransactionNo = tblTransactions.TransactionNo;
UPDATE tblTransactionItems08, tblTransactions SET tblTransactionItems08.NewTransactionID = tblTransactions.TransactionID WHERE tblTransactionItems08.TransactionNo = tblTransactions.TransactionNo;
UPDATE tblTransactionItems09, tblTransactions SET tblTransactionItems09.NewTransactionID = tblTransactions.TransactionID WHERE tblTransactionItems09.TransactionNo = tblTransactions.TransactionNo;
UPDATE tblTransactionItems10, tblTransactions SET tblTransactionItems10.NewTransactionID = tblTransactions.TransactionID WHERE tblTransactionItems10.TransactionNo = tblTransactions.TransactionNo;
UPDATE tblTransactionItems11, tblTransactions SET tblTransactionItems11.NewTransactionID = tblTransactions.TransactionID WHERE tblTransactionItems11.TransactionNo = tblTransactions.TransactionNo;
UPDATE tblTransactionItems12, tblTransactions SET tblTransactionItems12.NewTransactionID = tblTransactions.TransactionID WHERE tblTransactionItems12.TransactionNo = tblTransactions.TransactionNo;


INSERT INTO tblTransactionItems (TransactionID, ProductID, ProductCode, BarCode, Description, ProductUnitID, ProductUnitCode, Quantity, 
								Price, SellingPrice, Discount, ItemDiscount, ItemDiscountType, Amount, VAT, VatableAmount, EVAT, EVatableAmount, 
								LocalTax, VariationsMatrixID, MatrixDescription, ProductGroup, ProductSubGroup, TransactionItemStatus, 
								DiscountCode, DiscountRemarks, ProductPackageID, MatrixPackageID, PackageQuantity, PromoQuantity, PromoValue, 
								PromoInPercent, PromoType, PromoApplied, PurchasePrice, PurchaseAmount, IncludeInSubtotalDiscount, 
								OrderSlipPrinter, OrderSlipPrinted, PercentageCommision, Commision, PaxNo)
						SELECT	NewTransactionID, ProductID, ProductCode, BarCode, Description, ProductUnitID, ProductUnitCode, Quantity, 
								Price, SellingPrice, Discount, ItemDiscount, ItemDiscountType, Amount, VAT, VatableAmount, EVAT, EVatableAmount, 
								LocalTax, VariationsMatrixID, MatrixDescription, ProductGroup, ProductSubGroup, TransactionItemStatus, 
								DiscountCode, DiscountRemarks, ProductPackageID, MatrixPackageID, PackageQuantity, PromoQuantity, PromoValue, 
								PromoInPercent, PromoType, PromoApplied, PurchasePrice, PurchaseAmount, IncludeInSubtotalDiscount, 
								OrderSlipPrinter, OrderSlipPrinted, PercentageCommision, Commision, PaxNo FROM tblTransactionItems01;
								
INSERT INTO tblTransactionItems (TransactionID, ProductID, ProductCode, BarCode, Description, ProductUnitID, ProductUnitCode, Quantity, 
								Price, SellingPrice, Discount, ItemDiscount, ItemDiscountType, Amount, VAT, VatableAmount, EVAT, EVatableAmount, 
								LocalTax, VariationsMatrixID, MatrixDescription, ProductGroup, ProductSubGroup, TransactionItemStatus, 
								DiscountCode, DiscountRemarks, ProductPackageID, MatrixPackageID, PackageQuantity, PromoQuantity, PromoValue, 
								PromoInPercent, PromoType, PromoApplied, PurchasePrice, PurchaseAmount, IncludeInSubtotalDiscount, 
								OrderSlipPrinter, OrderSlipPrinted, PercentageCommision, Commision, PaxNo)
						SELECT	NewTransactionID, ProductID, ProductCode, BarCode, Description, ProductUnitID, ProductUnitCode, Quantity, 
								Price, SellingPrice, Discount, ItemDiscount, ItemDiscountType, Amount, VAT, VatableAmount, EVAT, EVatableAmount, 
								LocalTax, VariationsMatrixID, MatrixDescription, ProductGroup, ProductSubGroup, TransactionItemStatus, 
								DiscountCode, DiscountRemarks, ProductPackageID, MatrixPackageID, PackageQuantity, PromoQuantity, PromoValue, 
								PromoInPercent, PromoType, PromoApplied, PurchasePrice, PurchaseAmount, IncludeInSubtotalDiscount, 
								OrderSlipPrinter, OrderSlipPrinted, PercentageCommision, Commision, PaxNo FROM tblTransactionItems02;
								
INSERT INTO tblTransactionItems (TransactionID, ProductID, ProductCode, BarCode, Description, ProductUnitID, ProductUnitCode, Quantity, 
								Price, SellingPrice, Discount, ItemDiscount, ItemDiscountType, Amount, VAT, VatableAmount, EVAT, EVatableAmount, 
								LocalTax, VariationsMatrixID, MatrixDescription, ProductGroup, ProductSubGroup, TransactionItemStatus, 
								DiscountCode, DiscountRemarks, ProductPackageID, MatrixPackageID, PackageQuantity, PromoQuantity, PromoValue, 
								PromoInPercent, PromoType, PromoApplied, PurchasePrice, PurchaseAmount, IncludeInSubtotalDiscount, 
								OrderSlipPrinter, OrderSlipPrinted, PercentageCommision, Commision, PaxNo)
						SELECT	NewTransactionID, ProductID, ProductCode, BarCode, Description, ProductUnitID, ProductUnitCode, Quantity, 
								Price, SellingPrice, Discount, ItemDiscount, ItemDiscountType, Amount, VAT, VatableAmount, EVAT, EVatableAmount, 
								LocalTax, VariationsMatrixID, MatrixDescription, ProductGroup, ProductSubGroup, TransactionItemStatus, 
								DiscountCode, DiscountRemarks, ProductPackageID, MatrixPackageID, PackageQuantity, PromoQuantity, PromoValue, 
								PromoInPercent, PromoType, PromoApplied, PurchasePrice, PurchaseAmount, IncludeInSubtotalDiscount, 
								OrderSlipPrinter, OrderSlipPrinted, PercentageCommision, Commision, PaxNo FROM tblTransactionItems03;
								
INSERT INTO tblTransactionItems (TransactionID, ProductID, ProductCode, BarCode, Description, ProductUnitID, ProductUnitCode, Quantity, 
								Price, SellingPrice, Discount, ItemDiscount, ItemDiscountType, Amount, VAT, VatableAmount, EVAT, EVatableAmount, 
								LocalTax, VariationsMatrixID, MatrixDescription, ProductGroup, ProductSubGroup, TransactionItemStatus, 
								DiscountCode, DiscountRemarks, ProductPackageID, MatrixPackageID, PackageQuantity, PromoQuantity, PromoValue, 
								PromoInPercent, PromoType, PromoApplied, PurchasePrice, PurchaseAmount, IncludeInSubtotalDiscount, 
								OrderSlipPrinter, OrderSlipPrinted, PercentageCommision, Commision, PaxNo)
						SELECT	NewTransactionID, ProductID, ProductCode, BarCode, Description, ProductUnitID, ProductUnitCode, Quantity, 
								Price, SellingPrice, Discount, ItemDiscount, ItemDiscountType, Amount, VAT, VatableAmount, EVAT, EVatableAmount, 
								LocalTax, VariationsMatrixID, MatrixDescription, ProductGroup, ProductSubGroup, TransactionItemStatus, 
								DiscountCode, DiscountRemarks, ProductPackageID, MatrixPackageID, PackageQuantity, PromoQuantity, PromoValue, 
								PromoInPercent, PromoType, PromoApplied, PurchasePrice, PurchaseAmount, IncludeInSubtotalDiscount, 
								OrderSlipPrinter, OrderSlipPrinted, PercentageCommision, Commision, PaxNo FROM tblTransactionItems04;
								
INSERT INTO tblTransactionItems (TransactionID, ProductID, ProductCode, BarCode, Description, ProductUnitID, ProductUnitCode, Quantity, 
								Price, SellingPrice, Discount, ItemDiscount, ItemDiscountType, Amount, VAT, VatableAmount, EVAT, EVatableAmount, 
								LocalTax, VariationsMatrixID, MatrixDescription, ProductGroup, ProductSubGroup, TransactionItemStatus, 
								DiscountCode, DiscountRemarks, ProductPackageID, MatrixPackageID, PackageQuantity, PromoQuantity, PromoValue, 
								PromoInPercent, PromoType, PromoApplied, PurchasePrice, PurchaseAmount, IncludeInSubtotalDiscount, 
								OrderSlipPrinter, OrderSlipPrinted, PercentageCommision, Commision, PaxNo)
						SELECT	NewTransactionID, ProductID, ProductCode, BarCode, Description, ProductUnitID, ProductUnitCode, Quantity, 
								Price, SellingPrice, Discount, ItemDiscount, ItemDiscountType, Amount, VAT, VatableAmount, EVAT, EVatableAmount, 
								LocalTax, VariationsMatrixID, MatrixDescription, ProductGroup, ProductSubGroup, TransactionItemStatus, 
								DiscountCode, DiscountRemarks, ProductPackageID, MatrixPackageID, PackageQuantity, PromoQuantity, PromoValue, 
								PromoInPercent, PromoType, PromoApplied, PurchasePrice, PurchaseAmount, IncludeInSubtotalDiscount, 
								OrderSlipPrinter, OrderSlipPrinted, PercentageCommision, Commision, PaxNo FROM tblTransactionItems05;
								
INSERT INTO tblTransactionItems (TransactionID, ProductID, ProductCode, BarCode, Description, ProductUnitID, ProductUnitCode, Quantity, 
								Price, SellingPrice, Discount, ItemDiscount, ItemDiscountType, Amount, VAT, VatableAmount, EVAT, EVatableAmount, 
								LocalTax, VariationsMatrixID, MatrixDescription, ProductGroup, ProductSubGroup, TransactionItemStatus, 
								DiscountCode, DiscountRemarks, ProductPackageID, MatrixPackageID, PackageQuantity, PromoQuantity, PromoValue, 
								PromoInPercent, PromoType, PromoApplied, PurchasePrice, PurchaseAmount, IncludeInSubtotalDiscount, 
								OrderSlipPrinter, OrderSlipPrinted, PercentageCommision, Commision, PaxNo)
						SELECT	NewTransactionID, ProductID, ProductCode, BarCode, Description, ProductUnitID, ProductUnitCode, Quantity, 
								Price, SellingPrice, Discount, ItemDiscount, ItemDiscountType, Amount, VAT, VatableAmount, EVAT, EVatableAmount, 
								LocalTax, VariationsMatrixID, MatrixDescription, ProductGroup, ProductSubGroup, TransactionItemStatus, 
								DiscountCode, DiscountRemarks, ProductPackageID, MatrixPackageID, PackageQuantity, PromoQuantity, PromoValue, 
								PromoInPercent, PromoType, PromoApplied, PurchasePrice, PurchaseAmount, IncludeInSubtotalDiscount, 
								OrderSlipPrinter, OrderSlipPrinted, PercentageCommision, Commision, PaxNo FROM tblTransactionItems06;
								
INSERT INTO tblTransactionItems (TransactionID, ProductID, ProductCode, BarCode, Description, ProductUnitID, ProductUnitCode, Quantity, 
								Price, SellingPrice, Discount, ItemDiscount, ItemDiscountType, Amount, VAT, VatableAmount, EVAT, EVatableAmount, 
								LocalTax, VariationsMatrixID, MatrixDescription, ProductGroup, ProductSubGroup, TransactionItemStatus, 
								DiscountCode, DiscountRemarks, ProductPackageID, MatrixPackageID, PackageQuantity, PromoQuantity, PromoValue, 
								PromoInPercent, PromoType, PromoApplied, PurchasePrice, PurchaseAmount, IncludeInSubtotalDiscount, 
								OrderSlipPrinter, OrderSlipPrinted, PercentageCommision, Commision, PaxNo)
						SELECT	NewTransactionID, ProductID, ProductCode, BarCode, Description, ProductUnitID, ProductUnitCode, Quantity, 
								Price, SellingPrice, Discount, ItemDiscount, ItemDiscountType, Amount, VAT, VatableAmount, EVAT, EVatableAmount, 
								LocalTax, VariationsMatrixID, MatrixDescription, ProductGroup, ProductSubGroup, TransactionItemStatus, 
								DiscountCode, DiscountRemarks, ProductPackageID, MatrixPackageID, PackageQuantity, PromoQuantity, PromoValue, 
								PromoInPercent, PromoType, PromoApplied, PurchasePrice, PurchaseAmount, IncludeInSubtotalDiscount, 
								OrderSlipPrinter, OrderSlipPrinted, PercentageCommision, Commision, PaxNo FROM tblTransactionItems07;
								
INSERT INTO tblTransactionItems (TransactionID, ProductID, ProductCode, BarCode, Description, ProductUnitID, ProductUnitCode, Quantity, 
								Price, SellingPrice, Discount, ItemDiscount, ItemDiscountType, Amount, VAT, VatableAmount, EVAT, EVatableAmount, 
								LocalTax, VariationsMatrixID, MatrixDescription, ProductGroup, ProductSubGroup, TransactionItemStatus, 
								DiscountCode, DiscountRemarks, ProductPackageID, MatrixPackageID, PackageQuantity, PromoQuantity, PromoValue, 
								PromoInPercent, PromoType, PromoApplied, PurchasePrice, PurchaseAmount, IncludeInSubtotalDiscount, 
								OrderSlipPrinter, OrderSlipPrinted, PercentageCommision, Commision, PaxNo)
						SELECT	NewTransactionID, ProductID, ProductCode, BarCode, Description, ProductUnitID, ProductUnitCode, Quantity, 
								Price, SellingPrice, Discount, ItemDiscount, ItemDiscountType, Amount, VAT, VatableAmount, EVAT, EVatableAmount, 
								LocalTax, VariationsMatrixID, MatrixDescription, ProductGroup, ProductSubGroup, TransactionItemStatus, 
								DiscountCode, DiscountRemarks, ProductPackageID, MatrixPackageID, PackageQuantity, PromoQuantity, PromoValue, 
								PromoInPercent, PromoType, PromoApplied, PurchasePrice, PurchaseAmount, IncludeInSubtotalDiscount, 
								OrderSlipPrinter, OrderSlipPrinted, PercentageCommision, Commision, PaxNo FROM tblTransactionItems08;
								
INSERT INTO tblTransactionItems (TransactionID, ProductID, ProductCode, BarCode, Description, ProductUnitID, ProductUnitCode, Quantity, 
								Price, SellingPrice, Discount, ItemDiscount, ItemDiscountType, Amount, VAT, VatableAmount, EVAT, EVatableAmount, 
								LocalTax, VariationsMatrixID, MatrixDescription, ProductGroup, ProductSubGroup, TransactionItemStatus, 
								DiscountCode, DiscountRemarks, ProductPackageID, MatrixPackageID, PackageQuantity, PromoQuantity, PromoValue, 
								PromoInPercent, PromoType, PromoApplied, PurchasePrice, PurchaseAmount, IncludeInSubtotalDiscount, 
								OrderSlipPrinter, OrderSlipPrinted, PercentageCommision, Commision, PaxNo)
						SELECT	NewTransactionID, ProductID, ProductCode, BarCode, Description, ProductUnitID, ProductUnitCode, Quantity, 
								Price, SellingPrice, Discount, ItemDiscount, ItemDiscountType, Amount, VAT, VatableAmount, EVAT, EVatableAmount, 
								LocalTax, VariationsMatrixID, MatrixDescription, ProductGroup, ProductSubGroup, TransactionItemStatus, 
								DiscountCode, DiscountRemarks, ProductPackageID, MatrixPackageID, PackageQuantity, PromoQuantity, PromoValue, 
								PromoInPercent, PromoType, PromoApplied, PurchasePrice, PurchaseAmount, IncludeInSubtotalDiscount, 
								OrderSlipPrinter, OrderSlipPrinted, PercentageCommision, Commision, PaxNo FROM tblTransactionItems09;
								
INSERT INTO tblTransactionItems (TransactionID, ProductID, ProductCode, BarCode, Description, ProductUnitID, ProductUnitCode, Quantity, 
								Price, SellingPrice, Discount, ItemDiscount, ItemDiscountType, Amount, VAT, VatableAmount, EVAT, EVatableAmount, 
								LocalTax, VariationsMatrixID, MatrixDescription, ProductGroup, ProductSubGroup, TransactionItemStatus, 
								DiscountCode, DiscountRemarks, ProductPackageID, MatrixPackageID, PackageQuantity, PromoQuantity, PromoValue, 
								PromoInPercent, PromoType, PromoApplied, PurchasePrice, PurchaseAmount, IncludeInSubtotalDiscount, 
								OrderSlipPrinter, OrderSlipPrinted, PercentageCommision, Commision, PaxNo)
						SELECT	NewTransactionID, ProductID, ProductCode, BarCode, Description, ProductUnitID, ProductUnitCode, Quantity, 
								Price, SellingPrice, Discount, ItemDiscount, ItemDiscountType, Amount, VAT, VatableAmount, EVAT, EVatableAmount, 
								LocalTax, VariationsMatrixID, MatrixDescription, ProductGroup, ProductSubGroup, TransactionItemStatus, 
								DiscountCode, DiscountRemarks, ProductPackageID, MatrixPackageID, PackageQuantity, PromoQuantity, PromoValue, 
								PromoInPercent, PromoType, PromoApplied, PurchasePrice, PurchaseAmount, IncludeInSubtotalDiscount, 
								OrderSlipPrinter, OrderSlipPrinted, PercentageCommision, Commision, PaxNo FROM tblTransactionItems10;
								
INSERT INTO tblTransactionItems (TransactionID, ProductID, ProductCode, BarCode, Description, ProductUnitID, ProductUnitCode, Quantity, 
								Price, SellingPrice, Discount, ItemDiscount, ItemDiscountType, Amount, VAT, VatableAmount, EVAT, EVatableAmount, 
								LocalTax, VariationsMatrixID, MatrixDescription, ProductGroup, ProductSubGroup, TransactionItemStatus, 
								DiscountCode, DiscountRemarks, ProductPackageID, MatrixPackageID, PackageQuantity, PromoQuantity, PromoValue, 
								PromoInPercent, PromoType, PromoApplied, PurchasePrice, PurchaseAmount, IncludeInSubtotalDiscount, 
								OrderSlipPrinter, OrderSlipPrinted, PercentageCommision, Commision, PaxNo)
						SELECT	NewTransactionID, ProductID, ProductCode, BarCode, Description, ProductUnitID, ProductUnitCode, Quantity, 
								Price, SellingPrice, Discount, ItemDiscount, ItemDiscountType, Amount, VAT, VatableAmount, EVAT, EVatableAmount, 
								LocalTax, VariationsMatrixID, MatrixDescription, ProductGroup, ProductSubGroup, TransactionItemStatus, 
								DiscountCode, DiscountRemarks, ProductPackageID, MatrixPackageID, PackageQuantity, PromoQuantity, PromoValue, 
								PromoInPercent, PromoType, PromoApplied, PurchasePrice, PurchaseAmount, IncludeInSubtotalDiscount, 
								OrderSlipPrinter, OrderSlipPrinted, PercentageCommision, Commision, PaxNo FROM tblTransactionItems11;

INSERT INTO tblTransactionItems (TransactionID, ProductID, ProductCode, BarCode, Description, ProductUnitID, ProductUnitCode, Quantity, 
								Price, SellingPrice, Discount, ItemDiscount, ItemDiscountType, Amount, VAT, VatableAmount, EVAT, EVatableAmount, 
								LocalTax, VariationsMatrixID, MatrixDescription, ProductGroup, ProductSubGroup, TransactionItemStatus, 
								DiscountCode, DiscountRemarks, ProductPackageID, MatrixPackageID, PackageQuantity, PromoQuantity, PromoValue, 
								PromoInPercent, PromoType, PromoApplied, PurchasePrice, PurchaseAmount, IncludeInSubtotalDiscount, 
								OrderSlipPrinter, OrderSlipPrinted, PercentageCommision, Commision, PaxNo)
						SELECT	NewTransactionID, ProductID, ProductCode, BarCode, Description, ProductUnitID, ProductUnitCode, Quantity, 
								Price, SellingPrice, Discount, ItemDiscount, ItemDiscountType, Amount, VAT, VatableAmount, EVAT, EVatableAmount, 
								LocalTax, VariationsMatrixID, MatrixDescription, ProductGroup, ProductSubGroup, TransactionItemStatus, 
								DiscountCode, DiscountRemarks, ProductPackageID, MatrixPackageID, PackageQuantity, PromoQuantity, PromoValue, 
								PromoInPercent, PromoType, PromoApplied, PurchasePrice, PurchaseAmount, IncludeInSubtotalDiscount, 
								OrderSlipPrinter, OrderSlipPrinted, PercentageCommision, Commision, PaxNo FROM tblTransactionItems12;
													
DROP TABLE tblTransactions01;
DROP TABLE tblTransactions02;
DROP TABLE tblTransactions03;
DROP TABLE tblTransactions04;
DROP TABLE tblTransactions05;
DROP TABLE tblTransactions06;
DROP TABLE tblTransactions07;
DROP TABLE tblTransactions08;
DROP TABLE tblTransactions09;
DROP TABLE tblTransactions10;
DROP TABLE tblTransactions11;
DROP TABLE tblTransactions12;

DROP TABLE tblTransactionItems01;
DROP TABLE tblTransactionItems02;
DROP TABLE tblTransactionItems03;
DROP TABLE tblTransactionItems04;
DROP TABLE tblTransactionItems05;
DROP TABLE tblTransactionItems06;
DROP TABLE tblTransactionItems07;
DROP TABLE tblTransactionItems08;
DROP TABLE tblTransactionItems09;
DROP TABLE tblTransactionItems10;
DROP TABLE tblTransactionItems11;
DROP TABLE tblTransactionItems12;


ALTER TABLE tblProducts DROP PRIMARY KEY;
DROP INDEX PK_tblProducts ON tblProducts;
DROP INDEX PK1_tblProducts ON tblProducts;
DROP INDEX IX2_tblProducts ON tblProducts;
DROP INDEX IX3_tblProducts ON tblProducts;
DROP INDEX IX1_tblProducts ON tblProducts;
DROP INDEX IX_tblProducts_Barcode2 ON tblProducts;
DROP INDEX IX_tblProducts_Barcode3 ON tblProducts;
DROP INDEX IX4_tblProducts ON tblProducts;

ALTER TABLE tblProducts ADD INDEX IX_tblProducts_ProductID (ProductID);
ALTER TABLE tblProducts ADD INDEX IX_tblProducts_BarCode1 (BarCode);
ALTER TABLE tblProducts ADD INDEX IX_tblProducts_BarCode2 (BarCode2);
ALTER TABLE tblProducts ADD INDEX IX_tblProducts_BarCode3 (BarCode3);
ALTER TABLE tblProducts ADD INDEX IX_tblProducts_ProductCode (ProductCode);

ALTER TABLE tblProducts ENGINE = InnoDB;
ALTER TABLE tblProducts PARTITION BY HASH ( ProductID ) PARTITIONS 5 ;

/*********************************  v_4.0.0.0.sql END  *******************************************************/ 

/*********************************  v_4.0.0.1.sql START  *******************************************************/ 


ALTER TABLE tblProductSubGroup MODIFY ProductSubGroupCode VARCHAR(50);
ALTER TABLE tblTransactionItems MODIFY ProductSubGroup VARCHAR(50);
ALTER TABLE tblTransactionItems MODIFY ProductGroup VARCHAR(50);

ALTER TABLE tblProductBaseVariationsMatrix MODIFY ActualQuantity DECIMAL(18,3) DEFAULT 0;
ALTER TABLE tblProducts MODIFY ActualQuantity DECIMAL(18,3) DEFAULT 0;
ALTER TABLE tblBranchInventory MODIFY ActualQuantity DECIMAL(18,3) DEFAULT 0;
ALTER TABLE tblBranchInventoryMatrix MODIFY ActualQuantity DECIMAL(18,3) DEFAULT 0;

-- [02/28/2012] For checking who did save the new purchase price
ALTER TABLE tblProductPurchasePriceHistory ADD `PurchaserName` VARCHAR(100);
ALTER TABLE tblProductPurchasePriceHistory ADD `DateCreated` DATETIME NOT NULL;
UPDATE tblProductPurchasePriceHistory SET 
	PurchaserName = (SELECT PurchaserName FROM tblPO WHERE tblPO.PurchaserName = tblProductPurchasePriceHistory.PurchaserName);

-- [03/02/2012] HP request to include the purchase price in Stocks to know how much is the cost of bad order.
ALTER TABLE tblStockItems ADD `PurchasePrice` DECIMAL(18,3) NOT NULL DEFAULT 0;
UPDATE tblStockItems a,  tblProductPackage b SET a.PurchasePrice = IFNULL(b.PurchasePrice,0) WHERE b.ProductID = a.ProductID AND b.UnitID  = a.ProductUnitID;

-- [03/18/2012] Include How the terminal will search item during search code.
--		0 = Search by Barcode1, Barcode2, Barcode 3 Only
--		1 = Search by Barcode1, Barcode2, Barcode 3, ProductCode Only
--		2 = Search by Barcode1, Barcode2, Barcode 3, ProductCode, ProductDesc Only
--		3 = Search by ProductCode Only
--		4 = Search by ProductDesc Only
--		5 = Search by ProductCode, ProductDesc Only
ALTER TABLE tblTerminal ADD `ProductSearchType` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0;
-- 
/*********************************  v_4.0.0.1.sql END  *******************************************************/ 

/*********************************  v_4.0.0.2.sql  *******************************************************/ 

-- [03/31/2012] Include a Flag wether the Movement is in the Main Quantity or Branch Quantity
--		0 = Movement in Main Quantity
--		1 = Movement in Branch Quantity
ALTER TABLE tblProductMovement ADD `QuantityMovementType` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE tblProductMovement MODIFY `TransactionNo` varchar(30) NOT NULL;


-- [04/02/2012] Remove the tblContactCreditCardMovement and put all info inside the tblCreditPayment
--
DROP TABLE IF EXISTS tblContactCreditCardMovement;

ALTER TABLE tblCreditPayment ADD `GuarantorID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE tblCreditPayment ADD `CreditType` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblCreditPayment ADD `CreditDate` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblCreditPayment ADD `CreditBefore` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCreditPayment ADD `CreditAfter` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCreditPayment ADD `CreditExpiryDate` DATE NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblCreditPayment ADD `CreditReason` VARCHAR(150) NOT NULL;
ALTER TABLE tblCreditPayment ADD `TerminalNo` VARCHAR(10) NOT NULL;
ALTER TABLE tblCreditPayment ADD `CashierName` VARCHAR(150) NOT NULL;
ALTER TABLE tblCreditPayment ADD `AmountPaidCuttOffMonth` DECIMAL(18,3) NOT NULL DEFAULT 0;

-- CREATE INDEX `IX_tblContactCreditCardMovement`(`CustomerID`) ON 
-- INDEX `IX_tblContactCreditCardMovement1`(`CreditDate`),
-- INDEX `IX_tblContactCreditCardMovement2`(`CustomerID`, `CreditDate`)


/*****************************
**	sysConfig
*****************************/
DROP TABLE IF EXISTS sysConfig;
CREATE TABLE sysConfig (
	`ConfigName` VARCHAR(30) NOT NULL,
	`ConfigValue` VARCHAR(150) NOT NULL,
	PRIMARY KEY (ConfigName),
	INDEX `IX_sysConfig`(`ConfigName`),
	UNIQUE `PK_sysConfig`(`ConfigName`)
);


ALTER TABLE tblTerminal MODIFY `Status` INT (1) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminal MODIFY `AutoPrint` INT (1) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminal MODIFY `TerminalReceiptType` INT (1) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminal MODIFY `ProductSearchType` INT (1) NOT NULL DEFAULT 0;


ALTER TABLE tblTerminal MODIFY `IsPrinterAutoCutter` TINYINT (1) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminal MODIFY `EnableEVAT` TINYINT (1) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminal MODIFY `ItemVoidConfirmation` TINYINT (1) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminal MODIFY `ShowCustomerSelection` TINYINT (1) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminal MODIFY `ShowItemMoreThanZeroQty` TINYINT (1) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminal MODIFY `RoundDownRewardPoints` TINYINT (1) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminal MODIFY `EnableRewardPoints` TINYINT (1) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminal MODIFY `IsFineDining` TINYINT (1) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminal MODIFY `AutoGenerateRewardCardNo` TINYINT (1) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminal MODIFY `EnableRewardPointsAsPayment` TINYINT (1) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminal MODIFY `WillPrintGrandTotal` TINYINT (1) NOT NULL DEFAULT 0;

ALTER TABLE tblTerminal MODIFY `IsVATInclusive` TINYINT (1) NOT NULL DEFAULT 0;

ALTER TABLE tblTerminal MODIFY `OrderSlipPrinter` INT (1) NOT NULL DEFAULT 0;
ALTER TABLE tblProductGroup MODIFY `OrderSlipPrinter` INT (1) NOT NULL DEFAULT 0;

ALTER TABLE tblTransactionItems MODIFY `OrderSlipPrinter` INT (1) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems MODIFY `ItemDiscountType` INT (1) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems MODIFY `TransactionItemStatus` INT (1) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems MODIFY `PromoType` INT (1) NOT NULL DEFAULT 0;

ALTER TABLE tblContactRewards MODIFY `RewardCardStatus` INT (1) NOT NULL DEFAULT 0;
ALTER TABLE tblContactCreditCardInfo MODIFY `CreditType` INT (1) NOT NULL DEFAULT 0;
ALTER TABLE tblContactCreditCardInfo MODIFY `CreditCardStatus` INT (1) NOT NULL DEFAULT 0;

CREATE TABLE tblCalDate(
	`CalDate` Date,
    INDEX `IX_tblCalDate`(`CalDate`)
);


-- 06Jan2013 LEAceron : fixed data types due to Boolean and enum conflict

ALTER TABLE tblContactGroup MODIFY `ContactGroupCategory` TINYINT(1) UNSIGNED NOT NULL DEFAULT 3;
ALTER TABLE tblStockType MODIFY `StockDirection` TINYINT(1) UNSIGNED NOT NULL DEFAULT 1;
ALTER TABLE tblPromo MODIFY `Status` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE tblTerminal MODIFY `Status` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE tblTerminal MODIFY `TerminalReceiptType` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE tblTerminal MODIFY `OrderSlipPrinter` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE tblProductGroup MODIFY `OrderSlipPrinter` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE tblPLUReport MODIFY `OrderSlipPrinter` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE tblContactRewards MODIFY `RewardCardStatus` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE tblContactCreditCardInfo MODIFY `CreditType` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE tblContactCreditCardInfo MODIFY `CreditCardStatus` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems MODIFY `ItemDiscountType` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems MODIFY `PromoType` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems MODIFY `OrderSlipPrinter` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems MODIFY `OrderSlipPrinted` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblCreditPayment MODIFY `CreditType` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0;

ALTER TABLE tblTransactions ADD PARTITION (
		PARTITION p2014 VALUES LESS THAN (2014) (
			SUBPARTITION sJan2014,
			SUBPARTITION sFeb2014,
			SUBPARTITION sMar2014,
			SUBPARTITION sApr2014,
			SUBPARTITION sMay2014,
			SUBPARTITION sJun2014,
			SUBPARTITION sJul2014,
			SUBPARTITION sAug2014,
			SUBPARTITION sSep2014,
			SUBPARTITION sOct2014,
			SUBPARTITION sNov2014,
			SUBPARTITION sDec2014) ) ;

/*********************************  v_4.0.0.2.sql END  *******************************************************/ 

/*********************************  v_4.0.0.3.sql START
	Change the inventory to look into tblProductInventory
 *******************************************************/ 
ALTER TABLE tblCreditPayment MODIFY `Remarks` VARCHAR(8000); -- 09Mar2013 put payments log in remarks
ALTER TABLE tblProductMovement MODIFY `MatrixDescription` VARCHAR(100) DEFAULT '';

-- Update the correct transactionid. Found out in BOOZE that incorrect transactionid was saved for old transactions.
UPDATE tblCreditPayment SET
	TransactionID = (SELECT transactionid FROM tblTransactions 
				WHERE tblTransactions.transactionno = tblCreditPayment.transactionno
					and tblTransactions.customerid = tblCreditPayment.Contactid);

-- Added Apr 29, 2013
INSERT INTO tblReceipt(Module, Text, Value, Orientation) VALUES ('GroupCreditChargeHeader', '', 'GROUP CREDIT CHARGE SLIP',1);
INSERT INTO tblReceipt(Module, Text, Value, Orientation) VALUES ('IndividualCreditChargeHeader', '', 'CHARGE SLIP',1);
-- For HP values should be
--		GroupCreditChargeHeader:		HP CREDIT CHARGE SLIP
--		IndividualCreditChargeHeader:	SUPER CREDIT CHARGE SLIP

ALTER TABLE tblTerminal ADD `IncludeCreditChargeAgreement` TINYINT(1) NOT NULL DEFAULT 0;
-- If HP the value should be 1 which will include the following
--		I hereby agree  to pay the total  amount
--		stated herein including any charges  due
--		thereon  subject   to    the   pertinent
--		contract   governing  the use of    this


-- Added May 14, 2013. 
--	0  means product can be sold and not lock for closing inventory
--	1  means product can be sold and lock for closing inventory
ALTER TABLE tblProductGroup ADD `isLock` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblContacts ADD `isLock` TINYINT(1) NOT NULL DEFAULT 0;


DROP TABLE IF EXISTS deleted_tblProducts;
CREATE TABLE deleted_tblProducts(SELECT * FROM tblProducts);

DROP TABLE IF EXISTS deleted_tblProductBaseVariationsMatrix;
CREATE TABLE deleted_tblProductBaseVariationsMatrix(SELECT * FROM tblProductBaseVariationsMatrix);

/*****************************
**	tblProductInventory
*****************************/
DROP TABLE IF EXISTS tblProductInventory;
CREATE TABLE tblProductInventory (
	`BranchID` INT(4) UNSIGNED NOT NULL DEFAULT 0,
	`ProductID` BIGINT NOT NULL DEFAULT 0,
	`MatrixID` BIGINT NOT NULL DEFAULT 0,
	`Quantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`QuantityIn` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`QuantityOut` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ActualQuantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`IsLock` TINYINT(1) NOT NULL DEFAULT 0,
	INDEX `IX_tblProductInventory`(`ProductID`, `MatrixID`, `BranchID`),
	UNIQUE `PK_tblProductInventory`(`ProductID`, `MatrixID`, `BranchID`)
);


RENAME TABLE tblBranchInventory TO deleted_tblBranchInventory;
RENAME TABLE tblBranchInventoryMatrix TO deleted_tblBranchInventoryMatrix;

INSERT INTO tblProductInventory(BranchID, ProductID, MatrixID, Quantity, QuantityIn, QuantityOut, ActualQuantity)
SELECT BranchID, ProductID, 0, Quantity, QuantityIn, QuantityOut, ActualQuantity 
FROM deleted_tblBranchInventory
WHERE ProductID NOT IN (SELECT DISTINCT ProductID FROM deleted_tblBranchInventoryMatrix);

INSERT INTO tblProductInventory(BranchID, ProductID, MatrixID, Quantity, QuantityIn, QuantityOut, ActualQuantity)
SELECT BranchID, ProductID, MatrixID, Quantity, QuantityIn, QuantityOut, ActualQuantity FROM deleted_tblBranchInventoryMatrix;

-- insert all products that are not in the inventory
INSERT INTO tblProductInventory(BranchID, ProductID, MatrixID, Quantity, QuantityIn, QuantityOut, ActualQuantity)
SELECT brnch.BranchID, prd.ProductID, 0, prd.Quantity, prd.QuantityIn, prd.QuantityOut, prd.ActualQuantity
FROM deleted_tblProducts prd
LEFT OUTER JOIN tblBranch brnch ON 1=1
LEFT OUTER JOIN tblProductInventory inv ON prd.ProductID = inv.ProductID AND MatrixID = 0 AND brnch.BranchID = inv.BranchID
WHERE inv.MatrixID IS NULL;

-- insert all variations that are not in the inventory
INSERT INTO tblProductInventory(BranchID, ProductID, MatrixID, Quantity, QuantityIn, QuantityOut, ActualQuantity)
SELECT brnch.BranchID, prd.ProductID, mtrx.MatrixID, mtrx.Quantity, mtrx.QuantityIn, mtrx.QuantityOut, mtrx.ActualQuantity
FROM deleted_tblProducts prd
INNER JOIN deleted_tblProductBaseVariationsMatrix mtrx ON prd.ProductID = mtrx.ProductID
LEFT OUTER JOIN tblBranch brnch ON 1=1
LEFT OUTER JOIN tblProductInventory inv ON prd.ProductID = inv.ProductID AND inv.MatrixID = mtrx.MatrixID AND brnch.BranchID = inv.BranchID
WHERE inv.MatrixID IS NULL;

-- remove all variations where productid not in tblproducts
DELETE FROM tblProductBaseVariationsMatrix WHERE ProductID NOT IN (SELECT DISTINCT ProductID FROM tblProducts);

-- remove invalid variations from the inventory.
DELETE FROM tblProductInventory WHERE MatrixID <> 0 AND MatrixID NOT IN (SELECT DISTINCT MatrixID FROM tblProductBaseVariationsMatrix);

-- check if all variations are already in the inventory, should all be zero result
SELECT * FROM tblProductInventory WHERE MatrixID <> 0 AND MatrixID NOT IN (SELECT DISTINCT MatrixID FROM tblProductBaseVariationsMatrix);
SELECT * FROM tblProductBaseVariationsMatrix WHERE MatrixID <> 0 AND MatrixID NOT IN (SELECT DISTINCT MatrixID FROM tblProductInventory);

-- remove invalid products from the inventory. this is cause by the branchinventorymatrix
DELETE FROM tblProductInventory WHERE ProductID NOT IN (SELECT DISTINCT ProductID FROM tblProducts);

-- check if all products are already in the inventory, should all be zero result
SELECT * FROM tblProducts WHERE ProductID NOT IN (SELECT DISTINCT ProductID FROM tblProductInventory);
SELECT * FROM tblProductInventory WHERE ProductID NOT IN (SELECT DISTINCT ProductID FROM tblProducts);

-- update the quantity of constant products
UPDATE tblProductInventory SET Quantity = 999999999 WHERE ProductID = (SELECT ProductID FROM tblProducts WHERE ProductCode = 'CREDIT PAYMENT');
UPDATE tblProductInventory SET Quantity = 999999999 WHERE ProductID = (SELECT ProductID FROM tblProducts WHERE ProductCode = 'ADVNTGE CARD - MEMBERSHIP FEE');
UPDATE tblProductInventory SET Quantity = 999999999 WHERE ProductID = (SELECT ProductID FROM tblProducts WHERE ProductCode = 'ADVNTGE CARD - RENEWAL FEE');
UPDATE tblProductInventory SET Quantity = 999999999 WHERE ProductID = (SELECT ProductID FROM tblProducts WHERE ProductCode = 'ADVNTGE CARD - REPLACEMENT FEE');
UPDATE tblProductInventory SET Quantity = 999999999 WHERE ProductID = (SELECT ProductID FROM tblProducts WHERE ProductCode = 'CREDIT CARD - MEMBERSHIP FEE');
UPDATE tblProductInventory SET Quantity = 999999999 WHERE ProductID = (SELECT ProductID FROM tblProducts WHERE ProductCode = 'CREDIT CARD - RENEWAL FEE');
UPDATE tblProductInventory SET Quantity = 999999999 WHERE ProductID = (SELECT ProductID FROM tblProducts WHERE ProductCode = 'CREDIT CARD - REPLACEMENT FEE');
UPDATE tblProductInventory SET Quantity = 999999999 WHERE ProductID = (SELECT ProductID FROM tblProducts WHERE ProductCode = 'SUPER CARD - MEMBERSHIP FEE');
UPDATE tblProductInventory SET Quantity = 999999999 WHERE ProductID = (SELECT ProductID FROM tblProducts WHERE ProductCode = 'SUPER CARD - RENEWAL FEE');
UPDATE tblProductInventory SET Quantity = 999999999 WHERE ProductID = (SELECT ProductID FROM tblProducts WHERE ProductCode = 'SUPER CARD - REPLACEMENT FEE');

ALTER TABLE tblProductBaseVariationsMatrix DROP Quantity;
ALTER TABLE tblProductBaseVariationsMatrix DROP QuantityIN;
ALTER TABLE tblProductBaseVariationsMatrix DROP QuantityOut;
ALTER TABLE tblProductBaseVariationsMatrix DROP ActualQuantity;

ALTER TABLE tblProducts DROP Quantity;
ALTER TABLE tblProducts DROP QuantityIN;
ALTER TABLE tblProducts DROP QuantityOut;
ALTER TABLE tblProducts DROP ActualQuantity;


/******************************** do the package insertion ***********************************/
ALTER TABLE tblProductPackage ADD MatrixID bigint NOT NULL DEFAULT 0;
ALTER TABLE tblProductPackage ADD PRIMARY KEY(PackageID);

ALTER TABLE tblProductPackage DROP INDEX `PK_tblProductPackage`;
ALTER TABLE tblProductPackage ADD UNIQUE INDEX `PK_tblProductPackage`(`ProductID`,`MatrixID`,`UnitID`,`Quantity`);
ALTER TABLE tblProductPackage DROP INDEX `IX_tblProductPackage`;
ALTER TABLE tblProductPackage ADD INDEX `IX_tblProductPackage`(`PackageID`,`ProductID`,`MatrixID`);

ALTER TABLE tblProductPackage ADD BarCode4 VARCHAR(60);
ALTER TABLE tblProductPackage ADD INDEX `IX3_tblProductPackage`(`BarCode1`,`BarCode2`,`BarCode3`,`BarCode4`);

INSERT INTO tblProductPackage(ProductID, MatrixID, UnitID, Price, Quantity, VAT, EVAT, LocalTax, WSPrice, Barcode1, Barcode2, Barcode3)
SELECT ProductID, 0, BaseUnitID, Price, 1, VAT, EVAT, LocalTax, WSPrice, BarCode, BarCode2, BarCode3
FROM tblProducts prd WHERE ProductID NOT IN (SELECT DISTINCT PRODUCTID FROM tblProductPackage WHERE MatrixID = 0);

DROP TABLE IF EXISTS deleted_tblmatrixpackage;
RENAME TABLE tblmatrixpackage TO deleted_tblmatrixpackage;

INSERT INTO tblProductPackage(ProductID, MatrixID, UnitID, Price, Quantity, VAT, EVAT, LocalTax, WSPrice, Barcode1, Barcode2, Barcode3)
SELECT ProductID, mtrxpkg.MatrixID, mtrxpkg.UnitID, mtrxpkg.Price, mtrxpkg.Quantity, mtrxpkg.VAT, mtrxpkg.EVAT, mtrxpkg.LocalTax, mtrxpkg.WSPrice, '', '', '' 
FROM deleted_tblmatrixpackage mtrxpkg INNER JOIN tblProductBaseVariationsMatrix mtrx ON mtrxpkg.MatrixID = mtrx.MatrixID;

-- update the barcode4 as a unique system barcode
UPDATE tblProductPackage SET 
	BarCode4 = REPLACE(CONCAT(IFNULL(BarCode1,''), Quantity, ProductID, MatrixID),'.','')
WHERE MatrixID = 0;	

-- update the barcode4 as a unique system barcode for each variations
UPDATE tblProductPackage prd 
INNER JOIN tblProductPackage mtrx ON
	prd.ProductID = mtrx.ProductID AND mtrx.MatrixID <> 0
SET mtrx.BarCode4 = REPLACE(CONCAT(IFNULL(prd.BarCode1,''), mtrx.Quantity, prd.ProductID, mtrx.MatrixID),'.','');

-- update the purchase price
UPDATE tblProductPackage pkg
INNER JOIN tblProducts prd ON pkg.ProductID = prd.ProductID AND pkg.MatrixID = 0 AND pkg.Quantity = 1 AND pkg.UnitID = prd.BaseUnitID 
SET pkg.purchaseprice = prd.PurchasePrice;

UPDATE tblProductPackage pkg
INNER JOIN tblProductBaseVariationsMatrix mtrx ON pkg.ProductID = mtrx.ProductID AND pkg.MatrixID = mtrx.MatrixID AND pkg.Quantity = 1 AND pkg.UnitID = mtrx.UnitID 
SET pkg.purchaseprice = mtrx.PurchasePrice;

ALTER TABLE tblProducts DROP Barcode;
ALTER TABLE tblProducts DROP Barcode2;
ALTER TABLE tblProducts DROP Barcode3;

ALTER TABLE tblProducts DROP PurchasePrice;
ALTER TABLE tblProducts DROP Price;
ALTER TABLE tblProducts DROP WSPrice;
ALTER TABLE tblProducts DROP VAT;
ALTER TABLE tblProducts DROP EVAT;
ALTER TABLE tblProducts DROP LocalTax;

ALTER TABLE tblProductBaseVariationsMatrix DROP PurchasePrice;
ALTER TABLE tblProductBaseVariationsMatrix DROP Price;
ALTER TABLE tblProductBaseVariationsMatrix DROP WSPrice;
ALTER TABLE tblProductBaseVariationsMatrix DROP VAT;
ALTER TABLE tblProductBaseVariationsMatrix DROP EVAT;
ALTER TABLE tblProductBaseVariationsMatrix DROP LocalTax;

-- This will be use to determine if Transaction is Refund
--		0 POSNormal
--		1 POSRefund
--		2 POSOpenSuspended
ALTER TABLE tblTransactions ADD TransactionType INT(1) NOT NULL DEFAULT 0;


/*********************************  v_4.0.0.3.sql END  *******************************************************/ 

/*********************************  v_4.0.0.4.sql START  
	Include terminal as parking and parking rates
*******************************************************/ 

ALTER TABLE tblTerminal add `IsParkingTerminal` TINYINT (1) NOT NULL DEFAULT 0;

ALTER TABLE tblTerminal add `WillPrintChargeSlip` TINYINT (1) NOT NULL DEFAULT 1;

/*****************************
**	tblParkingRates
		Overrides the base parking rate if the rate is not flat rate. Flat rate is the Price in tblProductPackage. 
		No need to create parking rate if rate is just flat rate but not daily. If daily flat rate then have to create this.
	
		MinimumStayInMin is the no of minutes on the first bucket 
			example: 24HRS everyday rate is 200 pesos value should be 1440 and MinimumStayPrice should be 200 (pesos)
			example: if first 2 hours is 100 pesos value should be 120 and MinimumStayPrice should be 100 (pesos)
			example: if first 1 hour is 50 pesos value should be 60 and MinimumStayPrice should be 50 (pesos)
			example: if first 15 mins is free value should be 15 and MinimumStayPrice should be 0 (pesos)
		NoOfUnitPerMin is the no of units per succeeding after the first charge of MinimumStayInMin
			example: if succeeding hourly rate is 10 pesos value should be 60 and PerUnitPrice should be 10 (pesos)
			example: if succeeding rate is 10 pesos every 30 min value should be 30 and PerUnitPrice should be 10 (pesos)
			example: if succeeding rate is 1 peso per min value should be 1 and PerUnitPrice should be 10 (peso)

*****************************/
DROP TABLE IF EXISTS tblParkingRates;
CREATE TABLE tblParkingRates (
	`ParkingRateID` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
	`ProductID` BIGINT NOT NULL DEFAULT 0,
	`DayOfWeek` VARCHAR(9) NOT NULL,
	`StartTime` VARCHAR(5) NOT NULL,
	`Endtime` VARCHAR(5) NOT NULL,
	`NoOfUnitPerMin` INT NOT NULL DEFAULT 1,
	`PerUnitPrice` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`MinimumStayInMin` INT NOT NULL DEFAULT 60,
	`MinimumStayPrice` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`CreatedByName` VARCHAR(100),
	`CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`LastUpdatedByName` VARCHAR(100),
	`LastUpdatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	INDEX `IX_tblParkingRates`(`ProductID`, `DayOfWeek`, `StartTime`),
	PRIMARY KEY (ParkingRateID),
	UNIQUE `PK_tblParkingRates`(`ProductID`, `DayOfWeek`, `StartTime`, `Endtime`)
);

/*****************************
**	tblTransactionsBackup
		This table will hold the backup records of tblTransactions.
	
		Purpose of this is to make the reporting of sales items faster specially in groceries.

*****************************/

DROP TABLE IF EXISTS tblTransactionsBackup;
CREATE TABLE `tblTransactionsBackup` (
  `TransactionID` bigint(20) unsigned NOT NULL DEFAULT 0,
  `TransactionNo` varchar(30) NOT NULL,
  `CustomerID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `CustomerName` varchar(100) NOT NULL,
  `CashierID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `CashierName` varchar(100) NOT NULL,
  `TerminalNo` varchar(30) NOT NULL,
  `TransactionDate` datetime NOT NULL,
  `DateSuspended` datetime NOT NULL DEFAULT '1900-01-01 12:00:00',
  `DateResumed` datetime NOT NULL DEFAULT '1900-01-01 12:00:00',
  `TransactionStatus` smallint(1) unsigned NOT NULL DEFAULT '0',
  `SubTotal` decimal(18,3) NOT NULL DEFAULT '0.00',
  `Discount` decimal(18,3) NOT NULL DEFAULT '0.00',
  `TransDiscount` decimal(18,3) NOT NULL DEFAULT '0.00',
  `TransDiscountType` int(10) NOT NULL DEFAULT '0',
  `VAT` decimal(18,3) NOT NULL DEFAULT '0.00',
  `VatableAmount` decimal(18,3) NOT NULL DEFAULT '0.00',
  `EVAT` decimal(18,3) NOT NULL DEFAULT '0.00',
  `EVatableAmount` decimal(18,3) NOT NULL DEFAULT '0.00',
  `LocalTax` decimal(18,3) NOT NULL DEFAULT '0.00',
  `AmountPaid` decimal(18,3) NOT NULL DEFAULT '0.00',
  `CashPayment` decimal(18,3) NOT NULL DEFAULT '0.00',
  `ChequePayment` decimal(18,3) NOT NULL DEFAULT '0.00',
  `CreditCardPayment` decimal(18,3) NOT NULL DEFAULT '0.00',
  `CreditPayment` decimal(18,3) NOT NULL DEFAULT '0.00',
  `BalanceAmount` decimal(18,3) NOT NULL DEFAULT '0.00',
  `ChangeAmount` decimal(18,3) NOT NULL DEFAULT '0.00',
  `DateClosed` datetime NOT NULL DEFAULT '1900-01-01 12:00:00',
  `PaymentType` int(10) unsigned NOT NULL DEFAULT '4',
  `DiscountCode` varchar(5) DEFAULT NULL,
  `DiscountRemarks` varchar(255) DEFAULT NULL,
  `DebitPayment` decimal(18,3) NOT NULL DEFAULT '0.00',
  `ItemsDiscount` decimal(18,3) NOT NULL DEFAULT '0.00',
  `Charge` decimal(18,3) NOT NULL DEFAULT '0.00',
  `ChargeAmount` decimal(18,3) NOT NULL DEFAULT '0.00',
  `ChargeCode` varchar(30) DEFAULT NULL,
  `ChargeRemarks` varchar(255) DEFAULT NULL,
  `WaiterID` bigint(20) unsigned NOT NULL DEFAULT '2',
  `WaiterName` varchar(100) NOT NULL,
  `Packed` tinyint(1) NOT NULL DEFAULT '0',
  `OrderType` smallint(6) NOT NULL DEFAULT '0',
  `AgentID` bigint(20) NOT NULL DEFAULT '1',
  `AgentName` varchar(100) DEFAULT 'RetailPlus Customer T',
  `CreatedByID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `CreatedByName` varchar(100) DEFAULT NULL,
  `AgentDepartmentName` varchar(30) NOT NULL DEFAULT 'System Default Department',
  `AgentPositionName` varchar(30) NOT NULL DEFAULT 'System Default Position',
  `ReleaserID` bigint(20) NOT NULL DEFAULT '0',
  `ReleaserName` varchar(100) DEFAULT NULL,
  `ReleasedDate` datetime NOT NULL DEFAULT '1900-01-01 12:00:00',
  `RewardPointsPayment` decimal(18,3) NOT NULL DEFAULT '0.000',
  `RewardConvertedPayment` decimal(18,3) NOT NULL DEFAULT '0.000',
  `PaxNo` int(4) NOT NULL DEFAULT '1',
  `CreditChargeAmount` decimal(18,3) NOT NULL DEFAULT '0.000',
  `BranchID` int(4) NOT NULL DEFAULT '1',
  `BranchCode` varchar(30) DEFAULT NULL,
  `TransactionType` int(1) NOT NULL DEFAULT '0',
  `BackupDate` datetime,
  KEY `IXU_tblTransactionsBackup` (`TransactionDate`),
  KEY `IX0_tblTransactionsBackup` (`TransactionID`),
  KEY `IX1_tblTransactionsBackup` (`TransactionNo`),
  KEY `IX2_tblTransactionsBackup` (`CustomerID`),
  KEY `IX3_tblTransactionsBackup` (`CashierID`)
);

DROP TABLE IF EXISTS tblTransactionItemsBackup;
CREATE TABLE `tblTransactionItemsBackup` (
	`TransactionItemsID` bigint(20) unsigned NOT NULL DEFAULT 0,
	`TransactionID` bigint(20) unsigned NOT NULL DEFAULT '0',
	`ProductID` bigint(20) unsigned NOT NULL DEFAULT '0',
	`ProductCode` varchar(30) NOT NULL,
	`BarCode` varchar(30) NOT NULL,
	`Description` varchar(100) NOT NULL,
	`ProductUnitID` int(3) unsigned NOT NULL DEFAULT '0',
	`ProductUnitCode` varchar(5) DEFAULT NULL,
	`Quantity` decimal(12,3) NOT NULL DEFAULT '0.000',
	`Price` decimal(18,3) NOT NULL DEFAULT '0.00',
	`SellingPrice` decimal(18,3) NOT NULL DEFAULT '0.00',
	`Discount` decimal(18,3) NOT NULL DEFAULT '0.00',
	`ItemDiscount` decimal(18,3) NOT NULL DEFAULT '0.00',
	`ItemDiscountType` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
	`Amount` decimal(18,3) NOT NULL DEFAULT '0.00',
	`VAT` decimal(18,3) NOT NULL DEFAULT '0.00',
	`VatableAmount` decimal(18,3) NOT NULL DEFAULT '0.00',
	`EVAT` decimal(18,3) NOT NULL DEFAULT '0.00',
	`EVatableAmount` decimal(18,3) NOT NULL DEFAULT '0.00',
	`LocalTax` decimal(18,3) NOT NULL DEFAULT '0.00',
	`VariationsMatrixID` bigint(20) unsigned NOT NULL DEFAULT '0',
	`MatrixDescription` varchar(150) DEFAULT NULL,
	`ProductGroup` varchar(20) DEFAULT NULL,
	`ProductSubGroup` varchar(50) DEFAULT NULL,
	`TransactionItemStatus` int(1) NOT NULL DEFAULT '0',
	`DiscountCode` varchar(5) DEFAULT NULL,
	`DiscountRemarks` varchar(255) DEFAULT NULL,
	`ProductPackageID` bigint(20) unsigned NOT NULL DEFAULT '0',
	`MatrixPackageID` bigint(20) unsigned NOT NULL DEFAULT '0',
	`PackageQuantity` decimal(18,3) NOT NULL DEFAULT '0.00',
	`PromoQuantity` decimal(18,3) NOT NULL DEFAULT '0.00',
	`PromoValue` decimal(18,3) NOT NULL DEFAULT '0.00',
	`PromoInPercent` tinyint(1) NOT NULL DEFAULT '0',
	`PromoType` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
	`PromoApplied` decimal(18,3) NOT NULL DEFAULT '0.00',
	`PurchasePrice` decimal(18,3) NOT NULL DEFAULT '0.00',
	`PurchaseAmount` decimal(18,3) NOT NULL DEFAULT '0.00',
	`IncludeInSubtotalDiscount` tinyint(1) NOT NULL DEFAULT '1',
	`OrderSlipPrinter` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
	`orderslipprinted` tinyint(1) NOT NULL DEFAULT '0',
	`PercentageCommision` decimal(18,3) NOT NULL DEFAULT '0.00',
	`Commision` decimal(18,3) NOT NULL DEFAULT '0.00',
	`PaxNo` int(4) NOT NULL DEFAULT '1',
	`BackupDate` datetime,
	PRIMARY KEY (`TransactionItemsID`),
	KEY `IX_tblTransactionItemsBackup` (`TransactionItemsID`),
	KEY `IX0_tblTransactionItemsBackup` (`TransactionID`,`ProductID`),
	KEY `IX1_tblTransactionItemsBackup` (`TransactionID`,`ProductID`,`VariationsMatrixID`),
	KEY `IX2_tblTransactionItemsBackup` (`ProductCode`),
	KEY `IX3_tblTransactionItemsBackup` (`TransactionID`),
	KEY `IX4_tblTransactionItemsBackup` (`ProductUnitID`)
);

/*********************************  v_4.0.0.5.sql END  *******************************************************/ 

/*********************************  v_4.0.1.0.sql START  
	09-Aug-2013 LEAceron
	Purpose: To serve the Customer Management System required by GLA Mandarin

	Requirements:
		Roster Information of members w/ complete information.
*******************************************************/ 

UPDATE tblTerminal SET DBVersion = '4.0.1.0';

ALTER TABLE sysConfig ADD Category VARCHAR(100);

ALTER TABLE tblContactGroup MODIFY ContactGroupCode VARCHAR(10);


/*****************************
**	tblProductInventoryAudit
**	This will contain all changes in the tblProductInventory
*****************************/
DROP TABLE IF EXISTS tblProductInventoryAudit;
CREATE TABLE tblProductInventoryAudit (
	`BranchID` INT(4) UNSIGNED NOT NULL,
	`ProductID` BIGINT NOT NULL DEFAULT 0,
	`MatrixID` BIGINT NOT NULL DEFAULT 0,
	`Quantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`QuantityIn` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`QuantityOut` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ActualQuantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`IsLock` TINYINT(1) NOT NULL DEFAULT 0,
	`DateCreated` DATETIME NOT NULL DEFAULT '1900-01-01',
	INDEX `IX_tblProductInventory`(`BranchID`, `ProductID`, `MatrixID`)
);

/*****************************
**	tblProductInventoryDaily
**	This will contain all the end-of-day quantity in tblProductInventory
*****************************/
DROP TABLE IF EXISTS tblProductInventoryDaily;
CREATE TABLE tblProductInventoryDaily (
	`BranchID` INT(4) UNSIGNED NOT NULL,
	`ProductID` BIGINT NOT NULL DEFAULT 0,
	`MatrixID` BIGINT NOT NULL DEFAULT 0,
	`Quantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`QuantityIn` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`QuantityOut` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ActualQuantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`IsLock` TINYINT(1) NOT NULL DEFAULT 0,
	`DateCreated` DATETIME NOT NULL DEFAULT '1900-01-01',
	INDEX `IX_tblProductInventory`(`BranchID`, `ProductID`, `MatrixID`)
);


/*****************************
**	tblProductInventoryMonthly
**	This will contain all the end-of-month quantity in tblProductInventory
*****************************/
DROP TABLE IF EXISTS tblProductInventoryMonthly;
CREATE TABLE tblProductInventoryMonthly (
	`BranchID` INT(4) UNSIGNED NOT NULL,
	`ProductID` BIGINT NOT NULL DEFAULT 0,
	`MatrixID` BIGINT NOT NULL DEFAULT 0,
	`Quantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`QuantityIn` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`QuantityOut` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`ActualQuantity` DECIMAL(18,3) NOT NULL DEFAULT 0,
	`IsLock` TINYINT(1) NOT NULL DEFAULT 0,
	`DateMonth` VARCHAR(7),
	`DateCreated` DATETIME NOT NULL DEFAULT '1900-01-01',
	INDEX `IX_tblProductInventory`(`BranchID`, `ProductID`, `MatrixID`)
);

CREATE INDEX IX_tblProductInventory_PID ON tblProductInventory (ProductID);
CREATE INDEX IX_tblProductInventory_PBID ON tblProductInventory (ProductID, BranchID);

DROP TABLE IF EXISTS tblContactsAudit;
CREATE TABLE `tblContactsAudit` (
  `ContactID` bigint(20) NOT NULL,
  `ContactCode` varchar(25) NOT NULL,
  `ContactName` varchar(75) NOT NULL,
  `ContactGroupID` int(10) unsigned DEFAULT '0',
  `ModeOfTerms` int(10) NOT NULL DEFAULT '0',
  `Terms` int(10) NOT NULL DEFAULT '0',
  `Address` varchar(150) NOT NULL DEFAULT '',
  `BusinessName` varchar(75) NOT NULL DEFAULT '',
  `TelephoneNo` varchar(75) NOT NULL DEFAULT '',
  `Remarks` varchar(150) NOT NULL DEFAULT '',
  `Debit` decimal(18,3) NOT NULL DEFAULT '0.00',
  `Credit` decimal(18,3) NOT NULL DEFAULT '0.00',
  `CreditLimit` decimal(18,3) NOT NULL DEFAULT '0.00',
  `IsCreditAllowed` tinyint(1) NOT NULL DEFAULT '0',
  `DateCreated` DATETIME NOT NULL,
  `Deleted` tinyint(1) NOT NULL DEFAULT '0',
  `DepartmentID` int(10) unsigned NOT NULL DEFAULT '1',
  `PositionID` int(10) unsigned NOT NULL DEFAULT '1',
  `isLock` tinyint(1) NOT NULL DEFAULT '0',
  `AuditDateCreated` DATETIME NOT NULL DEFAULT '1900-01-01',
  KEY `IX_tblcontactsAudit` (`ContactID`,`ContactCode`,`ContactName`),
  KEY `IX1_tblcontactsAudit` (`ContactGroupID`)
);

/*********************************  v_4.0.1.0.sql END  *******************************************************/ 

UPDATE tblTerminal SET DBVersion = '4.0.1.1';

ALTER TABLE tblTransactions ADD `isConsignment` TINYINT(1) NOT NULL DEFAULT 0;

ALTER TABLE tblProductInventory ADD ReservedQuantity DECIMAL(18,3) NOT NULL DEFAULT '0.000';
ALTER TABLE tblProductInventoryAudit ADD ReservedQuantity DECIMAL(18,3) NOT NULL DEFAULT '0.000';
ALTER TABLE tblProductInventoryDaily ADD ReservedQuantity DECIMAL(18,3) NOT NULL DEFAULT '0.000';
ALTER TABLE tblProductInventoryMonthly ADD ReservedQuantity DECIMAL(18,3) NOT NULL DEFAULT '0.000';

INSERT INTO tblVariations (VariationID, VariationCode, VariationType) VALUES (6, 'LOT', 'LOTNO');

ALTER TABLE tblProductInventoryDaily ADD PurchasePrice DECIMAL(18,3) NOT NULL DEFAULT '0.000';
ALTER TABLE tblProductInventoryMonthly ADD PurchasePrice DECIMAL(18,3) NOT NULL DEFAULT '0.000';

ALTER TABLE tblProductInventoryDaily ADD Price DECIMAL(18,3) NOT NULL DEFAULT '0.000';
ALTER TABLE tblProductInventoryMonthly ADD Price DECIMAL(18,3) NOT NULL DEFAULT '0.000';

UPDATE tblProductInventoryDaily, tblProducts, tblProductPackage
	SET
		tblProductInventoryDaily.PurchasePrice = tblProductPackage.PurchasePrice,
		tblProductInventoryDaily.Price = tblProductPackage.Price
WHERE tblProductInventoryDaily.ProductID = tblProducts.ProductID
	AND tblProductInventoryDaily.ProductID = tblProductPackage.ProductID
	AND tblProducts.BaseUnitID = tblProductPackage.UnitID
	AND tblProductInventoryDaily.MatrixID = tblProductPackage.MatrixID
	AND tblProductPackage.Quantity = 1
	AND DATE_FORMAT(tblProductInventoryDaily.DateCreated, '%Y-%m-%d') = DATE_FORMAT(NOW(), '%Y-%m-%d');
	
UPDATE tblProductInventoryMonthly, tblProducts, tblProductPackage
	SET
		tblProductInventoryMonthly.PurchasePrice = tblProductPackage.PurchasePrice,
		tblProductInventoryMonthly.Price = tblProductPackage.Price
WHERE tblProductInventoryMonthly.ProductID = tblProducts.ProductID
	AND tblProductInventoryMonthly.ProductID = tblProductPackage.ProductID
	AND tblProducts.BaseUnitID = tblProductPackage.UnitID
	AND tblProductInventoryMonthly.MatrixID = tblProductPackage.MatrixID
	AND tblProductPackage.Quantity = 1
	AND DATE_FORMAT(tblProductInventoryMonthly.DateCreated, '%Y-%m-%d') = DATE_FORMAT(NOW(), '%Y-%m-%d');

-- Oct 10, 2013


/*****************************
**	tblContactAddOn
*****************************/
DROP TABLE IF EXISTS tblContactDetails;
DROP TABLE IF EXISTS tblContactAddOn;
CREATE TABLE tblContactAddOn (
    `ContactDetailID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
	`ContactID` BIGINT(20) NOT NULL DEFAULT 0,
	`Salutation` VARCHAR(30) NOT NULL,
	`FirstName` VARCHAR(85) NOT NULL,
	`MiddleName` VARCHAR(85) NULL,
	`LastName` VARCHAR(85) NOT NULL,	
	`SpouseName` VARCHAR(85) NULL,
	
	`BirthDate` DATE NOT NULL DEFAULT '1900-01-01 12:00:00',
	`SpouseBirthDate` DATE NOT NULL DEFAULT '1900-01-01 12:00:00',
	`AnniversaryDate` DATE NOT NULL DEFAULT '1900-01-01 12:00:00',
	
	`Address1` VARCHAR (150) NULL,
	`Address2` VARCHAR (150) NULL,
	`City` VARCHAR (30) NULL,
	`State` VARCHAR (30) NULL,
	`ZipCode` VARCHAR (15) NULL,
	`CountryID` TINYINT NOT NULL DEFAULT 0,

	`BusinessphoneNo` VARCHAR(75) NOT NULL DEFAULT '',
	`HomephoneNo` VARCHAR(75) NOT NULL DEFAULT '',
	`MobileNo` VARCHAR(75) NOT NULL DEFAULT '',
	`FaxNo` VARCHAR(75) NOT NULL DEFAULT '',

	`EmailAddress` VARCHAR(85) NOT NULL,
PRIMARY KEY (ContactDetailID),
INDEX `IX_tblContactAddOn`(`ContactID`)
);

ALTER TABLE tblDiscount MODIFY DiscountType VARCHAR(60) NOT NULL;
ALTER TABLE tblContactAddon MODIFY MiddleName VARCHAR(85) NULL;

-- IMPORTANT: recreate the tblContactAddOn above......
-- see also changes in inventory.sql

-- COLLATE ILLEGAL MIX ISSUE
-- YOU NEED TO RE-RUN THE PROC TO SOLVE THIS ISSUE
ALTER DATABASE pos CHARACTER SET utf8;

SELECT default_character_set_name FROM information_schema.SCHEMATA S WHERE schema_name = 'pos';


-- additional in sysConfig this will override the .config
DELETE FROM sysConfig;

DELETE FROM sysConfig WHERE ConfigName = 'CompanyCode';
INSERT INTO sysConfig (ConfigName, Category, ConfigValue) VALUES ('CompanyCode',			'CompanyDetails',					'HP SUPERMARKET');
DELETE FROM sysConfig WHERE ConfigName = 'CompanyName';
INSERT INTO sysConfig (ConfigName, Category, ConfigValue) VALUES ('CompanyName',			'CompanyDetails',					'HP SUPERMARKET');

INSERT INTO sysConfig (ConfigName, Category, ConfigValue) VALUES ('BACKEND_VARIATION_TYPE',	'BACKEND_VARIATION_TYPE',			'EXPIRATION;LOTNO');


INSERT INTO sysConfig (ConfigName, Category, ConfigValue) VALUES ('TIN',					'CompanyDetails',					'004-180-231-005');
INSERT INTO sysConfig (ConfigName, Category, ConfigValue) VALUES ('Currency',				'CompanyDetails',					'PHP');
INSERT INTO sysConfig (ConfigName, Category, ConfigValue) VALUES ('VersionFTPIPAddress',	'CompanyDetails',					'Localhost');
INSERT INTO sysConfig (ConfigName, Category, ConfigValue) VALUES ('CheckOutBillHeaderLabel','FE',								'-/- CHECK-OUT BILL -/-');
INSERT INTO sysConfig (ConfigName, Category, ConfigValue) VALUES ('ChargeSlipHeaderLabel',  'FE',								'');

ALTER TABLE tblTerminal ADD `IncludeTermsAndConditions` TINYINT(1) NOT NULL DEFAULT 0;

/*******
UPDATE sysConfig set ConfigValue = '' where ConfigName = 'CompanyCode';
UPDATE sysConfig set ConfigValue = '' where ConfigName = 'CompanyName';
UPDATE sysConfig set ConfigValue = '' where ConfigName = 'TIN';
*******/

DELETE FROM sysConfig WHERE ConfigName = 'WillPrintCreditPaymentHeader';
INSERT INTO sysConfig (ConfigName, Category, ConfigValue) VALUES ('WillPrintCreditPaymentHeader',	'FE',						'true');
DELETE FROM sysConfig WHERE ConfigName = 'WillWriteSystemLog';
INSERT INTO sysConfig (ConfigName, Category, ConfigValue) VALUES ('WillWriteSystemLog',				'FE',						'true');


-- 18Nov2013 settings to show if will print the values with TF
--			 set to true
DELETE FROM sysConfig WHERE ConfigName = 'WillDeductTFInXRead';
INSERT INTO sysConfig (ConfigName, Category, ConfigValue) VALUES ('WillDeductTFInXRead',			'FE',						'true');
DELETE FROM sysConfig WHERE ConfigName = 'WillDeductTFInZRead';
INSERT INTO sysConfig (ConfigName, Category, ConfigValue) VALUES ('WillDeductTFInZRead',			'FE',						'true');
DELETE FROM sysConfig WHERE ConfigName = 'WillDeductTFInTerminalReport';
INSERT INTO sysConfig (ConfigName, Category, ConfigValue) VALUES ('WillDeductTFInTerminalReport',	'FE',						'true');

-- 20Nov2013 settings to show if will print the values with TF
--			hold the actual values.
--			
ALTER TABLE tblTerminalReport ADD `ActualOldGrandTotal` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReport ADD `ActualNewGrandTotal` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReportHistory ADD `ActualOldGrandTotal` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReportHistory ADD `ActualNewGrandTotal` DECIMAL(18,3) NOT NULL DEFAULT 0;

UPDATE tblTerminalReport SET ActualOldGrandTotal = OldGrandTotal WHERE ActualOldGrandTotal = 0;
UPDATE tblTerminalReport SET ActualNewGrandTotal = NewGrandTotal WHERE ActualNewGrandTotal = 0;
UPDATE tblTerminalReportHistory SET ActualOldGrandTotal = OldGrandTotal WHERE ActualOldGrandTotal = 0;
UPDATE tblTerminalReportHistory SET ActualNewGrandTotal = NewGrandTotal WHERE ActualNewGrandTotal = 0;


-- Added to get the discount given
ALTER TABLE tblTransactionItems ADD `TransactionDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'This is an applied discount computed evenly from transaction discount';
ALTER TABLE tblSalesPerItem ADD `Discount` DECIMAL(18,3) NOT NULL DEFAULT 0;

ALTER TABLE sysConfig MODIFY ConfigName VARCHAR(100);

DELETE FROM sysConfig WHERE ConfigName = 'WillAskDoNotPrintTransactionDate';
INSERT INTO sysConfig (ConfigName, Category, ConfigValue) VALUES ('WillAskDoNotPrintTransactionDate',			'FE',						'false');

DELETE FROM sysConfig WHERE ConfigName = 'WillShowProductTotalQuantityInItemSelect';
INSERT INTO sysConfig (ConfigName, Category, ConfigValue) VALUES ('WillShowProductTotalQuantityInItemSelect',	'FE',						'false');

DELETE FROM sysConfig WHERE ConfigName = 'WillNotPrintReprintMessage';
INSERT INTO sysConfig (ConfigName, Category, ConfigValue) VALUES ('WillNotPrintReprintMessage',					'FE',						'false');

DELETE FROM sysConfig WHERE ConfigName = 'ORHeader';
INSERT INTO sysConfig (ConfigName, Category, ConfigValue) VALUES ('ORHeader',									'FE',						'WARRANTY RECEIPT');

ALTER TABLE tblTerminal ADD PWDDiscountCode VARCHAR(100) DEFAULT 'PWD Discount';

INSERT INTO tblPositions VALUES(1, 'System Default Position', 'System Default Position');


/*****************************
**	tblSalutations
*****************************/
DROP TABLE IF EXISTS tblSalutations;
CREATE TABLE tblSalutations (
	`SalutationID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`SalutationCode` VARCHAR(30) NOT NULL,
	`SalutationName` VARCHAR(30) NOT NULL,
PRIMARY KEY (`SalutationID`),
INDEX `IX_tblSalutations`(`SalutationID`, `SalutationCode`, `SalutationName`),
UNIQUE `PK_tblSalutations`(`SalutationCode`),
INDEX `IX1_tblSalutations`(`SalutationID`),
INDEX `IX2_tblSalutations`(`SalutationCode`),
INDEX `IX3_tblSalutations`(`SalutationName`)
);

DELETE FROM sysConfig WHERE Category = 'Salutation';

ALTER TABLE tblContactRewards ADD `SoldByID` BIGINT NOT NULL DEFAULT 3;
ALTER TABLE tblContactRewards ADD `SoldByName` VARCHAR(150);
ALTER TABLE tblContactRewards ADD `ConfirmedByID` BIGINT NOT NULL DEFAULT 1;
ALTER TABLE tblContactRewards ADD `ConfirmedByName` VARCHAR(150);


-- 06Feb2014 Added for RLC accreditation
ALTER TABLE tblTerminalReport ADD `NoOfReprintedTransaction` INT(10) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReport ADD `TotalReprintedTransaction` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReportHistory ADD `NoOfReprintedTransaction` INT(10) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReportHistory ADD `TotalReprintedTransaction` DECIMAL(18,3) NOT NULL DEFAULT 0;



-- 19Feb2014 Added for HP
DELETE FROM sysAccessRights WHERE TranTypeID = 148; 
DELETE FROM sysAccessGroupRights WHERE TranTypeID = 148;
DELETE FROM sysAccessTypes WHERE TypeID = 148;
INSERT INTO sysAccessTypes (TypeID, TypeName) VALUES (148, 'Summarized Daily Sales');
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 148, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 148, 1, 1);
UPDATE sysAccessTypes SET SequenceNo = 6, Category = '11: Backend - Sales Reports' WHERE TypeID = 148;

DELETE FROM sysAccessRights WHERE TranTypeID = 149; DELETE FROM sysAccessGroupRights WHERE TranTypeID = 149;
DELETE FROM sysAccessTypes WHERE TypeID = 149;
INSERT INTO sysAccessTypes (TypeID, TypeName) VALUES (149, 'Summarized Daily Sales With TF');
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 149, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 149, 1, 1);
UPDATE sysAccessTypes SET SequenceNo = 7, Category = '11: Backend - eSales Reports' WHERE TypeID = 149;

DELETE FROM sysAccessRights WHERE TranTypeID = 150; DELETE FROM sysAccessGroupRights WHERE TranTypeID = 150;
DELETE FROM sysAccessTypes WHERE TypeID = 150;
INSERT INTO sysAccessTypes (TypeID, TypeName) VALUES (150, 'PaidOut Disburse ROC');
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 150, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 150, 1, 1);
UPDATE sysAccessTypes SET SequenceNo = 8, Category = '11: Backend - Sales Reports' WHERE TypeID = 150;

DELETE FROM sysAccessRights WHERE TranTypeID = 151; DELETE FROM sysAccessGroupRights WHERE TranTypeID = 151;
DELETE FROM sysAccessTypes WHERE TypeID = 151;
INSERT INTO sysAccessTypes (TypeID, TypeName) VALUES (151, 'Management Reports Menu');
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 151, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 151, 1, 1);
UPDATE sysAccessTypes SET SequenceNo = 1, Category = '11: Backend - Management Reports' WHERE TypeID = 151;

DELETE FROM sysAccessRights WHERE TranTypeID = 152; DELETE FROM sysAccessGroupRights WHERE TranTypeID = 152;
DELETE FROM sysAccessTypes WHERE TypeID = 152;
INSERT INTO sysAccessTypes (TypeID, TypeName) VALUES (152, 'Analytics Reports Menu');
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 152, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 152, 1, 1);
UPDATE sysAccessTypes SET SequenceNo = 1, Category = '11: Backend - Analytics Reports' WHERE TypeID = 152;


ALTER TABLE tblTerminal MODIFY SeniorCitizenDiscountCode VARCHAR(50);
ALTER TABLE tblChargeType MODIFY ChargeTypeCode VARCHAR(60);

ALTER TABLE tblTransactions ADD DataSource VARCHAR(30) NULL;
ALTER TABLE tblTransactions MODIFY DiscountCode VARCHAR(60);
ALTER TABLE tblTransactions MODIFY ChargeCode VARCHAR(60);
ALTER TABLE tblTransactionItems ADD DataSource VARCHAR(30) NULL;
ALTER TABLE tblTransactions ADD CustomerGroupName VARCHAR(60) NULL;

UPDATE tblTransactions trx
INNER JOIN tblContacts cntct ON trx.CustomerID = cntct.ContactID
INNER JOIN tblContactGroup grp ON cntct.ContactGroupID = grp.ContactGroupID
SET
	CustomerGroupName = grp.ContactGroupName
WHERE IFNULL(trx.CustomerGroupName,'') = '';

ALTER TABLE tblSalesPerItem ADD ProductID BIGINT NOT NULL DEFAULT 0;
ALTER TABLE tblSalesPerItem ADD PurchasePrice DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblSalesPerItem ADD InvQuantity DECIMAL(18,3) NOT NULL DEFAULT 0;

-- Apr 12, 2014 for the breakdown of credits

ALTER TABLE tblTerminalReport ADD `CreditPaymentCash` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReport ADD `CreditPaymentCheque` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReport ADD `CreditPaymentCreditCard` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReport ADD `CreditPaymentDebit` DECIMAL(18,3) NOT NULL DEFAULT 0;

ALTER TABLE tblTerminalReportHistory ADD `CreditPaymentCash` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReportHistory ADD `CreditPaymentCheque` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReportHistory ADD `CreditPaymentCreditCard` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReportHistory ADD `CreditPaymentDebit` DECIMAL(18,3) NOT NULL DEFAULT 0;

ALTER TABLE tblCashierReport ADD `CreditPaymentCash` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReport ADD `CreditPaymentCheque` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReport ADD `CreditPaymentCreditCard` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReport ADD `CreditPaymentDebit` DECIMAL(18,3) NOT NULL DEFAULT 0;

ALTER TABLE tblCashierReportHistory ADD `CreditPaymentCash` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReportHistory ADD `CreditPaymentCheque` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReportHistory ADD `CreditPaymentCreditCard` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReportHistory ADD `CreditPaymentDebit` DECIMAL(18,3) NOT NULL DEFAULT 0;

ALTER TABLE tblPLUReport ADD `ProductGroup` VARCHAR(50);

-- Aug 1, 2014 For StandAlone Terminal (Sync)

ALTER TABLE sysAccessGroupRights DROP CreatedOn;
ALTER TABLE sysAccessGroups DROP CreatedOn;
ALTER TABLE sysAccessRights DROP CreatedOn;
ALTER TABLE sysAccessTypes DROP CreatedOn;
ALTER TABLE sysAccessUserDetails DROP CreatedOn;
ALTER TABLE sysAccessUsers DROP CreatedOn;
ALTER TABLE sysAuditTrail DROP CreatedOn;
ALTER TABLE sysConfig DROP CreatedOn;
ALTER TABLE sysTerminalKey DROP CreatedOn;
ALTER TABLE tblAgentsCommision DROP CreatedOn;
ALTER TABLE tblBranch DROP CreatedOn;
ALTER TABLE tblBranchTransfer DROP CreatedOn;
ALTER TABLE tblBranchTransferItems DROP CreatedOn;
ALTER TABLE tblCalDate DROP CreatedOn;
ALTER TABLE tblCardTypes DROP CreatedOn;
ALTER TABLE tblCashCount DROP CreatedOn;
ALTER TABLE tblCashierLogs DROP CreatedOn;
ALTER TABLE tblCashierReport DROP CreatedOn;
ALTER TABLE tblCashierReportHistory DROP CreatedOn;
ALTER TABLE tblCashPayment DROP CreatedOn;
ALTER TABLE tblChargeType DROP CreatedOn;
ALTER TABLE tblChequePayment DROP CreatedOn;
ALTER TABLE tblContactAddon DROP CreatedOn;
ALTER TABLE tblContactCreditCardinfo DROP CreatedOn;
ALTER TABLE tblContactGroup DROP CreatedOn;
ALTER TABLE tblContactRewards DROP CreatedOn;
ALTER TABLE tblContactRewardsMovement DROP CreatedOn;
ALTER TABLE tblContacts DROP CreatedOn;
ALTER TABLE tblContactsAudit DROP CreatedOn;
ALTER TABLE tblCountingRef DROP CreatedOn;
ALTER TABLE tblCountry DROP CreatedOn;
ALTER TABLE tblCreditCardPayment DROP CreatedOn;
ALTER TABLE tblCreditPayment DROP CreatedOn;
ALTER TABLE tblDebitPayment DROP CreatedOn;
ALTER TABLE tblDenomination DROP CreatedOn;
ALTER TABLE tblDepartments DROP CreatedOn;
ALTER TABLE tblDeposit DROP CreatedOn;
ALTER TABLE tblDisburse DROP CreatedOn;
ALTER TABLE tblDiscount DROP CreatedOn;
ALTER TABLE tblDiscountHistory DROP CreatedOn;
ALTER TABLE tblInvAdjustment DROP CreatedOn;
ALTER TABLE tblInvAdjustmentItems DROP CreatedOn;
ALTER TABLE tblInventory DROP CreatedOn;
ALTER TABLE tblMatrixPackagePriceHistory DROP CreatedOn;
ALTER TABLE tblPaidOut DROP CreatedOn;
ALTER TABLE tblParkingRates DROP CreatedOn;
ALTER TABLE tblPLUReport DROP CreatedOn;
ALTER TABLE tblPositions DROP CreatedOn;
ALTER TABLE tblProductBaseVariationsMatrix DROP CreatedOn;
ALTER TABLE tblProductComposition DROP CreatedOn;
ALTER TABLE tblProductGroup DROP CreatedOn;
ALTER TABLE tblProductGroupBaseVariationsMatrix DROP CreatedOn;
ALTER TABLE tblProductGroupCharges DROP CreatedOn;
ALTER TABLE tblProductGroupUnitMatrix DROP CreatedOn;
ALTER TABLE tblProductGroupVariations DROP CreatedOn;
ALTER TABLE tblProductGroupVariationsMatrix DROP CreatedOn;
ALTER TABLE tblProductHistory DROP CreatedOn;
ALTER TABLE tblProductInventory DROP CreatedOn;
ALTER TABLE tblProductInventoryAudit DROP CreatedOn;
ALTER TABLE tblProductInventoryDaily DROP CreatedOn;
ALTER TABLE tblProductInventoryMonthly DROP CreatedOn;
ALTER TABLE tblProductMovement DROP CreatedOn;
ALTER TABLE tblProductPackage DROP CreatedOn;
ALTER TABLE tblProductPackagepriceHistory DROP CreatedOn;
ALTER TABLE tblProductprices DROP CreatedOn;
ALTER TABLE tblProductPurchasepriceHistory DROP CreatedOn;
ALTER TABLE tblProducts DROP CreatedOn;
ALTER TABLE tblProductSubGroup DROP CreatedOn;
ALTER TABLE tblProductSubGroupbaseVariationsMatrix DROP CreatedOn;
ALTER TABLE tblProductSubGroupCharges DROP CreatedOn;
ALTER TABLE tblProductSubGroupUnitMatrix DROP CreatedOn;
ALTER TABLE tblProductSubGroupVariations DROP CreatedOn;
ALTER TABLE tblProductSubGroupVariationsMatrix DROP CreatedOn;
ALTER TABLE tblProductUnitMatrix DROP CreatedOn;
ALTER TABLE tblProductVariations DROP CreatedOn;
ALTER TABLE tblProductVariationsMatrix DROP CreatedOn;
ALTER TABLE tblPromo DROP CreatedOn;
ALTER TABLE tblPromoItems DROP CreatedOn;
ALTER TABLE tblPromotype DROP CreatedOn;
ALTER TABLE tblReceipt DROP CreatedOn;
ALTER TABLE tblReceiptFormat DROP CreatedOn;
ALTER TABLE tblremotebranchInventory DROP CreatedOn;
ALTER TABLE tblrewardItems DROP CreatedOn;
ALTER TABLE tblSalesPerItem DROP CreatedOn;
ALTER TABLE tblSalutations DROP CreatedOn;
ALTER TABLE tblStock DROP CreatedOn;
ALTER TABLE tblStockItems DROP CreatedOn;
ALTER TABLE tblStocktype DROP CreatedOn;
ALTER TABLE tblTerminal DROP CreatedOn;
ALTER TABLE tblTerminalReport DROP CreatedOn;
ALTER TABLE tblTerminalReportHistory DROP CreatedOn;
ALTER TABLE tblTransactionItems DROP CreatedOn;
ALTER TABLE tblTransactionItemsBackup DROP CreatedOn;
ALTER TABLE tblTransactionNos DROP CreatedOn;
ALTER TABLE tblTransactions DROP CreatedOn;
ALTER TABLE tblTransactionsBackup DROP CreatedOn;
ALTER TABLE tblUnit DROP CreatedOn;
ALTER TABLE tblVariations DROP CreatedOn;
ALTER TABLE tblWithhold DROP CreatedOn;

ALTER TABLE sysAccessGroupRights ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE sysAccessGroups ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE sysAccessRights ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE sysAccessTypes ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE sysAccessUserDetails ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE sysAccessUsers ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE sysAuditTrail ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE sysConfig ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE sysTerminalKey ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblAgentsCommision ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblBranch ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblBranchTransfer ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblBranchTransferItems ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblCalDate ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblCardTypes ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblCashCount ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblCashierLogs ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblCashierReport ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblCashierReportHistory ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblCashPayment ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblChargeType ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblChequePayment ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblContactAddon ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblContactCreditCardinfo ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblContactGroup ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblContactRewards ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblContactRewardsMovement ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblContacts ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblContactsAudit ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblCountingRef ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblCountry ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblCreditCardPayment ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblCreditPayment ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblDebitPayment ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblDenomination ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblDepartments ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblDeposit ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblDisburse ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblDiscount ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblDiscountHistory ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblInvAdjustment ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblInvAdjustmentItems ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblInventory ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblMatrixPackagePriceHistory ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblPaidOut ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblParkingRates ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblPLUReport ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblPositions ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblProductBaseVariationsMatrix ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblProductComposition ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblProductGroup ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblProductGroupBaseVariationsMatrix ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblProductGroupCharges ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblProductGroupUnitMatrix ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblProductGroupVariations ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblProductGroupVariationsMatrix ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblProductHistory ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblProductInventory ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblProductInventoryAudit ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblProductInventoryDaily ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblProductInventoryMonthly ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblProductMovement ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblProductPackage ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblProductPackagepriceHistory ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblProductprices ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblProductPurchasepriceHistory ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblProducts ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblProductSubGroup ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblProductSubGroupbaseVariationsMatrix ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblProductSubGroupCharges ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblProductSubGroupUnitMatrix ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblProductSubGroupVariations ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblProductSubGroupVariationsMatrix ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblProductUnitMatrix ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblProductVariations ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblProductVariationsMatrix ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblPromo ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblPromoItems ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblPromotype ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblReceipt ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblReceiptFormat ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblremotebranchInventory ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblrewardItems ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblSalesPerItem ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblSalutations ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblStock ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblStockItems ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblStocktype ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblTerminal ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblTerminalReport ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblTerminalReportHistory ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblTransactionItems ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblTransactionItemsBackup ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblTransactionNos ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblTransactions ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblTransactionsBackup ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblUnit ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblVariations ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';
ALTER TABLE tblWithhold ADD `CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00';

ALTER TABLE sysAccessGroupRights DROP LastModified;
ALTER TABLE sysAccessGroups DROP LastModified;
ALTER TABLE sysAccessRights DROP LastModified;
ALTER TABLE sysAccessTypes DROP LastModified;
ALTER TABLE sysAccessUserDetails DROP LastModified;
ALTER TABLE sysAccessUsers DROP LastModified;
ALTER TABLE sysAuditTrail DROP LastModified;
ALTER TABLE sysConfig DROP LastModified;
ALTER TABLE sysTerminalKey DROP LastModified;
ALTER TABLE tblAgentsCommision DROP LastModified;
ALTER TABLE tblBranch DROP LastModified;
ALTER TABLE tblBranchTransfer DROP LastModified;
ALTER TABLE tblBranchTransferItems DROP LastModified;
ALTER TABLE tblCalDate DROP LastModified;
ALTER TABLE tblCardTypes DROP LastModified;
ALTER TABLE tblCashCount DROP LastModified;
ALTER TABLE tblCashierLogs DROP LastModified;
ALTER TABLE tblCashierReport DROP LastModified;
ALTER TABLE tblCashierReportHistory DROP LastModified;
ALTER TABLE tblCashPayment DROP LastModified;
ALTER TABLE tblChargeType DROP LastModified;
ALTER TABLE tblChequePayment DROP LastModified;
ALTER TABLE tblContactAddon DROP LastModified;
ALTER TABLE tblContactCreditCardinfo DROP LastModified;
ALTER TABLE tblContactGroup DROP LastModified;
ALTER TABLE tblContactRewards DROP LastModified;
ALTER TABLE tblContactRewardsMovement DROP LastModified;
ALTER TABLE tblContacts DROP LastModified;
ALTER TABLE tblContactsAudit DROP LastModified;
ALTER TABLE tblCountingRef DROP LastModified;
ALTER TABLE tblCountry DROP LastModified;
ALTER TABLE tblCreditCardPayment DROP LastModified;
ALTER TABLE tblCreditPayment DROP LastModified;
ALTER TABLE tblDebitPayment DROP LastModified;
ALTER TABLE tblDenomination DROP LastModified;
ALTER TABLE tblDepartments DROP LastModified;
ALTER TABLE tblDeposit DROP LastModified;
ALTER TABLE tblDisburse DROP LastModified;
ALTER TABLE tblDiscount DROP LastModified;
ALTER TABLE tblDiscountHistory DROP LastModified;
ALTER TABLE tblInvAdjustment DROP LastModified;
ALTER TABLE tblInvAdjustmentItems DROP LastModified;
ALTER TABLE tblInventory DROP LastModified;
ALTER TABLE tblMatrixPackagePriceHistory DROP LastModified;
ALTER TABLE tblPaidOut DROP LastModified;
ALTER TABLE tblParkingRates DROP LastModified;
ALTER TABLE tblPLUReport DROP LastModified;
ALTER TABLE tblPositions DROP LastModified;
ALTER TABLE tblProductBaseVariationsMatrix DROP LastModified;
ALTER TABLE tblProductComposition DROP LastModified;
ALTER TABLE tblProductGroup DROP LastModified;
ALTER TABLE tblProductGroupBaseVariationsMatrix DROP LastModified;
ALTER TABLE tblProductGroupCharges DROP LastModified;
ALTER TABLE tblProductGroupUnitMatrix DROP LastModified;
ALTER TABLE tblProductGroupVariations DROP LastModified;
ALTER TABLE tblProductGroupVariationsMatrix DROP LastModified;
ALTER TABLE tblProductHistory DROP LastModified;
ALTER TABLE tblProductInventory DROP LastModified;
ALTER TABLE tblProductInventoryAudit DROP LastModified;
ALTER TABLE tblProductInventoryDaily DROP LastModified;
ALTER TABLE tblProductInventoryMonthly DROP LastModified;
ALTER TABLE tblProductMovement DROP LastModified;
ALTER TABLE tblProductPackage DROP LastModified;
ALTER TABLE tblProductPackagepriceHistory DROP LastModified;
ALTER TABLE tblProductprices DROP LastModified;
ALTER TABLE tblProductPurchasepriceHistory DROP LastModified;
ALTER TABLE tblProducts DROP LastModified;
ALTER TABLE tblProductSubGroup DROP LastModified;
ALTER TABLE tblProductSubGroupbaseVariationsMatrix DROP LastModified;
ALTER TABLE tblProductSubGroupCharges DROP LastModified;
ALTER TABLE tblProductSubGroupUnitMatrix DROP LastModified;
ALTER TABLE tblProductSubGroupVariations DROP LastModified;
ALTER TABLE tblProductSubGroupVariationsMatrix DROP LastModified;
ALTER TABLE tblProductUnitMatrix DROP LastModified;
ALTER TABLE tblProductVariations DROP LastModified;
ALTER TABLE tblProductVariationsMatrix DROP LastModified;
ALTER TABLE tblPromo DROP LastModified;
ALTER TABLE tblPromoItems DROP LastModified;
ALTER TABLE tblPromotype DROP LastModified;
ALTER TABLE tblReceipt DROP LastModified;
ALTER TABLE tblReceiptFormat DROP LastModified;
ALTER TABLE tblremotebranchInventory DROP LastModified;
ALTER TABLE tblrewardItems DROP LastModified;
ALTER TABLE tblSalesPerItem DROP LastModified;
ALTER TABLE tblSalutations DROP LastModified;
ALTER TABLE tblStock DROP LastModified;
ALTER TABLE tblStockItems DROP LastModified;
ALTER TABLE tblStocktype DROP LastModified;
ALTER TABLE tblTerminal DROP LastModified;
ALTER TABLE tblTerminalReport DROP LastModified;
ALTER TABLE tblTerminalReportHistory DROP LastModified;
ALTER TABLE tblTransactionItems DROP LastModified;
ALTER TABLE tblTransactionItemsBackup DROP LastModified;
ALTER TABLE tblTransactionNos DROP LastModified;
ALTER TABLE tblTransactions DROP LastModified;
ALTER TABLE tblTransactionsBackup DROP LastModified;
ALTER TABLE tblUnit DROP LastModified;
ALTER TABLE tblVariations DROP LastModified;
ALTER TABLE tblWithhold DROP LastModified;

ALTER TABLE sysAccessGroupRights ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE sysAccessGroups ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE sysAccessRights ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE sysAccessTypes ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE sysAccessUserDetails ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE sysAccessUsers ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE sysAuditTrail ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE sysConfig ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE sysTerminalKey ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblAgentsCommision ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblBranch ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblBranchTransfer ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblBranchTransferItems ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblCalDate ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblCardTypes ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblCashCount ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblCashierLogs ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblCashierReport ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblCashierReportHistory ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblCashPayment ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblChargeType ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblChequePayment ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblContactAddon ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblContactCreditCardinfo ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblContactGroup ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblContactRewards ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblContactRewardsMovement ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblContacts ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblContactsAudit ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblCountingRef ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblCountry ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblCreditCardPayment ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblCreditPayment ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblDebitPayment ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblDenomination ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblDepartments ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblDeposit ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblDisburse ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblDiscount ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblDiscountHistory ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblInvAdjustment ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblInvAdjustmentItems ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblInventory ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblMatrixPackagePriceHistory ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblPaidOut ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblParkingRates ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblPLUReport ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblPositions ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblProductBaseVariationsMatrix ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblProductComposition ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblProductGroup ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblProductGroupBaseVariationsMatrix ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblProductGroupCharges ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblProductGroupUnitMatrix ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblProductGroupVariations ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblProductGroupVariationsMatrix ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblProductHistory ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblProductInventory ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblProductInventoryAudit ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblProductInventoryDaily ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblProductInventoryMonthly ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblProductMovement ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblProductPackage ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblProductPackagepriceHistory ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblProductprices ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblProductPurchasepriceHistory ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblProducts ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblProductSubGroup ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblProductSubGroupbaseVariationsMatrix ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblProductSubGroupCharges ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblProductSubGroupUnitMatrix ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblProductSubGroupVariations ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblProductSubGroupVariationsMatrix ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblProductUnitMatrix ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblProductVariations ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblProductVariationsMatrix ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblPromo ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblPromoItems ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblPromotype ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblReceipt ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblReceiptFormat ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblremotebranchInventory ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblrewardItems ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblSalesPerItem ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblSalutations ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblStock ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblStockItems ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblStocktype ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblTerminal ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblTerminalReport ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblTerminalReportHistory ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblTransactionItems ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblTransactionItemsBackup ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblTransactionNos ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblTransactions ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblTransactionsBackup ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblUnit ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblVariations ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE tblWithhold ADD `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;


DROP TRIGGER IF EXISTS trgsysAccessGroupRightsCreatedOn;
DROP TRIGGER IF EXISTS trgsysAccessGroupsCreatedOn;
DROP TRIGGER IF EXISTS trgsysAccessRightsCreatedOn;
DROP TRIGGER IF EXISTS trgsysAccessTypesCreatedOn;
DROP TRIGGER IF EXISTS trgsysAccessUserDetailsCreatedOn;
DROP TRIGGER IF EXISTS trgsysAccessUsersCreatedOn;
DROP TRIGGER IF EXISTS trgsysAuditTrailCreatedOn;
DROP TRIGGER IF EXISTS trgsysConfigCreatedOn;
DROP TRIGGER IF EXISTS trgsysTerminalKeyCreatedOn;
DROP TRIGGER IF EXISTS trgtblAgentsCommisionCreatedOn;
DROP TRIGGER IF EXISTS trgtblBranchCreatedOn;
DROP TRIGGER IF EXISTS trgtblBranchTransferCreatedOn;
DROP TRIGGER IF EXISTS trgtblBranchTransferItemsCreatedOn;
DROP TRIGGER IF EXISTS trgtblCalDateCreatedOn;
DROP TRIGGER IF EXISTS trgtblCardTypesCreatedOn;
DROP TRIGGER IF EXISTS trgtblCashCountCreatedOn;
DROP TRIGGER IF EXISTS trgtblCashierLogsCreatedOn;
DROP TRIGGER IF EXISTS trgtblCashierReportCreatedOn;
DROP TRIGGER IF EXISTS trgtblCashierReportHistoryCreatedOn;
DROP TRIGGER IF EXISTS trgtblCashPaymentCreatedOn;
DROP TRIGGER IF EXISTS trgtblChargeTypeCreatedOn;
DROP TRIGGER IF EXISTS trgtblChequePaymentCreatedOn;
DROP TRIGGER IF EXISTS trgtblContactAddonCreatedOn;
DROP TRIGGER IF EXISTS trgtblContactCreditCardinfoCreatedOn;
DROP TRIGGER IF EXISTS trgtblContactGroupCreatedOn;
DROP TRIGGER IF EXISTS trgtblContactRewardsCreatedOn;
DROP TRIGGER IF EXISTS trgtblContactRewardsMovementCreatedOn;
DROP TRIGGER IF EXISTS trgtblContactsCreatedOn;
DROP TRIGGER IF EXISTS trgtblContactsAuditCreatedOn;
DROP TRIGGER IF EXISTS trgtblCountingRefCreatedOn;
DROP TRIGGER IF EXISTS trgtblCountryCreatedOn;
DROP TRIGGER IF EXISTS trgtblCreditCardPaymentCreatedOn;
DROP TRIGGER IF EXISTS trgtblCreditPaymentCreatedOn;
DROP TRIGGER IF EXISTS trgtblDebitPaymentCreatedOn;
DROP TRIGGER IF EXISTS trgtblDenominationCreatedOn;
DROP TRIGGER IF EXISTS trgtblDepartmentsCreatedOn;
DROP TRIGGER IF EXISTS trgtblDepositCreatedOn;
DROP TRIGGER IF EXISTS trgtblDisburseCreatedOn;
DROP TRIGGER IF EXISTS trgtblDiscountCreatedOn;
DROP TRIGGER IF EXISTS trgtblDiscountHistoryCreatedOn;
DROP TRIGGER IF EXISTS trgtblInvAdjustmentCreatedOn;
DROP TRIGGER IF EXISTS trgtblInvAdjustmentItemsCreatedOn;
DROP TRIGGER IF EXISTS trgtblInventoryCreatedOn;
DROP TRIGGER IF EXISTS trgtblMatrixPackagePriceHistoryCreatedOn;
DROP TRIGGER IF EXISTS trgtblPaidOutCreatedOn;
DROP TRIGGER IF EXISTS trgtblParkingRatesCreatedOn;
DROP TRIGGER IF EXISTS trgtblPLUReportCreatedOn;
DROP TRIGGER IF EXISTS trgtblPositionsCreatedOn;
DROP TRIGGER IF EXISTS trgtblProductBaseVariationsMatrixCreatedOn;
DROP TRIGGER IF EXISTS trgtblProductCompositionCreatedOn;
DROP TRIGGER IF EXISTS trgtblProductGroupCreatedOn;
DROP TRIGGER IF EXISTS trgtblProductGroupBaseVariationsMatrixCreatedOn;
DROP TRIGGER IF EXISTS trgtblProductGroupChargesCreatedOn;
DROP TRIGGER IF EXISTS trgtblProductGroupUnitMatrixCreatedOn;
DROP TRIGGER IF EXISTS trgtblProductGroupVariationsCreatedOn;
DROP TRIGGER IF EXISTS trgtblProductGroupVariationsMatrixCreatedOn;
DROP TRIGGER IF EXISTS trgtblProductHistoryCreatedOn;
DROP TRIGGER IF EXISTS trgtblProductInventoryCreatedOn;
DROP TRIGGER IF EXISTS trgtblProductInventoryAuditCreatedOn;
DROP TRIGGER IF EXISTS trgtblProductInventoryDailyCreatedOn;
DROP TRIGGER IF EXISTS trgtblProductInventoryMonthlyCreatedOn;
DROP TRIGGER IF EXISTS trgtblProductMovementCreatedOn;
DROP TRIGGER IF EXISTS trgtblProductPackageCreatedOn;
DROP TRIGGER IF EXISTS trgtblProductPackagepriceHistoryCreatedOn;
DROP TRIGGER IF EXISTS trgtblProductpricesCreatedOn;
DROP TRIGGER IF EXISTS trgtblProductPurchasepriceHistoryCreatedOn;
DROP TRIGGER IF EXISTS trgtblProductsCreatedOn;
DROP TRIGGER IF EXISTS trgtblProductSubGroupCreatedOn;
DROP TRIGGER IF EXISTS trgtblProductSubGroupbaseVariationsMatrixCreatedOn;
DROP TRIGGER IF EXISTS trgtblProductSubGroupChargesCreatedOn;
DROP TRIGGER IF EXISTS trgtblProductSubGroupUnitMatrixCreatedOn;
DROP TRIGGER IF EXISTS trgtblProductSubGroupVariationsCreatedOn;
DROP TRIGGER IF EXISTS trgtblProductSubGroupVariationsMatrixCreatedOn;
DROP TRIGGER IF EXISTS trgtblProductUnitMatrixCreatedOn;
DROP TRIGGER IF EXISTS trgtblProductVariationsCreatedOn;
DROP TRIGGER IF EXISTS trgtblProductVariationsMatrixCreatedOn;
DROP TRIGGER IF EXISTS trgtblPromoCreatedOn;
DROP TRIGGER IF EXISTS trgtblPromoItemsCreatedOn;
DROP TRIGGER IF EXISTS trgtblPromotypeCreatedOn;
DROP TRIGGER IF EXISTS trgtblReceiptCreatedOn;
DROP TRIGGER IF EXISTS trgtblReceiptFormatCreatedOn;
DROP TRIGGER IF EXISTS trgtblremotebranchInventoryCreatedOn;
DROP TRIGGER IF EXISTS trgtblrewardItemsCreatedOn;
DROP TRIGGER IF EXISTS trgtblSalesPerItemCreatedOn;
DROP TRIGGER IF EXISTS trgtblSalutationsCreatedOn;
DROP TRIGGER IF EXISTS trgtblStockCreatedOn;
DROP TRIGGER IF EXISTS trgtblStockItemsCreatedOn;
DROP TRIGGER IF EXISTS trgtblStocktypeCreatedOn;
DROP TRIGGER IF EXISTS trgtblTerminalCreatedOn;
DROP TRIGGER IF EXISTS trgtblTerminalReportCreatedOn;
DROP TRIGGER IF EXISTS trgtblTerminalReportHistoryCreatedOn;
DROP TRIGGER IF EXISTS trgtblTransactionItemsCreatedOn;
DROP TRIGGER IF EXISTS trgtblTransactionItemsBackupCreatedOn;
DROP TRIGGER IF EXISTS trgtblTransactionNosCreatedOn;
DROP TRIGGER IF EXISTS trgtblTransactionsCreatedOn;
DROP TRIGGER IF EXISTS trgtblTransactionsBackupCreatedOn;

DROP TRIGGER IF EXISTS trgtblUnitCreatedOn;
DROP TRIGGER IF EXISTS trgtblVariationsCreatedOn;
DROP TRIGGER IF EXISTS trgtblWithholdCreatedOn;

CREATE TRIGGER trgsysAccessGroupRightsCreatedOn BEFORE INSERT ON sysAccessGroupRights FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgsysAccessGroupsCreatedOn BEFORE INSERT ON sysAccessGroups FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgsysAccessRightsCreatedOn BEFORE INSERT ON sysAccessRights FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgsysAccessTypesCreatedOn BEFORE INSERT ON sysAccessTypes FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgsysAccessUserDetailsCreatedOn BEFORE INSERT ON sysAccessUserDetails FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgsysAccessUsersCreatedOn BEFORE INSERT ON sysAccessUsers FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgsysAuditTrailCreatedOn BEFORE INSERT ON sysAuditTrail FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgsysConfigCreatedOn BEFORE INSERT ON sysConfig FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgsysTerminalKeyCreatedOn BEFORE INSERT ON sysTerminalKey FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblAgentsCommisionCreatedOn BEFORE INSERT ON tblAgentsCommision FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblBranchCreatedOn BEFORE INSERT ON tblBranch FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblBranchTransferCreatedOn BEFORE INSERT ON tblBranchTransfer FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblBranchTransferItemsCreatedOn BEFORE INSERT ON tblBranchTransferItems FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblCalDateCreatedOn BEFORE INSERT ON tblCalDate FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblCardTypesCreatedOn BEFORE INSERT ON tblCardTypes FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblCashCountCreatedOn BEFORE INSERT ON tblCashCount FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblCashierLogsCreatedOn BEFORE INSERT ON tblCashierLogs FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblCashierReportCreatedOn BEFORE INSERT ON tblCashierReport FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblCashierReportHistoryCreatedOn BEFORE INSERT ON tblCashierReportHistory FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblCashPaymentCreatedOn BEFORE INSERT ON tblCashPayment FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblChargeTypeCreatedOn BEFORE INSERT ON tblChargeType FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblChequePaymentCreatedOn BEFORE INSERT ON tblChequePayment FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblContactAddonCreatedOn BEFORE INSERT ON tblContactAddon FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblContactCreditCardinfoCreatedOn BEFORE INSERT ON tblContactCreditCardinfo FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblContactGroupCreatedOn BEFORE INSERT ON tblContactGroup FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblContactRewardsCreatedOn BEFORE INSERT ON tblContactRewards FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblContactRewardsMovementCreatedOn BEFORE INSERT ON tblContactRewardsMovement FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblContactsCreatedOn BEFORE INSERT ON tblContacts FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblContactsAuditCreatedOn BEFORE INSERT ON tblContactsAudit FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblCountingRefCreatedOn BEFORE INSERT ON tblCountingRef FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblCountryCreatedOn BEFORE INSERT ON tblCountry FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblCreditCardPaymentCreatedOn BEFORE INSERT ON tblCreditCardPayment FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblCreditPaymentCreatedOn BEFORE INSERT ON tblCreditPayment FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblDebitPaymentCreatedOn BEFORE INSERT ON tblDebitPayment FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblDenominationCreatedOn BEFORE INSERT ON tblDenomination FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblDepartmentsCreatedOn BEFORE INSERT ON tblDepartments FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblDepositCreatedOn BEFORE INSERT ON tblDeposit FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblDisburseCreatedOn BEFORE INSERT ON tblDisburse FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblDiscountCreatedOn BEFORE INSERT ON tblDiscount FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblDiscountHistoryCreatedOn BEFORE INSERT ON tblDiscountHistory FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblInvAdjustmentCreatedOn BEFORE INSERT ON tblInvAdjustment FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblInvAdjustmentItemsCreatedOn BEFORE INSERT ON tblInvAdjustmentItems FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblInventoryCreatedOn BEFORE INSERT ON tblInventory FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblMatrixPackagePriceHistoryCreatedOn BEFORE INSERT ON tblMatrixPackagePriceHistory FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblPaidOutCreatedOn BEFORE INSERT ON tblPaidOut FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblParkingRatesCreatedOn BEFORE INSERT ON tblParkingRates FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblPLUReportCreatedOn BEFORE INSERT ON tblPLUReport FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblPositionsCreatedOn BEFORE INSERT ON tblPositions FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblProductBaseVariationsMatrixCreatedOn BEFORE INSERT ON tblProductBaseVariationsMatrix FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblProductCompositionCreatedOn BEFORE INSERT ON tblProductComposition FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblProductGroupCreatedOn BEFORE INSERT ON tblProductGroup FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblProductGroupBaseVariationsMatrixCreatedOn BEFORE INSERT ON tblProductGroupBaseVariationsMatrix FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblProductGroupChargesCreatedOn BEFORE INSERT ON tblProductGroupCharges FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblProductGroupUnitMatrixCreatedOn BEFORE INSERT ON tblProductGroupUnitMatrix FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblProductGroupVariationsCreatedOn BEFORE INSERT ON tblProductGroupVariations FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblProductGroupVariationsMatrixCreatedOn BEFORE INSERT ON tblProductGroupVariationsMatrix FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblProductHistoryCreatedOn BEFORE INSERT ON tblProductHistory FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblProductInventoryCreatedOn BEFORE INSERT ON tblProductInventory FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblProductInventoryAuditCreatedOn BEFORE INSERT ON tblProductInventoryAudit FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblProductInventoryDailyCreatedOn BEFORE INSERT ON tblProductInventoryDaily FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblProductInventoryMonthlyCreatedOn BEFORE INSERT ON tblProductInventoryMonthly FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblProductMovementCreatedOn BEFORE INSERT ON tblProductMovement FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblProductPackageCreatedOn BEFORE INSERT ON tblProductPackage FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblProductPackagepriceHistoryCreatedOn BEFORE INSERT ON tblProductPackagepriceHistory FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblProductpricesCreatedOn BEFORE INSERT ON tblProductprices FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblProductPurchasepriceHistoryCreatedOn BEFORE INSERT ON tblProductPurchasepriceHistory FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblProductsCreatedOn BEFORE INSERT ON tblProducts FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblProductSubGroupCreatedOn BEFORE INSERT ON tblProductSubGroup FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblProductSubGroupbaseVariationsMatrixCreatedOn BEFORE INSERT ON tblProductSubGroupbaseVariationsMatrix FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblProductSubGroupChargesCreatedOn BEFORE INSERT ON tblProductSubGroupCharges FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblProductSubGroupUnitMatrixCreatedOn BEFORE INSERT ON tblProductSubGroupUnitMatrix FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblProductSubGroupVariationsCreatedOn BEFORE INSERT ON tblProductSubGroupVariations FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblProductSubGroupVariationsMatrixCreatedOn BEFORE INSERT ON tblProductSubGroupVariationsMatrix FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblProductUnitMatrixCreatedOn BEFORE INSERT ON tblProductUnitMatrix FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblProductVariationsCreatedOn BEFORE INSERT ON tblProductVariations FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblProductVariationsMatrixCreatedOn BEFORE INSERT ON tblProductVariationsMatrix FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblPromoCreatedOn BEFORE INSERT ON tblPromo FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblPromoItemsCreatedOn BEFORE INSERT ON tblPromoItems FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblPromotypeCreatedOn BEFORE INSERT ON tblPromotype FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblReceiptCreatedOn BEFORE INSERT ON tblReceipt FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblReceiptFormatCreatedOn BEFORE INSERT ON tblReceiptFormat FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblremotebranchInventoryCreatedOn BEFORE INSERT ON tblremotebranchInventory FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblrewardItemsCreatedOn BEFORE INSERT ON tblrewardItems FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblSalesPerItemCreatedOn BEFORE INSERT ON tblSalesPerItem FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblSalutationsCreatedOn BEFORE INSERT ON tblSalutations FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblStockCreatedOn BEFORE INSERT ON tblStock FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblStockItemsCreatedOn BEFORE INSERT ON tblStockItems FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblStocktypeCreatedOn BEFORE INSERT ON tblStocktype FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblTerminalCreatedOn BEFORE INSERT ON tblTerminal FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblTerminalReportCreatedOn BEFORE INSERT ON tblTerminalReport FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblTerminalReportHistoryCreatedOn BEFORE INSERT ON tblTerminalReportHistory FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblTransactionItemsCreatedOn BEFORE INSERT ON tblTransactionItems FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblTransactionItemsBackupCreatedOn BEFORE INSERT ON tblTransactionItemsBackup FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblTransactionNosCreatedOn BEFORE INSERT ON tblTransactionNos FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblTransactionsCreatedOn BEFORE INSERT ON tblTransactions FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblTransactionsBackupCreatedOn BEFORE INSERT ON tblTransactionsBackup FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblUnitCreatedOn BEFORE INSERT ON tblUnit FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblVariationsCreatedOn BEFORE INSERT ON tblVariations FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
CREATE TRIGGER trgtblWithholdCreatedOn BEFORE INSERT ON tblWithhold FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;

UPDATE sysAccessGroupRights SET LastModified = NOW();
UPDATE sysAccessGroups SET LastModified = NOW();
UPDATE sysAccessRights SET LastModified = NOW();
UPDATE sysAccessTypes SET LastModified = NOW();
UPDATE sysAccessUserDetails SET LastModified = NOW();
UPDATE sysAccessUsers SET LastModified = NOW();
UPDATE sysAuditTrail SET LastModified = NOW();
UPDATE sysConfig SET LastModified = NOW();
UPDATE sysTerminalKey SET LastModified = NOW();
UPDATE tblAgentsCommision SET LastModified = NOW();
UPDATE tblBranch SET LastModified = NOW();
UPDATE tblBranchTransfer SET LastModified = NOW();
UPDATE tblBranchTransferItems SET LastModified = NOW();
UPDATE tblCalDate SET LastModified = NOW();
UPDATE tblCardTypes SET LastModified = NOW();
UPDATE tblCashCount SET LastModified = NOW();
UPDATE tblCashierLogs SET LastModified = NOW();
UPDATE tblCashierReport SET LastModified = NOW();
UPDATE tblCashierReportHistory SET LastModified = NOW();
UPDATE tblCashPayment SET LastModified = NOW();
UPDATE tblChargeType SET LastModified = NOW();
UPDATE tblChequePayment SET LastModified = NOW();
UPDATE tblContactAddon SET LastModified = NOW();
UPDATE tblContactCreditCardinfo SET LastModified = NOW();
UPDATE tblContactGroup SET LastModified = NOW();
UPDATE tblContactRewards SET LastModified = NOW();
UPDATE tblContactRewardsMovement SET LastModified = NOW();
UPDATE tblContacts SET LastModified = NOW();
UPDATE tblContactsAudit SET LastModified = NOW();
UPDATE tblCountingRef SET LastModified = NOW();
UPDATE tblCountry SET LastModified = NOW();
UPDATE tblCreditCardPayment SET LastModified = NOW();
UPDATE tblCreditPayment SET LastModified = NOW();
UPDATE tblDebitPayment SET LastModified = NOW();
UPDATE tblDenomination SET LastModified = NOW();
UPDATE tblDepartments SET LastModified = NOW();
UPDATE tblDeposit SET LastModified = NOW();
UPDATE tblDisburse SET LastModified = NOW();
UPDATE tblDiscount SET LastModified = NOW();
UPDATE tblDiscountHistory SET LastModified = NOW();
UPDATE tblInvAdjustment SET LastModified = NOW();
UPDATE tblInvAdjustmentItems SET LastModified = NOW();
UPDATE tblInventory SET LastModified = NOW();
UPDATE tblMatrixPackagePriceHistory SET LastModified = NOW();
UPDATE tblPaidOut SET LastModified = NOW();
UPDATE tblParkingRates SET LastModified = NOW();
UPDATE tblPLUReport SET LastModified = NOW();
UPDATE tblPOItems SET LastModified = NOW();
UPDATE tblPositions SET LastModified = NOW();
UPDATE tblProductBaseVariationsMatrix SET LastModified = NOW();
UPDATE tblProductComposition SET LastModified = NOW();
UPDATE tblProductGroup SET LastModified = NOW();
UPDATE tblProductGroupBaseVariationsMatrix SET LastModified = NOW();
UPDATE tblProductGroupCharges SET LastModified = NOW();
UPDATE tblProductGroupUnitMatrix SET LastModified = NOW();
UPDATE tblProductGroupVariations SET LastModified = NOW();
UPDATE tblProductGroupVariationsMatrix SET LastModified = NOW();
UPDATE tblProductHistory SET LastModified = NOW();
UPDATE tblProductInventory SET LastModified = NOW();
UPDATE tblProductInventoryAudit SET LastModified = NOW();
UPDATE tblProductInventoryDaily SET LastModified = NOW();
UPDATE tblProductInventoryMonthly SET LastModified = NOW();
UPDATE tblProductMovement SET LastModified = NOW();
UPDATE tblProductPackage SET LastModified = NOW();
UPDATE tblProductPackagepriceHistory SET LastModified = NOW();
UPDATE tblProductprices SET LastModified = NOW();
UPDATE tblProductPurchasepriceHistory SET LastModified = NOW();
UPDATE tblProducts SET LastModified = NOW();
UPDATE tblProductSubGroup SET LastModified = NOW();
UPDATE tblProductSubGroupbaseVariationsMatrix SET LastModified = NOW();
UPDATE tblProductSubGroupCharges SET LastModified = NOW();
UPDATE tblProductSubGroupUnitMatrix SET LastModified = NOW();
UPDATE tblProductSubGroupVariations SET LastModified = NOW();
UPDATE tblProductSubGroupVariationsMatrix SET LastModified = NOW();
UPDATE tblProductUnitMatrix SET LastModified = NOW();
UPDATE tblProductVariations SET LastModified = NOW();
UPDATE tblProductVariationsMatrix SET LastModified = NOW();
UPDATE tblPromo SET LastModified = NOW();
UPDATE tblPromoItems SET LastModified = NOW();
UPDATE tblPromotype SET LastModified = NOW();
UPDATE tblReceipt SET LastModified = NOW();
UPDATE tblReceiptFormat SET LastModified = NOW();
UPDATE tblremotebranchInventory SET LastModified = NOW();
UPDATE tblrewardItems SET LastModified = NOW();
UPDATE tblSalesPerItem SET LastModified = NOW();
UPDATE tblSalutations SET LastModified = NOW();
UPDATE tblStock SET LastModified = NOW();
UPDATE tblStockItems SET LastModified = NOW();
UPDATE tblStocktype SET LastModified = NOW();
UPDATE tblTerminal SET LastModified = NOW();
UPDATE tblTerminalReport SET LastModified = NOW();
UPDATE tblTerminalReportHistory SET LastModified = NOW();
UPDATE tblTransactionItems SET LastModified = NOW();
UPDATE tblTransactionItemsBackup SET LastModified = NOW();
UPDATE tblTransactionNos SET LastModified = NOW();
UPDATE tblTransactions SET LastModified = DateClosed;
UPDATE tblTransactionsBackup SET LastModified = DateClosed;
UPDATE tblUnit SET LastModified = NOW();
UPDATE tblVariations SET LastModified = NOW();
UPDATE tblWithhold SET LastModified = NOW();

ALTER TABLE SysAccessTypes MODIFY Enabled TINYINT(1) NOT NULL DEFAULT 0;

ALTER TABLE tblCalDate ADD `CalDateID` BIGINT(20) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT;

ALTER TABLE tblTerminal MODIFY `IncludeCreditChargeAgreement` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminal MODIFY `IncludeTermsAndConditions` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblReceipt ADD `ReceiptID` INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT;

-- Added August 4, 2014
--	0  means product can be sold and not lock for closing inventory
--	1  means product can be sold and lock for closing inventory
ALTER TABLE tblProductGroup MODIFY `isLock` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblContacts MODIFY `isLock` TINYINT(1) NOT NULL DEFAULT 0;

-- add the auto_increment id's for offline mode sync 
ALTER TABLE tblProductGroupVariations ADD `ProductGroupVariationID` BIGINT(20) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT;
ALTER TABLE tblProductGroupVariationsMatrix ADD `ProductGroupVariationsMatrixID` BIGINT(20) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT;

-- add the auto_increment id's for offline mode sync 
ALTER TABLE tblProductSubGroupVariations ADD `ProductSubGroupVariationID` BIGINT(20) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT;
ALTER TABLE tblProductSubGroupVariationsMatrix ADD `ProductSubGroupVariationsMatrixID` BIGINT(20) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT;

-- add the auto_increment id's for offline mode sync 
ALTER TABLE tblProductVariations ADD `ProductVariationID` BIGINT(20) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT;
ALTER TABLE tblProductVariationsMatrix ADD `ProductVariationsMatrixID` BIGINT(20) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT;

-- Modify the VariationMatrixID from int(20) to bigint(20)
ALTER TABLE tblProductComposition MODIFY `VariationMatrixID` BIGINT(20) UNSIGNED;
ALTER TABLE tblPromoItems MODIFY `VariationMatrixID` BIGINT(20) UNSIGNED;

-- deleted no use (for confirmation)
RENAME TABLE tblTransactionNos TO deleted_tblTransactionNos;
RENAME TABLE tblProductPrices TO deleted_tblProductPrices;
RENAME TABLE tblInvAdjustmentItems TO deleted_tblInvAdjustmentItems;
RENAME TABLE tblRemoteBranchInventory TO deleted_tblRemoteBranchInventory;


ALTER TABLE tblRewardItems ADD `RewardItemsID` BIGINT(20) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT;

-- replace LastUpdatedOn with LastModified
-- update the last modified with correct values first before dropping
UPDATE tblParkingRates SET LastModified = LastUpdatedOn WHERE LastUpdatedOn > '2011-01-01';
ALTER TABLE tblParkingRates DROP LastUpdatedOn;

-- replace table with tblReceipt
RENAME TABLE tblReceiptFormat TO deleted_tblReceiptFormat;

RENAME TABLE tblMatrixPackagePriceHistory TO deleted_tblMatrixPackagePriceHistory;

-- replaced with tblProductInventory
RENAME TABLE deleted_tblBranchInventory TO deleted_tblBranchInventory_old;
RENAME TABLE deleted_tblBranchInventoryMatrix TO deleted_tblBranchInventoryMatrix_old;
RENAME TABLE tblBranchInventory TO deleted_tblBranchInventory;
RENAME TABLE tblBranchInventoryMatrix TO deleted_tblBranchInventoryMatrix;

ALTER TABLE sysAuditTrail ADD `BranchID` INT(4) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE sysAuditTrail ADD `TerminalNo` VARCHAR(5);

ALTER TABLE tblCashierLogs ADD `SyncID` BIGINT(20) NOT NULL DEFAULT 0;
CREATE INDEX IX_tblCashierLogs_IXSync ON tblCashierLogs (SyncID);
UPDATE tblCashierLogs SET SyncID = CashierLogsID WHERE SyncID = 0;


ALTER TABLE tblCashierReport DROP INDEX PK_tblCashierReport;
ALTER TABLE tblCashierReport DROP PRIMARY KEY;
ALTER TABLE tblCashierReport ADD `CashierReportID` BIGINT(20) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT;
ALTER TABLE tblCashierReport ADD `SyncID` BIGINT(20) NOT NULL DEFAULT 0;
CREATE INDEX IX_tblCashierReport_IXSync ON tblCashierReport (SyncID);
UPDATE tblCashierReport SET SyncID = CashierReportID WHERE SyncID = 0;

ALTER TABLE tblCashierReportHistory ADD `CashierReportHistoryID` BIGINT(20) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT;
ALTER TABLE tblCashierReportHistory ADD `SyncID` BIGINT(20) NOT NULL DEFAULT 0;
CREATE INDEX IX_tblCashierReport_IXSync ON tblCashierReportHistory (SyncID);
UPDATE tblCashierReportHistory SET SyncID = CashierReportHistoryID WHERE SyncID = 0;
ALTER TABLE tblCashierReportHistory ADD `IsCashCountInitialized` TINYINT(1) NOT NULL DEFAULT 0; 


ALTER TABLE tblDeposit ADD `SyncID` BIGINT(20) NOT NULL DEFAULT 0;
CREATE INDEX IX_tblDeposit_IXSync ON tblDeposit (SyncID);
UPDATE tblDeposit SET SyncID = DepositID WHERE SyncID = 0;

ALTER TABLE tblDisburse ADD `SyncID` BIGINT(20) NOT NULL DEFAULT 0;
CREATE INDEX IX_tblDisburse_IXSync ON tblDisburse (SyncID);
UPDATE tblDisburse SET SyncID = DisburseID WHERE SyncID = 0;

ALTER TABLE tblPaidOut ADD `SyncID` BIGINT(20) NOT NULL DEFAULT 0;
CREATE INDEX IX_tblPaidOut_IXSync ON tblPaidOut (SyncID);
UPDATE tblPaidOut SET SyncID = PaidOutID WHERE SyncID = 0;

ALTER TABLE tblWithhold ADD `SyncID` BIGINT(20) NOT NULL DEFAULT 0;
CREATE INDEX IX_tblWithhold_IXSync ON tblWithhold (SyncID);
UPDATE tblWithhold SET SyncID = WithholdID WHERE SyncID = 0;

ALTER TABLE tblCashPayment ADD `CashPaymentID` BIGINT(20) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT;
ALTER TABLE tblCashPayment ADD `SyncID` BIGINT(20) NOT NULL DEFAULT 0;
CREATE INDEX IX_tblCashPayment_IXSync ON tblCashPayment (SyncID);
UPDATE tblCashPayment SET SyncID = CashPaymentID WHERE SyncID = 0;
ALTER TABLE tblCashPayment ADD `TerminalNo` VARCHAR(5);
ALTER TABLE tblCashPayment ADD `BranchID` INT(4) NOT NULL DEFAULT 0;

ALTER TABLE tblChequePayment ADD `ChequePaymentID` BIGINT(20) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT;
ALTER TABLE tblChequePayment ADD `SyncID` BIGINT(20) NOT NULL DEFAULT 0;
CREATE INDEX IX_tblChequePayment_IXSync ON tblChequePayment (SyncID);
UPDATE tblChequePayment SET SyncID = ChequePaymentID WHERE SyncID = 0;
ALTER TABLE tblChequePayment ADD `TerminalNo` VARCHAR(5);
ALTER TABLE tblChequePayment ADD `BranchID` INT(4) NOT NULL DEFAULT 0;


ALTER TABLE tblCreditCardPayment ADD `CreditCardPaymentID` BIGINT(20) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT;
ALTER TABLE tblCreditCardPayment ADD `SyncID` BIGINT(20) NOT NULL DEFAULT 0;
CREATE INDEX IX_tblCreditCardPayment_IXSync ON tblCreditCardPayment (SyncID);
UPDATE tblCreditCardPayment SET SyncID = CreditCardPaymentID WHERE SyncID = 0;
ALTER TABLE tblCreditCardPayment ADD `TerminalNo` VARCHAR(5);
ALTER TABLE tblCreditCardPayment ADD `BranchID` INT(4) NOT NULL DEFAULT 0;

ALTER TABLE tblCreditPayment ADD `CreditPaymentID` BIGINT(20) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT;
ALTER TABLE tblCreditPayment ADD `SyncID` BIGINT(20) NOT NULL DEFAULT 0;
CREATE INDEX IX_tblCreditPayment_IXSync ON tblCreditPayment (SyncID);
UPDATE tblCreditPayment SET SyncID = CreditPaymentID WHERE SyncID = 0;
ALTER TABLE tblCreditPayment ADD `BranchID` INT(4) NOT NULL DEFAULT 0;

-- create a productid reference so that references will be matrixid and productid
ALTER TABLE tblProductVariationsMatrix ADD `ProductID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0;
UPDATE tblProducts, tblProductBaseVariationsMatrix, tblProductVariationsMatrix SET 
	tblProductVariationsMatrix.ProductID = tblProductBaseVariationsMatrix.ProductID
WHERE tblProducts.ProductID = tblProductBaseVariationsMatrix.ProductID 
	AND tblProductVariationsMatrix.MatrixID = tblProductBaseVariationsMatrix.MatrixID;

-- remove the foreign key so that updating of VARIATIONS for basematrix can be done.
ALTER TABLE tblProductVariationsMatrix DROP FOREIGN KEY `tblproductvariationsmatrix_ibfk_2`;

ALTER TABLE tblCashCount ADD `SyncID` BIGINT(20) NOT NULL DEFAULT 0;
CREATE INDEX IX_tblCashCount_IXSync ON tblCashCount (SyncID);
UPDATE tblCashCount SET SyncID = CashCountID WHERE SyncID = 0;
ALTER TABLE tblCashCount ADD `DenominationValue` DECIMAL(18,2) NOT NULL DEFAULT 0 COMMENT 'Need for audit purposes only';

ALTER TABLE tblPLUReport ADD `BranchID` INT(4) NOT NULL DEFAULT 0;

-- extend the no of char from 20 to 40
ALTER TABLE tblReceipt Modify `Text` VARCHAR(40);

-- This is the OR no that will be printed if the transactions are:
-- Closed and Refund; 
-- No OR no for CreditPayment, Void
ALTER TABLE tblTerminalReport ADD `BeginningORNo` VARCHAR(30) NOT NULL;
ALTER TABLE tblTerminalReport ADD `EndingORNo` VARCHAR(30) NOT NULL;
UPDATE tblTerminalReport SET BeginningORNo = BeginningTransactionNo WHERE BeginningORNo = '' OR BeginningORNo IS NULL;
UPDATE tblTerminalReport SET EndingORNo = EndingTransactionNo WHERE EndingORNo = '' OR EndingORNo IS NULL;

ALTER TABLE tblTerminalReportHistory ADD `BeginningORNo` VARCHAR(30) NOT NULL;
ALTER TABLE tblTerminalReportHistory ADD `EndingORNo` VARCHAR(30) NOT NULL;
UPDATE tblTerminalReportHistory SET BeginningORNo = BeginningTransactionNo WHERE BeginningORNo = '' OR BeginningORNo IS NULL;
UPDATE tblTerminalReportHistory SET EndingORNo = EndingTransactionNo WHERE EndingORNo = '' OR EndingORNo IS NULL;

ALTER TABLE tblTransactions ADD `ORNo` VARCHAR(30);
-- update ORNo of those that are closed and refunded
UPDATE tblTransactions SET ORNo = NULL WHERE TransactionStatus NOT IN (1,5,11) AND IFNULL(ORNo,'') <> '';
UPDATE tblTransactions SET ORNo = TransactionNo WHERE TransactionStatus IN (1,5,11) AND IFNULL(ORNo,'') = '';

ALTER TABLE tblTransactions ADD `SyncID` BIGINT(20) NOT NULL DEFAULT 0;
CREATE INDEX IX_tblTransactions_IXSync ON tblTransactions (SyncID);
UPDATE tblTransactions SET SyncID = TransactionID WHERE SyncID = 0;
ALTER TABLE tblTransactions ADD `ZeroRatedVAT` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'Use for ZeroRated';
ALTER TABLE tblTransactions ADD `NonVATableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'Use for NonVAT';
ALTER TABLE tblTransactions ADD `VATExempt` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'Use for SNR';
ALTER TABLE tblTransactions ADD `NonEVATableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0;

ALTER TABLE tblTransactions ADD `SNRDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions ADD `PWDDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions ADD `OtherDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions ADD `NetSales` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'Net Sales = Amount Due = VAT Exempt - SNRDisc = Subtotal - Not SNRDisc';

ALTER TABLE tblTransactionItems ADD `SyncID` BIGINT(20) NOT NULL DEFAULT 0;
CREATE INDEX IX_tblTransactionItems_IXSync ON tblTransactionItems (SyncID);
UPDATE tblTransactionItems SET SyncID = TransactionItemsID WHERE SyncID = 0;
ALTER TABLE tblTransactionItems ADD `ZeroRatedVAT` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'Use for ZeroRated';
ALTER TABLE tblTransactionItems ADD `NonVATableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'Use for NonVAT';
ALTER TABLE tblTransactionItems ADD `VATExempt` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'Use for SNR';
ALTER TABLE tblTransactionItems ADD `NonEVATableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0;

ALTER TABLE tblTerminalReport ADD `ZeroRatedVAT` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'Use for ZeroRated';
ALTER TABLE tblTerminalReport ADD `NonVATableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'Use for NonVAT';
ALTER TABLE tblTerminalReport ADD `VATExempt` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'Use for SNR';
ALTER TABLE tblTerminalReport MODIFY `NonEVATableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReport ADD `SNRDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReport ADD `PWDDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReport ADD `OtherDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReport ADD `NetSales` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'Net Sales = Amount Due = VAT Exempt - SNRDisc = Subtotal - Not SNRDisc';

ALTER TABLE tblTerminalReportHistory ADD `ZeroRatedVAT` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'Use for ZeroRated';
ALTER TABLE tblTerminalReportHistory MODIFY `NonVATableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'Use for NonvAT';
ALTER TABLE tblTerminalReportHistory ADD `VATExempt` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'Use for SNR';
ALTER TABLE tblTerminalReportHistory MODIFY `NonEVATableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReportHistory ADD `SNRDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReportHistory ADD `PWDDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReportHistory ADD `OtherDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReportHistory ADD `NetSales` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'Net Sales = Amount Due = VAT Exempt - SNRDisc = Subtotal - Not SNRDisc';

/**************GENERATE DISCOUNT**************/
-- break the TotalDiscount = ItemsDiscount + SNRDiscount (VATExempt * 0.20) + PWDDiscount + OtherDiscount
/***
UPDATE tblTerminalReport SET SNRDiscount = VATExempt * 0.05;
UPDATE tblTerminalReportHistory SET SNRDiscount = VATExempt * 0.05;

UPDATE tblTerminalReport SET OtherDiscount = TotalDiscount - ItemsDiscount - SNRDiscount;
UPDATE tblTerminalReportHistory SET OtherDiscount = TotalDiscount - ItemsDiscount - SNRDiscount;

UPDATE tblTerminalReport SET NetSales = GrossSales - (VATExempt * 0.12) - TotalDiscount;
UPDATE tblTerminalReportHistory SET NetSales = GrossSales - (VATExempt * 0.12) - TotalDiscount;
***/

ALTER TABLE tblCashierReport ADD `VATableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'Use for VAT';
ALTER TABLE tblCashierReport ADD `ZeroRatedVAT` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'Use for ZeroRated';
ALTER TABLE tblCashierReport ADD `NonVATableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'Use for NonVAT';
ALTER TABLE tblCashierReport ADD `VATExempt` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'Use for SNR';
ALTER TABLE tblCashierReport ADD `EVATableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReport ADD `NonEVATableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0;

ALTER TABLE tblCashierReport ADD `SNRDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReport ADD `PWDDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReport ADD `OtherDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReport ADD `NetSales` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'Net Sales = Amount Due = VAT Exempt - SNRDisc = Subtotal - Not SNRDisc';

ALTER TABLE tblCashierReportHistory ADD `VATableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'Use for VAT';
ALTER TABLE tblCashierReportHistory ADD `ZeroRatedVAT` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'Use for ZeroRated';
ALTER TABLE tblCashierReportHistory ADD `NonVATableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'Use for NonVAT';
ALTER TABLE tblCashierReportHistory ADD `VATExempt` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'Use for SNR';
ALTER TABLE tblCashierReportHistory ADD `EVATableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReportHistory ADD `NonEVATableAmount` DECIMAL(18,3) NOT NULL DEFAULT 0;

ALTER TABLE tblCashierReportHistory ADD `SNRDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReportHistory ADD `PWDDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReportHistory ADD `OtherDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReportHistory ADD `NetSales` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'Net Sales = Amount Due = VAT Exempt - SNRDisc = Subtotal - Not SNRDisc';

/**************GENERATE DISCOUNT**************/
-- break the TotalDiscount = ItemsDiscount + SNRDiscount (VATExempt * 0.20) + PWDDiscount + OtherDiscount
UPDATE tblCashierReport SET VATableAmount = VAT / 0.12;
UPDATE tblCashierReportHistory SET VATableAmount = VAT / 0.12;

UPDATE tblCashierReport SET SNRDiscount = VATExempt * 0.05;
UPDATE tblCashierReportHistory SET SNRDiscount = VATExempt * 0.05;

UPDATE tblCashierReport SET OtherDiscount = TotalDiscount - ItemsDiscount - SNRDiscount;
UPDATE tblCashierReportHistory SET OtherDiscount = TotalDiscount - ItemsDiscount - SNRDiscount;


ALTER TABLE tblPLUReport MODIFY `ProductCode` VARCHAR(500);

ALTER TABLE tblTransactions ADD `ChargeType` INT(1) NOT NULL DEFAULT 0;
UPDATE tblTransactions SET ChargeType = IFNULL((SELECT InPercent FROM tblChargeType WHERE tblChargeType.ChargeTypeCode = tblTransactions.ChargeCode),0);

-- update the new added column
UPDATE sysAuditTrail SET CreatedON = ActivityDate WHERE DATE_FORMAT(CreatedON, '%Y-%m-%d') = '1900-01-01' OR DATE_FORMAT(CreatedON, '%Y-%m-%d') = '0001-01-01' OR DATE_FORMAT(CreatedON, '%Y-%m-%d') = '0000-00-00';
UPDATE sysAuditTrail SET LastModified = ActivityDate WHERE DATE_FORMAT(LastModified, '%Y-%m-%d') = '1900-01-01' OR DATE_FORMAT(LastModified, '%Y-%m-%d') = '0001-01-01' OR DATE_FORMAT(LastModified, '%Y-%m-%d') = '0000-00-00';

-- update the new added column
UPDATE tblCashPayment, tblTransactions SET tblCashPayment.TerminalNo = tblTransactions.TerminalNo, tblCashPayment.BranchID = tblTransactions.BranchID WHERE tblCashPayment.TransactionID = tblTransactions.TransactionID AND tblCashPayment.BranchID = 0 AND IFNULL(tblCashPayment.TerminalNo,'') = '';

-- update the new added column
UPDATE tblChequePayment, tblTransactions SET tblChequePayment.TerminalNo = tblTransactions.TerminalNo, tblChequePayment.BranchID = tblTransactions.BranchID WHERE tblChequePayment.TransactionID = tblTransactions.TransactionID AND (tblChequePayment.BranchID = 0 OR IFNULL(tblChequePayment.TerminalNo,'') = '');

-- update the new added column
UPDATE tblCreditCardPayment, tblTransactions SET tblCreditCardPayment.TerminalNo = tblTransactions.TerminalNo, tblCreditCardPayment.BranchID = tblTransactions.BranchID WHERE tblCreditCardPayment.TransactionID = tblTransactions.TransactionID AND (tblCreditCardPayment.BranchID = 0 OR IFNULL(tblCreditCardPayment.TerminalNo,'') = '');

-- update the new added column
UPDATE tblCreditPayment, tblTransactions SET tblCreditPayment.TerminalNo = tblTransactions.TerminalNo, tblCreditPayment.BranchID = tblTransactions.BranchID WHERE tblCreditPayment.TransactionID = tblTransactions.TransactionID AND (tblCreditPayment.BranchID = 0 OR IFNULL(tblCreditPayment.TerminalNo,'') = '');

-- update the new added column
UPDATE tblCashCount, tblDenomination SET tblCashCount.DenominationValue = tblDenomination.DenominationValue WHERE tblCashCount.DenominationID = tblDenomination.DenominationID AND tblCashCount.DenominationValue = 0;

ALTER TABLE tblCashierReportHistory ADD `BeginningTransactionNo` VARCHAR(30) NOT NULL;
ALTER TABLE tblCashierReportHistory ADD `BeginningORNo` VARCHAR(30) NOT NULL;
ALTER TABLE tblCashierReportHistory ADD `EndingTransactionNo` VARCHAR(30) NOT NULL;
ALTER TABLE tblCashierReportHistory ADD `EndingORNo` VARCHAR(30) NOT NULL;

ALTER TABLE tblTransactions ADD `ItemSold` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions ADD `QuantitySold` DECIMAL(18,3) NOT NULL DEFAULT 0;

UPDATE tblTransactions,  
	(
		SELECT TransactionID,
			SUM(CASE TransactionItemStatus
					WHEN 0 THEN 1	-- Valid
					WHEN 1 THEN 0	-- Void
					WHEN 2 THEN 0	-- trash
					WHEN 3 THEN 1	-- return
					WHEN 4 THEN 1	-- refund
					WHEN 5 THEN 1	-- orderslip
				END) ItemsSold,
			SUM(CASE TransactionItemStatus
					WHEN 0 THEN Quantity	-- Valid
					WHEN 1 THEN 0			-- Void
					WHEN 2 THEN 0			-- trash
					WHEN 3 THEN Quantity	-- return
					WHEN 4 THEN Quantity	-- refund
					WHEN 5 THEN Quantity	-- orderslip
				END) QuantitySold
		FROM tblTransactionItems
		GROUP BY TransactionID
	) TrxItems
SET 
	tblTransactions.ItemSold		= TrxItems.ItemsSold,
	tblTransactions.QuantitySold	= TrxItems.QuantitySold
WHERE tblTransactions.TransactionID = TrxItems.TransactionID;

-- change the SNRDiscount based on
-- 0.05 Groceries
-- 0.20 Pharmaceuticals

UPDATE tblTransactions SET 
	VATExempt = CASE DiscountCode WHEN 'SNR' THEN Discount / 0.20 ELSE 0 END,
	SNRDiscount = CASE DiscountCode WHEN 'SNR' THEN Discount ELSE 0 END,
	PWDDiscount = CASE DiscountCode WHEN 'PWD' THEN Discount ELSE 0 END,
	OtherDiscount = CASE DiscountCode WHEN 'SNR' THEN 0 WHEN 'PWD' THEN 0 ELSE Discount END;
	
UPDATE tblTransactions SET NetSales = SubTotal - (VATExempt * 0.12) - Discount;

ALTER TABLE tblTerminalReport ADD `IsProcessed` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReportHistory ADD `IsProcessed` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReport ADD `ItemSold` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReportHistory ADD `ItemSold` DECIMAL(18,3) NOT NULL DEFAULT 0;

ALTER TABLE tblTerminalReport ADD `TrustFund` DECIMAL(18,3) NOT NULL DEFAULT 0;

ALTER TABLE tblCashierReport ADD `IsProcessed` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReportHistory ADD `IsProcessed` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReport ADD `ItemSold` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReportHistory ADD `ItemSold` DECIMAL(18,3) NOT NULL DEFAULT 0;

ALTER TABLE tblProductSubGroup ADD `isLock` TINYINT(1) NOT NULL DEFAULT 0;

ALTER TABLE tblCashierReport ADD `BeginningTransactionNo` VARCHAR(30) NOT NULL;
ALTER TABLE tblCashierReport ADD `BeginningORNo` VARCHAR(30) NOT NULL;
ALTER TABLE tblCashierReport ADD `EndingTransactionNo` VARCHAR(30) NOT NULL;
ALTER TABLE tblCashierReport ADD `EndingORNo` VARCHAR(30) NOT NULL;

UPDATE tblCashierReport, tblTerminalReport SET 
	tblCashierReport.BeginningTransactionNo = tblTerminalReport.BeginningTransactionNo,
	tblCashierReport.BeginningORNo = tblTerminalReport.BeginningORNo
WHERE tblCashierReport.BranchID = tblTerminalReport.BranchID
	AND tblCashierReport.TerminalNo = tblTerminalReport.TerminalNo;

-- delete the redundant records
DELETE FROM tblCashierReport WHERE GrossSales = 0 AND NoOfTotalTransactions = 0;
DELETE FROM tblCashierReportHistory WHERE GrossSales = 0 AND NoOfTotalTransactions = 0;

-- update the correct terminalid of those that are zero
UPDATE tblCashierReportHistory, tblTerminal SET 
	tblCashierReportHistory.TerminalID = tblTerminal.TerminalID
WHERE tblCashierReportHistory.TerminalNo = tblTerminal.TerminalNo
	AND tblCashierReportHistory.TerminalID = 0;

-- update the transactionno and orno of those that are blank
UPDATE tblCashierReportHistory, 
	(SELECT BranchID, TerminalNo, a.DateLastInitialized,
		(SELECT DateLastInitialized FROM tblTerminalReportHistory b WHERE a.BranchID = b.BranchID AND a.TerminalNo = b.TerminalNo AND b.DateLastInitialized > a.DateLastInitialized ORDER BY b.DateLastInitialized ASC LIMIT 1) DateLastInitializedTo,
		BeginningTransactionNo, BeginningORNo, 
		CASE 
			WHEN EndingTransactionNo = 0 THEN EndingTransactionNo
			ELSE LPAD(EndingTransactionNo-1, LENGTH(BeginningTransactionNo), '0') 
		END EndingTransactionNo, 
		CASE 
			WHEN EndingORNo = 0 THEN EndingORNo
			ELSE LPAD(EndingORNo-1, LENGTH(BeginningTransactionNo), '0') 
		END EndingORNo
	 FROM tblTerminalReportHistory a
	) tblTerminalReportHistory
SET 
	tblCashierReportHistory.BeginningTransactionNo = tblTerminalReportHistory.BeginningTransactionNo,
	tblCashierReportHistory.EndingTransactionNo = tblTerminalReportHistory.EndingTransactionNo,
	tblCashierReportHistory.BeginningORNo = tblTerminalReportHistory.BeginningORNo,
	tblCashierReportHistory.EndingORNo = tblTerminalReportHistory.EndingORNo
WHERE tblCashierReportHistory.BranchID = tblTerminalReportHistory.BranchID
	AND tblCashierReportHistory.TerminalNo = tblTerminalReportHistory.TerminalNo
	AND tblCashierReportHistory.LastLoginDate BETWEEN DateLastInitialized AND DateLastInitializedTo;

-- delete this no need for this. this is always true anyway
DELETE FROM sysConfig WHERE ConfigName = 'WillDeductTFInTerminalReport';

ALTER TABLE tblTerminal ADD DefaultTransactionChargeCode VARCHAR(60);
ALTER TABLE tblTerminal ADD DineInChargeCode VARCHAR(60);
ALTER TABLE tblTerminal ADD TakeOutChargeCode VARCHAR(60);
ALTER TABLE tblTerminal ADD DeliveryChargeCode VARCHAR(60);

-- Add to put the iamge of subgroups in restoplus
ALTER TABLE tblProductSubGroup ADD ImagePath VARCHAR(500);

ALTER TABLE tblContacts ADD `LastCheckInDate` DATETIME NOT NULL DEFAULT '1900-01-01';
ALTER TABLE tblTransactions ADD `ContactCheckInDate` DATETIME NOT NULL DEFAULT '1900-01-01';

ALTER TABLE tblDiscountHistory MODIFY DiscountCode VARCHAR(60);

-- update the transactionstatus of Credit Payments
-- rerun the procTerminalReportHistorySyncTransactionSales after updating this
-- CALL procTerminalReportHistorySyncTransactionSales( 1, '01', '2014-09-01 00:00');
UPDATE tblTransactions SET TransactionStatus = 7 WHERE TransactionStatus <> 7 AND TransactionID IN (SELECT DISTINCT TransactionID FROM tblTransactionItems WHERE ProductCode = 'CREDIT PAYMENT');

-- for monitoring the breakdown of refunds
-- to separated from the cashsales
ALTER TABLE tblTerminalReport ADD `RefundCash` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReport ADD `RefundCheque` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReport ADD `RefundCreditCard` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReport ADD `RefundCredit` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReport ADD `RefundDebit` DECIMAL(18,3) NOT NULL DEFAULT 0;

-- for monitoring the breakdown of refunds
-- to separated from the cashsales
ALTER TABLE tblTerminalReportHistory ADD `RefundCash` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReportHistory ADD `RefundCheque` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReportHistory ADD `RefundCreditCard` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReportHistory ADD `RefundCredit` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReportHistory ADD `RefundDebit` DECIMAL(18,3) NOT NULL DEFAULT 0;

-- for monitoring the breakdown of refunds
-- to separated from the cashsales
ALTER TABLE tblCashierReport ADD `RefundCash` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReport ADD `RefundCheque` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReport ADD `RefundCreditCard` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReport ADD `RefundCredit` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReport ADD `RefundDebit` DECIMAL(18,3) NOT NULL DEFAULT 0;

-- for monitoring the breakdown of refunds
-- to separated from the cashsales
ALTER TABLE tblCashierReportHistory ADD `RefundCash` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReportHistory ADD `RefundCheque` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReportHistory ADD `RefundCreditCard` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReportHistory ADD `RefundCredit` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReportHistory ADD `RefundDebit` DECIMAL(18,3) NOT NULL DEFAULT 0;

/*********************************  v_4.0.1.1.sql END  *******************************************************/ 

UPDATE tblTerminal SET DBVersion = '4.0.1.2';

CREATE INDEX IX_tblCashierLogs_IXSync ON tblCashierLogs (SyncID);
CREATE INDEX IX_tblCashierReport_IXSync ON tblCashierReport (SyncID);
CREATE INDEX IX_tblCashierReport_IXSync ON tblCashierReportHistory (SyncID);
CREATE INDEX IX_tblDeposit_IXSync ON tblDeposit (SyncID);
CREATE INDEX IX_tblDisburse_IXSync ON tblDisburse (SyncID);
CREATE INDEX IX_tblPaidOut_IXSync ON tblPaidOut (SyncID);
CREATE INDEX IX_tblWithhold_IXSync ON tblWithhold (SyncID);
CREATE INDEX IX_tblCashPayment_IXSync ON tblCashPayment (SyncID);
CREATE INDEX IX_tblChequePayment_IXSync ON tblChequePayment (SyncID);
CREATE INDEX IX_tblCreditCardPayment_IXSync ON tblCreditCardPayment (SyncID);
CREATE INDEX IX_tblCreditPayment_IXSync ON tblCreditPayment (SyncID);
CREATE INDEX IX_tblCashCount_IXSync ON tblCashCount (SyncID);
CREATE INDEX IX_tblTransactions_IXSync ON tblTransactions (SyncID);
CREATE INDEX IX_tblTransactionItems_IXSync ON tblTransactionItems (SyncID);

-- this is use for creating transactionnos in BranchTransfer, PO, ClosingInventory, etc.
-- replacement of 3digits Company Code in BE
-- this must be a 3 to 5digits Company Code
DELETE FROM sysConfig WHERE ConfigName = 'BECompanyCode';
INSERT INTO sysConfig (ConfigName, Category, ConfigValue) VALUES ('BECompanyCode',			'CompanyDetails',					'ACE');

-- remove the header's. use the credit card name as the header
DELETE FROM tblReceipt WHERE Module = 'GroupCreditChargeHeader';
DELETE FROM tblReceipt WHERE Module = 'IndividualCreditChargeHeader';
-- For HP values should be
--		GroupCreditChargeHeader:		HP CREDIT CHARGE SLIP
--		IndividualCreditChargeHeader:	SUPER CREDIT CHARGE SLIP

-- remove this coz it's already moved in the CardType
ALTER TABLE tblTerminal DROP InHouseIndividualCreditPermitNo;
ALTER TABLE tblTerminal DROP InHouseGroupCreditPermitNo;

ALTER TABLE tblCreditCardPayment ADD AdditionalCharge DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCreditCardPayment ADD ContactID BIGINT(20) NOT NULL DEFAULT 0;
ALTER TABLE tblCreditCardPayment ADD GuarantorID BIGINT(20) NOT NULL DEFAULT 0;
ALTER TABLE tblCreditCardPayment ADD TransactionDate DATETIME NOT NULL DEFAULT '1900-01-01';
UPDATE tblCreditCardPayment, tblTransactions
SET
	tblCreditCardPayment.TransactionDate = tblTransactions.TransactionDate
WHERE tblCreditCardPayment.BranchID = tblTransactions.BranchID
	AND tblCreditCardPayment.TerminalNo = tblTransactions.TerminalNo
	AND tblCreditCardPayment.TransactionNo = tblTransactions.TransactionNo;

ALTER TABLE tblCreditCardPayment ADD CashierName VARCHAR(150);
UPDATE tblCreditCardPayment, tblTransactions
SET
	tblCreditCardPayment.CashierName = tblTransactions.CashierName
WHERE tblCreditCardPayment.BranchID = tblTransactions.BranchID
	AND tblCreditCardPayment.TerminalNo = tblTransactions.TerminalNo
	AND tblCreditCardPayment.TransactionNo = tblTransactions.TransactionNo;

ALTER TABLE tblCreditPayment ADD CreditCardPaymentID BIGINT(20) NOT NULL DEFAULT 0;
ALTER TABLE tblCreditPayment ADD CreditCardTypeID INT(10) NOT NULL DEFAULT 0;

DELETE FROM sysConfig WHERE ConfigName = 'CreditVerificationSlipHeaderLabel';
INSERT INTO sysConfig (ConfigName, Category, ConfigValue) VALUES ('CreditVerificationSlipHeaderLabel',  'FE',								'{CardTypeName}');

ALTER TABLE tblCardTypes ADD `CreditFinanceCharge` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCardTypes ADD `CreditLatePenaltyCharge` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCardTypes ADD `CreditMinimumAmountDue` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCardTypes ADD `CreditMinimumPercentageDue` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCardTypes ADD `CreditFinanceCharge15th` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCardTypes ADD `CreditLatePenaltyCharge15th` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCardTypes ADD `CreditMinimumAmountDue15th` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCardTypes ADD `CreditMinimumPercentageDue15th` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCardTypes ADD `CreditCardType` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '-- 0 means external -- 1 means internal';
ALTER TABLE tblCardTypes ADD `WithGuarantor` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '-- 0 means not needed -- 1 means needed';

ALTER TABLE tblCardTypes ADD `CreditPurcStartDateToProcess` DATE NOT NULL DEFAULT '1900-01-01';
ALTER TABLE tblCardTypes ADD `CreditPurcEndDateToProcess` DATE NOT NULL DEFAULT '1900-01-01';
ALTER TABLE tblCardTypes ADD `CreditCutOffDate` DATE NOT NULL DEFAULT '1900-01-01';
ALTER TABLE tblCardTypes ADD `BillingDate` DATE NOT NULL DEFAULT '1900-01-01';
ALTER TABLE tblCardTypes ADD `CreditUseLastDayCutOffDate` INT(2) NOT NULL DEFAULT 0;

ALTER TABLE tblCreditPayment DROP `GuarantorID`;
ALTER TABLE tblCreditPayment DROP `CreditType`;
ALTER TABLE tblCreditPayment DROP `CreditExpiryDate`;

ALTER TABLE tblContactCreditCardInfo DROP `CreditType`;
ALTER TABLE tblContactCreditCardInfo ADD `CreditCardTypeID` INT(10) NOT NULL DEFAULT 0;

UPDATE tblContactCreditCardInfo SET CreditCardTypeID = (SELECT IFNULL(CardTypeID,0) FROM tblCardTypes WHERE CardTypeCode = 'HP SUPERCARD');

-- categorized the access for cleanup
UPDATE sysAccessTypes SET Category = '01: System Configurations' WHERE Category = 'System Configurations';
UPDATE sysAccessTypes SET Category = '05: Backend - MasterFiles - Products' WHERE Category = '05: Backend - MasterFiles - Product';
UPDATE sysAccessTypes SET Category = '07: Backend - Credits' WHERE Category = '11: Backend - MasterFiles';
UPDATE sysAccessTypes SET Category = '11: Backend - Inventory Reports' WHERE Category = '10: Backend - Inventory Reports';
UPDATE sysAccessTypes SET SequenceNo = 10, Category = '08: Backend - Customer Rewards' WHERE TypeID = 147;
UPDATE sysAccessTypes SET SequenceNo = 1, Category = '07: Backend - Credits' WHERE TypeID = 153;
UPDATE sysAccessTypes SET SequenceNo = 6, Category = '08: Backend - Customer Rewards' WHERE TypeID = 140;
UPDATE sysAccessTypes SET SequenceNo = 7, Category = '08: Backend - Customer Rewards' WHERE TypeID = 141;
UPDATE sysAccessTypes SET SequenceNo = 8, Category = '08: Backend - Customer Rewards' WHERE TypeID = 142;
UPDATE sysAccessTypes SET SequenceNo = 9, Category = '08: Backend - Customer Rewards' WHERE TypeID = 143;
UPDATE sysAccessTypes SET SequenceNo = 10, Category = '08: Backend - Customer Rewards' WHERE TypeID = 144;

UPDATE tblTerminal SET DBVersion = '4.0.1.2';	-- start update of marzan

ALTER TABLE tblTerminal ADD `WillPrintVoidItem` TINYINT (1) NOT NULL DEFAULT 0;

ALTER TABLE tblContactCreditCardInfo ADD `CreditBeginningBalance` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'Beginning Balance for Creditors w/ Guarantor';

ALTER TABLE tblTerminal MODIFY `IncludeCreditChargeAgreement` TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'Print Guarantor''s copy of chargeslip';

ALTER TABLE tblTerminal MODIFY `ShowCustomerSelection` TINYINT (1) NOT NULL DEFAULT 0 COMMENT 'Show customer selection or use swipe. If swipe, uses ContactAddDetWnd instead of ContactAddWnd. If Swipe credit will be disabled, only inhousecreditcard is enabled. ';

	/*****************************
	**	tblCreditPaymentCash
	*****************************/
	DROP TABLE IF EXISTS tblCreditPaymentCash;
	CREATE TABLE tblCreditPaymentCash (
		`CreditPaymentID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
		`CPRefTerminalNo` VARCHAR(5),
		`CPRefBranchID` INT(4) NOT NULL DEFAULT 0,
		`TransactionID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
		`Amount`  DECIMAL(18,3) NOT NULL DEFAULT 0,
		`Remarks` VARCHAR(255),
		`TransactionNo` VARCHAR(30),
		`CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
		`LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
		`CreditPaymentCashID` BIGINT(20) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
		`SyncID` BIGINT(20) NOT NULL DEFAULT 0,
		`TerminalNo` VARCHAR(5),
		`BranchID` INT(4) NOT NULL DEFAULT 0,
	INDEX `IX_tblCreditPaymentCash`(`TransactionID`),
	INDEX `IX1_tblCreditPaymentCash`(`Remarks`)
	);

	CREATE TRIGGER trgtblCreditPaymentCashCreatedOn BEFORE INSERT ON tblCreditPaymentCash FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
	CREATE INDEX IX_tblCreditPaymentCash_IXSync ON tblCreditPaymentCash (SyncID);

	/*****************************
	**	tblCreditPaymentCheque
	*****************************/
	DROP TABLE IF EXISTS tblCreditPaymentCheque;
	CREATE TABLE tblCreditPaymentCheque (
		`CreditPaymentID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
		`CPRefTerminalNo` VARCHAR(5),
		`CPRefBranchID` INT(4) NOT NULL DEFAULT 0,
		`TransactionID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
		`ChequeNo` VARCHAR(30) NOT NULL,
		`Amount`  DECIMAL(18,3) NOT NULL DEFAULT 0,
		`ValidityDate`	DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
		`Remarks` VARCHAR(255),
		`TransactionNo` VARCHAR(30),
		`CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
		`LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
		`CreditPaymentChequeID` BIGINT(20) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
		`SyncID` BIGINT(20) NOT NULL DEFAULT 0,
		`TerminalNo` VARCHAR(5),
		`BranchID` INT(4) NOT NULL DEFAULT 0,
	INDEX `IX_tblCreditPaymentCheque`(`TransactionID`),
	INDEX `IX1_tblCreditPaymentCheque`(`ChequeNo`),
	INDEX `IX2_tblCreditPaymentCheque`(`ValidityDate`),
	INDEX `IX3_tblCreditPaymentCheque`(`Remarks`)
	);

	ALTER TABLE tblDebitPayment ADD `BranchID` INT(4) UNSIGNED NOT NULL DEFAULT 0;
	ALTER TABLE tblDebitPayment ADD `TerminalNo` VARCHAR(5);

	CREATE TRIGGER trgtblCreditPaymentChequeCreatedOn BEFORE INSERT ON tblCreditPaymentCheque FOR EACH ROW SET NEW.CreatedOn = CURRENT_TIMESTAMP;
	CREATE INDEX IX_tblCreditPaymentCheque_IXSync ON tblCreditPaymentCheque (SyncID);

	ALTER TABLE tblProductSubGroup ADD `BarCodeCounter` BIGINT NOT NULL DEFAULT 0;

-- Automatically deposit the change of CreditPayment
-- selection: true, false
DELETE FROM sysConfig WHERE ConfigName = 'WillDepositChangeOfCreditPayment';
INSERT INTO sysConfig (ConfigName, Category, ConfigValue) VALUES ('WillDepositChangeOfCreditPayment',	'FE', 'false');

-- put the CreditPaymentType to be use in selecting creditpayment. Case sensitive
-- selection: Normal, Houseware, MPC
DELETE FROM sysConfig WHERE ConfigName = 'CreditPaymentType';
INSERT INTO sysConfig (ConfigName, Category, ConfigValue) VALUES ('CreditPaymentType',	'FE', 'MPC');

-- put the AllowDebitPayment to be use if debit payment is allowed
-- selection: true, false
DELETE FROM sysConfig WHERE ConfigName = 'AllowDebitPayment';
INSERT INTO sysConfig (ConfigName, Category, ConfigValue) VALUES ('AllowDebitPayment',	'FE', 'true');

-- put the AllowRewardPointsPayment to be use if reward points payment is allowed
-- selection: true, false
DELETE FROM sysConfig WHERE ConfigName = 'AllowRewardPointsPayment';
INSERT INTO sysConfig (ConfigName, Category, ConfigValue) VALUES ('AllowRewardPointsPayment',	'FE', 'true');

-- CreditReasonID
-- 0 - POS creditpayment. Default CreditReasonID
-- 1 - Credit Card w/out Guarantor Late Payment Charge
-- 2 - Credit Card w/out Guarantor Finance Charge
-- 5 - Credit Card with Guarantor Finance Charge
ALTER TABLE tblCreditPayment ADD `CreditReasonID` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0;

ALTER TABLE tblChargeType MODIFY ChargeType VARCHAR(30);

-- isExcluded for the charges if in-house CreditCard with Guarantor is used
ALTER TABLE tblProducts ADD IsCreditChargeExcluded TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'isExcluded for the charges if in-house CreditCard with Guarantor is used';
ALTER TABLE tblTransactionItems ADD IsCreditChargeExcluded TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'isExcluded for the charges if in-house CreditCard with Guarantor is used';

ALTER TABLE tblTransactions ADD `SNRItemsDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'SNR Items Discount';
ALTER TABLE tblTransactions ADD `PWDItemsDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'PWD Items Discount';
ALTER TABLE tblTransactions ADD `OtherItemsDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'Other items discount (not SNR & not PWD)';
ALTER TABLE tblTransactions MODIFY `ItemsDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'SNRItemsDiscount + PWDItemsDiscount + OtherItemsDiscount';
ALTER TABLE tblTransactions ADD `GrossSales` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'Price * Quantity';
ALTER TABLE tblTransactionItems ADD `GrossSales` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'Price * Quantity';

UPDATE tblTransactionItems SET GrossSales = Price * Quantity;

UPDATE tblTransactions,
	(SELECT TransactionID,
		SUM(CASE TransactionItemStatus
				WHEN 3 THEN -GrossSales	-- return
				WHEN 4 THEN -GrossSales	-- refund
				ELSE GrossSales
			END) AS GrossSales
	 FROM tblTransactionItems 
	 GROUP BY TransactionID
	) tblTransactionItems
SET tblTransactions.GrossSales = tblTransactionItems.GrossSales
WHERE tblTransactionItems.TransactionID = tblTransactions.TransactionID;

ALTER TABLE tblTerminalReport ADD `SNRItemsDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'SNR Items Discount';
ALTER TABLE tblTerminalReport ADD `PWDItemsDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'PWD Items Discount';
ALTER TABLE tblTerminalReport ADD `OtherItemsDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'Other items discount (not SNR & not PWD)';
ALTER TABLE tblTerminalReport MODIFY `ItemsDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'SNRItemsDiscount + PWDItemsDiscount + OtherItemsDiscount';

ALTER TABLE tblTerminalReportHistory ADD `SNRItemsDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'SNR Items Discount';
ALTER TABLE tblTerminalReportHistory ADD `PWDItemsDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'PWD Items Discount';
ALTER TABLE tblTerminalReportHistory ADD `OtherItemsDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'Other items discount (not SNR & not PWD)';
ALTER TABLE tblTerminalReportHistory MODIFY `ItemsDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'SNRItemsDiscount + PWDItemsDiscount + OtherItemsDiscount';

ALTER TABLE tblCashierReport ADD `SNRItemsDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'SNR Items Discount';
ALTER TABLE tblCashierReport ADD `PWDItemsDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'PWD Items Discount';
ALTER TABLE tblCashierReport ADD `OtherItemsDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'Other items discount (not SNR & not PWD)';
ALTER TABLE tblCashierReport MODIFY `ItemsDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'SNRItemsDiscount + PWDItemsDiscount + OtherItemsDiscount';

ALTER TABLE tblCashierReportHistory ADD `SNRItemsDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'SNR Items Discount';
ALTER TABLE tblCashierReportHistory ADD `PWDItemsDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'PWD Items Discount';
ALTER TABLE tblCashierReportHistory ADD `OtherItemsDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'Other items discount (not SNR & not PWD)';
ALTER TABLE tblCashierReportHistory MODIFY `ItemsDiscount` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'SNRItemsDiscount + PWDItemsDiscount + OtherItemsDiscount';

ALTER TABLE tblTransactions ADD PARTITION (
		PARTITION p2015 VALUES LESS THAN (2015) (
			SUBPARTITION sJan2015,
			SUBPARTITION sFeb2015,
			SUBPARTITION sMar2015,
			SUBPARTITION sApr2015,
			SUBPARTITION sMay2015,
			SUBPARTITION sJun2015,
			SUBPARTITION sJul2015,
			SUBPARTITION sAug2015,
			SUBPARTITION sSep2015,
			SUBPARTITION sOct2015,
			SUBPARTITION sNov2015,
			SUBPARTITION sDec2015) ) ;

/*********************************  v_4.0.1.2.sql END  *******************************************************/ 

/*********************************  v_4.0.1.3.sql START  *******************************************************/ 

UPDATE tblTerminal SET DBVersion = '4.0.1.3';

/*****************************
**	tblMergeTable
*****************************/
DROP TABLE IF EXISTS tblMergeTable;
CREATE TABLE tblMergeTable (
	`MergeTableID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`MainTableCode` VARCHAR(25) NOT NULL,
	`ChildTableCode` VARCHAR(25) NOT NULL,
	PRIMARY KEY (MergeTableID),
	INDEX `IX_tblMergeTable`(`MergeTableID`),
	INDEX `IX1_tblMergeTable`(`MainTableCode`)
);

ALTER TABLE tblTerminal MODIFY AccreditationNo VARCHAR(50) NOT NULL COMMENT 'Current BIR Length = 23';

ALTER TABLE tblCardTypes ADD `ExemptInTerminalCharge` TINYINT(1) NOT NULL DEFAULT 0;


/*********************************  v_4.0.1.3.sql END  *******************************************************/ 


UPDATE tblTerminal SET DBVersion = '4.0.1.12';

ALTER TABLE tblTransactions ADD RewardsCustomerID BIGINT(20) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions ADD RewardsCustomerName VARCHAR(100) NOT NULL DEFAULT 0;

UPDATE tblTransactions SET RewardsCustomerID = CustomerID, RewardsCustomerName=CustomerName  WHERE TransactionDate <= '2014-12-01 23:59';

UPDATE tblTerminalReportHistory SET BeginningTransactionNo = '00000000000000', EndingTransactionNo = '00000000000000' 
WHERE BeginningTransactionNo = '00000000000001' AND EndingTransactionNo = '00000000000001';

UPDATE tblTerminalReportHistory SET BeginningTransactionNo = '00000000000000', EndingTransactionNo = '00000000000000' 
WHERE BeginningTransactionNo = '00000000000000' AND EndingTransactionNo = '00000000000001';

/*********************************  v_4.0.1.12.sql END  *******************************************************/ 

UPDATE tblTerminal SET DBVersion = '4.0.1.14';

DROP TRIGGER IF EXISTS trgr_tblProductInventory_Update;
DROP TRIGGER IF EXISTS trgr_tblProductInventory_Insert;
DROP TRIGGER IF EXISTS trgr_tblContacts_Update;
DROP TRIGGER IF EXISTS trgr_tblContacts_Insert;
DROP TRIGGER IF EXISTS trgr_tblProducts_Update;

DROP TRIGGER IF EXISTS trgtblTransactionsCreatedOn;
DROP TRIGGER IF EXISTS trgtblTransactionItemsCreatedOn;

ALTER TABLE tblTransactions MODIFY `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE tblTransactionItems MODIFY `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE tblTransactionItems ADD `RewardPoints` DECIMAL(18,3) NOT NULL DEFAULT 0;

ALTER TABLE tblProductPackage DROP INDEX `IX_tblProductPackage_Barcode`;
ALTER TABLE tblProductPackage DROP INDEX `IX3_tblProductPackage`;

CREATE INDEX IX_tblProductPackage_Barcode4 ON tblProductPackage (Barcode4);

ALTER TABLE tblContactCreditCardInfo DROP INDEX `IX_tblContactCreditCardInfo`;
ALTER TABLE tblContactCreditCardInfo DROP INDEX `IX_tblContactCreditCardInfo1`;
ALTER TABLE tblContactCreditCardInfo DROP INDEX `IX_tblContactCreditCardInfo2`;

CREATE INDEX IX4_tblTransactions ON tblTransactions (BranchID);

ALTER TABLE tblProductInventory DROP INDEX `IX_tblProductInventory`;
ALTER TABLE tblProductInventory DROP INDEX `IX_tblProductInventory_PID`;
ALTER TABLE tblProductInventory DROP INDEX `IX_tblProductInventory_PBID`;

ALTER TABLE tblContactRewards DROP INDEX `IX_tblContactRewards`;
ALTER TABLE tblContactRewards DROP INDEX `IX_tblContactRewards1`;
ALTER TABLE tblContactRewards DROP INDEX `IX_tblContactRewards2`;

ALTER TABLE tblContacts DROP INDEX `IX_tblContacts`;
CREATE INDEX IX_tblContacts ON tblContacts (Contactname);

ALTER TABLE sysAccessUsers DROP INDEX `IX_sysAccessUser`;
ALTER TABLE sysAccessUserDetails DROP INDEX `IX_sysAccessUserDetails`;
CREATE INDEX IX_sysAccessUserDetails ON sysAccessUserDetails (Name);

CREATE INDEX IX_tblTerminalReport_BeginningTransactionNo ON tblTerminalReport (BeginningTransactionNo);
CREATE INDEX IX_tblTerminalReport_EndingTransactionNo ON tblTerminalReport (EndingTransactionNo);
CREATE INDEX IX_tblTerminalReportHistory_BeginningTransactionNo ON tblTerminalReportHistory (BeginningTransactionNo);
CREATE INDEX IX_tblTerminalReportHistory_EndingTransactionNo ON tblTerminalReportHistory (EndingTransactionNo);
CREATE INDEX IX_tblCashierReport_BeginningTransactionNo ON tblCashierReport (BeginningTransactionNo);
CREATE INDEX IX_tblCashierReport_EndingTransactionNo ON tblCashierReport (EndingTransactionNo);
CREATE INDEX IX_tblCashierReportHistory_BeginningTransactionNo ON tblCashierReportHistory (BeginningTransactionNo);
CREATE INDEX IX_tblCashierReportHistory_EndingTransactionNo ON tblCashierReportHistory (EndingTransactionNo);

CREATE INDEX IX_tblTransactions_TerminalNo ON tblTransactions (TerminalNo);

/*********************************  v_4.0.1.14.sql END  *******************************************************/ 

UPDATE tblTerminal SET DBVersion = '4.0.1.21';

DROP TRIGGER IF EXISTS trgtblCreditPaymentCashCreatedOn;
ALTER TABLE tblCreditPaymentCash MODIFY `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

DROP TRIGGER IF EXISTS trgtblCreditPaymentCreatedOn;
ALTER TABLE tblCreditPayment MODIFY `LastModified` TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

-- put the AllowRewardPointsPayment to be use if reward points payment is allowed
-- selection: true, false
DELETE FROM sysConfig WHERE ConfigName = 'AllowDiscountGreaterThanAmount';
INSERT INTO sysConfig (ConfigName, Category, ConfigValue) VALUES ('AllowDiscountGreaterThanAmount',	'FE', 'true');

/*********************************  v_4.0.1.21.sql END  *******************************************************/ 

UPDATE tblTerminal SET DBVersion = '4.0.1.22';


ALTER TABLE tblContactCreditCardInfo ADD Last2BillingDate DATE NOT NULL DEFAULT '1900-01-01';

ALTER TABLE tblContacts ADD SequenceNo INT(10) NOT NULL DEFAULT 0;
UPDATE tblContacts SET SequenceNo = ContactID;

DELETE FROM sysAccessRights WHERE TranTypeID = 171; DELETE FROM sysAccessGroupRights WHERE TranTypeID = 171;
DELETE FROM sysAccessTypes WHERE TypeID = 171;
INSERT INTO sysAccessTypes (TypeID, TypeName, Enabled) VALUES (171, 'Change Order Type (DineIn/Take-Out/Delivery)', 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 171, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 171, 1, 1);
UPDATE sysAccessTypes SET SequenceNo = 23, Category = '14: Frontend - Cashiering' WHERE TypeID = 171;

/*********************************  v_4.0.1.22.sql END  *******************************************************/ 


UPDATE tblTerminal SET DBVersion = '4.0.1.23';


ALTER TABLE tblTransactions ADD PARTITION (
		PARTITION p2016 VALUES LESS THAN (2016) (
			SUBPARTITION sJan2016,
			SUBPARTITION sFeb2016,
			SUBPARTITION sMar2016,
			SUBPARTITION sApr2016,
			SUBPARTITION sMay2016,
			SUBPARTITION sJun2016,
			SUBPARTITION sJul2016,
			SUBPARTITION sAug2016,
			SUBPARTITION sSep2016,
			SUBPARTITION sOct2016,
			SUBPARTITION sNov2016,
			SUBPARTITION sDec2016) ) ;


ALTER TABLE tblTransactions ADD PARTITION (
		PARTITION p2017 VALUES LESS THAN (2017) (
			SUBPARTITION sJan2017,
			SUBPARTITION sFeb2017,
			SUBPARTITION sMar2017,
			SUBPARTITION sApr2017,
			SUBPARTITION sMay2017,
			SUBPARTITION sJun2017,
			SUBPARTITION sJul2017,
			SUBPARTITION sAug2017,
			SUBPARTITION sSep2017,
			SUBPARTITION sOct2017,
			SUBPARTITION sNov2017,
			SUBPARTITION sDec2017) ) ;

/*********************************  v_4.0.1.23.sql END  *******************************************************/ 

UPDATE tblTerminal SET DBVersion = '4.0.1.24';

ALTER TABLE tblTransactions ADD `isZeroRated` TINYINT(1) NOT NULL DEFAULT 0;

ALTER TABLE tblTransactions ADD `ZeroRatedSales` DECIMAL(18,3) NOT NULL DEFAULT 0;
UPDATE tblTransactions SET ZeroRatedSales=SubTotal, VATableAmount=0, VAT=0 WHERE isZeroRated = 1;

ALTER TABLE tblTerminalReport ADD `ZeroRatedSales` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'Use for ZeroRated';
ALTER TABLE tblTerminalReportHistory ADD `ZeroRatedSales` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'Use for ZeroRated';
ALTER TABLE tblCashierReport ADD `ZeroRatedSales` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'Use for ZeroRated';
ALTER TABLE tblCashierReportHistory ADD `ZeroRatedSales` DECIMAL(18,3) NOT NULL DEFAULT 0 COMMENT 'Use for ZeroRated';

ALTER TABLE tblTransactions DROP `ZeroRatedVAT`;
ALTER TABLE tblTransactionItems DROP `ZeroRatedVAT`;
ALTER TABLE tblTerminalReport DROP `ZeroRatedVAT`;
ALTER TABLE tblTerminalReportHistory DROP `ZeroRatedVAT`;
ALTER TABLE tblCashierReport DROP `ZeroRatedVAT`;
ALTER TABLE tblCashierReportHistory DROP `ZeroRatedVAT`;

/*********************************  v_4.0.1.24.sql END  *******************************************************/ 

UPDATE tblTerminal SET DBVersion = '4.0.1.25';
UPDATE tblTerminal SET DBVersion = '4.0.1.26'; -- update the BranchWnd.cs CTRL + SHIFT + Enter
UPDATE tblTerminal SET DBVersion = '4.0.1.27'; -- update the BranchWnd.cs and Program.cs automatic update MachineSerialNo and AccreditationNo in config file
UPDATE tblTerminal SET DBVersion = '4.0.1.28'; -- update the CreditVerification F8

/*********************************  v_4.0.1.28.sql END  *******************************************************/ 

UPDATE tblTerminal SET DBVersion = '4.0.1.29';

ALTER TABLE tblProducts DROP `OrderSlipPrinter1`;
ALTER TABLE tblProducts DROP `OrderSlipPrinter2`;
ALTER TABLE tblProducts DROP `OrderSlipPrinter3`;
ALTER TABLE tblProducts DROP `OrderSlipPrinter4`;
ALTER TABLE tblProducts DROP `OrderSlipPrinter5`;

ALTER TABLE tblProducts ADD `OrderSlipPrinter1` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblProducts ADD `OrderSlipPrinter2` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblProducts ADD `OrderSlipPrinter3` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblProducts ADD `OrderSlipPrinter4` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblProducts ADD `OrderSlipPrinter5` TINYINT(1) NOT NULL DEFAULT 0;

UPDATE tblProducts 
INNER JOIN tblProductSubGroup ON tblProductSubGroup.ProductSubGroupID = tblProducts.ProductSubGroupID
INNER JOIN tblProductGroup ON tblProductGroup.ProductGroupID = tblProductSubGroup.ProductGroupID
SET OrderSlipPrinter1 = CASE OrderSlipPrinter WHEN 0 THEN 1 ELSE 0 END,
    OrderSlipPrinter2 = CASE OrderSlipPrinter WHEN 1 THEN 1 ELSE 0 END,
	OrderSlipPrinter3 = CASE OrderSlipPrinter WHEN 2 THEN 1 ELSE 0 END,
	OrderSlipPrinter4 = CASE OrderSlipPrinter WHEN 3 THEN 1 ELSE 0 END,
	OrderSlipPrinter5 = CASE OrderSlipPrinter WHEN 4 THEN 1 ELSE 0 END;

ALTER TABLE tblTransactionItems ADD `OrderSlipPrinter1` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems ADD `OrderSlipPrinter2` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems ADD `OrderSlipPrinter3` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems ADD `OrderSlipPrinter4` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactionItems ADD `OrderSlipPrinter5` TINYINT(1) NOT NULL DEFAULT 0;

UPDATE tblTransactionItems SET OrderSlipPrinter1 = OrderSlipPrinter;
ALTER TABLE tblTransactionItems DROP OrderSlipPrinter;
ALTER TABLE tblProductGroup DROP OrderSlipPrinter;


/*********************************  v_4.0.1.29.sql END  *******************************************************/ 

UPDATE tblTerminal SET DBVersion = '4.0.1.30';

ALTER TABLE tblTransactionItems ADD `ItemRemarks` VARCHAR(80);

UPDATE tblCashPayment 
INNER JOIN tblTransactions ON tblCashPayment.TransactionID = tblTransactions.TransactioNID
SET tblCashPayment.CreatedOn = tblTransactions.TransactionDate WHERE DATE_FORMAT(tblCashPayment.CreatedOn, '%Y-%m-%d') = '1900-01-01';

UPDATE tblCreditPayment SET CreatedOn = CreditDate WHERE DATE_FORMAT(CreatedOn, '%Y-%m-%d') = '1900-01-01';
UPDATE tblCreditCardPayment SET CreatedOn = TransactionDate WHERE DATE_FORMAT(CreatedOn, '%Y-%m-%d') = '1900-01-01';

/*********************************  v_4.0.1.30.sql END  *******************************************************/ 

UPDATE tblTerminal SET DBVersion = '4.0.1.31';

INSERT INTO sysAccessTypes (TypeID, TypeName, Enabled) VALUES (172, 'Change OSPrinter', 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 172, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 172, 1, 1);
UPDATE sysAccessTypes SET SequenceNo = 10, Category = '05: Backend - MasterFiles - Products' WHERE TypeID = 172;

DELETE FROM sysAccessTypes WHERE TypeID = 173;
INSERT INTO sysAccessTypes (TypeID, TypeName, Enabled) VALUES (173, 'Print Shelves/Tag Price', 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 173, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 173, 1, 1);
UPDATE sysAccessTypes SET SequenceNo = 11, Category = '05: Backend - MasterFiles - Products' WHERE TypeID = 173;
	
-- this will determine if the report will show in eSales Report / BIR
ALTER TABLE tblTerminal ADD IncludeIneSales TINYINT(1) NOT NULL DEFAULT 1;
ALTER TABLE tblTerminalReport ADD IncludeIneSales TINYINT(1) NOT NULL DEFAULT 1;
ALTER TABLE tblTerminalReportHistory ADD IncludeIneSales TINYINT(1) NOT NULL DEFAULT 1;

-- Jan 31, 2015
UPDATE tblTerminal SET IncludeIneSales = 0 WHERE TerminalID >= 80;
UPDATE tblTerminalReport SET IncludeIneSales = 0 WHERE TerminalID >= 80;
UPDATE tblTerminalReportHistory SET IncludeIneSales = 0 WHERE TerminalID >= 80;

ALTER TABLE tblBranch ADD IncludeIneSales TINYINT(1) NOT NULL DEFAULT 1;


/*********************************  v_4.0.1.31.sql END  *******************************************************/ 

UPDATE tblTerminal SET DBVersion = '4.0.1.32';

DELETE FROM sysAccessTypes WHERE TypeID = 174;
INSERT INTO sysAccessTypes (TypeID, TypeName, Enabled) VALUES (174, 'Zero Out Branch Inventory', 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 174, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 174, 1, 1);
UPDATE sysAccessTypes SET SequenceNo = 11, Category = '11: Data Collector' WHERE TypeID = 174;
	

-- put the isDefaultButtonYesInPrintTransaction to be use when default button is yes = true
-- selection: true, false
DELETE FROM sysConfig WHERE ConfigName = 'isDefaultButtonYesInPrintTransaction';
INSERT INTO sysConfig (ConfigName, Category, ConfigValue) VALUES ('isDefaultButtonYesInPrintTransaction',	'FE', 'false');

-- put the AllowZeroAmountTransaction to be use when closing transaction
-- selection: 
--		true	- allow
--		false	- do not allow
-- default true:
DELETE FROM sysConfig WHERE ConfigName = 'AllowZeroAmountTransaction';
INSERT INTO sysConfig (ConfigName, Category, ConfigValue) VALUES ('AllowZeroAmountTransaction',	'FE', 'true');
-- INSERT INTO sysConfig (ConfigName, Category, ConfigValue) VALUES ('AllowZeroAmountTransaction',	'FE', 'false');

-- put the AllowMoreThan1ItemIfConsignment to be use when closing transaction
-- selection: 
--		true	- allow
--		false	- do not allow
-- default true:
DELETE FROM sysConfig WHERE ConfigName = 'AllowMoreThan1ItemIfConsignment';
INSERT INTO sysConfig (ConfigName, Category, ConfigValue) VALUES ('AllowMoreThan1ItemIfConsignment',	'FE', 'false');

-- put the AllowMoreThan1ItemIfConsignment to be use when closing transaction
-- selection: 
--		true	- yes will process in program
--		false	- no will process in event.sql
-- default true:
DELETE FROM sysConfig WHERE ConfigName = 'WillProcessCreditBillerInProgram';
INSERT INTO sysConfig (ConfigName, Category, ConfigValue) VALUES ('WillProcessCreditBillerInProgram',	'Biller', 'false');

/*********************************  v_4.0.1.32.sql END  *******************************************************/ 

UPDATE tblTerminal SET DBVersion = '4.0.1.33';

ALTER TABLE tblTransactions ADD `ModeOfTerms` INT(10) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions ADD `Terms` INT(10) NOT NULL DEFAULT 0;
ALTER TABLE tblTransactions ADD `CRNo` BIGINT(20) NOT NULL DEFAULT 0;


DELETE FROM sysConfig WHERE ConfigName = 'OutOfStockCustomerCode';
INSERT INTO sysConfig (ConfigName, Category, ConfigValue) VALUES ('OutOfStockCustomerCode',		'FE',						'OUT OF STOCK');

DELETE FROM sysConfig WHERE ConfigName = 'WalkInCustomerCode';
INSERT INTO sysConfig (ConfigName, Category, ConfigValue) VALUES ('WalkInCustomerCode',			'FE',						'WALK-IN');


-- 25Feb2015 :	As requested by MPC
--				Consignment does not issue OR. Consignment is only Paid by CreditPayment
--				Once consignment is collected it is paid using {Shift + Enter} or Credit Payment
ALTER TABLE tblTerminalReport ADD `NoOfConsignmentTransactions` INT(10) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReport ADD `NoOfConsignmentRefundTransactions` INT(10) NOT NULL DEFAULT 0;

-- 25Feb2015 :	As requested by MPC
--				WalkIn does not issue OR. WalkIn is only Paid by Cash
--				WalkIn is not reflected as sales coz those are invalid transactions
ALTER TABLE tblTerminalReport ADD `NoOfWalkInTransactions` INT(10) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReport ADD `NoOfWalkInRefundTransactions` INT(10) NOT NULL DEFAULT 0;

-- 25Feb2015 :	As requested by MPC
--				OutOfStock does not issue OR. OutOfStock is only Paid by Cash
--				WalkIn is not reflected as sales coz those are invalid transactions
ALTER TABLE tblTerminalReport ADD `NoOfOutOfStockTransactions` INT(10) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReport ADD `NoOfOutOfStockRefundTransactions` INT(10) NOT NULL DEFAULT 0;

ALTER TABLE tblTerminalReport ADD `ConsignmentSales` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReport ADD `ConsignmentRefundSales` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReport ADD `WalkInSales` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReport ADD `WalkInRefundSales` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReport ADD `OutOfStockSales` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReport ADD `OutOfStockRefundSales` DECIMAL(18,3) NOT NULL DEFAULT 0;

ALTER TABLE tblTerminalReportHistory ADD `NoOfConsignmentTransactions` INT(10) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReportHistory ADD `NoOfConsignmentRefundTransactions` INT(10) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReportHistory ADD `NoOfWalkInTransactions` INT(10) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReportHistory ADD `NoOfWalkInRefundTransactions` INT(10) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReportHistory ADD `NoOfOutOfStockTransactions` INT(10) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReportHistory ADD `NoOfOutOfStockRefundTransactions` INT(10) NOT NULL DEFAULT 0;

ALTER TABLE tblTerminalReportHistory ADD `ConsignmentSales` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReportHistory ADD `ConsignmentRefundSales` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReportHistory ADD `WalkInSales` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReportHistory ADD `WalkInRefundSales` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReportHistory ADD `OutOfStockSales` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReportHistory ADD `OutOfStockRefundSales` DECIMAL(18,3) NOT NULL DEFAULT 0;

ALTER TABLE tblCashierReport ADD `NoOfConsignmentTransactions` INT(10) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReport ADD `NoOfConsignmentRefundTransactions` INT(10) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReport ADD `NoOfWalkInTransactions` INT(10) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReport ADD `NoOfWalkInRefundTransactions` INT(10) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReport ADD `NoOfOutOfStockTransactions` INT(10) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReport ADD `NoOfOutOfStockRefundTransactions` INT(10) NOT NULL DEFAULT 0;

ALTER TABLE tblCashierReport ADD `ConsignmentSales` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReport ADD `ConsignmentRefundSales` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReport ADD `WalkInSales` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReport ADD `WalkInRefundSales` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReport ADD `OutOfStockSales` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReport ADD `OutOfStockRefundSales` DECIMAL(18,3) NOT NULL DEFAULT 0;

ALTER TABLE tblCashierReportHistory ADD `NoOfConsignmentTransactions` INT(10) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReportHistory ADD `NoOfConsignmentRefundTransactions` INT(10) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReportHistory ADD `NoOfWalkInTransactions` INT(10) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReportHistory ADD `NoOfWalkInRefundTransactions` INT(10) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReportHistory ADD `NoOfOutOfStockTransactions` INT(10) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReportHistory ADD `NoOfOutOfStockRefundTransactions` INT(10) NOT NULL DEFAULT 0;

ALTER TABLE tblCashierReportHistory ADD `ConsignmentSales` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReportHistory ADD `ConsignmentRefundSales` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReportHistory ADD `WalkInSales` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReportHistory ADD `WalkInRefundSales` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReportHistory ADD `OutOfStockSales` DECIMAL(18,3) NOT NULL DEFAULT 0;
ALTER TABLE tblCashierReportHistory ADD `OutOfStockRefundSales` DECIMAL(18,3) NOT NULL DEFAULT 0;

UPDATE tblTransactions SET ORNo = TransactionNo WHERE TransactionStatus IN (1,5,11) AND IFNULL(ORNo,'') = '';

ALTER TABLE tblProductPackage ADD Price1 DECIMAL(18,3) DEFAULT 0;
ALTER TABLE tblProductPackage ADD Price2 DECIMAL(18,3) DEFAULT 0;
ALTER TABLE tblProductPackage ADD Price3 DECIMAL(18,3) DEFAULT 0;
ALTER TABLE tblProductPackage ADD Price4 DECIMAL(18,3) DEFAULT 0;
ALTER TABLE tblProductPackage ADD Price5 DECIMAL(18,3) DEFAULT 0;


ALTER TABLE tblProductPackagePriceHistory ADD Price1Before DECIMAL(18,3) DEFAULT 0;
ALTER TABLE tblProductPackagePriceHistory ADD Price2Before DECIMAL(18,3) DEFAULT 0;
ALTER TABLE tblProductPackagePriceHistory ADD Price3Before DECIMAL(18,3) DEFAULT 0;
ALTER TABLE tblProductPackagePriceHistory ADD Price4Before DECIMAL(18,3) DEFAULT 0;
ALTER TABLE tblProductPackagePriceHistory ADD Price5Before DECIMAL(18,3) DEFAULT 0;

ALTER TABLE tblProductPackagePriceHistory ADD Price1Now DECIMAL(18,3) DEFAULT 0;
ALTER TABLE tblProductPackagePriceHistory ADD Price2Now DECIMAL(18,3) DEFAULT 0;
ALTER TABLE tblProductPackagePriceHistory ADD Price3Now DECIMAL(18,3) DEFAULT 0;
ALTER TABLE tblProductPackagePriceHistory ADD Price4Now DECIMAL(18,3) DEFAULT 0;
ALTER TABLE tblProductPackagePriceHistory ADD Price5Now DECIMAL(18,3) DEFAULT 0;

/*********************************  v_4.0.1.33.sql END  *******************************************************/ 

UPDATE tblTerminal SET DBVersion = '4.0.1.34';

-- 02Mar2015 :	Change the way DebitPayment is handled. 
--				DebitPayment is currently use by MPC.
ALTER TABLE tblDebitPayment ADD DebitPaymentID BIGINT(20) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT;
ALTER TABLE tblDebitPayment ADD SyncID BIGINT(20) NOT NULL DEFAULT 0;
UPDATE tblDebitPayment SET SyncID = DebitPaymentID WHERE SyncID = 0;
UPDATE tblDebitPayment SET BranchID = 1 WHERE BranchID = 0;
UPDATE tblDebitPayment SET TerminalNo = '01' WHERE IFNULL(TerminalNo,'') = '';

-- 02Mar2015 :	Modify the ProductGroup from VARCHAR(20) to VARCHAR(50)
--				some items will encounter error if this is not set.
ALTER TABLE tblTransactionItems MODIFY ProductGroup VARCHAR(50) NOT NULL DEFAULT '';

-- 03Mar2015 :	Add to hold the TIN and LTO No (BFAD No)
--				this should only be asked if customer is drugstore.
ALTER TABLE tblContacts ADD TINNo VARCHAR(20) DEFAULT '';
ALTER TABLE tblContacts ADD LTONo VARCHAR(20) DEFAULT '';

/*********************************  v_4.0.1.34.sql END  *******************************************************/ 

UPDATE tblTerminal SET DBVersion = '4.0.1.35';

-- 05Mar2015 : HP; put KG, KILO as 1 Quantity Only
-- put the WillConvertWeightMeasurementTo1InQtySold to be use when printing the Qty Sold
-- selection: 
--		true	- if will convert
--		false	- if will not convert
-- default true:
DELETE FROM sysConfig WHERE ConfigName = 'WillConvertWeightMeasurementTo1InQtySold';
INSERT INTO sysConfig (ConfigName, Category, ConfigValue) VALUES ('WillConvertWeightMeasurementTo1InQtySold',	'FE', 'true');

DELETE FROM sysConfig WHERE ConfigName = 'WeightMeasurement';
INSERT INTO sysConfig (ConfigName, Category, ConfigValue) VALUES ('WeightMeasurement',	'FE', 'GAL,GALLON,KL,KILO,KG,KILOGRAM,GRM,GRAM,GRAMS');


-- 05Mar2015 : MPC; put the acceptable no of days for cheque payment
--				default is 180 days and below meaning if today is March 5, 2015 valid is from October 6, 2014 onwards
DELETE FROM sysConfig WHERE ConfigName = 'ChequePaymentAcceptableNoOfDays';
INSERT INTO sysConfig (ConfigName, Category, ConfigValue) VALUES ('ChequePaymentAcceptableNoOfDays',	'FE', '365');


DELETE FROM sysAccessTypes WHERE TypeID = 175;
INSERT INTO sysAccessTypes (TypeID, TypeName, Enabled) VALUES (175, 'Summarized DailySales WithTF Detailed', 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 175, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 175, 1, 1);
UPDATE sysAccessTypes SET SequenceNo = 1, Category = '11: Backend - eSales Reports' WHERE TypeID = 175;

UPDATE sysAccessTypes SET SequenceNo = 2, Category = '11: Backend - eSales Reports' WHERE TypeID = 149;

DELETE FROM sysAccessTypes WHERE TypeID = 176;
INSERT INTO sysAccessTypes (TypeID, TypeName, Enabled) VALUES (176, 'Print Check Out Bill', 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 176, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 176, 1, 1);
UPDATE sysAccessTypes SET SequenceNo = 10, Category = '14: Frontend - Cashiering' WHERE TypeID = 176;

DELETE FROM sysAccessTypes WHERE TypeID = 177;
INSERT INTO sysAccessTypes (TypeID, TypeName, Enabled) VALUES (177, 'Resume SuspendedOpen Transaction', 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 177, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 177, 1, 1);
UPDATE sysAccessTypes SET SequenceNo = 4, Category = '14: Frontend - Cashiering' WHERE TypeID = 177;

/*********************************  v_4.0.1.35.sql END  *******************************************************/ 

UPDATE tblTerminal SET DBVersion = '4.0.1.36';

ALTER TABLE tblContacts ADD PriceLevel INT(2) NOT NULL DEFAULT 0;

ALTER TABLE tblContacts MODIFY TINNo VARCHAR(20) DEFAULT '';
ALTER TABLE tblContacts MODIFY LTONo VARCHAR(20) DEFAULT '';


/*********************************  v_4.0.1.36.sql END  *******************************************************/ 

UPDATE tblTerminal SET DBVersion = '4.0.1.37';

DELETE FROM sysAccessTypes WHERE TypeID = 178;
INSERT INTO sysAccessTypes (TypeID, TypeName, Enabled) VALUES (178, 'Change Customer''s Price Level', 1);
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 178, 1, 1);
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) VALUES (1, 178, 1, 1);
UPDATE sysAccessTypes SET SequenceNo = 7, Category = '04: Backend - MasterFiles' WHERE TypeID = 178;

-- 13Mar2015 : MPC; EnablePriceLevel so that when a customer is selected, it will get the price level of each punched product again
-- default		- false
-- selection: 
--		true	- will refetch then recompute
--		false	- will not refetch
DELETE FROM sysConfig WHERE ConfigName = 'EnablePriceLevel';
INSERT INTO sysConfig (ConfigName, Category, ConfigValue) VALUES ('EnablePriceLevel',	'FE', 'false');


/*********************************  v_4.0.1.37.sql END  *******************************************************/ 

UPDATE tblTerminal SET DBVersion = '4.0.1.38';


/****
-- 23Mar2015 : HP, AppplyORNo
-- default		- false
-- selection: 
--		true	- will use same branch OR series
--		false	- will have a per terminal OR series
ALTER TABLE tblTerminal ADD UseBranchORSeries TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReport ADD UseBranchORSeries TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReportHistory ADD UseBranchORSeries TINYINT(1) NOT NULL DEFAULT 0;

ALTER TABLE tblTerminal DROP UseBranchORSeries;
ALTER TABLE tblTerminalReport DROP UseBranchORSeries;
ALTER TABLE tblTerminalReportHistory DROP UseBranchORSeries;

****/

-- 23Mar2015 : HP, For Terminal's with Only 1 ORNoSeries 
ALTER TABLE tblTerminal ADD ORSeriesBranchID INT(4) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReport ADD ORSeriesBranchID INT(4) NOT NULL DEFAULT 0;
ALTER TABLE tblTerminalReportHistory ADD ORSeriesBranchID INT(4) NOT NULL DEFAULT 0;

UPDATE tblTerminal SET ORSeriesBranchID = BranchID;
UPDATE tblTerminalReport SET ORSeriesBranchID = BranchID;
UPDATE tblTerminalReportHistory SET ORSeriesBranchID = BranchID;
--	   HP : UPDATE tblTerminal SET ORSeriesBranchID = 1 WHERE TerminalNo >= 3 AND TerminalNo <= 22;
--	   HP : UPDATE tblTerminalReport SET ORSeriesBranchID = 1 WHERE TerminalNo >= 3 AND TerminalNo <= 22;

-- 23Mar2015 : HP, For Terminal's with Only 1 ORNoSeries 
ALTER TABLE tblTerminal ADD ORSeriesTerminalNo VARCHAR(10) NOT NULL DEFAULT '';
ALTER TABLE tblTerminalReport ADD ORSeriesTerminalNo VARCHAR(10) NOT NULL DEFAULT '';
ALTER TABLE tblTerminalReportHistory ADD ORSeriesTerminalNo VARCHAR(10) NOT NULL DEFAULT '';
UPDATE tblTerminal SET ORSeriesTerminalNo = TerminalNo;
UPDATE tblTerminalReport SET ORSeriesTerminalNo = TerminalNo;
UPDATE tblTerminalReportHistory SET ORSeriesTerminalNo = TerminalNo;
--	   HP : UPDATE tblTerminal SET ORSeriesTerminalNo = '03' WHERE TerminalNo >= 3 AND TerminalNo <= 22;
--	   HP : UPDATE tblTerminalReport SET ORSeriesTerminalNo = '03' WHERE TerminalNo >= 3 AND TerminalNo <= 22;
--	   HP : UPDATE tblTerminal SET ORSeriesBranchID = 1 WHERE TerminalNo >= 3 AND TerminalNo <= 22;
--	   HP : UPDATE tblTerminalReport SET ORSeriesBranchID = 1 WHERE TerminalNo >= 3 AND TerminalNo <= 22;
--	   HP : UPDATE tblTerminalReport SET EndingORNo = '00000000059031' WHERE TerminalNo >= 3 AND TerminalNo <= 22;



/*********************************  v_4.0.1.38.sql END  *******************************************************/ 

UPDATE tblTerminal SET DBVersion = '4.0.1.39';

-- 07Apr2015 : CashierReports.GeneratePLUReport add new line so that those products without OrderSlipPrinter will be defaulted to OrderSlipPrinter1
UPDATE tblTerminal SET DBVersion = '4.0.1.40';

-- 15Apr2015 : Add FirstPayment of the billingperiod
ALTER TABLE tblContactCreditCardInfo ADD FirstPaymentDateBillPeriod DATE DEFAULT '1900-01-01';

/*********************************  v_4.0.1.40.sql END  *******************************************************/ 

UPDATE tblTerminal SET DBVersion = '4.0.1.41';

-- 21Apr2015 : Fix bug when no items is punched and customer select is done first.

-- Look at credit.sql

/*********************************  v_4.0.1.41.sql END  *******************************************************/ 

UPDATE tblTerminal SET DBVersion = '4.0.1.42';

-- Separate the reporting for "SalesTransaction PerItem" and "SalesTransaction PerItem W/out PurchaseDetails"
-- Create a new modele "Warehouse -> Branch Inventory Transfer", this needs an approval before the transfer
-- Allow "Set Item As Demo" in Front-End
-- Allow "Set Inventory Threshold"

DELETE FROM sysAccessGroupRights WHERE TranTypeID = 179;
DELETE FROM sysAccessRights WHERE TranTypeID = 179;
DELETE FROM sysAccessTypes WHERE TypeID = 179;
INSERT INTO sysAccessTypes (TypeID, TypeName, Enabled) VALUES (179, 'SalesTransaction PerItem', 1);
UPDATE sysAccessTypes SET SequenceNo = 3, Category = '11: Backend - Sales Reports' WHERE TypeID = 179;
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) SELECT GroupID, 179, AllowRead, AllowWrite FROM sysAccessGroupRights WHERE TranTypeID=30;
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) SELECT UID, 179, AllowRead, AllowWrite FROM sysAccessRights WHERE TranTypeID=30;

DELETE FROM sysAccessRights WHERE TranTypeID = 180;
DELETE FROM sysAccessGroupRights WHERE TranTypeID = 180;
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) SELECT GroupID, 180, AllowRead, AllowWrite FROM sysAccessGroupRights WHERE TranTypeID=30;
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) SELECT UID, 180, AllowRead, AllowWrite FROM sysAccessRights WHERE TranTypeID=30;
DELETE FROM sysAccessTypes WHERE TypeID = 180;
INSERT INTO sysAccessTypes (TypeID, TypeName, Enabled) VALUES (180, 'SalesTransaction PerItem W/out PurchaseDetails', 1);
UPDATE sysAccessTypes SET SequenceNo = 4, Category = '11: Backend - Sales Reports' WHERE TypeID = 180;


UPDATE sysAccessTypes SET SequenceNo = 1, Category = '11: Backend - Sales Reports' WHERE TypeID = 41;
UPDATE sysAccessTypes SET SequenceNo = 2, Category = '11: Backend - Sales Reports' WHERE TypeID = 30;
UPDATE sysAccessTypes SET SequenceNo = 3, Category = '11: Backend - Sales Reports' WHERE TypeID = 179;
UPDATE sysAccessTypes SET SequenceNo = 4, Category = '11: Backend - Sales Reports' WHERE TypeID = 180;
UPDATE sysAccessTypes SET SequenceNo = 5, Category = '11: Backend - Sales Reports' WHERE TypeID = 36;
UPDATE sysAccessTypes SET SequenceNo = 6, Category = '11: Backend - Sales Reports' WHERE TypeID = 137;
UPDATE sysAccessTypes SET SequenceNo = 7, Category = '11: Backend - Sales Reports' WHERE TypeID = 134;
UPDATE sysAccessTypes SET SequenceNo = 8, Category = '11: Backend - Sales Reports' WHERE TypeID = 148;
UPDATE sysAccessTypes SET SequenceNo = 9, Category = '11: Backend - Sales Reports' WHERE TypeID = 150;


DELETE FROM sysAccessRights WHERE TranTypeID = 181;
DELETE FROM sysAccessGroupRights WHERE TranTypeID = 181;
DELETE FROM sysAccessTypes WHERE TypeID = 181;
INSERT INTO sysAccessTypes (TypeID, TypeName, Enabled) VALUES (181, 'Branch Inventory Transfer', 1);
UPDATE sysAccessTypes SET SequenceNo = 8, Category = '08: Backend - Inventory' WHERE TypeID = 181;
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) SELECT GroupID, 181, AllowRead, AllowWrite FROM sysAccessGroupRights WHERE TranTypeID=112;
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) SELECT UID, 181, AllowRead, AllowWrite FROM sysAccessRights WHERE TranTypeID=112;

DELETE FROM sysAccessGroupRights WHERE TranTypeID = 182;
DELETE FROM sysAccessRights WHERE TranTypeID = 182;
DELETE FROM sysAccessTypes WHERE TypeID = 182;
INSERT INTO sysAccessTypes (TypeID, TypeName, Enabled) VALUES (182, 'Warehouse -> Branch Inventory Transfer', 1);
UPDATE sysAccessTypes SET SequenceNo = 8, Category = '08: Backend - Inventory' WHERE TypeID = 182;
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) SELECT GroupID, 182, AllowRead, AllowWrite FROM sysAccessGroupRights WHERE TranTypeID=112;
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) SELECT UID, 182, AllowRead, AllowWrite FROM sysAccessRights WHERE TranTypeID=112;


DELETE FROM sysAccessGroupRights WHERE TranTypeID = 185;
DELETE FROM sysAccessRights WHERE TranTypeID = 185;
DELETE FROM sysAccessTypes WHERE TypeID = 185;
INSERT INTO sysAccessTypes (TypeID, TypeName, Enabled) VALUES (185, 'Warehouse -> Branch Inventory Transfer IssueGRN', 1);
UPDATE sysAccessTypes SET SequenceNo = 8, Category = '08: Backend - Inventory' WHERE TypeID = 185;
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) SELECT GroupID, 185, AllowRead, AllowWrite FROM sysAccessGroupRights WHERE TranTypeID=112;
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) SELECT UID, 185, AllowRead, AllowWrite FROM sysAccessRights WHERE TranTypeID=112;


UPDATE sysAccessTypes SET SequenceNo = 1, Category = '08: Backend - Inventory' WHERE TypeID = 21;
UPDATE sysAccessTypes SET SequenceNo = 2, Category = '08: Backend - Inventory' WHERE TypeID = 22;
UPDATE sysAccessTypes SET SequenceNo = 3, Category = '08: Backend - Inventory' WHERE TypeID = 23;
UPDATE sysAccessTypes SET SequenceNo = 4, Category = '08: Backend - Inventory' WHERE TypeID = 89;
UPDATE sysAccessTypes SET SequenceNo = 5, Category = '08: Backend - Inventory' WHERE TypeID = 90;
UPDATE sysAccessTypes SET SequenceNo = 6, Category = '08: Backend - Inventory' WHERE TypeID = 112;
UPDATE sysAccessTypes SET SequenceNo = 7, Category = '08: Backend - Inventory' WHERE TypeID = 113;
UPDATE sysAccessTypes SET SequenceNo = 8, Category = '08: Backend - Inventory' WHERE TypeID = 181;
UPDATE sysAccessTypes SET SequenceNo = 9, Category = '08: Backend - Inventory' WHERE TypeID = 182;
UPDATE sysAccessTypes SET SequenceNo = 10, Category = '08: Backend - Inventory' WHERE TypeID = 185;
UPDATE sysAccessTypes SET SequenceNo = 11, Category = '08: Backend - Inventory' WHERE TypeID = 114;
UPDATE sysAccessTypes SET SequenceNo = 12, Category = '08: Backend - Inventory' WHERE TypeID = 115;
UPDATE sysAccessTypes SET SequenceNo = 13, Category = '08: Backend - Inventory' WHERE TypeID = 116;
UPDATE sysAccessTypes SET SequenceNo = 14, Category = '08: Backend - Inventory' WHERE TypeID = 117;
UPDATE sysAccessTypes SET SequenceNo = 15, Category = '08: Backend - Inventory' WHERE TypeID = 118;
UPDATE sysAccessTypes SET SequenceNo = 16, Category = '08: Backend - Inventory' WHERE TypeID = 119;
UPDATE sysAccessTypes SET SequenceNo = 17, Category = '08: Backend - Inventory' WHERE TypeID = 120;
UPDATE sysAccessTypes SET SequenceNo = 18, Category = '08: Backend - Inventory' WHERE TypeID = 139;

DELETE FROM sysConfig WHERE ConfigName = 'WillShowProductBranchQuantityInItemSelect';
INSERT INTO sysConfig (ConfigName, Category, ConfigValue) VALUES ('WillShowProductBranchQuantityInItemSelect',	'FE',						'false');
-- INSERT INTO sysConfig (ConfigName, Category, ConfigValue) VALUES ('WillShowProductBranchQuantityInItemSelect',	'FE',						'true');


DELETE FROM sysAccessRights WHERE TranTypeID = 183;
DELETE FROM sysAccessGroupRights WHERE TranTypeID = 183;
DELETE FROM sysAccessTypes WHERE TypeID = 183;

INSERT INTO sysAccessTypes (TypeID, TypeName, Enabled) VALUES (183, 'Set Item As Demo', 1);
UPDATE sysAccessTypes SET SequenceNo = 25, Category = '14: Frontend - Cashiering' WHERE TypeID = 183;
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) SELECT GroupID, 183, AllowRead, AllowWrite FROM sysAccessGroupRights WHERE TranTypeID=66;
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) SELECT UID, 183, AllowRead, AllowWrite FROM sysAccessRights WHERE TranTypeID=66;

UPDATE tblTransactions trx
LEFT OUTER JOIN tblContacts cntct ON trx.CustomerID = cntct.ContactID
LEFT OUTER JOIN tblContactGroup grp ON cntct.ContactGroupID = grp.ContactGroupID
SET
	CustomerGroupName = IFNULL(grp.ContactGroupName, 'Default Customer Group')
WHERE IFNULL(trx.CustomerGroupName,'') = '';

-- use this kapag mabagal
-- RENAME TABLE tblProductInventoryAudit TO tblProductInventoryAudit_20150607;
-- RENAME TABLE tblProductInventoryDaily TO tblProductInventoryDaily_20150607;
-- RENAME TABLE tblProductInventoryMonthly TO tblProductInventoryMonthly_20150607;

ALTER TABLE tblProductInventory ADD BranchMinThreshold DECIMAL(18,3) NOT NULL DEFAULT '0.000';
ALTER TABLE tblProductInventoryAudit ADD BranchMinThreshold DECIMAL(18,3) NOT NULL DEFAULT '0.000';
ALTER TABLE tblProductInventoryDaily ADD BranchMinThreshold DECIMAL(18,3) NOT NULL DEFAULT '0.000';
ALTER TABLE tblProductInventoryMonthly ADD BranchMinThreshold DECIMAL(18,3) NOT NULL DEFAULT '0.000';

ALTER TABLE tblProductInventory ADD BranchMaxThreshold DECIMAL(18,3) NOT NULL DEFAULT '0.000';
ALTER TABLE tblProductInventoryAudit ADD BranchMaxThreshold DECIMAL(18,3) NOT NULL DEFAULT '0.000';
ALTER TABLE tblProductInventoryDaily ADD BranchMaxThreshold DECIMAL(18,3) NOT NULL DEFAULT '0.000';
ALTER TABLE tblProductInventoryMonthly ADD BranchMaxThreshold DECIMAL(18,3) NOT NULL DEFAULT '0.000';

ALTER TABLE tblProductInventory ADD RIDBranchMinThreshold DECIMAL(18,3) NOT NULL DEFAULT '0.000';
ALTER TABLE tblProductInventoryAudit ADD RIDBranchMinThreshold DECIMAL(18,3) NOT NULL DEFAULT '0.000';
ALTER TABLE tblProductInventoryDaily ADD RIDBranchMinThreshold DECIMAL(18,3) NOT NULL DEFAULT '0.000';
ALTER TABLE tblProductInventoryMonthly ADD RIDBranchMinThreshold DECIMAL(18,3) NOT NULL DEFAULT '0.000';

ALTER TABLE tblProductInventory ADD RIDBranchMaxThreshold DECIMAL(18,3) NOT NULL DEFAULT '0.000';
ALTER TABLE tblProductInventoryAudit ADD RIDBranchMaxThreshold DECIMAL(18,3) NOT NULL DEFAULT '0.000';
ALTER TABLE tblProductInventoryDaily ADD RIDBranchMaxThreshold DECIMAL(18,3) NOT NULL DEFAULT '0.000';
ALTER TABLE tblProductInventoryMonthly ADD RIDBranchMaxThreshold DECIMAL(18,3) NOT NULL DEFAULT '0.000';

ALTER TABLE tblProductInventory ADD RIDBranch INT(4) NOT NULL DEFAULT '14';
ALTER TABLE tblProductInventoryAudit ADD RIDBranch INT(4) NOT NULL DEFAULT '14';
ALTER TABLE tblProductInventoryDaily ADD RIDBranch INT(4) NOT NULL DEFAULT '14';
ALTER TABLE tblProductInventoryMonthly ADD RIDBranch INT(4) NOT NULL DEFAULT '14';

UPDATE tblProducts SET RID = 14 WHERE RID <= 1;

DELETE FROM sysAccessRights WHERE TranTypeID = 184;
DELETE FROM sysAccessGroupRights WHERE TranTypeID = 184;
DELETE FROM sysAccessTypes WHERE TypeID = 184;
INSERT INTO sysAccessTypes (TypeID, TypeName, Enabled) VALUES (184, 'Set Inventory Threshold', 1);
UPDATE sysAccessTypes SET SequenceNo = 10, Category = '08: Backend - Inventory' WHERE TypeID = 184;
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) SELECT GroupID, 184, AllowRead, AllowWrite FROM sysAccessGroupRights WHERE TranTypeID=114;
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) SELECT UID, 184, AllowRead, AllowWrite FROM sysAccessRights WHERE TranTypeID=114;


-- For determining the MinThreshold when computed using the RID
-- 
ALTER TABLE tblContacts ADD LeadTimeToDeliver INT(2) NOT NULL DEFAULT 7 COMMENT 'For determining the Lead Time To Deliver to be use in computing MinThreshold';



/*********************************  v_4.0.1.42.sql END  *******************************************************/ 

UPDATE tblTerminal SET DBVersion = '4.0.1.43';

-- do a user logging during override.
-- This is to set how many percentage will be deducted from the actual inventory. This will reflect in "eInventory" report.


DELETE FROM sysConfig WHERE ConfigName = 'InventoryTrustFund';
INSERT INTO sysConfig (ConfigName, Category, ConfigValue) VALUES ('InventoryTrustFund', 'BE', '50');


/*********************************  v_4.0.1.43.sql END  *******************************************************/ 

UPDATE tblTerminal SET DBVersion = '4.0.1.44';

ALTER TABLE tblContactAddOn ADD Sex VARCHAR(6) NOT NULL DEFAULT 'Male';
ALTER TABLE tblContactAddOn ADD AttendingPhysician VARCHAR(150) DEFAULT '';


-- 08Jun2015 Added for determining which window to show when adding a customer
--	Default: ContactAddDetWnd
--			ContactAddWnd		- normal information
--			ContactAddNoLTOWnd	- normal information without LTO
--			ContactAddDetWnd	- with additional information for ContactAddOn table (HP)
--			ContactAddHCareWnd	- with additional information for HealthCare
DELETE FROM sysConfig WHERE ConfigName = 'ContactAddWndType';
INSERT INTO sysConfig (ConfigName, Category, ConfigValue) VALUES ('ContactAddWndType', 'FE', 'ContactAddWnd');

-- 08Jun2015 Added for determining which columns to show in ItemSelectWnd
--	Default: BcDesc
--			BcPc				- Barcode, ProductCode									-- for Parking
--			BcDesc				- Barcode, Description									-- Default, for HP
--			BcPcDescMtrx		- Barcode, ProductCode, Description, MatrixDesc			-- For WholeSaler e.g. Marzan Bambang
--			PcDescMtrx			- ProductCode, Description, MatrixDesc					-- For WholeSaler e.g. Marzan Bambang
--			PcDesc				- ProductCode, Description								-- For Non-Drugstore
--			SgDesc				- SubGroup, Description									-- For Drugstore, HealthCare, WholeSaler
--			SgPcDesc			- SubGroup, ProductCode, Description					-- For Drugstore, HealthCare, WholeSaler
--			SgDescMtrx			- SubGroup, Description, Matrix							-- For Drugstore, HealthCare, WholeSaler
DELETE FROM sysConfig WHERE ConfigName = 'ItemSelectWndColumnType';
INSERT INTO sysConfig (ConfigName, Category, ConfigValue) VALUES ('ItemSelectWndColumnType', 'FE', 'PcDescMtrx');

-- 08Jun2015 Added for determining which columns to filter in ItemSelectWnd
--	Default: BcDesc
--			BcPc				- Barcode, ProductCode									-- for Parking
--			BcDesc				- Barcode, Description									-- Default, for HP
--			PcDesc				- ProductCode, Description								-- For Non-Drugstore
--			SgDesc				- SubGroup, Description									-- For Drugstore, HealthCare, WholeSaler
--			SgPcDesc			- SubGroup, ProductCode, Description					-- For Drugstore, HealthCare, WholeSaler
DELETE FROM sysConfig WHERE ConfigName = 'ItemSelectWndColumnSearchType';
INSERT INTO sysConfig (ConfigName, Category, ConfigValue) VALUES ('ItemSelectWndColumnSearchType', 'FE', 'PcDesc');



DELETE FROM sysAccessRights WHERE TranTypeID = 194;
DELETE FROM sysAccessGroupRights WHERE TranTypeID = 194;
DELETE FROM sysAccessTypes WHERE TypeID = 194;
INSERT INTO sysAccessTypes (TypeID, TypeName, Enabled) VALUES (194, 'Resume Closed Transaction', 1);
UPDATE sysAccessTypes SET SequenceNo = 4, Category = '14: Frontend - Cashiering' WHERE TypeID = 194;
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) SELECT GroupID, 194, AllowRead, AllowWrite FROM sysAccessGroupRights WHERE TranTypeID=124;
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) SELECT UID, 194, AllowRead, AllowWrite FROM sysAccessRights WHERE TranTypeID=124;



/*********************************  v_4.0.1.44.sql END  *******************************************************/ 

UPDATE tblTerminal SET DBVersion = '4.0.1.45';

-- This is for attaching of results in a service


/*****************************
**	tblTransactionItemAttachments
*****************************/
DROP TABLE IF EXISTS tblTransactionItemAttachments;
CREATE TABLE tblTransactionItemAttachments (
	`TransactionItemAttachmentsID` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
	`TransactionItemsID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`TransactionID` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
	`OrigFileName` VARCHAR(150) NOT NULL,
	`FileName` VARCHAR(150) NOT NULL,
	`Deleted` TINYINT(1) NOT NULL DEFAULT 0,
	`UploadedByName` VARCHAR(100),
	`DeletedByName` VARCHAR(100),
	`LastUpdatedByName` VARCHAR(100),
	`CreatedOn` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	`LastModified` DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	PRIMARY KEY (TransactionItemAttachmentsID),
	INDEX `IX_tblTransactionItemAttachments`(`TransactionItemAttachmentsID`),
	INDEX `IX0_tblTransactionItemAttachments`(`TransactionItemsID`),
	INDEX `IX1_tblTransactionItemAttachments`(`TransactionID`),
	INDEX `IX2_tblTransactionItemAttachments`(`TransactionItemsID`, `TransactionID`)
);



DELETE FROM sysAccessRights WHERE TranTypeID = 195;
DELETE FROM sysAccessGroupRights WHERE TranTypeID = 195;
DELETE FROM sysAccessTypes WHERE TypeID = 195;
INSERT INTO sysAccessTypes (TypeID, TypeName, Enabled) VALUES (195, 'Delete Transaction Item Attachment', 1);
UPDATE sysAccessTypes SET SequenceNo = 4, Category = '14: Frontend - Cashiering' WHERE TypeID = 195;
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) SELECT GroupID, 195, AllowRead, AllowWrite FROM sysAccessGroupRights WHERE TranTypeID=124;
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) SELECT UID, 195, AllowRead, AllowWrite FROM sysAccessRights WHERE TranTypeID=124;



DELETE FROM sysAccessRights WHERE TranTypeID = 196;
DELETE FROM sysAccessGroupRights WHERE TranTypeID = 196;
DELETE FROM sysAccessTypes WHERE TypeID = 196;
INSERT INTO sysAccessTypes (TypeID, TypeName, Enabled) VALUES (196, 'View Deleted Transaction Item Attachment', 1);
UPDATE sysAccessTypes SET SequenceNo = 4, Category = '14: Frontend - Cashiering' WHERE TypeID = 196;
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) SELECT GroupID, 196, AllowRead, AllowWrite FROM sysAccessGroupRights WHERE TranTypeID=124;
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) SELECT UID, 196, AllowRead, AllowWrite FROM sysAccessRights WHERE TranTypeID=124;



/*********************************  v_4.0.1.45.sql END  *******************************************************/ 

UPDATE tblTerminal SET DBVersion = '4.0.1.46';

-- critical update for reporting the new TF
-- there should be an override even if a TF is already set

-- Do a backup of the tblTerminalReportHistory before doing anything
CREATE TABLE tblTerminalReportHistoryBackup AS SELECT * FROM tblTerminalReportHistory;

/*****************************
**	tblTerminalReportHistoryeSales
*****************************/
DROP TABLE IF EXISTS tblTerminalReportHistoryeSales;
CREATE TABLE tblTerminalReportHistoryeSales (
  `TerminalID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `TerminalNo` varchar(10) NOT NULL,
  `BeginningTransactionNo` varchar(30) NOT NULL,
  `EndingTransactionNo` varchar(30) NOT NULL,
  `ZReadCount` int(10) NOT NULL DEFAULT '0',
  `XReadCount` int(10) NOT NULL DEFAULT '0',
  `GrossSales` decimal(18,2) NOT NULL DEFAULT '0.00',
  `TotalDiscount` decimal(18,2) NOT NULL DEFAULT '0.00',
  `DailySales` decimal(18,2) NOT NULL DEFAULT '0.00',
  `QuantitySold` decimal(18,2) NOT NULL DEFAULT '0.00',
  `GroupSales` decimal(18,2) NOT NULL DEFAULT '0.00',
  `OldGrandTotal` decimal(18,2) NOT NULL DEFAULT '0.00',
  `NewGrandTotal` decimal(18,2) NOT NULL DEFAULT '0.00',
  `VATableAmount` decimal(18,2) NOT NULL DEFAULT '0.00',
  `NonVATableAmount` decimal(18,3) NOT NULL DEFAULT '0.000' COMMENT 'Use for NonvAT',
  `VAT` decimal(18,2) NOT NULL DEFAULT '0.00',
  `EVATableAmount` decimal(18,2) NOT NULL DEFAULT '0.00',
  `NonEVATableAmount` decimal(18,3) NOT NULL DEFAULT '0.000',
  `EVAT` decimal(18,2) NOT NULL DEFAULT '0.00',
  `LocalTax` decimal(18,2) NOT NULL DEFAULT '0.00',
  `CashSales` decimal(18,2) NOT NULL DEFAULT '0.00',
  `ChequeSales` decimal(18,2) NOT NULL DEFAULT '0.00',
  `CreditCardSales` decimal(18,2) NOT NULL DEFAULT '0.00',
  `CreditSales` decimal(18,2) NOT NULL DEFAULT '0.00',
  `CreditPayment` decimal(18,2) NOT NULL DEFAULT '0.00',
  `CashInDrawer` decimal(18,2) NOT NULL DEFAULT '0.00',
  `TotalDisburse` decimal(18,2) NOT NULL DEFAULT '0.00',
  `CashDisburse` decimal(18,2) NOT NULL DEFAULT '0.00',
  `ChequeDisburse` decimal(18,2) NOT NULL DEFAULT '0.00',
  `CreditCardDisburse` decimal(18,2) NOT NULL DEFAULT '0.00',
  `TotalWithhold` decimal(18,2) NOT NULL DEFAULT '0.00',
  `CashWithhold` decimal(18,2) NOT NULL DEFAULT '0.00',
  `ChequeWithhold` decimal(18,2) NOT NULL DEFAULT '0.00',
  `CreditCardWithhold` decimal(18,2) NOT NULL DEFAULT '0.00',
  `TotalPaidOut` decimal(18,2) NOT NULL DEFAULT '0.00',
  `CashPaidOut` decimal(18,2) NOT NULL DEFAULT '0.00',
  `ChequePaidOut` decimal(18,2) NOT NULL DEFAULT '0.00',
  `CreditCardPaidOut` decimal(18,2) NOT NULL DEFAULT '0.00',
  `BeginningBalance` decimal(18,2) NOT NULL DEFAULT '0.00',
  `VoidSales` decimal(18,2) NOT NULL DEFAULT '0.00',
  `RefundSales` decimal(18,2) NOT NULL DEFAULT '0.00',
  `ItemsDiscount` decimal(18,3) NOT NULL DEFAULT '0.000' COMMENT 'SNRItemsDiscount + PWDItemsDiscount + OtherItemsDiscount',
  `SubtotalDiscount` decimal(18,2) NOT NULL DEFAULT '0.00',
  `NoOfCashTransactions` int(10) NOT NULL DEFAULT '0',
  `NoOfChequeTransactions` int(10) NOT NULL DEFAULT '0',
  `NoOfCreditCardTransactions` int(10) NOT NULL DEFAULT '0',
  `NoOfCreditTransactions` int(10) NOT NULL DEFAULT '0',
  `NoOfCombinationPaymentTransactions` int(10) NOT NULL DEFAULT '0',
  `NoOfCreditPaymentTransactions` int(10) NOT NULL DEFAULT '0',
  `NoOfClosedTransactions` int(10) NOT NULL DEFAULT '0',
  `NoOfRefundTransactions` int(10) NOT NULL DEFAULT '0',
  `NoOfVoidTransactions` int(10) NOT NULL DEFAULT '0',
  `NoOfTotalTransactions` int(10) NOT NULL DEFAULT '0',
  `DateLastInitialized` datetime NOT NULL,
  `TotalDeposit` decimal(18,2) NOT NULL DEFAULT '0.00',
  `CashDeposit` decimal(18,2) NOT NULL DEFAULT '0.00',
  `ChequeDeposit` decimal(18,2) NOT NULL DEFAULT '0.00',
  `CreditCardDeposit` decimal(18,2) NOT NULL DEFAULT '0.00',
  `DebitPayment` decimal(18,2) NOT NULL DEFAULT '0.00',
  `NoOfDebitPaymentTransactions` int(10) NOT NULL DEFAULT '0',
  `TotalCharge` decimal(18,2) NOT NULL DEFAULT '0.00',
  `TrustFund` decimal(5,2) NOT NULL DEFAULT '0.00',
  `NoOfDiscountedTransactions` int(4) NOT NULL DEFAULT '0',
  `NegativeAdjustments` decimal(18,2) NOT NULL DEFAULT '0.00',
  `NoOfNegativeAdjustmentTransactions` int(4) NOT NULL DEFAULT '0',
  `PromotionalItems` decimal(18,2) NOT NULL DEFAULT '0.00',
  `CreditSalesTax` decimal(18,2) NOT NULL DEFAULT '0.00',
  `BatchCounter` int(4) NOT NULL DEFAULT '1',
  `MallFileName` varchar(30) DEFAULT NULL,
  `IsMallFileUploadComplete` tinyint(1) NOT NULL DEFAULT '0',
  `DebitDeposit` decimal(10,0) NOT NULL DEFAULT '0',
  `RewardPointsPayment` decimal(10,2) NOT NULL DEFAULT '0.00',
  `RewardConvertedPayment` decimal(10,2) NOT NULL DEFAULT '0.00',
  `NoOfRewardPointsPayment` int(10) NOT NULL DEFAULT '0',
  `InitializedBy` varchar(150) DEFAULT NULL,
  `BranchID` int(4) NOT NULL DEFAULT '1',
  `ActualOldGrandTotal` decimal(18,3) NOT NULL DEFAULT '0.000',
  `ActualNewGrandTotal` decimal(18,3) NOT NULL DEFAULT '0.000',
  `NoOfReprintedTransaction` int(10) NOT NULL DEFAULT '0',
  `TotalReprintedTransaction` decimal(18,2) NOT NULL DEFAULT '0.00',
  `CreditPaymentCash` decimal(18,2) NOT NULL DEFAULT '0.00',
  `CreditPaymentCheque` decimal(18,2) NOT NULL DEFAULT '0.00',
  `CreditPaymentCreditCard` decimal(18,2) NOT NULL DEFAULT '0.00',
  `CreditPaymentDebit` decimal(18,2) NOT NULL DEFAULT '0.00',
  `CreatedOn` datetime NOT NULL DEFAULT '0001-01-01 12:00:00',
  `LastModified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `BeginningORNo` varchar(30) NOT NULL,
  `EndingORNo` varchar(30) NOT NULL,
  `VATExempt` decimal(18,3) NOT NULL DEFAULT '0.000' COMMENT 'Use for SNR',
  `SNRDiscount` decimal(18,3) NOT NULL DEFAULT '0.000',
  `PWDDiscount` decimal(18,3) NOT NULL DEFAULT '0.000',
  `OtherDiscount` decimal(18,3) NOT NULL DEFAULT '0.000',
  `NetSales` decimal(18,3) NOT NULL DEFAULT '0.000' COMMENT 'Net Sales = Amount Due = VAT Exempt - SNRDisc = Subtotal - Not SNRDisc',
  `IsProcessed` tinyint(1) NOT NULL DEFAULT '0',
  `ItemSold` decimal(18,3) NOT NULL DEFAULT '0.000',
  `RefundCash` decimal(18,3) NOT NULL DEFAULT '0.000',
  `RefundCheque` decimal(18,3) NOT NULL DEFAULT '0.000',
  `RefundCreditCard` decimal(18,3) NOT NULL DEFAULT '0.000',
  `RefundCredit` decimal(18,3) NOT NULL DEFAULT '0.000',
  `RefundDebit` decimal(18,3) NOT NULL DEFAULT '0.000',
  `SNRItemsDiscount` decimal(18,3) NOT NULL DEFAULT '0.000' COMMENT 'SNR Items Discount',
  `PWDItemsDiscount` decimal(18,3) NOT NULL DEFAULT '0.000' COMMENT 'PWD Items Discount',
  `OtherItemsDiscount` decimal(18,3) NOT NULL DEFAULT '0.000' COMMENT 'Other items discount (not SNR & not PWD)',
  `ZeroRatedSales` decimal(18,3) NOT NULL DEFAULT '0.000' COMMENT 'Use for ZeroRated',
  `IncludeIneSales` tinyint(1) NOT NULL DEFAULT '1',
  `NoOfConsignmentTransactions` int(10) NOT NULL DEFAULT '0',
  `NoOfConsignmentRefundTransactions` int(10) NOT NULL DEFAULT '0',
  `NoOfWalkInTransactions` int(10) NOT NULL DEFAULT '0',
  `NoOfWalkInRefundTransactions` int(10) NOT NULL DEFAULT '0',
  `NoOfOutOfStockTransactions` int(10) NOT NULL DEFAULT '0',
  `NoOfOutOfStockRefundTransactions` int(10) NOT NULL DEFAULT '0',
  `ConsignmentSales` decimal(18,3) NOT NULL DEFAULT '0.000',
  `ConsignmentRefundSales` decimal(18,3) NOT NULL DEFAULT '0.000',
  `WalkInSales` decimal(18,3) NOT NULL DEFAULT '0.000',
  `WalkInRefundSales` decimal(18,3) NOT NULL DEFAULT '0.000',
  `OutOfStockSales` decimal(18,3) NOT NULL DEFAULT '0.000',
  `OutOfStockRefundSales` decimal(18,3) NOT NULL DEFAULT '0.000',
  `ORSeriesBranchID` int(4) NOT NULL DEFAULT '0',
  `ORSeriesTerminalNo` varchar(10) NOT NULL DEFAULT '',
  KEY `IX_tblTerminalReportHistoryeSales` (`TerminalNo`),
  KEY `IX1_tblTerminalReportHistoryeSales` (`ZReadCount`),
  KEY `IX2_tblTerminalReportHistoryeSales` (`XReadCount`),
  KEY `IX_tblTerminalReportHistoryeSales_BeginningTransactionNo` (`BeginningTransactionNo`),
  KEY `IX_tblTerminalReportHistoryeSales_EndingTransactionNo` (`EndingTransactionNo`)
) ENGINE=InnoDB;

-- Insert to eSales for Reporting
INSERT INTO tblTerminalReportHistoryeSales (
				TerminalID,
				TerminalNo,
				BeginningTransactionNo,
				EndingTransactionNo,
				ZReadCount,
				XReadCount,
				GrossSales,
				TotalDiscount,
				DailySales,
				QuantitySold,
				GroupSales,
				OldGrandTotal,
				NewGrandTotal,
				VATableAmount,
				NonVATableAmount,
				VAT,
				EVATableAmount,
				NonEVATableAmount,
				EVAT,
				LocalTax,
				CashSales,
				ChequeSales,
				CreditCardSales,
				CreditSales,
				CreditPayment,
				CashInDrawer,
				TotalDisburse,
				CashDisburse,
				ChequeDisburse,
				CreditCardDisburse,
				TotalWithhold,
				CashWithhold,
				ChequeWithhold,
				CreditCardWithhold,
				TotalPaidOut,
				CashPaidOut,
				ChequePaidOut,
				CreditCardPaidOut,
				BeginningBalance,
				VoidSales,
				RefundSales,
				ItemsDiscount,
				SubtotalDiscount,
				NoOfCashTransactions,
				NoOfChequeTransactions,
				NoOfCreditCardTransactions,
				NoOfCreditTransactions,
				NoOfCombinationPaymentTransactions,
				NoOfCreditPaymentTransactions,
				NoOfClosedTransactions,
				NoOfRefundTransactions,
				NoOfVoidTransactions,
				NoOfTotalTransactions,
				DateLastInitialized,
				TotalDeposit,
				CashDeposit,
				ChequeDeposit,
				CreditCardDeposit,
				DebitPayment,
				NoOfDebitPaymentTransactions,
				TotalCharge,
				NoOfDiscountedTransactions,
				NegativeAdjustments,
				NoOfNegativeAdjustmentTransactions,
				PromotionalItems,
				CreditSalesTax,
				BatchCounter,
				DebitDeposit,
				RewardPointsPayment,
				RewardConvertedPayment,
				NoOfRewardPointsPayment,
				BranchID,
				NoOfReprintedTransaction,
				TotalReprintedTransaction,
				CreditPaymentCash,
				CreditPaymentCheque,
				CreditPaymentCreditCard,
				CreditPaymentDebit,
				CreatedOn,
				LastModified,
				BeginningORNo,
				EndingORNo,
				VATExempt,
				SNRDiscount,
				PWDDiscount,
				OtherDiscount,
				NetSales,
				IsProcessed,
				ItemSold,
				TrustFund,
				RefundCash,
				RefundCheque,
				RefundCreditCard,
				RefundCredit,
				RefundDebit,
				SNRItemsDiscount,
				PWDItemsDiscount,
				OtherItemsDiscount,
				ZeroRatedSales,
				IncludeIneSales,
				NoOfConsignmentTransactions,
				NoOfConsignmentRefundTransactions,
				NoOfWalkInTransactions,
				NoOfWalkInRefundTransactions,
				NoOfOutOfStockTransactions,
				NoOfOutOfStockRefundTransactions,
				ConsignmentSales,
				ConsignmentRefundSales,
				WalkInSales,
				WalkInRefundSales,
				OutOfStockSales,
				OutOfStockRefundSales,
				ORSeriesBranchID,
				ORSeriesTerminalNo) 
			(SELECT 
				TerminalID,
				TerminalNo,
				BeginningTransactionNo,
				EndingTransactionNo,
				ZReadCount,
				XReadCount,
				GrossSales * ((100-TrustFund) / 100),
				TotalDiscount * ((100-TrustFund) / 100),
				DailySales * ((100-TrustFund) / 100),
				QuantitySold * ((100-TrustFund) / 100),
				GroupSales * ((100-TrustFund) / 100),
				OldGrandTotal,
				NewGrandTotal,
				VATableAmount * ((100-TrustFund) / 100),
				NonVATableAmount * ((100-TrustFund) / 100),
				VAT * ((100-TrustFund) / 100),
				EVATableAmount * ((100-TrustFund) / 100),
				NonEVATableAmount * ((100-TrustFund) / 100),
				EVAT * ((100-TrustFund) / 100),
				LocalTax * ((100-TrustFund) / 100),
				CashSales * ((100-TrustFund) / 100),
				ChequeSales * ((100-TrustFund) / 100),
				CreditCardSales * ((100-TrustFund) / 100),
				CreditSales * ((100-TrustFund) / 100),
				CreditPayment * ((100-TrustFund) / 100),
				BeginningBalance + ((CashInDrawer - BeginningBalance) * ((100-TrustFund) / 100)) AS  CashInDrawer,
				TotalDisburse * ((100-TrustFund) / 100),
				CashDisburse * ((100-TrustFund) / 100),
				ChequeDisburse * ((100-TrustFund) / 100),
				CreditCardDisburse * ((100-TrustFund) / 100),
				TotalWithhold * ((100-TrustFund) / 100),
				CashWithhold * ((100-TrustFund) / 100),
				ChequeWithhold * ((100-TrustFund) / 100),
				CreditCardWithhold * ((100-TrustFund) / 100),
				TotalPaidOut * ((100-TrustFund) / 100),
				CashPaidOut * ((100-TrustFund) / 100),
				ChequePaidOut * ((100-TrustFund) / 100),
				CreditCardPaidOut * ((100-TrustFund) / 100),
				BeginningBalance,
				VoidSales * ((100-TrustFund) / 100),
				RefundSales * ((100-TrustFund) / 100),
				ItemsDiscount * ((100-TrustFund) / 100),
				SubtotalDiscount * ((100-TrustFund) / 100),
				NoOfCashTransactions,
				NoOfChequeTransactions,
				NoOfCreditCardTransactions,
				NoOfCreditTransactions,
				NoOfCombinationPaymentTransactions,
				NoOfCreditPaymentTransactions,
				NoOfClosedTransactions,
				NoOfRefundTransactions,
				NoOfVoidTransactions,
				NoOfTotalTransactions,
				DateLastInitialized,
				TotalDeposit * ((100-TrustFund) / 100),
				CashDeposit * ((100-TrustFund) / 100),
				ChequeDeposit * ((100-TrustFund) / 100),
				CreditCardDeposit * ((100-TrustFund) / 100),
				DebitPayment * ((100-TrustFund) / 100),
				NoOfDebitPaymentTransactions,
				TotalCharge * ((100-TrustFund) / 100),
				NoOfDiscountedTransactions,
				NegativeAdjustments * ((100-TrustFund) / 100),
				NoOfNegativeAdjustmentTransactions,
				PromotionalItems * ((100-TrustFund) / 100),
				CreditSalesTax * ((100-TrustFund) / 100),
				BatchCounter,
				DebitDeposit * ((100-TrustFund) / 100),
				RewardPointsPayment * ((100-TrustFund) / 100),
				RewardConvertedPayment * ((100-TrustFund) / 100),
				NoOfRewardPointsPayment,
				BranchID,
				NoOfReprintedTransaction,
				TotalReprintedTransaction * ((100-TrustFund) / 100),
				CreditPaymentCash * ((100-TrustFund) / 100),
				CreditPaymentCheque * ((100-TrustFund) / 100),
				CreditPaymentCreditCard * ((100-TrustFund) / 100),
				CreditPaymentDebit * ((100-TrustFund) / 100),
				CreatedOn,
				LastModified,
				BeginningORNo,
				EndingORNo,
				VATExempt * ((100-TrustFund) / 100),
				SNRDiscount * ((100-TrustFund) / 100),
				PWDDiscount * ((100-TrustFund) / 100),
				OtherDiscount * ((100-TrustFund) / 100),
				NetSales * ((100-TrustFund) / 100),
				IsProcessed,
				ItemSold * ((100-TrustFund) / 100),
				TrustFund,
				RefundCash * ((100-TrustFund) / 100),
				RefundCheque * ((100-TrustFund) / 100),
				RefundCreditCard * ((100-TrustFund) / 100),
				RefundCredit * ((100-TrustFund) / 100),
				RefundDebit * ((100-TrustFund) / 100),
				SNRItemsDiscount * ((100-TrustFund) / 100),
				PWDItemsDiscount * ((100-TrustFund) / 100),
				OtherItemsDiscount * ((100-TrustFund) / 100),
				ZeroRatedSales * ((100-TrustFund) / 100),
				IncludeIneSales,
				NoOfConsignmentTransactions,
				NoOfConsignmentRefundTransactions,
				NoOfWalkInTransactions,
				NoOfWalkInRefundTransactions,
				NoOfOutOfStockTransactions,
				NoOfOutOfStockRefundTransactions,
				ConsignmentSales * ((100-TrustFund) / 100),
				ConsignmentRefundSales * ((100-TrustFund) / 100),
				WalkInSales * ((100-TrustFund) / 100),
				WalkInRefundSales * ((100-TrustFund) / 100),
				OutOfStockSales * ((100-TrustFund) / 100),
				OutOfStockRefundSales * ((100-TrustFund) / 100),
				ORSeriesBranchID,
				ORSeriesTerminalNo
			FROM tblTerminalReportHistory);



ALTER TABLE tblTerminalReport ADD  `eSalesOldGrandTotal` decimal(18,3) NOT NULL DEFAULT '0.000';
ALTER TABLE tblTerminalReport ADD  `eSalesNewGrandTotal` decimal(18,3) NOT NULL DEFAULT '0.000';
UPDATE tblTerminalReport SET eSalesOldGrandTotal = OldGrandTotal;
UPDATE tblTerminalReport SET eSalesNewGrandTotal = NewGrandTotal;

ALTER TABLE tblTerminalReportHistory ADD  `eSalesOldGrandTotal` decimal(18,3) NOT NULL DEFAULT '0.000';
ALTER TABLE tblTerminalReportHistory ADD  `eSalesNewGrandTotal` decimal(18,3) NOT NULL DEFAULT '0.000';
UPDATE tblTerminalReportHistory SET eSalesOldGrandTotal = OldGrandTotal;
UPDATE tblTerminalReportHistory SET eSalesNewGrandTotal = NewGrandTotal;
UPDATE tblTerminalReportHistory SET OldGrandTotal = ActualOldGrandTotal, NewGrandTotal = ActualNewGrandTotal;

ALTER TABLE tblTerminalReportHistoryeSales ADD `eSalesOldGrandTotal` decimal(18,3) NOT NULL DEFAULT '0.000';
ALTER TABLE tblTerminalReportHistoryeSales ADD `eSalesNewGrandTotal` decimal(18,3) NOT NULL DEFAULT '0.000';
UPDATE tblTerminalReportHistoryeSales SET eSalesOldGrandTotal = OldGrandTotal;
UPDATE tblTerminalReportHistoryeSales SET eSalesNewGrandTotal = NewGrandTotal;

-- ALTER TABLE tblTerminalReport DROP `ActualOldGrandTotal`;
-- ALTER TABLE tblTerminalReport DROP `ActualNewGrandTotal`;

-- ALTER TABLE tblTerminalReportHistory DROP `ActualOldGrandTotal`;
-- ALTER TABLE tblTerminalReportHistory DROP `ActualNewGrandTotal`;

-- ALTER TABLE tblTerminalReportHistoryeSales DROP `ActualOldGrandTotal`;
-- ALTER TABLE tblTerminalReportHistoryeSales DROP `ActualNewGrandTotal`;

ALTER TABLE tblTerminalReportHistoryBackup ADD `BackupOn` datetime NOT NULL DEFAULT '0001-01-01 12:00:00';
UPDATE tblTerminalReportHistoryBackup SET BackupOn = NOW();


/*********************************  v_4.0.1.46.sql END  *******************************************************/ 

UPDATE tblTerminal SET DBVersion = '4.0.1.47';


DELETE FROM sysAccessRights WHERE TranTypeID = 197;
DELETE FROM sysAccessGroupRights WHERE TranTypeID = 197;
DELETE FROM sysAccessTypes WHERE TypeID = 197;
INSERT INTO sysAccessTypes (TypeID, TypeName, Enabled) VALUES (197, 'Products In Demo Report', 1);
UPDATE sysAccessTypes SET SequenceNo = 4, Category = '11: Backend - Inventory Reports' WHERE TypeID = 197;
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) SELECT GroupID, 197, AllowRead, AllowWrite FROM sysAccessGroupRights WHERE TranTypeID=124;
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) SELECT UID, 197, AllowRead, AllowWrite FROM sysAccessRights WHERE TranTypeID=124;


/*********************************  v_4.0.1.47.sql END  *******************************************************/ 

UPDATE tblTerminal SET DBVersion = '4.0.1.48';

ALTER TABLE tblTerminal ADD `MultiInstanceEnabled` TINYINT(1) NOT NULL DEFAULT 1;
ALTER TABLE tblTerminal ADD `MaskProductSearch` VARCHAR(1) DEFAULT '*';
UPDATE tblTerminal SET MaskProductSearch = '*';


ALTER TABLE tblTransactionItems ADD ReturnTransactionItemsID BIGINT(20) NOT NULL DEFAULT 0 COMMENT 'This is the TransactionItemsID of the Item that is Return',
								ADD RefReturnTransactionItemsID BIGINT(20) NOT NULL DEFAULT 0 COMMENT 'This is the TransactionItemsID of the Item that is Returned this must be in ReturnStatus',
								ADD `SupplierID` BIGINT(20) NOT NULL DEFAULT 1, ADD `SupplierCode` VARCHAR(25) DEFAULT '', ADD `SupplierName` VARCHAR(75) DEFAULT '';

UPDATE tblTransactionItems 
INNER JOIN tblProducts ON tblTransactionItems.ProductID = tblProducts.ProductID
INNER JOIN tblContacts ON tblContacts.ContactID = tblProducts.SupplierID
SET tblTransactionItems.SupplierID = tblProducts.SupplierID,
	tblTransactionItems.SupplierCode = tblContacts.ContactCode,
	tblTransactionItems.SupplierName = tblContacts.ContactName
WHERE tblTransactionItems.SupplierID <= 1;



/*********************************  v_4.0.1.48.sql END  *******************************************************/ 

UPDATE tblTerminal SET DBVersion = '4.0.1.49';

DELETE FROM sysAccessRights WHERE TranTypeID = 198;
DELETE FROM sysAccessGroupRights WHERE TranTypeID = 198;
DELETE FROM sysAccessTypes WHERE TypeID = 198;
INSERT INTO sysAccessTypes (TypeID, TypeName, Enabled) VALUES (198, 'Products Unit Matrix Setup', 1);
UPDATE sysAccessTypes SET SequenceNo = 6, Category = '05: Backend - MasterFiles - Products' WHERE TypeID = 198;
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) SELECT GroupID, 198, AllowRead, AllowWrite FROM sysAccessGroupRights WHERE TranTypeID=124;
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) SELECT UID, 198, AllowRead, AllowWrite FROM sysAccessRights WHERE TranTypeID=124;


DELETE FROM sysAccessRights WHERE TranTypeID = 199;
DELETE FROM sysAccessGroupRights WHERE TranTypeID = 199;
DELETE FROM sysAccessTypes WHERE TypeID = 199;
INSERT INTO sysAccessTypes (TypeID, TypeName, Enabled) VALUES (199, 'Credit Verification', 1);
UPDATE sysAccessTypes SET SequenceNo = 17, Category = '14: Frontend - Cashiering' WHERE TypeID = 199;
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) SELECT GroupID, 199, AllowRead, AllowWrite FROM sysAccessGroupRights WHERE TranTypeID=80;
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) SELECT UID, 199, AllowRead, AllowWrite FROM sysAccessRights WHERE TranTypeID=80;

ALTER TABLE tblProducts MODIFY ProductDesc VARCHAR(100) NOT NULL DEFAULT '';
ALTER TABLE tblProductMovement MODIFY ProductDescription VARCHAR(100) NOT NULL DEFAULT '';

/*********************************  v_4.0.1.49.sql END  *******************************************************/ 

UPDATE tblTerminal SET DBVersion = '4.0.1.50';

ALTER TABLE tblTerminal MODIFY AccreditationNo VARCHAR(50) NOT NULL COMMENT 'Current BIR Length = 23';

-- This will hold the promo by supplier which will print coupons
DROP TABLE IF EXISTS tblPromoBySupplier;
CREATE TABLE tblPromoBySupplier (
	PromoBySupplierID BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	PromoBySupplierCode VARCHAR(60) NOT NULL,
	PromoBySupplierName VARCHAR(75) NOT NULL,
	StartDate DATETIME NOT NULL,
	EndDate DATETIME NOT NULL,
	PromoLevel INT(1) UNSIGNED NOT NULL DEFAULT 0,
	PromoTypeID INT(10) UNSIGNED NOT NULL DEFAULT 0,
	Status TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
	CreatedOn DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	LastModified TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (PromoBySupplierID),
	UNIQUE KEY PK_tblPromoBySupplier (PromoBySupplierCode),
	KEY IX_tblPromoBySupplier (PromoBySupplierID,PromoBySupplierCode,PromoBySupplierName,PromoTypeID),
	KEY IX_tblPromoBySupplier1 (PromoTypeID)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS tblPromoBySupplieritems;
CREATE TABLE tblPromoBySupplieritems (
	PromoBySupplierItemsID BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	PromoBySupplierID BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
	ContactID BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
	ProductGroupID BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
	ProductSubGroupID BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
	ProductID BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
	VariationMatrixID BIGINT(20) UNSIGNED DEFAULT NULL,
	PromoBySupplierValue DECIMAL(18,2) NOT NULL DEFAULT '0.00',
	CouponRemarks VARCHAR(3000) NOT NULL DEFAULT '',
	CreatedOn DATETIME NOT NULL DEFAULT '1900-01-01 12:00:00',
	LastModified TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (PromoBySupplierItemsID),
	UNIQUE KEY PK_tblPromoBySupplierItems (PromoBySupplierItemsID),
	UNIQUE KEY PK_tblPromoBySupplierItems1 (PromoBySupplierID,ContactID,ProductGroupID,ProductSubGroupID,ProductID,VariationMatrixID),
	KEY IX_tblPromoBySupplierItems (PromoBySupplierID),
	KEY IX_tblPromoBySupplierItems1 (VariationMatrixID),
	KEY IX_tblPromoBySupplierItems2 (ProductGroupID),
	KEY IX_tblPromoBySupplierItems3 (ProductSubGroupID),
	KEY IX_tblPromoBySupplierItems4 (ProductID),
	KEY IX_tblPromoBySupplierItems5 (VariationMatrixID),
	KEY IX_tblPromoBySupplierItems6 (ContactID)
) ENGINE=InnoDB;


DELETE FROM sysAccessRights WHERE TranTypeID = 200;
DELETE FROM sysAccessGroupRights WHERE TranTypeID = 200;
DELETE FROM sysAccess1Types WHERE TypeID = 200;
INSERT INTO sysAccessTypes (TypeID, TypeName, Enabled) VALUES (200, 'Promo''s by Coupons', 1);
UPDATE sysAccessTypes SET SequenceNo = 4, Category = '04: Backend - MasterFiles' WHERE TypeID = 200;
INSERT INTO sysAccessGroupRights (GroupID, TranTypeID, AllowRead, AllowWrite) SELECT GroupID, 200, AllowRead, AllowWrite FROM sysAccessGroupRights WHERE TranTypeID=17;
INSERT INTO sysAccessRights (UID, TranTypeID, AllowRead, AllowWrite) SELECT UID, 200, AllowRead, AllowWrite FROM sysAccessRights WHERE TranTypeID=17;


UPDATE sysAccessTypes SET TypeName = 'Promo''s by Amount' WHERE TypeID = 17;

/*********************************  v_4.0.1.50.sql END  *******************************************************/ 

UPDATE tblTerminal SET DBVersion = '4.0.1.51';


/*********************************  v_4.0.1.51.sql END  *******************************************************/ 

UPDATE tblTerminal SET DBVersion = '4.0.1.52';

/*********************************  v_4.0.1.52.sql END  *******************************************************/ 

UPDATE tblTerminal SET DBVersion = '4.0.1.53';

/*********************************  v_4.0.1.53.sql END  *******************************************************/ 

UPDATE tblTerminal SET DBVersion = '4.0.1.54';

-- 29Jul2015 : For Hatsune
--			 : BSDDiscountCode is used to determine the Discount which will be use to compute a special Discount
--			   using the ff formula:
--					Subtotal / [no of diners] * 10 diners = Total Bill For 10 diners
--					Total Bill For 10 Diners * 20% = Total Discounted Bill
--			 : BSDDiscountCodeDinerCount is used to determine the discountable no. of max Diners 

DELETE FROM sysConfig WHERE ConfigName = 'BSDDiscountCode';
INSERT INTO sysConfig (ConfigName, Category, ConfigValue) VALUES ('BSDDiscountCode',	'FE', 'BSD');

DELETE FROM sysConfig WHERE ConfigName = 'BSDDiscountCodeDinerCount';
INSERT INTO sysConfig (ConfigName, Category, ConfigValue) VALUES ('BSDDiscountCodeDinerCount',	'FE', '10');


/*********************************  v_4.0.1.54.sql END  *******************************************************/ 

UPDATE tblTerminal SET DBVersion = '4.0.1.55';



/*********************************  v_4.0.1.55.sql END  *******************************************************/ 

UPDATE tblTerminal SET DBVersion = '4.0.1.56';

-- 20Aug2015 : rename the deleted_ tables to xxx_ so that it will be at the bottom

RENAME TABLE deleted_tblbranchinventory_old TO xxx_tblbranchinventory_old;
RENAME TABLE deleted_tblbranchinventorymatrix_old TO xxx_tblbranchinventorymatrix_old;
RENAME TABLE deleted_tblinvadjustmentitems TO xxx_tblinvadjustmentitems;
RENAME TABLE deleted_tblmatrixpackage TO xxx_tblmatrixpackage;
RENAME TABLE deleted_tblmatrixpackagepricehistory TO xxx_tblmatrixpackagepricehistory;
RENAME TABLE deleted_tblproductbasevariationsmatrix TO xxx_tblproductbasevariationsmatrix;
RENAME TABLE deleted_tblproductprices TO xxx_tblproductprices;
RENAME TABLE deleted_tblproducts TO xxx_tblproducts;
RENAME TABLE deleted_tblreceiptformat TO xxx_tblreceiptformat;
RENAME TABLE deleted_tblremotebranchinventory TO xxx_tblremotebranchinventory;
RENAME TABLE deleted_tbltransactionnos TO xxx_tbltransactionnos;
RENAME TABLE deleted_tblbranchinventory TO xxx_tblbranchinventory;

-- 20Aug2015 : check if there are still un-renamed
SELECT CONCAT('RENAME TABLE ', TABLE_NAME, ' TO xxx_', RIGHT(TABLE_NAME,LENGTH(TABLE_NAME) - 8),';') FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA IN ('posea', 'posaudit') AND TABLE_NAME LIKE 'deleted_%';


DELETE FROM sysConfig WHERE ConfigName = 'ProdLastSyncDateTime';
INSERT INTO sysConfig (ConfigName, Category, ConfigValue) VALUES ('ProdLastSyncDateTime',	'Sync', '2015-06-29 18:00');

-- ProdSyncInterval : Product Sync Interval This is in minutes
DELETE FROM sysConfig WHERE ConfigName = 'ProdSyncInterval';
INSERT INTO sysConfig (ConfigName, Category, ConfigValue) VALUES ('ProdSyncInterval',	'Sync', '30');














-- Notes: Please read
-- run the retailplus_proc.sql

-- make sure to create a cerberus ftp with the following credintials
-- ftp username: ftprbsuser
-- ftp password: ftprbspwd
-- directory: subgroupimages	for subgroupsimages
-- directory: retailplusclient	for updated executable file
-- directory: attachment		for attachments of Trx Items

-- Add POSAuditUser see above

-- GRANT ALL PRIVILEGES ON pos.* TO POSAuditUser IDENTIFIED BY 'posauditpwd' WITH GRANT OPTION;
-- FLUSH PRIVILEGES;

-- add RetailPlusTagPricePrinter same as RetailPlusBarcodePrinter (TSCLIB)
