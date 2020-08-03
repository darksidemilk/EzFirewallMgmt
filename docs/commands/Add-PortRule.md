---
external help file: EzFirewallMgmt-help.xml
Module Name: EzFirewallMgmt
online version: https://EzFirewallMgmt.readthedocs.io/en/latest/commands/Add-PortRule
schema: 2.0.0
---

# Add-PortRule

## SYNOPSIS
Adds a port rule for blocking/unblockin

## SYNTAX

```
Add-PortRule [[-port] <String[]>] [[-protocol] <String>] [[-type] <String>] [<CommonParameters>]
```

## DESCRIPTION
Mainly meant to be an internal function to avoid repeated code

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -port
The port or ports to control

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -protocol
TCP,UDP, or BOTH

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

### -type
Block or Unblock

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

[Add-PortRule](https://EzFirewallMgmt.readthedocs.io/en/latest/commands/Add-PortRule)

[Block-PortRule](https://EzFirewallMgmt.readthedocs.io/en/latest/commands/Block-PortRule)

[Unblock-PortRule](https://EzFirewallMgmt.readthedocs.io/en/latest/commands/Unblock-PortRule)

[New-NetfirewallRule](https://docs.microsoft.com/en-us/powershell/module/netsecurity/New-NetfirewallRule)

