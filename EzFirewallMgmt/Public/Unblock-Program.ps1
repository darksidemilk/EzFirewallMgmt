function Unblock-Program {
    <#
    .SYNOPSIS
    Unblocks all exes found under parent folders matching a given name
    or unblocks all specific exes at given paths
    
    .DESCRIPTION
    When using -name will search programFiles/programfiles x86, current users local/roaming appdata, and the program data folder for
    folders that match the given name (using -match so doesn't need to be exact). Then finds all the exes in those paths
    and loops through that list of exes creating a unblock rule for each one both inbound and outbound.
    If you instead specifiy a path or list of paths it will create unblock rules only for the specified rules 
    
    .PARAMETER name
    The name of the program folder to match, will also be used in naming the rules
    
    .PARAMETER path
    The path or list of paths to exes to unblock
    Can also be passed via pipeline as a FileInfo Object from Get-ChildItem or Get-ExePaths
    
    .PARAMETER programName
    The programName to use in rule names when specifying path(s).
    Will default to the basename (name without extension) of the first exe in the path list parameter
    
    .EXAMPLE
    Unblock-Program -name "Steam"

    This will find all exe's in the steam program folders and unblock them. This will also include all your downloaded steam
    game exes. A quick and easy way to make sure your multiplayer games are unblocked
    Each rule would be named as `Unblock program steam - exename.exe`

    .EXAMPLE
    Unblock-Program -path "C:\Program Files\PowerShell\7\pwsh.exe"

    Will create rules to unblock the powershell 7 exe. Since no name was provided the rule will be called
    `Unblock program pwsh - pwsh.exe`

    .EXAMPLE
    Get-ExePaths "steam" |  Where-Object BaseName -in "Borderlands3","Drawful 2" | Unblock-Program -programName "selectedSteam"

    Will find all the exe's in the steam program folders and filter it down to only the exe's with basenames of
    Borderlands3 and Drawful 2 then pipe those into the path param and create unblock rules for them with a programName 
    of 'selectedSteam'. i.e. `Unblock program selectedSteam - Borderlands3.exe`

    .LINK
    Unblock-Program

    .LINK
    Block-Program

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
            $ProgramRule = Get-ProgramRuleName -type "Unblock" -program $name -exe "$($_.Name)";
            if ($null -eq (Get-NetFirewallRule -Name "$ProgramRule*") ) {
                Write-Debug "Creating '$($programRule) inbound'";
                $newRules.add((New-NetFirewallRule -DisplayName "$ProgramRule inbound" -Name "$ProgramRule inbound"  -Action "Allow" -Profile Any -Direction Inbound -Program "$($_.Fullname)"))
                Write-Debug "Creating '$($programRule) outbound'";
                $newRules.add((New-NetFirewallRule -DisplayName "$ProgramRule outbound" -Name "$ProgramRule Outbound"  -Action "Allow" -Profile Any -Direction Outbound -Program "$($_.Fullname)"))      
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