# Get-RemoteADComputer

Get-RemoteADComputer is a script used to get the computer name of a user in AD. It searches the description field of computers in AD for the name input to return the value of the computer name.

# Usage
#Examples
Searches for a computer in AD with the description filed "Michael Scott"
Get-RemoteADComputer -Name "Michael Scott"

# Parameters
-Name <string>
Name of the person whose computer name you want to know

# Further Help
For further help use Get-RemoteADComputer -?
