CREATE TABLE APP_CONFIGURATION (
VERSION varchar(15) NOT NULL,
BACKGROUND varchar(200),
ALERTSTATUS integer(2) NOT NULL DEFAULT(0),
TOUCHPASSWORD varchar(12),
IFPASSWORD integer(2) NOT NULL DEFAULT(0),
STARTDATE varchar(36),
LASTDATE varchar(36),
BILLDATE integer(2) NOT NULL DEFAULT(1)
);
CREATE TABLE BASE_CATEGORY (
CID varchar(36) PRIMARY KEY NOT NULL,
CNAME nvarchar(16) NOT NULL,
CCODE varchar(12) NOT NULL,
CPARENTCODE varchar(12) NOT NULL,
CSORT integer(4) NOT NULL DEFAULT(1),
CREATETIME varchar(128) NOT NULL,
CTYPE integer(2) NOT NULL DEFAULT(0),
ISVALID integer(2) NOT NULL DEFAULT(1),
CCOLOR char(2) NOT NULL DEFAULT('1')
);
CREATE UNIQUE INDEX BASECATEGORY_INDEX_CID ON BASE_CATEGORY (CID ASC);
CREATE TABLE BASE_FAMILY (
FID varchar(36) PRIMARY KEY NOT NULL,
FNAME varchar(36) NOT NULL,
FSORT integer(4) NOT NULL DEFAULT(0),
CREATETIME varchar NOT NULL,
ISEDIT char(1) NOT NULL DEFAULT('0'),
FPHOTO varchar(128) NOT NULL DEFAULT(''),
ACCOUNT varchar(36),
ACCOUNTFROM varchar(36)
);
CREATE UNIQUE INDEX BASEFAMILY_INDEX_FID ON BASE_FAMILY (FID ASC);
CREATE TABLE BUS_BUDGET (
BID integer PRIMARY KEY AUTOINCREMENT NOT NULL,
BYEAR varchar(4) NOT NULL,
BMONTH varchar(2) NOT NULL,
BVALUE double NOT NULL DEFAULT(0)
);
CREATE TABLE BUS_EXPENDITURE (
EID varchar(36) PRIMARY KEY NOT NULL,
EVALUE double(10) NOT NULL DEFAULT(0),
CID varchar,
FID varchar,
CREATETIME varchar NOT NULL,
EYEAR varchar(4) NOT NULL,
EMONTH varchar(6) NOT NULL,
EDAY varchar(8) NOT NULL,
IMARK nvarchar(36),
PID varchar(36),
BDX varchar(50),
BDY varchar(50),
BDADDRESS nvarchar(200),
PHOTO1 nvarchar(100),
OUTBUDGET integer(2) NOT NULL DEFAULT(0),
ISPRIVATE integer(2) NOT NULL DEFAULT(0),
FOREIGN KEY (CID) REFERENCES BASE_CATEGORY (CID) ON DELETE SET NULL,
FOREIGN KEY (FID) REFERENCES BASE_FAMILY (FID) ON DELETE SET NULL,
FOREIGN KEY (PID) REFERENCES BASE_PACKAGE (PID) ON DELETE SET NULL
);
CREATE UNIQUE INDEX BUSEXPENDITURE_INDEX_EID ON BUS_EXPENDITURE (EID ASC);
CREATE TABLE BUS_INCOME (
IID varchar(36) PRIMARY KEY NOT NULL,
CID varchar,
FID varchar,
IVALUE double(10) NOT NULL DEFAULT(0),
CREATETIME varchar NOT NULL,
IYEAR varchar(4) NOT NULL,
IMONTH varchar(6) NOT NULL,
IDAY varchar(8),
IMARK nvarchar(36),
PID varchar(36),
ISPRIVATE integer(2) NOT NULL DEFAULT(0),
FOREIGN KEY (CID) REFERENCES BASE_CATEGORY (CID) ON DELETE SET NULL,
FOREIGN KEY (FID) REFERENCES BASE_FAMILY (FID) ON DELETE SET NULL,
FOREIGN KEY (PID) REFERENCES BASE_PACKAGE (PID) ON DELETE SET NULL
);
CREATE UNIQUE INDEX BUSINCOME_INDEX_IID ON BUS_INCOME (IID ASC);
CREATE TABLE BUS_PLANEXPENDITURE (
EID varchar(36) PRIMARY KEY NOT NULL,
EVALUE double(10) NOT NULL DEFAULT(0),
CID varchar,
FID varchar,
CREATETIME varchar NOT NULL,
EYEAR varchar(4) NOT NULL,
EMONTH varchar(6) NOT NULL,
EDAY varchar(8) NOT NULL,
IMARK nvarchar(36),
PID varchar(36),
BDX varchar(50),
BDY varchar(50),
BDADDRESS nvarchar(200),
PHOTO1 nvarchar(100),
OUTBUDGET integer(2) NOT NULL DEFAULT(0),
ISPRIVATE integer(2) NOT NULL DEFAULT(0),
PTYPE integer(2) NOT NULL DEFAULT(1),
IFALERT integer(2) NOT NULL DEFAULT(1),
FOREIGN KEY (CID) REFERENCES BASE_CATEGORY (CID) ON DELETE SET NULL,
FOREIGN KEY (FID) REFERENCES BASE_FAMILY (FID) ON DELETE SET NULL,
FOREIGN KEY (PID) REFERENCES BASE_PACKAGE (PID) ON DELETE SET NULL
);
CREATE UNIQUE INDEX BUSPLANEXPENDITURE_EID ON BUS_PLANEXPENDITURE (EID ASC);
