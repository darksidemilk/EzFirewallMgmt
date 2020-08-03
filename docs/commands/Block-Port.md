---
external help file: EzFirewallMgmt-help.xml
Module Name: EzFirewallMgmt
online version: https://EzFirewallMgmt.readthedocs.io/en/latest/commands/Block-Port
schema: 2.0.0
---

# Block-Port

## SYNOPSIS
Blocks a given port or list of ports

## SYNTAX

```
Block-Port [[-port] <String[]>] [[-protocol] <String>] [<CommonParameters>]
```

## DESCRIPTION
By default will create blocking rules for both tcp and udp versions of the port list given.
Also creates blocks for both inbound and outbound. 
Returns a list of the rules created

## EXAMPLES

### EXAMPLE 1
```
Block-Port -port "1433-1434"
```

Will block tcp and udp ports 1433 through 1434 which would block incoming and outgoing mircosoft sql servers
from being accessed over the network or even being browsed if they're using default ports
The rule names would be \`Block port 1433-1434 TCP inbound\` \`Block port 1433-1434 TCP outbound\` \`Block port 1433-1434 UDP inbound\` \`Block port 1433-1434 UDP outbound\`

## PARAMETERS

### -port
The port or list of ports/port ranges to block

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -protocol
Can be TCP, UDP, or BOTH defaults to Both

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Block-Port](https://EzFirewallMgmt.readthedocs.io/en/latest/commands/Block-Port)

[Unblock-Port](https://EzFirewallMgmt.readthedocs.io/en/latest/commands/Unblock-Port)

[Get-PortRuleName](https://EzFirewallMgmt.readthedocs.io/en/latest/commands/Get-PortRuleName)

[Remove-PortRule](https://EzFirewallMgmt.readthedocs.io/en/latest/commands/Remove-PortRule)

[New-NetfirewallRule](https://docs.microsoft.com/en-us/powershell/module/netsecurity/New-NetfirewallRule)

