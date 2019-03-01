# Purpose:
#     This script will change a list of users' Account Expiration date to a new date
# Input:
#     Array of Users
#     New Date
# Output:
#     Test Display Confirmation of New Account Expiration Dates for users
# Author: 
#     Anne Caballero
# Collaborators
#     Adnan Abdulai
#     Jonathan Leemur
#     Juan Z
#     Mooch
# Created:
#     1/30/2019
# Last Updated:
#     2/6/2019


# Function Name: Get-NewExpirationDate
# Parameters: None
# Return value : $expDate ; DateTime object
# Purpose: Function will get the current date, adds 90 days from current date, calculates the current date's day of the week and calculates the nearest thursday from that date






# Function Name: Get-NewExpirationDate
# Parameters: None
# Return value : $expDate ; DateTime object
# Purpose: Function will get the current date, adds 90 days from current date, calculates the current date's day of the week and calculates the nearest thursday from that date



function Get-NewExpirationDate {

    $todayDate = Get-Date
    
    $plus90Days = $todayDate.AddDays(90)
    
    $dayOfTheWeek = $plus90Days.DayOfWeek

    
    switch($dayOfTheWeek) {
     
    
        'Sunday'  { $expDate = $plus90Days.AddDays(-3) ; break  }
        'Monday'  {  $expDate = $plus90Days.AddDays(-4) ; break  }
        'Tuesday'  {  $expDate = $plus90Days.AddDays(-5) ; break  }
        'Wednesday'  {  $expDate = $plus90Days.AddDays(-6) ; break  }
        'Thursday'  { $expDate = $plus90Days ;  break  }
        'Friday'  {  $expDate = $plus90Days.AddDays(-1) ; break  }
        'Saturday'  {  $expDate = $plus90Days.AddDays(-2) ; break  }
    }


    return $expDate
}



<# ------------------Start Code----------------  #>


# Get user input via command line and save input to an array
# When user is done, user inputs string 'DONE' which will mark the end of the array


$usernames = @()

Do{
    $input = (Read-Host "Enter username, type DONE to exit")
    if($input -ne 'DONE'){
        $usernames += $input
        }

}Until($input -eq 'DONE')



Write-Host "Usernames:"
Write-Host $usernames

# Insert exceptionHandling



# Get new expiration date
$newDate = Get-NewExpirationDate | Get-Date
$expDate = $newDate.AddDays(1)

# Insert exceptionHandling


# Read array and set expiration date to new date

foreach($u in $usernames){
   
    Set-ADAccountExpiration -Identity $u -DateTime $expDate

}


# Display List of users and their new expiration date


write-host "Pausing for 15 seconds to update Account Expiration Dates" -foregroundcolor yellow
Write-Host "`n`n`n"

start-sleep -s 15


foreach($u in $usernames){

  
    Get-ADuser $u  -Properties * | Select-Object -Property "samAccountName",  @{Name=“AccountExpires”;Expression={[datetime]::FromFileTime($_.Accountexpires)}}

}


write-host "Process is complete" -foregroundcolor magenta
Write-Host "`n`n`n"
write-host "Press any key to exit..." 
Write-Host "`n`n`n"

$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")



