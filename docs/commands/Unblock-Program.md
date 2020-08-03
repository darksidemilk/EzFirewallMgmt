---
external help file: EzFirewallMgmt-help.xml
Module Name: EzFirewallMgmt
online version: https://EzFirewallMgmt.readthedocs.io/en/latest/commands/Unblock-Program
schema: 2.0.0
---

# Unblock-Program

## SYNOPSIS
Unblocks all exes found under parent folders matching a given name
or unblocks all specific exes at given paths

## SYNTAX

### byName (Default)
```
Unblock-Program [-name <String>] [<CommonParameters>]
```

### byPath
```
Unblock-Program [-path <String[]>] [-programName <String>] [<CommonParameters>]
```

## DESCRIPTION
When using -name will search programFiles/programfiles x86, current users local/roaming appdata, and the program data folder for
folders that match the given name (using -match so doesn't need to be exact).
Then finds all the exes in those paths
and loops through that list of exes creating a unblock rule for each one both inbound and outbound.
If you instead specifiy a path or list of paths it will create unblock rules only for the specified rules

## EXAMPLES

### EXAMPLE 1
```
Unblock-Program -name "Steam"
```

This will find all exe's in the steam program folders and unblock them.
This will also include all your downloaded steam
game exes.
A quick and easy way to make sure your multiplayer games are unblocked
Each rule would be named as \`Unblock program steam - exename.exe\`

### EXAMPLE 2
```
Unblock-Program -path "C:\Program Files\PowerShell\7\pwsh.exe"
```

Will create rules to unblock the powershell 7 exe.
Since no name was provided the rule will be called
\`Unblock program pwsh - pwsh.exe\`

## PARAMETERS

### -name
The name of the program folder to match, will also be used in naming the rules

```yaml
Type: String
Parameter Sets: byName
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -path
The path or list of paths to exes to unblock

```yaml
Type: String[]
Parameter Sets: byPath
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -programName
The programName to use in rule names when specifying path(s).
Will default to the basename (name without extension) of the first exe in the path list parameter

```yaml
Type: String
Parameter Sets: byPath
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Unblock-Program](https://EzFirewallMgmt.readthedocs.io/en/latest/commands/Unblock-Program)

[Block-Program](https://EzFirewallMgmt.readthedocs.io/en/latest/commands/Block-Program)

[Get-ProgramRuleName](https://EzFirewallMgmt.readthedocs.io/en/latest/commands/Get-ProgramRuleName)

[Remove-ProgramRule](https://EzFirewallMgmt.readthedocs.io/en/latest/commands/Remove-ProgramRule)

[New-NetfirewallRule](https://docs.microsoft.com/en-us/powershell/module/netsecurity/New-NetfirewallRule)

