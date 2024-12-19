# Ansible Role: EMQX

[![Molecule CI/CD](https://github.com/zhongwencool/ansible-role-emqx/actions/workflows/molecule.yml/badge.svg)](https://github.com/zhongwencool/ansible-role-emqx/actions/workflows/molecule.yml) [![Debian 11](https://img.shields.io/badge/Debian-11-blue?logo=debian)](https://www.debian.org/) [![Debian 12](https://img.shields.io/badge/Debian-12-blue?logo=debian)](https://www.debian.org/) [![Ubuntu 20.04](https://img.shields.io/badge/Ubuntu-20.04-orange?logo=ubuntu)](https://ubuntu.com/) [![Ubuntu 22.04](https://img.shields.io/badge/Ubuntu-22.04-orange?logo=ubuntu)](https://ubuntu.com/) [![Rocky Linux 8](https://img.shields.io/badge/Rocky%20Linux-8-green?logo=rocky-linux)](https://rockylinux.org/) [![Rocky Linux 9](https://img.shields.io/badge/Rocky%20Linux-9-green?logo=rocky-linux)](https://rockylinux.org/) [![Amazon Linux 2](https://img.shields.io/badge/Amazon%20Linux-2-232F3E?logo=amazon-aws)](https://aws.amazon.com/amazon-linux-2/) [![Amazon Linux 2023](https://img.shields.io/badge/Amazon%20Linux-2023-232F3E?logo=amazon-aws)](https://aws.amazon.com/linux/) [![License](https://img.shields.io/badge/License-Apache--2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)


An Ansible Role that installs and configures EMQX 5.x on Linux.

## Requirements

- Ansible 2.18.1 or higher
- Supported OS: Debian 11/12, Ubuntu 20.04/22.04, Rocky Linux 8/9, Amazon Linux 2/2023

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml`).
## Dependencies

None.

## Example Playbooks

### Basic Installation



## TODO
- Update configuration interface
- update to ansible-galaxy
 
- Web interface for inventory generation
- host generator.
- SSL certificate management
- Backup/restore functionality (as plugin)