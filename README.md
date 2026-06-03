# Yggdrasil - Homelab Infrastructure

Yggdrasil is a comprehensive homelab infrastructure codebase spanning from bare metal provisioning through Kubernetes application deployment. The repository is organized to support both the legacy (v1) and new (v2) infrastructure implementations.

## Repository Structure

### `/version1` - Legacy Infrastructure
The current production implementation based on Ubuntu VMs with Kubernetes.

- **`ansible/`** - Configuration management for Ubuntu nodes
  - Roles for master and worker node setup
  - Inventory management
  
- **`terraform/`** - Infrastructure as Code for Proxmox
  - VM provisioning and configuration
  - Network and storage setup
  
- **`k8s/`** - Kubernetes manifests and ArgoCD configurations
  - Infrastructure applications (MetalLB, cert-manager, Traefik, etc.)
  - Authentication stack (LLDAP, Dex, OAuth2-Proxy)
  - Application deployments
  - Bootstrap Application and configuration files
  
- **`scripts/`** - Utility scripts
  - Ubuntu template creation for Proxmox

### `/version2` - New Infrastructure (ArgoCD App of Apps)
The next-generation implementation based on Talos with a scalable GitOps approach.

- **`clusters/`** - Cluster-specific configurations
  - Cluster bootstrap configurations
  - Environment-specific overrides
  
- **`projects/`** - ArgoCD Projects and RBAC
  - Project definitions
  - Access control configurations
  
- **`apps/`** - Applications (App of Apps Pattern)
  - Infrastructure services
  - Business applications
  - Service deployments
  
- **`talos/`** - Talos-specific configurations
  - Machine configurations
  - Cluster initialization

### `/talos` - Shared Talos Configuration (Root Level)
Shared Talos configurations and utilities used across versions.

- Talos cluster configuration
- Machine templates
- Image schematics

## Migration Path: v1 → v2

The repository supports running both versions simultaneously during the transition:

1. **v1** remains the current production environment
2. **v2** is being developed in parallel with Talos and ArgoCD App of Apps pattern
3. Shared resources (like `talos/` at root) can be used by both versions

## Getting Started

### For v1 (Current Production)
See [version1/README.md](version1/README.md) for detailed setup instructions.

### For v2 (Development)
See [version2/README.md](version2/README.md) for the new architecture guidelines.

## Key Technologies

**Version 1:**
- Proxmox VM Management
- Terraform for Infrastructure
- Ansible for Configuration Management
- Kubernetes with ArgoCD

**Version 2:**
- Talos Linux for OS
- Kubernetes native
- ArgoCD App of Apps Pattern
- GitOps-first approach

## Directory Summary

```
Yggdrasil/
├── version1/           # Legacy v1 infrastructure
│   ├── ansible/
│   ├── k8s/
│   ├── terraform/
│   └── scripts/
├── version2/           # New v2 infrastructure
│   ├── clusters/
│   ├── projects/
│   ├── apps/
│   └── talos/
├── talos/              # Shared Talos configs
└── README.md           # This file
```

## Notes

- All ArgoCD paths in v1 have been updated to reference `version1/k8s/*` paths
- Both versions can coexist during development
- Configuration management differs significantly between v1 and v2
- Transition timeline and strategy should be documented separately

---

Last Updated: 2026-05-31
