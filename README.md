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


## TODO
- Update configuration interface
- ci auto upload to ansible-galaxy when tag?

- Web site for host inventory generation
- playbook cli generator.

- SSL certificate management(as guard plugin)
- Backup/restore functionality (as guard plugin)
