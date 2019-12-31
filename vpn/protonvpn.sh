#!/bin/bash
# Version 0.1 - Nevarsin (Stefano Chittaro)
# Simple script to automatically enable a ProtonVPN tunnel and subsequently set it as your LAN default outgoing network interface

# ------------- Configuration ---------------------

# Set your LAN interface
LAN_INT=eth0

# Set your default WAN interface
WAN_INT=usb0

# Set the Protovpn country code (2 chars) your would like to use. Free tier allows for NL, JP and US
VPN_COUNTRY=NL

# -------------- End configuration ----------------

if [ ! -x protonvpn ]
then
    echo "ProtonVPN CLI not found in PATH. Please install it by following this tutorial: https://protonvpn.com/support/linux-vpn-tool. Exiting..."
    exit 1
fi

if [ -n $1 ] 
then
  case $1 in 
    enable)
      echo "Connecting VPN..."
      protonvpn c --cc $VPN_COUNTRY
      echo "... done"
      echo "Cleaning previous forward and NAT rules..."
      iptables -D FORWARD -i $WAN_INT -o $LAN_INT -m state --state RELATED,ESTABLISHED -j ACCEPT
      iptables -D FORWARD -i $LAN_INT -o $WAN_INT -j ACCEPT
      iptables -t nat --flush POSTROUTING
      echo "Setting Outgoing NAT to tun0..."
      iptables -A FORWARD -i tun0 -o $LAN_INT -m state --state RELATED,ESTABLISHED -j ACCEPT
      iptables -A FORWARD -i $LAN_INT -o tun0 -j ACCEPT
      iptables -t nat -A POSTROUTING -o tun0 -j MASQUERADE
      echo "... done"
      echo "Your default gateway is now a ProtonVPN Tunnel"
      ;;
    disable)
      echo "Disconnecting VPN..."
      protonvpn d
      echo "... done"
      iptables -D FORWARD -i tun0 -o $LAN_INT -m state --state RELATED,ESTABLISHED -j ACCEPT
      iptables -D FORWARD -i $LAN_INT -o tun0 -j ACCEPT
      iptables -t nat --flush POSTROUTING
      echo "Setting Outgoing NAT back to $WAN_INT..."
      iptables -A FORWARD -i $WAN_INT -o $LAN_INT -m state --state RELATED,ESTABLISHED -j ACCEPT
      iptables -A FORWARD -i $LAN_INT -o $WAN_INT -j ACCEPT
      iptables -t nat -A POSTROUTING -o $WAN_INT -j MASQUERADE
      echo "... done"
      echo "Your default gateway is now back to default"
      ;;
     *)
      echo "Unknown action. Available actions are enable/disable"
      ;;
    esac
else
  echo "Usage: ./protonvpn.sh enable|disable"
  exit 0
fi
