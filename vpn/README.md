# ProtonVPN as your home router default gateway

This is a Bash script that, in a single command, will set up a VPN tunnel with ProtonVPN and set the new interface as your LAN's default gateway.
It's a simple method to enable your entire network to connect to the Internet via VPN while using only the Free tier of ProtonVPN.
The Proton team provides amazing, privacy caring services (VPN and Mail) so support them anyway.

More info on their [website](https://protonvpn.com/)

## Preparation
Please set up ProtonVPN CLI by following [this tutorial](https://protonvpn.com/support/linux-vpn-tool/)
This script assume you have a Linux machine as your home router. If you'd like more info please have a look at [my blog article](https://nevarsin.blog/raspberry-router/)

## Configuration

The script assumes you have iptables installed.
Edit the script and set:
- your LAN interface
- your default WAN interface
- the Country Code (2 chars) for the VPN connection. Proton free tier allows for NL, JP and US

## Execution

`./protonvpn.sh enable` to connect and enable the new routing

`./protonvpn.sh disable` to disconnect and fall back to your default routing

