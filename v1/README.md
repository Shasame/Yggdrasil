# Version 1 - Legacy Infrastructure

This directory contains the version 1 implementation of the Yggdrasil homelab infrastructure, featuring Ubuntu-based Kubernetes cluster deployed on Proxmox.

## Structure

### `/ansible`
Configuration management for Ubuntu nodes using Ansible.
- **`roles/`** - Ansible roles for different node types
  - `common/` - Common setup for all nodes
  - `master/` - Master node configuration
  - `worker/` - Worker node configuration
- **`inventory/`** - Inventory files
  - `hosts.ini` - Node inventory and host groups
- **`site.yml`** - Main playbook
- **`ansible.cfg`** - Ansible configuration

### `/terraform`
Infrastructure as Code for Proxmox using Terraform.
- **`main.tf`** - Resource definitions
- **`providers.tf`** - Provider configuration
- **`variables.tf`** - Variable definitions
- **`terraform.tfvars`** - Variable values (not committed)
- **`terraform.tfstate`** - State file (not committed)

### `/k8s`
Kubernetes manifests and ArgoCD configurations.
- **`bootstrap/`** - Bootstrap applications
  - `root.yaml` - Root Application (loads infrastructure)
- **`infrastructure/`** - Infrastructure services
  - `app-stack.yaml` - Application stack root
  - `cert-manager.yaml` - Certificate management
  - `traefik.yaml` - Ingress controller
  - `metallb.yaml` - Load balancer
  - `longhorn.yaml` - Storage
  - `argocd-sso.yaml` - ArgoCD single sign-on
  - `network-stack.yaml` - Network infrastructure
  - `auth/` - Authentication services
    - `dex.yaml` - OIDC provider
    - `lldap.yaml` - LDAP directory
    - `oauth2-proxy.yaml` - OAuth2 proxy
    - `rbac/` - RBAC configurations
  - `configs/` - Configuration files
- **`apps/`** - Application deployments
  - `glance.yaml` - Example application
- **`_archive/`** - Archived/disabled applications

### `/scripts`
Utility scripts for infrastructure management.
- `create_ubuntu_template.sh` - Creates Ubuntu cloud-init templates on Proxmox nodes

## Workflow

### 1. Infrastructure Provisioning
```bash
cd terraform
terraform init
terraform plan
terraform apply
```

### 2. Node Configuration
```bash
cd ansible
ansible-playbook -i inventory/hosts.ini site.yml
```

### 3. Kubernetes Deployment
The cluster is bootstrapped through ArgoCD Applications:
- Root Application deploys from `k8s/bootstrap/root.yaml`
- Infrastructure stack loads from `k8s/infrastructure/app-stack.yaml`
- Applications load from `k8s/apps/`

## Key Points

- **Path Updates**: All ArgoCD manifests have been updated to use `version1/k8s/*` paths
- **Relative Paths**: Ansible and Terraform use relative paths which work from their respective directories
- **State Management**: Terraform state files (tfstate) are gitignored
- **Secrets**: Variable files and SSH keys are kept separate from version control

## Notes

- This is the current production environment
- Version 2 is being developed in parallel for a migration to Talos
- Both versions can coexist during transition

---

For repository-wide documentation, see [../README.md](../README.md)
