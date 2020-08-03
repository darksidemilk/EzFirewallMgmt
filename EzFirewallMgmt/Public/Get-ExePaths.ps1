function Get-ExePaths {
    <#
    .SYNOPSIS
    Gets the exe's of a matching program name
    
    .DESCRIPTION
    Searches through all common install directories for exes with a matching
    parent directory name
    
    .PARAMETER name
    The name to use when searching for exe's will be matched anywhere in the name
    
    .EXAMPLE
    Get-ExePaths -name "steam"

    Will return all exes in the steam program file and appdata folders
    
    .NOTES
    Uses a list collection object and get-childitem. Adds to the list at the of filtering with get child item so each item is a single entry in the list
    
    .LINK
    Get-ExePaths

    .LINK
    Block-Program

    .LINK
    Unblock-Program
    
    #>

    [CmdletBinding()]
    param (
        [string]$name
    )
    
    begin {
        $paths = New-Object System.Collections.Generic.List[Object];
    }
    
    process {
        (Get-ChildItem ${ENV:ProgramFiles(x86)} -Directory | Where-Object name -match $name | Get-ChildItem -Recurse -Filter "*.exe" -File) | Foreach-Object {$paths.add($_)}
        (Get-ChildItem $ENV:ProgramFiles -Directory | Where-Object name -match $name | Get-ChildItem -Recurse -Filter "*.exe" -File) | Foreach-Object {$paths.add($_)}
        (Get-ChildItem $ENV:ProgramData -Directory | Where-Object name -match $name | Get-ChildItem -Recurse -Filter "*.exe" -File) | Foreach-Object {$paths.add($_)}
        (Get-ChildItem $ENV:APPDATA -Directory | Where-Object name -match $name | Get-ChildItem -Recurse -Filter "*.exe" -File) | Foreach-Object {$paths.add($_)}
        (Get-ChildItem $ENV:LocalAppData -Directory | Where-Object name -match $name | Get-ChildItem -Recurse -Filter "*.exe" -File) | Foreach-Object {$paths.add($_)}
    }
    
    end {
        return $paths;
    }
}