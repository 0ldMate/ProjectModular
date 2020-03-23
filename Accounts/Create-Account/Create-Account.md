# Create-Account

Create-Account is a set of two scripts used to create accounts when a user has joined the company. These scripts are based off a .csv file that allows the user to create accounts in bulk. I have made this process into two parts.

Part 1
    The create-account script creates the AD account, and gives it permissions based off another user. After this script is run, the admin should setup the users profile on the computer and wait for Office365 to sync. After this is set up, move to part 2.

Part 2
    The reset-adpassword script resets the password of the account, enables the spanning license and emails the manager their users password and how to login. Once the user then logs in they will be force to reset his/her password.