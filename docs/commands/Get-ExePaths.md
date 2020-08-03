---
external help file: EzFirewallMgmt-help.xml
Module Name: EzFirewallMgmt
online version: https://EzFirewallMgmt.readthedocs.io/en/latest/commands/Get-ExePaths
schema: 2.0.0
---

# Get-ExePaths

## SYNOPSIS
Gets the exe's of a matching program name

## SYNTAX

```
Get-ExePaths [[-name] <String>] [<CommonParameters>]
```

## DESCRIPTION
Searches through all common install directories for exes with a matching
parent directory name

## EXAMPLES

### EXAMPLE 1
```
Get-ExePaths -name "steam"
```

Will return all exes in the steam program file and appdata folders

## PARAMETERS

### -name
The name to use when searching for exe's will be matched anywhere in the name

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Uses a list collection object and get-childitem.
Adds to the list at the of filtering with get child item so each item is a single entry in the list

## RELATED LINKS

[Get-ExePaths](https://EzFirewallMgmt.readthedocs.io/en/latest/commands/Get-ExePaths)

[Block-Program](https://EzFirewallMgmt.readthedocs.io/en/latest/commands/Block-Program)

[Unblock-Program](https://EzFirewallMgmt.readthedocs.io/en/latest/commands/Unblock-Program)

