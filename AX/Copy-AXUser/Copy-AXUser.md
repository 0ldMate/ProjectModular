# Copy-AXUser

Copy-AXUser is a script used to replicate the copy user function in AD but for Microsoft Dynamics AX. It copies permissions from user to another, if the user does not exist it creates an account for them. Used in the account creation script.

# Prerequisites
Microsoft Dynamics AX 2012 Tools - Check Prerequisites folder for install instructions

# Usage
#Examples
Creates user with data from the account creation process
Copy-AXUser

Copies user permissions from MJack to BRoss
Copy-AXUser -AXUserName MJack -CopyUser BRoss SAMAccountName MJackson -AXDomain company.com.au

# Parameters
-AXUserName <string>
Target Username of user in AX

-CopyUser <string>
Username of person to copy from in AX

-SAMAccountName <string>
Used by account creation script to generate username

-AXDomain <string>
Domain of AX

# Further Help
For further help use Copy-AXUser -?
