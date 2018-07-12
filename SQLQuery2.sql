--Practicing TSQL Functions
--CPW 210

print CONCAT('Bryce', ' ', 'Rowley')

Select CONCAT(VendorCity, ', ', VendorState)
From Vendors

Declare @phone varchar(20)
Set @phone = '(253) 589-5580' 

Set @phone = REPLACE(@phone, '-', '')
Set @phone = REPLACE(@phone, '(', '')
Set @phone = REPLACE(@phone, ')', '')
Set @phone = REPLACE(@phone, ' ', '')

Set @phone = STUFF(@phone, 7, 0, '-')
Set @phone = STUFF(@phone, 4, 0, ')')
Set @phone = STUFF(@phone, 1, 0, '(')
print @phone



print LEN('Bryce Rowley')
print LEN('Bryce Rowley                      ')
print LEN('                     Bryce Rowley')

Declare @fullName varchar(25)

Set @fullName = '    Bryce Rowley       '
print @fullname

Set @fullName = RTRIM(@fullName)
print @fullName

Set @fullName = LTRIM(@fullName)
print @fullName

--figure out how old in days you are
print DATEDIFF(MONTH, GETDATE(), 'November 01, 1993')