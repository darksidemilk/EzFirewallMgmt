function Remove-PortRule {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [ValidateSet("Block","Unblock")]
        [string]$type,
        [string[]]$port,
        [Parameter()]
        [ValidateSet("TCP","UDP","BOTH")]
        [string]$protocol
    )
    
    begin {
        if ($null -eq $protocol) {
            $protocol = "BOTH";
        }
        $removedRules = New-Object System.Collections.Generic.List[object];
    }
    
    process {
        if ($protocol -eq "BOTH" -OR $protocol -eq "TCP") {
            $TCPRule = Get-PortRuleName -type "Unblock" -port $port -protocol "TCP";
            "Removing $TCPRule" | Out-Host;
            $removedRules.add((Remove-NetFirewallRule -Name "$TCPRule*" -EA 0))
            # $removedRules.add((Remove-NetFirewallRule -Name $TCPRule -EA 0))
        } 
        if ($protocol -eq "BOTH" -OR $protocol -eq "UDP") {
            $UDPRule = Get-PortRuleName -type "Unblock" -port $port -protocol "UDP";
            $removedRules.add((Remove-NetFirewallRule -Name "$UDPRule*" -EA 0))
            # $removedRules.add((Remove-NetFirewallRule -Name $UDPRule -EA 0))
        }
    }
    
    end {
        if ($null -eq $removedRules) {
            "Some or all Rules didn't exist" | Out-Host
        }
        return $removedRules;
    }
}