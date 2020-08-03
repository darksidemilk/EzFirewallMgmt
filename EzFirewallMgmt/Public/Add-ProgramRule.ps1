function Add-ProgramRule {
    <#
    .SYNOPSIS
    Adds program rules via pipe
    
    .DESCRIPTION
    Runs through the list of paths and makes the rules
    Mainly meant for internal use to avoid repeated code
    
    .PARAMETER paths
    The list of paths generated during Block/Unblock-Program
    
    .PARAMETER type
    Block or Unblock, used to determin rule name and rule action
    
    .EXAMPLE
    $paths | Add-ProgramRule
    
    .LINK
    Add-ProgramRule

    .LINK
    Block-Program

    .LINK
    Unblock-Program

    .LINK
    Remove-ProgramRule

    .LINK
    Get-ProgramRulename

    .LINK
    New-NetfirewallRule

    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
        $paths,
        [Parameter()]
        [ValidateSet("Block","Unblock")]
        [string]$type,
        $count
    )
    
    begin {
        $newRules = New-Object System.Collections.Generic.List[object];
        $i = 1;
        # $count = $paths.count;
    }
    
    process {
        Write-Debug "paths list is $($paths | out-string)";
        if ($type -eq "Unblock") {
            $action = "Allow";
        } else {
            $action = "Block";
        }
        $paths | Foreach-Object {
            $ProgramRule = Get-ProgramRuleName -type $type -program $name -exe "$($_.Name)";
            Write-Progress -Activity "Creating Firewall Rules" -Status "$i of $count" -Id 1 -PercentComplete (($i/$count)*100) -CurrentOperation "Creating $ProgramRule rules";
           
            if ($null -eq (Get-NetFirewallRule -Name "$ProgramRule*") ) {
           
                Write-Debug "Creating '$($programRule) inbound'";
                Write-Progress -Activity "Creating $ProgramRule" -Status "creating inbound/outbound rules" -Id 2 -parentid 1 -CurrentOperation "Creating inbound rule";
                $newRules.add((New-NetFirewallRule -DisplayName "$ProgramRule inbound" -Name "$ProgramRule inbound" -Action $action -Profile Any -Direction Inbound -Program "$($_.Fullname)"))
                
                Write-Debug "Creating '$($programRule) outbound'";
                Write-Progress -Activity "Creating $ProgramRule" -Status "creating inbound/outbound rules" -Id 2 -parentid 1 -CurrentOperation "Creating outbound rule";
                $newRules.add((New-NetFirewallRule -DisplayName "$ProgramRule outbound" -Name "$ProgramRule Outbound" -Action $action -Profile Any -Direction Outbound -Program "$($_.Fullname)"))      
           
                Write-Progress -Activity "Creating $ProgramRule" -Status "creating inbound/outbound rules" -Id 2 -parentid 1 -Completed
            } else {
                "$ProgramRule already exists" | Out-Host;
           }
           $i++;
        }
    }
    
    end {
        Write-Progress -Activity "Creating Firewall Rules" -Status "$i of $count" -Id 1 -Completed;
        if ($null -eq $newRules) {
            "Some or all Rules already existed" | Out-Host
        }
        return $newRules;
    }
}