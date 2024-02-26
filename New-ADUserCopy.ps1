## Quickly create a new user in Active Directory with the same existing template.

## Input new information in the shell (remove/add AD user objects according to organizational policies).
$samCopy = Read-Host "Enter existing AD SAM account name to copy: "
$newSam = Read-Host "Enter new AD SAM account name: "
$newFirstname = Read-Host "Enter new first name: "
$newLastname = Read-Host "Enter new last name: "
$newName = Read-Host "Enter a new username: "
$newPassword = Read-Host "Enter a password: "
$newDescription = Read-Host "Enter a description for this user: "
$newOUName = Read-Host "Enter a new OU name: "
$enableUser = $true
$passExpire = $false
$changePass = $false

## Retrieve properties of the existing user from Active Directory, including groups.
$adUserCopy = Get-Aduser $samCopy -Properties memberOf
## Create hashtable that contains properties of new AD user. Convert plaintext password into secure hash.
$params = @{'SamAccountName' = $newSam;
            'Instance' = $adUserCopy;
            'GivenName' = $newFirstname;
            'SurName' = $newLastname;
            'PasswordNeverExpires' = $passExpire;
            'CannotChangePassword' = $changePass;
            'Description' = $newDescription;
            'Enabled' = $enableUser;
            'AccountPassword' = (ConvertTo-SecureString -AsPlainText $newPassword -Force);
            }

## Create the new user account in Active Directory using new properties.
New-ADUser -Name $newName @params

## Copy the groups the original account was a member of for new user.
$adUserCopy.Memberof | ForEach-Object {Add-ADGroupMember $_ $newSam }

## Move new user to specified OU.
Get-ADUser $newSam | Move-ADObject -TargetPath $newOUName