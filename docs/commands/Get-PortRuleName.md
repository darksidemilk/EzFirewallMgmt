---
external help file: EzFirewallMgmt-help.xml
Module Name: EzFirewallMgmt
online version: https://EzFirewallMgmt.readthedocs.io/en/latest/commands/Get-PortRuleName
schema: 2.0.0
---

# Get-PortRuleName

## SYNOPSIS
Gets the name to use for given port rule

## SYNTAX

```
Get-PortRuleName [[-type] <String>] [[-port] <String[]>] [[-protocol] <String>] [<CommonParameters>]
```

## DESCRIPTION
Takes the parameters to build a simple string for the base name of a rule.
This is used when creating new rules and when removing them.
You can also use this 
with \`Get-NetFirewallRule -name\` to get matching firewall rules
Creates rule name strings with the structure \`{$type} port {$port} {$protocol}\`

## EXAMPLES

### EXAMPLE 1
```
Get-PortRuleName -type "Unblock" -port "135","1433-1434" -Protocol TCP
```

Will create a string of "Unblock port 135,1433-1434 TCP".

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

### -port
The port or ports the rule controls

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

### -protocol
Can be TCP or UDP

```yaml
Type: String
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
Append "*" to the return string to get or remove all matching rules as when they are created inbound or outbound is appended

## RELATED LINKS

[Get-PortRuleName](https://EzFirewallMgmt.readthedocs.io/en/latest/commands/Get-PortRuleName)

[Remove-PortRule](https://EzFirewallMgmt.readthedocs.io/en/latest/commands/Remove-PortRule)

[Block-Port](https://EzFirewallMgmt.readthedocs.io/en/latest/commands/Block-Port)

[Unblock-Port](https://EzFirewallMgmt.readthedocs.io/en/latest/commands/Unblock-Port)

