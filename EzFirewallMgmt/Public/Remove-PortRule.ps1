function Remove-PortRule {
    <#
    .SYNOPSIS
    Removes a port firewall rule
    
    .DESCRIPTION
    Creates a search string with given parameters using Get-PortRuleName and appends a wildcard '*'
    Then uses Remove-NetFirewallRule to remove all matching firewall rules
    
    .PARAMETER type
    Can be Unblock or Block
    
    .PARAMETER port
    The port or list of ports controlled by the rule
    
    .PARAMETER protocol
    Can be TCP, UDP, or BOTH, defaults to BOTH
    
    .EXAMPLE
    Remove-PortRule -type "Block" -port "135","1433-1434"

    Will remove all the TCP and UDP port rules that match the naming "Block port 135,1433-1434*"
    Will run it against "Block port 135,1433-1434 TCP*" and "Block port 135,1433-1434 UDP*"
    
    .LINK
    Remove-PortRule

    .LINK
    Get-PortRuleName

    .LINK
    Block-Port
    
    .LINK
    Unblock-Port

    .LINK
    Remove-NetFirewallRule

    #>
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
        if ([string]::IsNullOrEmpty($protocol)) {
            $protocol = "BOTH";
        }
        $removedRules = New-Object System.Collections.Generic.List[object];
    }
    
    process {
        if ($protocol -eq "BOTH" -OR $protocol -eq "TCP") {
            $TCPRule = Get-PortRuleName -type "Unblock" -port $port -protocol "TCP";
            "Removing $TCPRule" | Out-Host;
            $removedRules.add((Get-NetFirewallRule -Name "$TCPRule*" -EA 0))
            Get-NetFirewallRule -Name "$TCPRule*" | Remove-NetFirewallRule -EA 0;
            # $removedRules.add((Remove-NetFirewallRule -Name $TCPRule -EA 0))
        } 
        if ($protocol -eq "BOTH" -OR $protocol -eq "UDP") {
            $UDPRule = Get-PortRuleName -type "Unblock" -port $port -protocol "UDP";
            $removedRules.add((Get-NetFirewallRule -Name "$UDPRule*" -EA 0))
            Get-NetFirewallRule -Name "$UDPRule*" | Remove-NetFirewallRule -EA 0;
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