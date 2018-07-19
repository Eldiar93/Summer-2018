-- Name: Bryce Rowley
-- Date: July 10, 2018
-- Class: CPW 210
-- Assignment: Select Queries
--
--Problem 1
Select Size ,DaysToManufacture 
From Production.Product
Where size > 50 AND SizeUnitMeasureCode = 'CM' AND DaysToManufacture >= 1

--Problem 2
Select Size ,DaysToManufacture, Color 
From Production.Product
Where size > 50 AND SizeUnitMeasureCode = 'CM' AND DaysToManufacture >= 1 AND ((Color LIKE 'Red') OR (Color LIKE 'Yell'))

--Problem 3
Select Weight 
From Production.Product
Where Weight IS NULL

--Problem 4
Select FirstName, LastName
From Person.Person
Where FirstName LIKE 'Alex' AND ((LastName LIKE '[a]%') OR  (LastName LIKE '[e]%') OR (LastName LIKE '[i]%') OR (LastName LIKE '[o]%') OR (LastName LIKE '[u]%') OR (LastName LIKE '[y]%'))

--Problem 5
Select JobTitle, BirthDate, DATEDIFF(year, 1965, 1975) 
From HumanResources.Employee
Where (JobTitle LIKE '%Engineer%') OR (JobTitle LIKE '%Technician%')  --AND YEAR(BirthDate)  BETWEEN 66 AND 75
Order By BirthDate

--Problem 6
Select * From Production.ProductPhoto
Where YEAR(ModifiedDate) BETWEEN YEAR(GETDATE()) AND (YEAR(GETDATE()) - 3)
--Select (YEAR(GETDATE()) - 3)
ORDER BY ModifiedDate DESC

--Problem 7
Select HireDate 
From HumanResources.Employee
Where MONTH(HireDate) BETWEEN 06 AND 08
Order By HireDate

print month(6)