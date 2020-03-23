# Get-ADGroups

Get-ADGroups is a script used to gather Active Directory groups and users within those groups. It can be used to gather all groups in AD or specifically which groups.

# Usage
#Examples
Gathers all groups and users of those groups from Active Directory
Get-ADGroups

Gathers groups and users of groups with "Marketing" in their name
Get-ADGroups -ADGroupFilter "*Marketing*"

# Parameters
-ADGroupFilter <string>
Filter for groups

# Further Help
For further help use Get-ADGroups -?
