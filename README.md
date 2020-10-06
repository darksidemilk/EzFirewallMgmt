# Overview

Simplified helper functions to block and unblock ports and programs
Utilizes New-NetFirewallRule and Remove-NetFirewallRule functions and turns them into easier to use versions for basic operations

## Documentation

You can find documentation hosted on this project's readthedocs page [https://EzFirewallMgmt.readthedocs.io/en/latest/](https://EzFirewallMgmt.readthedocs.io/en/latest/)

## Installation

### Through powershell Gallery (Recommended)

This module is published in the powershellgallery.com. Simply run `Install-Module EzFirewallMgmt` in powershell to install the latest published version. Then `Import-Module EzFirewallMgmt` to start using it.

See also https://www.powershellgallery.com/packages/EzFirewallMgmt

### Manual Building

* Clone this repo
* Run the `build.ps1 -releaseNote "manual building/edits"` script in the root of the repo.
  * You should use the cloned repo's root directory as a working directory when running the build script
* Move the built module to the default module install directory
  * `Move-Item "$ENV:UserProfile\ModuleBuild\EzFirewallMgmt" "$ENV:PROGRAMFILES\WindowsPowershell\Modules\EZFirewallMgmt"`
  * That is the default module install directory for Powershell 5.1. This module should work with powershell 6/7 but those have different module directory paths for user/machine installs. I haven't tested this on 6/7 but I'm pretty sure it would at least work on 7 for windows. Could theoretically one day make this cross platform by making it use iptables for linux machines, but that's a project for another day, or another person.
* Run `Import-Module EzFirewallMgmt` to start using the module
  * You can also import from the default build directory without moving it to the installed modules directory with `Import-Module "$ENV:UserProfile\ModuleBuild\EzFirewallMgmt"`

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
