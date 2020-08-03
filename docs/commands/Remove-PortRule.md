---
external help file: EzFirewallMgmt-help.xml
Module Name: EzFirewallMgmt
online version: https://EzFirewallMgmt.readthedocs.io/en/latest/commands/Remove-PortRule
schema: 2.0.0
---

# Remove-PortRule

## SYNOPSIS
Removes a port firewall rule

## SYNTAX

```
Remove-PortRule [-type] <String> [[-port] <String[]>] [[-protocol] <String>] [<CommonParameters>]
```

## DESCRIPTION
Creates a search string with given parameters using Get-PortRuleName and appends a wildcard '*'
Then uses Remove-NetFirewallRule to remove all matching firewall rules

## EXAMPLES

### EXAMPLE 1
```
Remove-PortRule -type "Block" -port "135","1433-1434"
```

Will remove all the TCP and UDP port rules that match the naming "Block port 135,1433-1434*"
Will run it against "Block port 135,1433-1434 TCP*" and "Block port 135,1433-1434 UDP*"

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

### -port
The port or list of ports controlled by the rule

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
Can be TCP, UDP, or BOTH, defaults to BOTH

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

## RELATED LINKS

[Remove-PortRule](https://EzFirewallMgmt.readthedocs.io/en/latest/commands/Remove-PortRule)

[Get-PortRuleName](https://EzFirewallMgmt.readthedocs.io/en/latest/commands/Get-PortRuleName)

[Block-Port](https://EzFirewallMgmt.readthedocs.io/en/latest/commands/Block-Port)

[Unblock-Port](https://EzFirewallMgmt.readthedocs.io/en/latest/commands/Unblock-Port)

[Remove-NetFirewallRule](https://docs.microsoft.com/en-us/powershell/module/netsecurity/Remove-NetFirewallRule)

