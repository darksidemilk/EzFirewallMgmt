function Get-PortRuleName {
    <#
    .SYNOPSIS
    Gets the name to use for given port rule
    
    .DESCRIPTION
    Takes the parameters to build a simple string for the base name of a rule.
    This is used when creating new rules and when removing them. You can also use this 
    with `Get-NetFirewallRule -name` to get matching firewall rules
    Creates rule name strings with the structure `{$type} port {$port} {$protocol}`
    
    .PARAMETER type
    Can be Block or Unblock
    
    .PARAMETER port
    The port or ports the rule controls
    
    .PARAMETER protocol
    Can be TCP or UDP
    
    .EXAMPLE
    Get-PortRuleName -type "Unblock" -port "135","1433-1434" -Protocol TCP

    Will create a string of "Unblock port 135,1433-1434 TCP".
    
    .NOTES
    Append "*" to the return string to get or remove all matching rules as when they are created inbound or outbound is appended

    .LINK
    Get-PortRuleName

    .LINK
    Remove-PortRule

    .LINK
    Block-Port
    
    .LINK
    Unblock-Port

    #>
    [CmdletBinding()]
    param (
        [Parameter()]
        [ValidateSet("Block","Unblock")]
        [string]$type,
        [string[]]$port,
        [Parameter()]
        [ValidateSet("TCP","UDP")]
        [string]$protocol
    )
    
    
    process {
        return "$type port $port $protocol"    
    }
    
}