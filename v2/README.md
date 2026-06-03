# Version 2 - ArgoCD App of Apps Pattern

This directory contains the version 2 implementation of the Yggdrasil homelab infrastructure, built on Talos and following the ArgoCD App of Apps design pattern.

## Structure

### `/clusters`
Cluster-specific configurations and bootstrap files. Each cluster may have its own subdirectory.
- Example: `local/`, `prod/`, etc.

### `/projects`
Project definitions and RBAC configurations for ArgoCD projects. Organize by project name or environment.
- Used to define project permissions and synchronization policies
- Contains AppProject resources

### `/apps`
Individual application definitions following the App of Apps pattern.
- Each application should have its own Application resource
- Organize by service type or functionality (e.g., `core/`, `monitoring/`, `security/`, etc.)

### `/talos`
Talos cluster configuration and machine configurations.
- Talos machine configs
- Cluster bootstrap scripts

## Getting Started

1. Configure your Talos cluster in `/talos`
2. Define your ArgoCD Projects in `/projects`
3. Create your cluster bootstrap Application in `/clusters`
4. Add individual applications in `/apps`

## References

- [ArgoCD App of Apps Pattern](https://argo-cd.readthedocs.io/en/stable/operator-manual/cluster-bootstrapping/#app-of-apps-pattern)
- [Talos Documentation](https://www.talos.dev/)
