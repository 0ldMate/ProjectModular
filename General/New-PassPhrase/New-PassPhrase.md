# New-PassPhrase

New-PassPhrase is a script used to generate random passwords based off a wordlist. It is recommended to expand the current wordlist for more security. There are many means to generating a list of random words such as webistes or already pre made dictionaries.

# Usage
#Examples
Generates password with minimum length of 20 characters
New-PassPhrase -MinLength 20

Generate a password with minimum length of 15 characters with the delimeter of ';'
New-PassPhrase -MinLength 15 -delimiter ';'

# Parameters
-MinLength <int>
Minimum character length

-Delimiter <char>
Delimiter between words

-PhraseFile <string>
Location of the wordlist

# Further Help
For further help use New-PassPhrase -?

Script written by colleague
