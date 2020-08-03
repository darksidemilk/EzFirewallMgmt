function Add-PortRule {
    <#
    .SYNOPSIS
    Adds a port rule for blocking/unblockin
    
    .DESCRIPTION
    Mainly meant to be an internal function to avoid repeated code
    
    .PARAMETER port
    The port or ports to control
    
    .PARAMETER protocol
    TCP,UDP, or BOTH
    
    .PARAMETER type
    Block or Unblock
    
    .LINK 
    Add-PortRule

    .LINK
    Block-PortRule

    .LINK
    Unblock-PortRule

    .LINK
    New-NetfirewallRule

    #>
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline=$true)]
        [string[]]$port,
        [Parameter()]
        [ValidateSet("TCP","UDP","BOTH")]
        [string]$protocol,
        [Parameter()]
        [ValidateSet("Block","Unblock")]
        [string]$type
    )
    
    begin {
        $newRules = New-Object System.Collections.Generic.List[object];
        $i = 1;
        if ($type -eq "Unblock") {
            $action = "Allow";
        } else {
            $action = "Block";
        }
        switch ($protocol) {
            BOTH {
                $count = 4;
            }
            Default {
                $count = 2;
            }
        }
    }
    
    process {
        if ($protocol -eq "BOTH" -OR $protocol -eq "TCP") {
            $TCPRule = Get-PortRuleName -type $type -port $port -protocol "TCP";
            if ($null -eq (Get-NetFirewallRule -Name "$TCPRule*") ) {
                Write-Progress -Activity "Creating Port Rules" -id 1 -Status "$i of $count" -CurrentOperation "Creating $TCPRule inBound Rule";$i++;
                $newRules.add((New-NetFirewallRule -DisplayName "$TCPRule inbound" -Name "$TCPRule inbound" -Action $action -Profile Any -Direction Inbound -Protocol TCP -LocalPort $port -EA 0))
                
                Write-Progress -Activity "Creating Port Rules" -id 1 -Status "$i of $count" -CurrentOperation "Creating $TCPRule outbound Rule";$i++;
                $newRules.add((New-NetFirewallRule -DisplayName "$TCPRule outbound" -Name "$TCPRule outbound" -Action $action -Profile Any -Direction Outbound -Protocol TCP -LocalPort $port -EA 0))
            } else {
                "$TCPRule already exists" | Out-Host; $i+=2;
            }
        } 
        if ($protocol -eq "BOTH" -OR $protocol -eq "UDP") {
            $UDPRule = Get-PortRuleName -type $type -port $port -protocol "UDP";
            if ($null -eq (Get-NetFirewallRule -Name "$UDPRule*") ) {
                Write-Progress -Activity "Creating Port Rules" -id 1 -Status "$i of $count" -CurrentOperation "Creating $UDPRule inbound Rule";$i++;
                $newRules.add((New-NetFirewallRule -DisplayName "$UDPRule inbound" -Name "$UDPRule inbound" -Action $action -Profile Any -Direction Inbound -Protocol UDP -LocalPort $port -EA 0))

                Write-Progress -Activity "Creating Port Rules" -id 1 -Status "$i of $count" -CurrentOperation "Creating $UDPRule outbound Rule";$i++;
                $newRules.add((New-NetFirewallRule -DisplayName "$UDPRule outbound" -Name "$UDPRule outbound" -Action $action -Profile Any -Direction Outbound -Protocol UDP -LocalPort $port -EA 0))
            }  else {
                "$UDPRule already exists" | Out-Host; $i+=2;
            }
        }
        Write-Progress -Activity "Creating Port Rules" -id 1 -Status "$i of $count" -Completed
        
    }
    
    end {
        return $newRules;
    }
}