USE master

Drop Database IF EXISTS MonsterHunterForum

Create Database MonsterHunterforum
GO

USE MonsterHunterForum
GO
Create Table dbo.Habitat
(
	HabitatID		tinyint				PRIMARY KEY	Identity
	,HabitatName	varchar(40)			NOT NULL	Unique
	,NumAreas		tinyint				Check(NumAreas Between 1 AND 25)
)

GO

GO
Create Table ArmorPiece
(
	ArmorPieceID	int					PRIMARY KEY Identity
	,PieceName		varchar(40)			NOT NULL	Unique
	,BodyPart		varchar(6)			NOT NULL	Check(BodyPart IN ('Head', 'Chest', 'Arm', 'Waist', 'Legs'))
	,Skills			varchar(100)		NULL
	--MinDefense is the total defense of the piece of armor has in its base form before being upgraded.
	,MinDefense		smallint			NOT NULL	Check(MinDefense Between 20 AND 999)
	--UpDefense is the total defense the piece of armor has when upgraded without also being augmented.
	,UpDefense		smallint			NOT NULL	Check(UpDefense Between 20 AND 999)
	--AugDefense is total defense the piece of armor has when augmented AND upgraded all the way
	,AugDefense		smallint			NOT NULL	Check(AugDefense Between 20 AND 999)		
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

Create Table LargeMonster
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
Create Table Weapon
(
	WeaponID		int					PRIMARY KEY	Identity
	,WeaponName		varchar(40)			NOT NULL	Unique
	,WeaponClass	varchar(20)			NOT NULL
	,Elements		varchar(30)			NULL
	,Status			varchar(20)			NULL
	,BaseAttack		numeric(4,0)		NOT NULL
	--need to add a check to this to ensure it always has a percent sign in it EX. -20%, 10%, -25%.
	,Affinity		varchar(4)			NULL
	--will always be in format of R(number. Ex. R8, R5
	,Rarity			Char(2)				NOT NULL
	,Defense		char(3)				NULL
	,Slots			char(4)				NULL
	--says from what tree of weapons it is crafted from or where you get it.
	,RootTree		varchar(15)			NOT NULL	CHECK(RootTree IN ('Bone', 'Ore', 'DragonBone', 'BlackSteel', 'WorkShop', 'Taroth', 'Lunastra', 'Deviljho'))
	--need to specify this more
	,ElderSeal		bit					NOT NULL	Default 'False'
	--NatSharpness is the base level of sharpness that it has Ex. Blue, Green
	--problem wit this and MaxSharpness is it has no way to show how much of said sharpness it has i.e. this weapon has 'this' much blue sharpness while this weapon only has a little white sharpness.
	,NatSharpness	varchar(6)			NOT NULL	CHECK(NatSharpness IN ('Red', 'Orange',  'Yellow', 'Green', 'Blue', 'White', 'Purple'))
	,MaxSharpness	varchar(6)			NOT NULL	CHECK(MaxSharpness IN ('Red', 'Orange',  'Yellow', 'Green', 'Blue', 'White', 'Purple'))
	,LMonsterID		tinyint				FOREIGN KEY REFERENCES LargeMonster(LMonsterID)
)
GO

GO
Create Table Skills
(
	SkillsID		int					PRIMARY KEY IDENTITY
	,SkillName		varchar(30)			NOT NULL	Unique
	,SkillDescript	varchar(300)		NULL
	,BaseEffect		varchar(100)		NOT NULL
	,MaxEffect		varchar(100)		NOT NULL
	,MaxLevels		numeric(1)			NOT NULL
	,IsSetBonus		bit					NOT NULL	Default 'False'
)
GO

GO
Create Table WeaponChar
(
	WeapCharID		int					PRIMARY KEY	IDENTITY
	,WeaponCharName	varchar(40)			NOT NULL
	,SkillsID		int					FOREIGN KEY REFERENCES Skills(SkillsID)
)
GO



GO
Create Table dbo.SmallMonsters
(
	SmallMonsterID	tinyint				PRIMARY KEY IDENTITY
	,SMonsterName	varchar(30)			NOT NULL	Unique
	,HabitatID		tinyint				FOREIGN KEY REFERENCES Habitat(HabitatID)
)
GO

GO
Create Table Items
(
	ItemID			int					PRIMARY KEY IDENTITY
	,ItemType		varchar(20)			NOT NULL
	,ItemDescript	varchar(200)		NULL				
)
GO

GO
Create Table CraftedItems
(
	CraftItemID		int					PRIMARY KEY IDENTITY
	,CraftItemName	varchar(30)			NOT NULL	Unique
	,ItemEffect		varchar(50)			NOT NULL
	,ItemsNeeded	varchar(50)			NULL
	,ItemClass		varchar(20)			NULL
)
GO

GO
Create Table CraftItem
(
	ItemID			int					NOT NULL	FOREIGN KEY REFERENCES Items(ItemID)
	,CraftItemID	int					NOT NULL	FOREIGN KEY REFERENCES CraftedItems(CraftItemID)
	,PRIMARY KEY(ItemID, CraftItemID)
)
GO


/*Attempted View that was supposed to be able to create mixed sets of armors and weapons, 
problem is it can only show the data of one armor piece at a time and cannot combine certain data togther like AugDefense, Slots and Skills
Create View Mixed_Sets AS
	Select WeaponName, WeaponClass, BaseAttack, Elements, Status, Affinity, PieceName, BodyPart, AugDefense, Slots, Skills
	From Weapon JOIN LargeMonster ON Weapon.WeaponID = LargeMonster.LMonsterID 
	JOIN Armor ON Weapon.WeaponID = Armor.ArmorID JOIN ArmorPiece ON Weapon.WeaponID = ArmorPiece.ArmorPieceID
*/
Insert Into LargeMonster (LMonsterName, SmalllestSize, LargestSize, Element, Blight, MonsterType)
Values	('Kulve Taroth', '4573.0', '4573.0', 'Fire', 'Fireblight', 'Elder Dragon')
Select * From LargeMonster

Insert Into Habitat (HabitatName,		NumAreas)
Values('Ancient Forest', '17'),
	('Wildspire Waste', '16'),
	('Coral Highlands', '15'),
	('Caves of Elderado','4'),
	('Elder''s Recess', '16'),
	('Rotten Vale',		'16') 

Insert Into Weapon(WeaponName, WeaponClass, BaseAttack, Rarity, RootTree, ElderSeal, NatSharpness, MaxSharpness, Elements, Affinity)
Values ('True Gae Bolg',	'Insect Glaive',	'589',	'R8',	'WorkShop',	'True', 'Blue', 'White', 'Dragon 300', '20%'),
		('Wyvern Ignition Impact', 'Great Sword',	'1008',	'R7', 'WorkShop',	'False', 'White', 'White', '(510 Fire)', '-15%'),
		('Metal Bagpipe I', 'Hunting Horn', '336', 'R1', 'Ore', 'False', 'Yellow', 'Green', NULL, '0%')
