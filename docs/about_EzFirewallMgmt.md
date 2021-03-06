# EzFirewallMgmt

## about_EzFirewallMgmt

# SHORT DESCRIPTION

Simplified helper functions to block and unblock ports and programs
Utilizes New-NetFirewallRule and Remove-NetFirewallRule functions and turns them into easier to use versions for basic operations


# LONG DESCRIPTION

New-NetFirewallRule has many parameters that you often don't need or don't want to specify over and over again.
This module handles the extra parameters in that function for simpler basic operations for common firewall rule needs.

This is done with helper functions like `Unblock-Port` and `Unblock-Program` which are 2 very common types of firewall rules that get created. This module helps with automatically creating inbound and outbound matching rules, finding all exes in a program's path, and also defaulting to blocking/unblocking both tcp and udp versions of a port.

It ends up creating multiple rules with similar naming conventions that can then be found and removed with its other helper functions.

# Usage Scenario

i.e. Maybe you set windows firewall to default block all incoming/outgoing connections
So you now want to selectively unblock things through the firewall for a more secure and controlled network.

You could set the default controls to block in the windows firewall advanced setting gui/control panel and then use the following ideas to start opening things up.

## Port Rules

You could unblock a port on both tcp and udp simply with `Unblock-Port -port 1434`

Or just unblock a port on tcp `Unblock-Port -port 1433 -protocol TCP`

## Program Rules

There is also `Unblock-Program -name "steam"`
this will find that folders that match that program name in the program files folders and allow all exe's within those folders
access to the network.

Or you can specify a path to a specific program(s) with `Unblock-Program -path "C:\Path\to\program.exe"`

Each Unblock function has an equal `Block` function that operates the same but creates block action rules.

## Removing Rules

You can also remove rules that were created with this module with `Remove-PortRule` and `Remove-ProgramRule`.

THe parameters for

# Rule Naming

These removals and adds of firewall rules will create names based on the command used.
i.e. `Unblock-Port -port "1433-1434","135"` would create rules named "Unblock Port 1433-1434,135 TCP inbound", "Unblock Port 1433-1434,135 TCP outbound", "Unblock Port 1433-1434,135 UDP inbound", "Unblock Port 1433-1434,135 UDP outbound" 

Running `Remove-PortUnblock -port "1433-1434","135"` Would remove all 4 of those rules by using `Get-PortRuleName` to get the base string used for creating the rule and appending a wildcard `*` to it.

The program rules follow a similar pattern of `{Unblock|Block} program {programName} - {program.exe} {inbound|outbound}` and the `Remove-ProgramRule` function works in the same wildcard appending manner.  