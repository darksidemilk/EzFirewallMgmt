function Block-Program {
    <#
    .SYNOPSIS
    Blocks all exes found under parent folders matching a given name
    or Blocks all specific exes at given paths
    
    .DESCRIPTION
    When using -name will search programFiles/programfiles x86, current users local/roaming appdata, and the program data folder for
    folders that match the given name (using -match so doesn't need to be exact). Then finds all the exes in those paths
    and loops through that list of exes creating a Block rule for each one both inbound and outbound.
    If you instead specifiy a path or list of paths it will create Block rules only for the specified rules 
    
    .PARAMETER name
    The name of the program folder to match, will also be used in naming the rules
    
    .PARAMETER path
    The path or list of paths to exes to Block
    Can also be passed via pipeline as a FileInfo Object from Get-ChildItem or Get-ExePaths
    
    .PARAMETER programName
    The programName to use in rule names when specifying path(s).
    Will default to the basename (name without extension) of the first exe in the path list parameter
    
    .EXAMPLE
    Block-Program -name "Steam"

    This will find all exe's in the steam program folders and Block them. This will also include all your downloaded steam
    game exes. A quick and easy way to make sure your multiplayer games are Blocked (because maybe you grounded your kid from video games)
    Each rule would be named as `Block program steam - exename.exe {inbound|outbound}`

    .EXAMPLE
    Block-Program -path "C:\Program Files\PowerShell\7\pwsh.exe"

    Will create rules to Block the powershell 7 exe. Since no name was provided the rule will be called
    `Block program pwsh - pwsh.exe {inbound|outbound}`

    .EXAMPLE
    Get-ExePaths "steam" |  Where-Object BaseName -in "Borderlands3","Drawful 2" | Block-Program -programName "selectedSteam"

    Will find all the exe's in the steam program folders and filter it down to only the exe's with basenames of
    Borderlands3 and Drawful 2 then pipe those into the path param and create block rules for them with a programName 
    of 'selectedSteam'. i.e. `Block program selectedSteam - Borderlands3.exe`
    
    .LINK
    Block-Program

    .LINK
    Unblock-Program

    .LINK
    Get-ProgramRuleName

    .LINK
    Remove-ProgramRule

    .LINK
    New-NetfirewallRule

    #>
    [CmdletBinding(DefaultParameterSetName="byName")]
    param (
        [Parameter(ParameterSetName="byName",Position=0)]
        [string]$name,
        [Parameter(ParameterSetName="byPath",ValueFromPipeline=$true)]
        $path,
        [Parameter(ParameterSetName="byPath")]
        [string]$programName
    )
    
    begin {
        $paths = New-Object System.Collections.Generic.List[Object];
        $newRules = New-Object System.Collections.Generic.List[object];
    }
    
    process {
        if($PsCmdlet.ParameterSetName -match "byName") {
            write-debug "Name parameter set";
            $paths = Get-ExePaths -name $name;
        } else {
            Write-Debug "Path is $($path | out-string)"
            if ($path.getType().Name -match "string") {
                $path = Get-Item $path;
            } 
            $path | Foreach-Object {
                if ($path[0].getType().Name -match "FileInfo") {
                    $paths.add($_);
                } else {
                    $paths.add((Get-Item $_));
                }
            }
            
            if ([string]::IsNullOrEmpty($programName)) {
                $programName = "$(($path)[0].BaseName)";
            }
            $name = $programName;
        }
    
    }
    
    end {
        Write-Debug "paths list is $($paths | out-string)";
        $paths | Foreach-Object {
            $ProgramRule = Get-ProgramRuleName -type "Block" -program $name -exe "$($_.Name)";
            if ($null -eq (Get-NetFirewallRule -Name "$ProgramRule*") ) {
                $newRules.add((New-NetFirewallRule -DisplayName "$ProgramRule inbound" -Name "$ProgramRule inbound"  -Action "Block" -Profile Any -Direction Inbound -Program "$($_.Fullname)"))
                $newRules.add((New-NetFirewallRule -DisplayName "$ProgramRule Outbound" -Name "$ProgramRule Outbound"  -Action "Block" -Profile Any -Direction Outbound -Program "$($_.Fullname)"))      
           } else {
                "$ProgramRule already exists" | Out-Host;
           }
        }
        if ($null -eq $newRules) {
            "Some or all Rules already existed" | Out-Host
        }
        return $newRules;
    }
}