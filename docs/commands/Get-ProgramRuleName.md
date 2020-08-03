---
external help file: EzFirewallMgmt-help.xml
Module Name: EzFirewallMgmt
online version: https://EzFirewallMgmt.readthedocs.io/en/latest/commands/Get-ProgramRuleName
schema: 2.0.0
---

# Get-ProgramRuleName

## SYNOPSIS
Gets the name to use for given program rule

## SYNTAX

```
Get-ProgramRuleName [[-type] <String>] [[-program] <String[]>] [[-exe] <String>] [<CommonParameters>]
```

## DESCRIPTION
Takes the parameters to build a simple string for the base name of a rule.
This is used when creating new rules and when removing them. 
You can also use this with \`Get-NetFirewallRule -name\` to get matching firewall rules.
Creates rule name strings with the structure \`{$type} program {$program} - {$exename}\`

## EXAMPLES

### EXAMPLE 1
```
Get-ProgramRuleName -type "Unblock" -program "steam" -exe "steam.exe"
```

Will create a string of "Unblock program steam - steam.exe"

## PARAMETERS

### -type
Can be Block or Unblock

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -program
The program name the rule controls.
Is created from the name/programName parameter
in Unblock/Block-Program.
Since groups of rules are created by each creating function
this helps maintain a findable name structure.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -exe
The name of the actual exe being controlled by the rule.
Defaults to * so if you're running this outside of the functions creating rules

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: *
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Append "*" to the return string to get or remove all matching rules as when they are created inbound or outbound is appended

## RELATED LINKS

[Get-ProgramRuleName](https://EzFirewallMgmt.readthedocs.io/en/latest/commands/Get-ProgramRuleName)

[Remove-ProgramRule](https://EzFirewallMgmt.readthedocs.io/en/latest/commands/Remove-ProgramRule)

[Block-Program](https://EzFirewallMgmt.readthedocs.io/en/latest/commands/Block-Program)

[Unblock-Program](https://EzFirewallMgmt.readthedocs.io/en/latest/commands/Unblock-Program)

