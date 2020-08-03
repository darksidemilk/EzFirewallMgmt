---
external help file: EzFirewallMgmt-help.xml
Module Name: EzFirewallMgmt
online version: https://EzFirewallMgmt.readthedocs.io/en/latest/commands/Remove-ProgramRule
schema: 2.0.0
---

# Remove-ProgramRule

## SYNOPSIS
Removes a program firewall rule

## SYNTAX

```
Remove-ProgramRule [-type] <String> [[-program] <String>] [[-exe] <String>] [<CommonParameters>]
```

## DESCRIPTION
Creates a search string with given parameters using Get-ProgramRuleName and appends a wildcard '*'
Then uses Remove-NetFirewallRule to remove all matching firewall rules

## EXAMPLES

### EXAMPLE 1
```
Remove-Program -type "Block" -program "steam"
```

Will remove all the block rules matching "Block program steam - *". 
Because maybe you ungrounded your kid from video games.

## PARAMETERS

### -type
Can be Unblock or Block

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -program
The program name used to create the rule

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -exe
The specific exe filename controlled by the rule.
Defaults to a wildcard '*'
To get all exe's created in a rule created by name

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

## RELATED LINKS

[Remove-ProgramRule](https://EzFirewallMgmt.readthedocs.io/en/latest/commands/Remove-ProgramRule)

[Get-ProgramRuleName](https://EzFirewallMgmt.readthedocs.io/en/latest/commands/Get-ProgramRuleName)

[Block-Program](https://EzFirewallMgmt.readthedocs.io/en/latest/commands/Block-Program)

[Unblock-Program](https://EzFirewallMgmt.readthedocs.io/en/latest/commands/Unblock-Program)

[Remove-NetFirewallRule](https://docs.microsoft.com/en-us/powershell/module/netsecurity/Remove-NetFirewallRule)

