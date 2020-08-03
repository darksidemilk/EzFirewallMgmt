# Overview

Simplified helper functions to block and unblock ports and programs
Utilizes New-NetFirewallRule and Remove-NetFirewallRule functions and turns them into easier versions
i.e. Maybe you set windows firewall to default block all incoming/outgoing connections
So you now want to selectively unblock things.
You could unblock a port on both tcp and udp simply with `Unblock-Port -port 1434`
Or just unblock a port on tcp `Unblock-Port -port 1433 -protocol tcp`
There is also `Unblock-Program -name "steam"` 
this will find that folders that match that program name in the program files folders and allow all exe's within those folders
access to the network.
Or you can specify a path to a specific program.
Each Unblock will have an equal `Block` function that does the same thing with creating block rules
You can also remove rules with `Remove-PortBlock` `Remove-PortUnblock` `Remove-ProgramUnBlock`
These removals and adds of firewall rules will create names based on the command used.
i.e. `Unblock-Port -port "1433-1434","135"` would create a rule named "Unblock Port 1433-1434,135 TCP" and a rule called "Unblock Port 1433-1434,135 UDP" running `Remove-PortUnblock -port "1433-1434","135"` Would remove roles with that same naming