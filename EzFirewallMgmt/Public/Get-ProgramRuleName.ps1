function Get-ProgramRuleName {
    <#
    .SYNOPSIS
    Gets the name to use for given program rule
    
    .DESCRIPTION
    Takes the parameters to build a simple string for the base name of a rule.
    This is used when creating new rules and when removing them. 
    You can also use this with `Get-NetFirewallRule -name` to get matching firewall rules.
    Creates rule name strings with the structure `{$type} program {$program} - {$exename}`
    
    .PARAMETER type
    Can be Block or Unblock
    
    .PARAMETER program
    The program name the rule controls. Is created from the name/programName parameter
    in Unblock/Block-Program. Since groups of rules are created by each creating function
    this helps maintain a findable name structure.
    
    .PARAMETER exe
    The name of the actual exe being controlled by the rule.
    Defaults to * so if you're running this outside of the functions creating rules
    
    .EXAMPLE
    Get-ProgramRuleName -type "Unblock" -program "steam" -exe "steam.exe"

    Will create a string of "Unblock program steam - steam.exe"
    
    .NOTES
    Append "*" to the return string to get or remove all matching rules as when they are created inbound or outbound is appended

    .LINK
    Get-ProgramRuleName

    .LINK
    Remove-ProgramRule

    .LINK
    Block-Program
    
    .LINK
    Unblock-Program

    #>
    [CmdletBinding()]
    param (
        [Parameter()]
        [ValidateSet("Block","Unblock")]
        [string]$type,
        [string[]]$program,
        [string]$exe="*"
    )
    
    
    process {
        return "$type program $program - $exe"    
    }
    
}