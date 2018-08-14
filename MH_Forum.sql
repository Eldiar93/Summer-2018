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
	,SmalllestSize	decimal(99999,1)	NULL		
	,LargestSize	decimal(99999,1)	NULL
	,Element		varchar(40)			NULL
	,Blight			varchar(50)			NULL
	,MonsterType	varchar(40)			NOT NULL
)

GO
Create Table dbo.Habitat
(
	HabitatID		tinyint				PRIMARY KEY	Identity
	,HabitatName	varchar(40)			NOT NULL	Unique
	,NumAreas		tinyint				Check(NumAreas Between 1 AND 25)
)

GO
