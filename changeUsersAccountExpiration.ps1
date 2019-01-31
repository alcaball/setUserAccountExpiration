# Purpose:
#     This script will change a list of users' Account Expiration date to a new date
# Input:
#     Array of Users
#     New Date
# Output:
#     Test Display Confirmation of New Account Expiration Dates for users
# Author: 
#     Anne Caballero
# Created:
#     1/30/2019
# Last Updated:
#     1/30/2019




<# ------------------Start Code----------------  #>

# Part 1 Get user input

# Get user input via command line and save input to an array
# When user is done, user inputs string 'END' which will mark the end of the array


$usernames = @()

Do{
    $input = (Read-Host "Enter username, type DONE to exit")
    if($input -ne 'DONE'){
        $usernames += $input
        }

}Until($input -eq 'DONE')



$usernames

# Insert exceptionHandling


# Get new expiration date

$newDate = (Read-Host "Enter new Expiration Date with Format MM/DD/YYYY")

# Insert exceptionHandling


# Read array and set expiration date to new date


foreach($u in $usernames){
    
    Set-ADAccountExpiration -Identity $u -DateTime [datetime]$newDate

}


# Display List of users and their new expiration date


foreach($u in $usernames){

    Get-ADUser -Identity $u –Properties "DisplayName", "msDS-UserPasswordExpiryTimeComputed" | Select-Object -Property "Displayname",@{Name="ExpiryDate";Expression={[datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed")}}

}
