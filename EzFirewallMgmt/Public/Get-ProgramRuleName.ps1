function Get-ProgramRuleName {
    [CmdletBinding()]
    param (
        [Parameter()]
        [ValidateSet("Block","Unblock")]
        [string]$type,
        [string[]]$program,
        [string]$exe
    )
    
    
    process {
        return "$type program $program - $exe"    
    }
    
}