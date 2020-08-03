---
external help file: EzFirewallMgmt-help.xml
Module Name: EzFirewallMgmt
online version: https://EzFirewallMgmt.readthedocs.io/en/latest/commands/Add-ProgramRule
schema: 2.0.0
---

# Add-ProgramRule

## SYNOPSIS
Adds program rules via pipe

## SYNTAX

```
Add-ProgramRule [-paths] <Object> [[-type] <String>] [[-count] <Object>] [<CommonParameters>]
```

## DESCRIPTION
Runs through the list of paths and makes the rules
Mainly meant for internal use to avoid repeated code

## EXAMPLES

### EXAMPLE 1
```
$paths | Add-ProgramRule
```

## PARAMETERS

### -paths
The list of paths generated during Block/Unblock-Program

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -type
Block or Unblock, used to determin rule name and rule action

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

### -count
{{ Fill count Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
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

[Add-ProgramRule](https://EzFirewallMgmt.readthedocs.io/en/latest/commands/Add-ProgramRule)

[Block-Program](https://EzFirewallMgmt.readthedocs.io/en/latest/commands/Block-Program)

[Unblock-Program](https://EzFirewallMgmt.readthedocs.io/en/latest/commands/Unblock-Program)

[Remove-ProgramRule](https://EzFirewallMgmt.readthedocs.io/en/latest/commands/Remove-ProgramRule)

[Get-ProgramRulename](https://EzFirewallMgmt.readthedocs.io/en/latest/commands/Get-ProgramRulename)

[New-NetfirewallRule](https://docs.microsoft.com/en-us/powershell/module/netsecurity/New-NetfirewallRule)

