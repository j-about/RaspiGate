# RaspiGate

Ansible-deployable networking hub for Raspberry Pi 5: DNS server, OpenVPN client/server with multiple routing configurations.

## Environment

### [Ansible](https://github.com/ansible/ansible) - Ansible is a radically simple IT automation system.

## How To Use It

```bash
gh repo clone j-about/RaspiGate # Clone the RaspiGate repository
```

```bash
cd RaspiGate # Move to the RaspiGate directory
```

```bash
cp .env.example .env # Copy the example environment file
```

### Define environment variables

<table>
    <thead>
        <tr>
            <th>Name</th>
            <th>Description</th>
            <th>Example value</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>RPI_IP</code></td>
            <td>The IP address of the Raspberry Pi.</td>
            <td><code>192.168.1.101</code></td>
        </tr>
        <tr>
            <td><code>RPI_USER</code></td>
            <td>Username for SSH access to the Raspberry Pi.</td>
            <td><code>username</code></td>
        </tr>
        <tr>
            <td><code>RPI_SSH_PRIVATE_KEY_FILE</code></td>
            <td>Path to the SSH private key file for authentication.</td>
            <td><code>~/.ssh/privatekeyfile</code></td>
        </tr>
        <tr>
            <td><code>RPI_STATIC_IP</code></td>
            <td>Static IP address for the Raspberry Pi.</td>
            <td><code>192.168.1.21</code></td>
        </tr>
        <tr>
            <td><code>CIDR</code></td>
            <td>CIDR notation for subnet.</td>
            <td><code>24</code></td>
        </tr>
        <tr>
            <td><code>GATEWAY</code></td>
            <td>Gateway IP for the network.</td>
            <td><code>192.168.1.1</code></td>
        </tr>
        <tr>
            <td><code>NETWORK</code></td>
            <td>Network IP address.</td>
            <td><code>192.168.1.0</code></td>
        </tr>
        <tr>
            <td><code>NETMASK</code></td>
            <td>Network mask.</td>
            <td><code>255.255.255.0</code></td>
        </tr>
        <tr>
            <td><code>RPI_MACVLAN_STATIC_IP</code></td>
            <td>Static IP assigned to the macvlan interface on Raspberry Pi.</td>
            <td><code>192.168.1.22</code></td>
        </tr>
        <tr>
            <td><code>ADGUARD_STATIC_IP</code></td>
            <td>Static IP for AdGuard server deployment.</td>
            <td><code>192.168.1.23</code></td>
        </tr>
        <tr>
            <td><code>VPN_USERNAME</code></td>
            <td>Username for VPN client authentication.</td>
            <td><code>JohnDoe</code></td>
        </tr>
        <tr>
            <td><code>VPN_PASSWORD</code></td>
            <td>Password for VPN client authentication.</td>
            <td><code>Password123</code></td>
        </tr>
        <tr>
            <td><code>VPN_CLIENT_STATIC_IP</code></td>
            <td>Static IP for the VPN client.</td>
            <td><code>192.168.1.24</code></td>
        </tr>
        <tr>
            <td><code>VPN_CLIENT_DNS_1</code></td>
            <td>Primary DNS for VPN client.</td>
            <td><code>8.8.8.8</code></td>
        </tr>
        <tr>
            <td><code>VPN_CLIENT_DNS_2</code></td>
            <td>Secondary DNS for VPN client.</td>
            <td><code>8.8.4.4</code></td>
        </tr>
        <tr>
            <td><code>EASYRSA_REQ_CN</code></td>
            <td>Common Name for EasyRSA certificate request.</td>
            <td><code>John Doe</code></td>
        </tr>
        <tr>
            <td><code>EASYRSA_CLIENT_NAME</code></td>
            <td>Client name for EasyRSA configuration.</td>
            <td><code>johndoe</code></td>
        </tr>
        <tr>
            <td><code>VPN_SERVER_VVC_EASYRSA_SERVER_NAME</code></td>
            <td>EasyRSA server name for VPN server via VPN client.</td>
            <td><code>vpn-server-via-vpn-client</code></td>
        </tr>
        <tr>
            <td><code>VPN_SERVER_VVC_STATIC_IP</code></td>
            <td>Static IP for VPN server via VPN client.</td>
            <td><code>192.168.1.25</code></td>
        </tr>
        <tr>
            <td><code>VPN_SERVER_VVC_PORT</code></td>
            <td>Port for VPN server via VPN client.</td>
            <td><code>443</code></td>
        </tr>
        <tr>
            <td><code>VPN_SERVER_VVC_PROTOCOL</code></td>
            <td>Protocol for VPN server via VPN client.</td>
            <td><code>tcp</code></td>
        </tr>
        <tr>
            <td><code>VPN_SERVER_VVC_HOST</code></td>
            <td>Host for VPN server via VPN client.</td>
            <td><code>vpn1.example.com</code></td>
        </tr>
        <tr>
            <td><code>VPN_SERVER_VVC_NETWORK</code></td>
            <td>Network for VPN server via VPN client.</td>
            <td><code>192.168.2.0</code></td>
        </tr>
        <tr>
            <td><code>VPN_SERVER_VVC_NETMASK</code></td>
            <td>Netmask for VPN server via VPN client.</td>
            <td><code>255.255.255.0</code></td>
        </tr>
        <tr>
            <td><code>VPN_SERVER_VISP_EASYRSA_SERVER_NAME</code></td>
            <td>EasyRSA server name for VPN server via ISP.</td>
            <td><code>vpn-server-via-isp</code></td>
        </tr>
        <tr>
            <td><code>VPN_SERVER_VISP_STATIC_IP</code></td>
            <td>Static IP for VPN server via ISP.</td>
            <td><code>192.168.1.26</code></td>
        </tr>
        <tr>
            <td><code>VPN_SERVER_VISP_PORT</code></td>
            <td>Port for VPN server via ISP.</td>
            <td><code>1194</code></td>
        </tr>
        <tr>
            <td><code>VPN_SERVER_VISP_PROTOCOL</code></td>
            <td>Protocol for VPN server via ISP.</td>
            <td><code>tcp</code></td>
        </tr>
        <tr>
            <td><code>VPN_SERVER_VISP_HOST</code></td>
            <td>Host for VPN server via ISP.</td>
            <td><code>vpn2.example.com</code></td>
        </tr>
        <tr>
            <td><code>VPN_SERVER_VISP_NETWORK</code></td>
            <td>Network for VPN server via ISP.</td>
            <td><code>192.168.3.0</code></td>
        </tr>
        <tr>
            <td><code>VPN_SERVER_VISP_NETMASK</code></td>
            <td>Netmask for VPN server via ISP.</td>
            <td><code>255.255.255.0</code></td>
        </tr>
        <tr>
            <td><code>VPN_SERVER_LOCAL_EASYRSA_SERVER_NAME</code></td>
            <td>EasyRSA server name for VPN server for local network access only.</td>
            <td><code>vpn-server-via-isp</code></td>
        </tr>
        <tr>
            <td><code>VPN_SERVER_LOCAL_STATIC_IP</code></td>
            <td>Static IP for VPN server for local network access only.</td>
            <td><code>192.168.1.27</code></td>
        </tr>
        <tr>
            <td><code>VPN_SERVER_LOCAL_PORT</code></td>
            <td>Port for VPN server for local network access only.</td>
            <td><code>1194</code></td>
        </tr>
        <tr>
            <td><code>VPN_SERVER_LOCAL_PROTOCOL</code></td>
            <td>Protocol for VPN server for local network access only.</td>
            <td><code>tcp</code></td>
        </tr>
        <tr>
            <td><code>VPN_SERVER_LOCAL_HOST</code></td>
            <td>Host for VPN server for local network access only.</td>
            <td><code>vpn3.example.com</code></td>
        </tr>
        <tr>
            <td><code>VPN_SERVER_LOCAL_NETWORK</code></td>
            <td>Network for VPN server for local network access only.</td>
            <td><code>192.168.4.0</code></td>
        </tr>
        <tr>
            <td><code>VPN_SERVER_LOCAL_NETMASK</code></td>
            <td>Netmask for VPN server for local network access only.</td>
            <td><code>255.255.255.0</code></td>
        </tr>
    </tbody>
</table>

### Add your VPN client configuration files

Place all your <code>.ovpn</code> configuration files into the <code>vpn-client/configs</code> directory. Each file represents a VPN connection you want to use.

```bash
ansible-playbook -i inventory.yaml playbook.yaml # Run the Ansible playbook
```
