function Remove-ProgramRule {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [ValidateSet("Block","Unblock")]
        [string]$type,
        [string]$program,
        [string]$exe="*"
    )
    
    begin {
        $removedRules = New-Object System.Collections.Generic.List[object];
    }
    
    process {
        $programRule = Get-ProgramRuleName -type $type -program $program -exe $exe;
        $removedRules.add((Remove-NetFirewallRule -Name "$ProgramRule" -EA 0))
    }
    
    end {
        if ($null -eq $removedRules) {
            "Some or all Rules didn't exist" | Out-Host
        }
        return $removedRules;
    }
}