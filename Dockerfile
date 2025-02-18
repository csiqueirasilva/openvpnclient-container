# Base Image
FROM debian:bullseye-slim

# Install OpenVPN, socat, and required tools
RUN apt update && apt install -y \
    openvpn \
    socat \
    iproute2 \
    iptables \
    curl \
    && mkdir -p /etc/openvpn \
    && chmod 0755 /etc/openvpn

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Copy the run-socat script
COPY run-socat.sh /run-socat.sh
RUN chmod +x /run-socat.sh

# Set the entrypoint
ENTRYPOINT ["/entrypoint.sh"]
