function Get-PortRuleName {
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