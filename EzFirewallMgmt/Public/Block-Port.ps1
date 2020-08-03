function Block-Port {
    <#
    .SYNOPSIS
    Blocks a given port or list of ports
    
    .DESCRIPTION
    By default will create blocking rules for both tcp and udp versions of the port list given.
    Also creates blocks for both inbound and outbound. 
    Returns a list of the rules created
    
    .PARAMETER port
    The port or list of ports/port ranges to block
    
    .PARAMETER protocol
    Can be TCP, UDP, or BOTH defaults to Both
    
    .EXAMPLE
    Block-Port -port "1433-1434"

    Will block tcp and udp ports 1433 through 1434 which would block incoming and outgoing mircosoft sql servers
    from being accessed over the network or even being browsed if they're using default ports
    The rule names would be `Block port 1433-1434 TCP inbound` `Block port 1433-1434 TCP outbound` `Block port 1433-1434 UDP inbound` `Block port 1433-1434 UDP outbound`

    .LINK
    Block-Port
    
    .LINK
    Unblock-Port

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
            $TCPRule = Get-PortRuleName -type "Block" -port $port -protocol "TCP";
            if ($null -eq (Get-NetFirewallRule -Name "$TCPRule*") ) {
                $newRules.add((New-NetFirewallRule -DisplayName "$TCPRule inbound" -Name "$TCPRule inbound" -Action "Block" -Profile Any -Direction Inbound -Protocol TCP -LocalPort $port -EA 0))
                $newRules.add((New-NetFirewallRule -DisplayName "$TCPRule outbound" -Name "$TCPRule outbound" -Action "Block" -Profile Any -Direction Outbound -Protocol TCP -LocalPort $port -EA 0))
            } else {
                "$TCPRule already exists" | Out-Host;
            }
        } 
        if ($protocol -eq "BOTH" -OR $protocol -eq "UDP") {
            $UDPRule = Get-PortRuleName -type "Block" -port $port -protocol "UDP";
            if ($null -eq (Get-NetFirewallRule -Name "$UDPRule*") ) {
                $newRules.add((New-NetFirewallRule -DisplayName "$UDPRule inbound" -Name "$UDPRule inbound" -Action "Block" -Profile Any -Direction Inbound -Protocol UDP -LocalPort $port -EA 0))
                $newRules.add((New-NetFirewallRule -DisplayName "$UDPRule outbound" -Name "$UDPRule outbound" -Action "Block" -Profile Any -Direction Outbound -Protocol UDP -LocalPort $port -EA 0))
            }  else {
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