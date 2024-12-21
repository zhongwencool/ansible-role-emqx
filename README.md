# Ansible Role: EMQX

[![Molecule CI/CD](https://github.com/zhongwencool/ansible-role-emqx/actions/workflows/molecule.yml/badge.svg)](https://github.com/zhongwencool/ansible-role-emqx/actions/workflows/molecule.yml) [![Debian 11](https://img.shields.io/badge/Debian-11-blue?logo=debian)](https://www.debian.org/) [![Debian 12](https://img.shields.io/badge/Debian-12-blue?logo=debian)](https://www.debian.org/) [![Ubuntu 20.04](https://img.shields.io/badge/Ubuntu-20.04-orange?logo=ubuntu)](https://ubuntu.com/) [![Ubuntu 22.04](https://img.shields.io/badge/Ubuntu-22.04-orange?logo=ubuntu)](https://ubuntu.com/) [![Rocky Linux 8](https://img.shields.io/badge/Rocky%20Linux-8-green?logo=rocky-linux)](https://rockylinux.org/) [![Rocky Linux 9](https://img.shields.io/badge/Rocky%20Linux-9-green?logo=rocky-linux)](https://rockylinux.org/) [![Amazon Linux 2](https://img.shields.io/badge/Amazon%20Linux-2-232F3E?logo=amazon-aws)](https://aws.amazon.com/amazon-linux-2/) [![Amazon Linux 2023](https://img.shields.io/badge/Amazon%20Linux-2023-232F3E?logo=amazon-aws)](https://aws.amazon.com/linux/) [![License](https://img.shields.io/badge/License-Apache--2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)


An Ansible Role that installs and configures EMQX 5.x on your target host(s).

## Requirements

- Ansible 2.18.1 or higher

For ease of use, you can install and/or upgrade Ansible core, Jinja2, and the Ansible collections on your Ansible host:

```bash
# Create virtual environment
python3 -m venv venv
source venv/bin/activate
pip install --upgrade pip
pip install --upgrade -r https://raw.githubusercontent.com/zhongwencool/ansible-role-emqx/main/requirements.txt
curl -O https://raw.githubusercontent.com/zhongwencool/ansible-role-emqx/main/meta/requirements_collections.yml
ansible-galaxy install --force -r requirements_collections.yml
rm -f requirements_collections.yml
```

## Role Installation

This role can be installed via either Ansible Galaxy (the Ansible community marketplace) or by cloning this repo. Once installed, you will need to include the role in your Ansible playbook using [the `roles` keyword, the `import_role` module, or the `include_role` module](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_reuse_roles.html#using-roles).

### Ansible Galaxy

To install the latest stable release of the role on your system, use:

```bash
ansible-galaxy install zhongwencool.emqx
```

Alternatively, if you have already installed the role, you can update the role to the latest release by using:

```bash
ansible-galaxy install -f zhongwencool.emqx
```

To use the role, include the following task in your playbook:

```yaml
- name: Install EMQX
  ansible.builtin.include_role:
    name: zhongwencool.emqx
```

### Git

To pull the latest edge commit of the role from GitHub, use:

```bash
git clone https://github.com/zhongwencool/ansible-role-emqx.git
```

To use the role, include the following task in your playbook:

```yaml
- name: Install EMQX
  ansible.builtin.include_role:
    name: <path/to/repo> # e.g. <roles/ansible-role-emqx> if you clone the repo inside your project's roles directory
```

## Role Variables

Available variables are listed below, along with default values (see `defaults/main/*.yml`).


## How This Role Works

This Ansible role automates the deployment and configuration of EMQX 5.x through several organized steps:

### 1. Initial Setup
- Sets up system user and group for EMQX
- Creates necessary directories with proper permissions
- Configures hostname and /etc/hosts for cluster communication
- Installs required system dependencies based on the OS family (Debian/RedHat)
- Sets up system locale and timezone

### 2. System Configuration
- Configures system kernel parameters (sysctl) for optimal EMQX performance
- Sets up firewall rules for EMQX ports:
  - TCP port 1883 (MQTT)
  - TCP port 8883 (MQTT over SSL)
  - TCP port 8083 (MQTT over WebSocket)
  - TCP port 8084 (MQTT over WSS)
  - TCP port 18083 (Dashboard)
  - TCP ports 4370/5730 (Cluster communication)

### 3. Time Synchronization
- Installs and configures Chrony for accurate time synchronization
- Essential for proper cluster operation and message timestamps

### 4. EMQX Installation and Configuration
- Installs EMQX package based on the specified version
- Configures core EMQX settings including:
  - Node name and cookie for cluster authentication
  - Dashboard access and ports
  - Listener ports (TCP/SSL/WebSocket/WSS)
  - SSL/TLS certificates if enabled
  - Cluster discovery strategy

### 5. Cluster Configuration
Supports multiple cluster discovery strategies:
- Static discovery (default)
  - Automatically configures all nodes in the inventory
  - No manual node configuration needed
- Manual discovery
  - Allows explicit control over which nodes join the cluster
  - Requires setting `emqx_initial_hostname`
- ETCD discovery
  - For dynamic cluster configurations
  - Requires ETCD server configuration

### 6. Plugin Management
- Handles EMQX plugin installation and configuration
- Supports Guard Pro plugin deployment when enabled

## Key Configuration Variables

Important variables you can customize (defaults shown):

```yaml
# EMQX Version
emqx_version: "5.8.3"

# Dashboard Configuration
emqx_dashboard:
  http_port: 18083
  swagger_support: true

# Core Listener Ports
emqx_tcp_port: 1883
emqx_ssl_port: 8883
emqx_ws_port: 8083
emqx_wss_port: 8084

# Cluster Configuration
emqx_cluster_discovery_strategy: static
emqx_node_cookie: "emqxsecretcookie"  # Change this in production!

# System Configuration
emqx_sysctl_enabled: true
emqx_chrony_enabled: true
```

## Deployment Process

1. **Prepare Your Inventory**
   ```ini
   [emqx_cluster]
   node1.emqx.local
   node2.emqx.local
   node3.emqx.local
   ```

2. **Configure Variables**
   Create a vars file or define in your playbook:
   ```yaml
   emqx_version: "5.8.3"
   emqx_node_cookie: "your-secure-cookie"
   # Add other custom configurations
   ```

3. **Run the Role**
   ```yaml
   - hosts: emqx_cluster
     roles:
       - zhongwencool.emqx
   ```

4. **Verify Installation**
   - Access the EMQX dashboard at `http://<node-ip>:18083`
   - Default credentials are admin/public
   - Check cluster status through dashboard or CLI

## Security Considerations

- Change default dashboard credentials
- Use a secure `emqx_node_cookie` in production
- Configure SSL/TLS for production environments
- Review and adjust firewall rules as needed
- Consider network security between cluster nodes

## Uninstall

To uninstall EMQX, run the following command:

```bash
molecule converge -s uninstall
```

