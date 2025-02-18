On ubuntu, change your netplan to something like:

```
network:
  version: 2
  renderer: NetworkManager
  ethernets:
    enp0s3:
      dhcp4: true
      nameservers:
        addresses:
          - 8.8.8.8       # Google DNS
          - 8.8.4.4       # Google DNS
          - 1.1.1.1       # Cloudflare DNS
          - 1.0.0.1       # Cloudflare DNS
    lo:
      addresses:
        - 127.0.0.1/8
        - 10.0.0.2/32
        - 10.0.0.3/32
        - 10.0.0.4/32
        - 10.0.0.5/32
        - 10.0.0.6/32
      dhcp4: false
```

To use additional hosts IPs. Bind what you need on those IPs using the docker-compose.yml, and use /etc/hosts to override DNS configuration from your desired hosts to your local IPs:

```
csiqueira@hawaiiland-linux:~/openvpnclient-container$ cat /etc/hosts
127.0.0.1 localhost
10.0.0.3 myhost1.com
10.0.0.4 myhost2.com
```

Also change your ovpn client configuration to include the password file if it doesn't:

```
auth-user-pass /etc/openvpn/auth.txt
```