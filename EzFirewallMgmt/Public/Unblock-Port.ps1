function Unblock-Port {
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