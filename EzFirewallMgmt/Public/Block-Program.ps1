function Block-Program {
    [CmdletBinding(DefaultParameterSetName="byName")]
    param (
        [Parameter(ParameterSetName="byName")]
        [string]$name,
        [Parameter(ParameterSetName="byPath")]
        [string[]]$path
    )
    
    begin {
        $paths = New-Object System.Collections.Generic.List[Object];
        $newRules = New-Object System.Collections.Generic.List[object];

        if($name) {
            $paths.add((Get-ChildItem ${ENV:ProgramFiles(x86)} -Directory | Where-Object name -match $name | Get-ChildItem -Recurse -Include "*.exe" -File))
            $paths.add((Get-ChildItem $ENV:ProgramFiles -Directory | Where-Object name -match $name | Get-ChildItem -Recurse -Include "*.exe" -File))
            $paths.add((Get-ChildItem $ENV:ProgramData -Directory | Where-Object name -match $name | Get-ChildItem -Recurse -Include "*.exe" -File))
            $paths.add((Get-ChildItem $ENV:APPDATA -Directory | Where-Object name -match $name | Get-ChildItem -Recurse -Include "*.exe" -File))
            $paths.add((Get-ChildItem $ENV:LocalAppData -Directory | Where-Object name -match $name | Get-ChildItem -Recurse -Include "*.exe" -File))

        } else {
            $paths.add($path);
            $name = (Get-Item $path).BaseName;
        }
    }
    
    process {
        $paths | Foreach-Object {
            $ProgramRule = Get-ProgramRuleName -type "Block" -program $name -exe $_.Name;
            if ($null -eq (Get-NetFirewallRule -Name "$ProgramRule*") ) {
                $newRules.add((New-NetFirewallRule -DisplayName "$ProgramRule inbound" -Name "$ProgramRule inbound"  -Action "Block" -Profile Any -Direction Inbound -Program "$($_.Fullname)"))
                $newRules.add((New-NetFirewallRule -DisplayName "$ProgramRule Outbound" -Name "$ProgramRule Outbound"  -Action "Block" -Profile Any -Direction Outbound -Program "$($_.Fullname)"))      
           } else {
                "$ProgramRule already exists" | Out-Host;
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