## Quick PowerShell script to query inactive/disabled computers in Active Directory for removal.

## Make sure RSAT/PowerShell remoting is installed and configured to execute script remotely with Invoke-Command.
Invoke-Command -ComputerName "DCSRV1" -ScriptBlock {
    ## Query all Active Directory computer objects then filter out each disabled ones, storing them in disabledComputers.
    $disabledComputers = Get-ADComputer -Filter * | Where-Object { $_.Enabled -eq $false };
    ## Iterate through each disabled computer.
    foreach ($disabled in $disabledComputers) {
        ## Remove disabled computer object without confirmation and all child objects.
	    Remove-ADObject -Identity $disabled -Confirm:$false -Recursive;
    }
}