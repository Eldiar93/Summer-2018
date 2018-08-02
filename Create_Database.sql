/*
	Author: Bryce Rowley
	Description: Creates the database
		for Joe's Used Car Emporium
	Date: July 24th, 2018
*/
Use master

Drop database IF EXISTS JoesCars

Create Database JoesCars
GO

Use JoesCars

/*****************************************************
		CREATE TABLES
*****************************************************/

Go 

--This creates a schema to be used when
--creating tables, instead of dbo
----Create SCHEMA Vehicle
Go

Create Table dbo.Make
(
	MakeID		tinyint		PRIMARY KEY Identity
	,MakeName	varchar(15)	NOT NULL UNIQUE
	,StartYear	smallint	NOT NULL CHECK(StartYear < YEAR(GETDATE()) + 2 AND StartYear >= 1878)
	,EndYear	smallint	NULL	 ,Check(EndYear >= StartYear)
)

Insert Into Make(MakeName ,Startyear ,EndYear)
	Values ('Honda' ,'1948' ,NULL)
		,('BMW' ,1950 , 2028)

Create Table dbo.Model
(
	ModelID		smallint	Primary Key Identity
	,ModelName	varchar(30)	NOT NULL Unique CHECK(LEN(ModelName) >= 1)
	,StartYear	smallint	NOT NULL CHECK(StartYear < YEAR(GETDATE()) + 2 AND StartYear >= 1878)
	,EndYear	smallint	NULL	 ,Check(EndYear >= StartYear)
	,MakeID		tinyint		References Make(MakeID)
)

Insert Into Model(ModelName ,StartYear ,MakeID)
	Values('Prelude' ,1985 ,1)
		,('M3' ,1980 ,2)

--Get a list of all makes and models available
--Select ModelName ,MakeName
--From Model JOIN Make ON
	--Model.MakeID = Make.MakeID

Create Table Vehicle
(
	VIN					char(17)		Primary Key
	--store basic colors (red, blue, yellow, etc.
	,Color				varchar(50)
	,Description		varchar(500) 	NOT NULL	DEFAULT 'Call for information'
	,ModelID			smallint		NOT NULL	REFERENCES Model(ModelID)
	,Year				smallint		NOT NULL
	,Mileage			int				NULL		CHECK (Mileage >= 0)
	,Condition			varchar(7)		NULL		CHECK(Condition IN('Perfect' ,'Good' ,'Fair'))
	,IsOutsidePurchase	bit				NOT NULL	DEFAULT 'false'
	--,StickerPrice		money
	--9,999,999.99 (9 digits total 2 to the right of the decimal point)
	,StickerPrice		numeric(9, 2)	NOT NULL	CHECK(StickerPrice > 0)
	,PurchaseDate		date			NOT NULL	
	,CarFaxURL			varchar(500)	NULL
)

Create Table Customer
(
	CustomerID		int				Primary Key
	,FirstName		varchar(30)		NOT NULL
	,LastName		varchar(40)		NOT NULL
	,Street			varchar(75)		NULL
	,City			varchar(60)		NULL
	,State			char(2)			NULL
	,Zip			char(5)			NULL
	,Phone			char(10)		NULL
	,Email			varchar(255)	NOT NULL
)

Create Table CustomerVehicles
(
	CustomerID	int			REFERENCES Customer(CustomerID)
	,VIN		char(17)	REFERENCES Vehicle(VIN)
	,Primary Key(CustomerID, VIN)	
)

GO
Create View vw_VehicleSummary
AS
	Select VIN, MakeName, ModelName
	From Vehicle
		JOIN Model ON Vehicle.ModelID = Model.ModelID
		JOIN Make ON Model.MakeID = Make.MakeID

GO

CREATE Index IX_Customer_LastName
	ON dbo.Customer
	(LastName)