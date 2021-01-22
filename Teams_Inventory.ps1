# Jerry Freund
# Microsoft Teams Inventory Script
# V 1.0.0
# 04/09/2018
# This script outputs an inventory of Microsoft Teams Sites and their respectives users and roles
#
#
# WARNING, this script will generate PII data (Personaly Identifiable Information)
# Please secure this file appropriatly
# NEVER SEND PII data by email
#
# You are running this script at your own responsability
# Provided as is 


# Requires an admin login/Teams login
# Requires PowerShell for Teams 
# Developper note, you should encrypt the output with (Get-Item –Path C:\yourfile.txt).Encrypt()




Write-Output "/!\ WARNING, this script will generate PII data (Personaly Identifiable Information) /!\"
Write-Output "/!\ Please secure this file appropriatly                                             /!\ "
Write-Output "/!\ NEVER SEND PII data by email                                                     /!\ "
Write-Output "/!\ You are running this script at your own responsability                           /!\ "
Write-Output ""

$continue = Read-Host "Do you wish to Proceed type[Y]es or [N]o and press [Enter]"
$continue = $continue.ToLower()

 

if($continue -eq "n" -or $continue -eq "no"){

    #exit the script
    Write-Output "Exiting now ..."
    exit

}else{

    #continue
    Write-Output "Executing the script ..."

}

#################################################################


$gID = Get-Team | ForEach-Object GroupId
$tName = Get-Team | ForEach-Object DisplayName

<# $mName = Get-TeamUser -GroupId $list[$i] | ForEach-Object Name
$mRole = Get-TeamUser -GroupId $list[$i] | ForEach-Object Role
$mUser = Get-TeamUser -GroupId $list[$i] | ForEach-Object User
$mUserId = Get-TeamUser -GroupId $list[$i] | ForEach-Object UserId
$userLength = $mName.Length #>

##


for ($i = 0; $i -lt $gID.length; $i++){

    $mName = Get-TeamUser -GroupId $list[$i] | ForEach-Object Name
	$mRole = Get-TeamUser -GroupId $list[$i] | ForEach-Object Role
	$mUser = Get-TeamUser -GroupId $list[$i] | ForEach-Object User
	$mUserId = Get-TeamUser -GroupId $list[$i] | ForEach-Object UserId
	$userLength = $mName.Length
    
    "Site Name: ", $tName[$i]
    "Teams Site ID: ", $gID[$i]

    for($j = 0; $j -lt $userLength; $j++){
    
        $inventoryL = "$($tName[$i]), $($mRole[$j]),$($mName[$j]), $($mUser[$j]), $($mUserId[$j])"
        
        #Save the file
        #Modify this to match you env:path and file name
        $inventoryL >> C:\Users\$env:UserName\Documents\Teams_Inventory.txt
        $inventoryL

    }

    ""
    ""

    "Channel(s) on this site:"
    Get-TeamChannel -GroupId $gID[$i] | ForEach-Object DisplayName

    
    $count = Get-TeamChannel -GroupId $gID[$i] | ForEach-Object DisplayName
    
    foreach($MMM in $count){
        
        "-----------"
        $MMM
        
        Get-TeamChannelUser -GroupId $gID[$i] -DisplayName $MMM

        "-----------"
    }

    "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++" 

}




#(Get-Item –Path C:\Users\$env:UserName\Documents\Teams_Inventory.txt).Encrypt()
