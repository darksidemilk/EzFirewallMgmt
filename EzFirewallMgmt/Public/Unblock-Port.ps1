function Unblock-Port {
    <#
    .SYNOPSIS
    UnBlocks a given port or list of ports
    
    .DESCRIPTION
    By default will create Unblocking rules for both tcp and udp versions of the port list given.
    Also creates Unblocks for both inbound and outbound. 
    Returns a list of the rules created
    
    .PARAMETER port
    The port or list of ports/port ranges to Unblock
    
    .PARAMETER protocol
    Can be TCP, UDP, or BOTH defaults to Both
    
    .EXAMPLE
    UnBlock-Port -port "1433-1434"

    Will Unblock tcp and udp ports 1433 through 1434 which would Unblock incoming and outgoing mircosoft sql servers
    from being accessed over the network or even being browsed if they're using default ports
    The rule names would be `Unblock port 1433-1434 TCP inbound` `Unblock port 1433-1434 TCP outbound` `Unblock port 1433-1434 UDP inbound` `Unblock port 1433-1434 UDP outbound`

    .LINK
    Unblock-Port

    .LINK
    Block-Port

    .LINK
    Get-PortRuleName

    .LINK
    Remove-PortRule

    .LINK
    New-NetfirewallRule

    #>
    [CmdletBinding()]
    param (
        [string[]]$port,
        [Parameter()]
        [ValidateSet("TCP","UDP","BOTH")]
        [string]$protocol
    )
    
    begin {
        if ([string]::IsNullOrEmpty($protocol)) {
            $protocol = "BOTH";
        }
        $newRules = New-Object System.Collections.Generic.List[object];
    }
    
    process {
        if ($protocol -eq "BOTH" -OR $protocol -eq "TCP") {
            $TCPRule = Get-PortRuleName -type "Unblock" -port $port -protocol "TCP";
            if ($null -eq (Get-NetFirewallRule -Name "$TCPRule*") ) {
                $newRules.add((New-NetFirewallRule -DisplayName "$TCPRule inbound" -Name "$TCPRule inbound"  -Action "Allow" -Profile Any -Direction Inbound -Protocol TCP -LocalPort $port))
                $newRules.add((New-NetFirewallRule -DisplayName "$TCPRule outbound" -Name "$TCPRule outbound" -Action "Allow" -Profile Any -Direction Outbound -Protocol TCP -LocalPort $port))
            } else {
                "$TCPRule already exists" | Out-Host;
            }
        } 
        if ($protocol -eq "BOTH" -OR $protocol -eq "UDP") {
            $UDPRule = Get-PortRuleName -type "Unblock" -port $port -protocol "UDP";
            if ($null -eq (Get-NetFirewallRule -Name "$UDPRule*") ) {
                $newRules.add((New-NetFirewallRule -DisplayName "$UDPRule inbound" -Name "$UDPRule inbound" -Action "Allow" -Profile Any -Direction Inbound -Protocol UDP -LocalPort $port))
                $newRules.add((New-NetFirewallRule -DisplayName "$UDPRule outbound" -Name "$UDPRule outbound" -Action "Allow" -Profile Any -Direction Outbound -Protocol UDP -LocalPort $port))
            } else {
                "$UDPRule already exists" | Out-Host;
            }
        }
    }
    
    end {
        if ($null -eq $newRules) {
            "Some or all Rules already existed" | Out-Host
        }
        return $newRules;
    }
}