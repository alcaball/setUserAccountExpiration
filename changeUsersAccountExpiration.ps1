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
Read-Host "Enter username below."

Do{
    $input = (Read-Host "input username")
    $input2 = (Read-Host "More users, y or n?")
    #if($input2 -ne 'n'){
        $usernames += $input
  #      }

}Until($input2 -eq 'n')



$usernames

#insert exceptionHandling


# Get new expiration date

$newDate = (Read-Host "Enter new Expiration Date with Format MM/DD/YYYY")

#insert exceptionHandling


foreach($u in $usernames){
    
    Set-ADAccountExpiration -Identity $u -DateTime $newDate

}



# Read array and set expiration date to new date

foreach($u in $usernames){

    Get-ADUser -Identity $u –Properties "DisplayName", "msDS-UserPasswordExpiryTimeComputed" | Select-Object -Property "Displayname",@{Name="ExpiryDate";Expression={[datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed")}}

}