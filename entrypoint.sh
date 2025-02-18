#!/bin/sh

# Start OpenVPN in the background
openvpn --config /etc/openvpn/config.ovpn &

# Wait until the VPN tunnel interface (typically tun0) is up with an IP address.
while true; do
    if ip addr show tun0 | grep -q "inet "; then
        echo "VPN tunnel (tun0) is up."
        break
    fi
    echo "Waiting for VPN tunnel (tun0) to be up..."
    sleep 1
done

echo "Starting socat proxies..."

# Call the socat startup script (which waits for the VPN tunnel)
bash run-socat.sh

echo "Startup complete"

# Keep the container running
tail -f /dev/null
