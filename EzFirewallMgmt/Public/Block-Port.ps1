function Block-Port {
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