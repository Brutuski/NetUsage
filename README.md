# NetUsage
![bash](https://img.shields.io/badge/Made%20with-Bash-1f425f.svg) [![license](https://img.shields.io/badge/License-MIT-green)](https://github.com/Brutuski/NetUsage/blob/master/LICENSE)
<br>A simple CLI to view your network usage since last boot.<br>
Can also be used as a module for  [Polybar](https://github.com/polybar/polybar)

---

## How to use
To get started: 
+ `git clone https://github.com/Brutuski/NetUsage.git`
+ Make the script executable: `chmod +x usage.sh`
+ To list available options: `./usage.sh -h`
+ User needs to provide their interface name, which looks something like `enp7s0` or `wlp8s0`. To list interfaces: `ip link`
+ For more information about interfaces, refer to [Arch wiki](https://wiki.archlinux.org/index.php/Network_configuration#Network_interfaces)
---

## Usage
_View all options and help_
```
./usage.sh -h
```

_Display Net Usage on the Terminal_
```
./usage.sh -i <interface_name> -c
```
_Display Net Usager for **[Polybar](https://github.com/polybar/polybar)**_
```
./usage.sh -i <interface_name> -p
```
## Setup Polybar
```
[module/netusage]
type = custom/script
exec = ./usage.sh -i <interface_name> -p

tail = true
interval = 1

label = "%output%"
```