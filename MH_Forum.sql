USE master

Drop Database IF EXISTS MonsterHunterForum

Create Database MonsterHunterforum
GO

USE MonsterHunterForum

GO

Create Table dbo.LargeMonster
(
	LMonsterID		tinyint				PRIMARY KEY Identity
	,LMonsterName	varchar(30)			NOT NULL	Unique
	,SmalllestSize	decimal(10,1)		NULL		
	,LargestSize	decimal(10,1)		NULL
	,Element		varchar(40)			NULL
	,Blight			varchar(50)			NULL
	,MonsterType	varchar(40)			NOT NULL
	,"Description"	varchar(500)		NULL
	,HabitatID		tinyint				FOREIGN KEY REFERENCES Habitat(HabitatID)
	,ArmorID		smallint			FOREIGN KEY REFERENCES Armor(ArmorID)
)
GO

GO
Create Table dbo.Habitat
(
	HabitatID		tinyint				PRIMARY KEY	Identity
	,HabitatName	varchar(40)			NOT NULL	Unique
	,NumAreas		tinyint				Check(NumAreas Between 1 AND 25)
)

GO

GO
Create Table dbo.Armor
(
	/*The armor table will show the full armor sets when all piece(s) are worn together.
	This is because each armor is made up of 1-5 pieces
	of armor that goes on diferent body parts.
	Each armor piece has individual data and values attached to them. 
	Not every would want to look at the individual 
	pieces so this can be considered and overview table.
	*/
	ArmorID			smallint			PRIMARY KEY Identity
	,ArmorName		varchar(50)			NOT NULL	Unique
	--MinSetDefense is the total defense the amorset has in its base form before being upgraded.
	,MinSetDefense	smallint			NOT NULL	Check(MinSetDefense Between 20 AND 999)
	--UpSetDefense is the total defense the armorset has when upgraded without also being augmented.
	,UpSetDefense	smallint			NOT NULL	Check(UpSetDefense Between 20 AND 999)
	--AugSetDefense is total defense the armoset has when augmented AND upgraded all the way
	,AugSetDefense	smallint			NOT NULL	Check(AugSetDefense Between 20 AND 999)
	--SetBonus: a lot of the higher ranked armor sets have skills called Set Bonuses 
	--that you get when you wear multiple armor pieces at the same time.
	--the problem we run into is that we can sometimes have 1 or 2 set bonuses per armor set
	,SetSkills		varchar(200)		NULL
	--Resistances are how much resistance this armor set has to that certain element.
	,FireRes		tinyint				NOT NULL	Check(FireRes Between -30 AND 30)
	,WaterRes		tinyint				NOT NULL	Check(WaterRes Between -30 AND 30)
	,ThunderRes		tinyint				NOT NULL	Check(ThunderRes Between -30 AND 30)
	,IceRes			tinyint				NOT NULL	Check(IceRes Between -30 AND 30)
	,DragonRes		tinyint				NOT NULL	Check(DragonRes Between -30 AND 30)
	,Rank			varchar(7)			NOT NULL	Check(Rank IN ('Normal', 'Alpha', 'Beta', 'Gamma'))
	,ArmorPieceID	int					FOREIGN KEY References ArmorPiece(ArmorPieceID)
)
GO

GO
Create Table ArmorPiece
(
	ArmorPieceID	int					PRIMARY KEY Identity
	,PieceName		varchar(40)			NOT NULL	Unique
	,BodyPart		varchar(6)			NOT NULL	Check(BodyPart IN ('Head', 'Chest', 'Arm', 'Waist', 'Legs'))
	,Skills			varchar(100)		NULL		
)
GO
