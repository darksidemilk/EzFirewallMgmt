function Remove-ProgramRule {
    <#
    .SYNOPSIS
    Removes a program firewall rule
    
    .DESCRIPTION
    Creates a search string with given parameters using Get-ProgramRuleName and appends a wildcard '*'
    Then uses Remove-NetFirewallRule to remove all matching firewall rules
    
    .PARAMETER type
    Can be Unblock or Block
    
    .PARAMETER program
    The program name used to create the rule
    
    .PARAMETER exe
    The specific exe filename controlled by the rule. Defaults to a wildcard '*'
    To get all exe's created in a rule created by name
    
    .EXAMPLE
    Remove-Program -type "Block" -program "steam"

    Will remove all the block rules matching "Block program steam - *". 
    Because maybe you ungrounded your kid from video games.
    
    .LINK
    Remove-ProgramRule

    .LINK
    Get-ProgramRuleName

    .LINK
    Block-Program
    
    .LINK
    Unblock-Program

    .LINK
    Remove-NetFirewallRule

    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [ValidateSet("Block","Unblock")]
        [string]$type,
        [string]$program,
        [string]$exe="*"
    )
    
    begin {
        # $removedRules = New-Object System.Collections.Generic.List[object];
    }
    
    process {
        $programRule = Get-ProgramRuleName -type $type -program $program -exe $exe;

        $removedRules = Get-NetFirewallRule -Name "$ProgramRule" -EA 0;
        Get-NetFirewallRule -Name "$ProgramRule" | Remove-NetFirewallRule -EA 0;
    }
    
    end {
        if ($null -eq $removedRules) {
            "Some or all Rules didn't exist" | Out-Host
        }
        return $removedRules;
    }
}