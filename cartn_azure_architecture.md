# Azure Production Environment Architecture & Security #

## Executive Summary ##

This document provides a high-level overview of our primary production application, **\"CARTN\"**, hosted in the Microsoft Azure cloud. The environment is designed for security, high availability, and scalability, supporting both internal and customer-facing services. All resources are contained within a single, well-managed resource group (rg-id001) in our cartn-production subscription. 

The architecture follows industry best practices, including a hub-and-spoke network model, zero-trust security principles, and comprehensive monitoring. Key highlights include a robust security posture with a firewall, encrypted data storage, and isolated application tiers. The total environment is currently in a healthy state with all critical monitoring and backup systems operational.

## Environment at a Glance ##
  
|Category         | Summary             |
|-----------------|-------------------- |
| Business Unit   |Xfinion CARTN        | 
|  Application    | CARTN (Component: A multi-tier application supporting ) web, API, and data services. |
| Subscription    | cartn-production     Dedicated production subscription. |
| Resource Group  | rg-id001  |Centralized management for all related resources. |

## High-Level Architecture & Data Flow ##

![architecture](media/high-level%20architecture%20and%20data%20flow.png)
**Key Architectural Decisions:**

- **Network Isolation:** All resources reside within a single, segmented   Virtual Network (vnet-id001-s001) with dedicated subnets for
  firewalls, services, and databases.

- **Security-First:** A central **Azure Firewall** controls all inbound,   outbound, and East-West traffic. Public access is minimized.

- **Modern Application Hosting:** We leverage **Azure App Services** and   a **Static Web App** for scalable and manageable web hosting, reducing
  operational overhead.

- **Secure Access:** Administrative access is provided securely   via **Azure Bastion Host**, eliminating the need for open RDP/SSH
  ports.

![Azure resource view.](media/resources.png)

## Key Components & Business Purpose ##

  --------------------------------------------------------------------------------
  Resource Name        Type        Business Purpose & Criticality
  -------------------- ----------- -----------------------------------------------
  vnet-id001-s001      Virtual     **Core Networking:** The secure backbone Network connecting all application components. **(Critical)**

  vmdbid002            Virtual     **Database Server:** Hosts the primary Machine application database. **(Critical)**

  vnet-fw-id001-s004   Firewall    **Security Perimeter:** Central point for network security and traffic inspection. **(Critical)**

  kv-id001-s160-001    Key Vault   **Secrets Management:** Securely stores passwords, certificates, and keys. **(Critical)**

  stgid001s030         Storage Account     **Data & Backup Storage:** Stores application data, logs, and diagnostics. **(High)**

  wa-\*-id001-s0\*0    App Services application  **Web Application Hosting:** Runs the user interface and API components of the **(High)**

  law-id001-s110       Log Analytics         **Centralized Monitoring:** Aggregates all logs and performance data for security and operational insights. **(High)**
  --------------------------------------------------------------------------------

## Security & Compliance Posture ##

We have implemented a strong security baseline, as confirmed by the
resource inventory.

  
  |Security Area | Status            | Details |
  |--------------|-------------------|--------------------------------------------|
  **Network      **Strong**          \- Default \"Deny All\" posture with
  Security**                         explicit allow rules.\
                                     - Database subnet (snet-db-id001-s011) is
                                     highly restricted.\
                                     - Azure Firewall deployed for centralized
                                     control.

  **Data         **Enabled**         \- All storage accounts and VM disks
  Encryption**                       encrypted at rest using Microsoft Managed
                                     Keys.\
                                     - TLS 1.2 enforced for data in transit.

  **Secrets      **Best Practice**   \- Key Vault with **Purge
  Management**                       Protection** and **Soft Delete** enabled.\
                                     - Accessed via **Private Endpoints**, not
                                     public internet.\
                                     - Uses RBAC (Role-Based Access Control) for
                                     authorization.

  **Access       **Managed**         \- All App Services and VMs
  Management**                       use **System-Assigned Managed
                                     Identities** for secure, credential-free
                                     access to other Azure services.

  **Monitoring & **Comprehensive**   \- Full monitoring enabled (Application
  Alerting**                         Insights, Log Analytics, VM Diagnostics).\
                                     - Alert rules configured for VM health (CPU,
                                     Memory, Disk, Network).
  -------------------------------------------------------------------------------

## Recommendations & Strategic Roadmap ##

The environment is well-architected. The following are strategic
recommendations to further enhance resilience and operational
excellence.

1.  **High Priority: Finalize Backup Strategy**

    - **Action:** A Recovery Services Vault (vm-db-rec-vlt-id001-s095)
      is deployed. We must configure and test a regular backup policy
      for the critical database VM (vmdbid002).

    - **Business Impact:** Ensures business continuity and data recovery
      in case of accidental deletion or corruption.

2.  **Medium Priority: Cost Optimization Review**

    - **Action:** Analyze the usage of the App Service Plans (currently
      B1 tier) and VM size (Standard_E4s_v3). Right-sizing these
      resources can lead to significant cost savings.

    - **Business Impact:** Direct reduction in monthly Azure spend.

3.  **Future Planning: Enhance Disaster Recovery (DR)**

    - **Action:** Develop a formal DR plan. Consider replicating the
      critical database VM to a secondary Azure region.

    - **Business Impact:** Minimizes downtime and data loss in a major
      regional outage scenario.

**B.**

**Azure Production Environment Architecture Overview**\
**Environment:** Production (cartn-production)\
**Resource Group:** rg-id001

**1. Summary**

This document provides a high-level overview of the CARTN application
architecture running in Microsoft Azure. The environment is designed for
security, reliability, and scalability, hosting business-critical
applications and data services for production use.

All infrastructure is centrally managed within the **rg-id001** resource
group, following modern cloud security practices including network
segmentation, private connectivity, and comprehensive monitoring.

## Core Architecture Components ##

### Networking & Security Foundation ###

  --------------------------------------------------------------------------
  **Component**     **Name**                      **Purpose**
  ----------------- ----------------------------- --------------------------
  **Virtual         vnet-id001-s001               Core network
  Network**                                       infrastructure
                                                  (10.0.0.0/19)

  **Firewall**      vnet-fw-id001-s004            Central network security &
                                                  traffic inspection

  **Bastion Host**  vnet-hst-bastion-id001-s002   Secure remote access to
                                                  virtual machines

  **DDoS            vnet-ddosp-id001-s015         Protection against
  Protection**                                    volumetric attacks

  **Network         vmdbid002-nsg,                Subnet and VM-level
  Security Groups** snet-sg-qpui-id001-s007       traffic control
  --------------------------------------------------------------------------

### Compute Resources ###

  ----------------------------------------------------------------------------------
  **Resource**               **Type**      **Role**       **Specifications**
  -------------------------- ------------- -------------- --------------------------
  **vmdbid002**              Virtual       Database       Standard_E4s_v3, 4 vCPUs,
                             Machine       Server         32GB RAM

  **wa-qpapi-id001-s060**    App Service   Application    Basic B1 Plan
                                           API            

  **wa-api-id001-s070**      App Service   Main API       Basic B1 Plan
                                           Service        

  **wa-ingsvc-id001-s080**   App Service   Ingestion      Basic B1 Plan
                                           Service        

  **swa-qpui-id001-s050**    Static Web    User Interface Standard Tier
                             App                          
  ----------------------------------------------------------------------------------

### Data & Storage Services ###

  ---------------------------------------------------------------------------
  **Service**     **Name**                   **Purpose**
  --------------- -------------------------- --------------------------------
  **Storage       stgid001s030               General storage, diagnostics,
  Account**                                  and backups

  **Key Vault**   kv-id001-s160-001          Secrets, certificates, and key
                                             management

  **Recovery      vm-db-rec-vlt-id001-s095   VM backup and disaster recovery
  Services**                                 
  ---------------------------------------------------------------------------

### Monitoring & Management ###

  -------------------------------------------------------------------------
  **Service**      **Name**                     **Function**
  ---------------- ---------------------------- ---------------------------
  **Log            law-id001-s110               Centralized logging and
  Analytics**                                   monitoring

  **Application    ai-id001-s130                Application performance
  Insights**                                    monitoring

  **Action         RecommendedAlertRules-AG-1   Alert notifications and
  Groups**                                      automation
  -------------------------------------------------------------------------

## Network Architecture ##

### Subnet Structure ###

The virtual network contains multiple isolated subnets for different
tiers:

- **AzureFirewallSubnet** (10.0.1.64/26) - Firewall services

- **AzureBastionSubnet** (10.0.1.0/26) - Secure access service

- **snet-db-id001-s011** (10.0.6.0/24) - Database tier

- **snet-qpui-id001-s007** (10.0.2.0/24) - User interface services

- **snet-api-id001-s009** (10.0.4.0/24) - API services

- **snet-stg-id001-s013** (10.0.8.0/24) - Storage connectivity

### Connectivity Flow ###

![connectivity](media/connection_flow.png)

## Security Posture ##

### Key Security Features ###

- **Network Security:** Default deny posture with explicit allow rules

- **Data Encryption:** All storage encrypted at rest; TLS 1.2 enforced

- **Access Control:** Managed Identities for service authentication

- **Secrets Management:** Key Vault with private endpoints and purge
  protection

- **Monitoring:** Comprehensive logging with Security Center integration

### Compliance & Protection ###

- **Soft Delete & Purge Protection** enabled on Key Vault

- **Private Endpoints** for Storage and Key Vault services

- **Network Security Groups** restricting traffic between tiers

- **Azure Defender** integrations enabled

## High Availability & Disaster Recovery ##

### Current Capabilities ###

- **Geo-redundant Storage** (GRS) for storage accounts

- **Recovery Services Vault** configured for VM backup

- **Distributed Application Architecture** across multiple subnets

### Backup Strategy ###

- **VM Backups:** Configured via Recovery Services Vault

- **Application Data:** Stored in geo-redundant storage

- **Operational Logs:** 90-day retention in Log Analytics

## Cost Management ##

### Resource Tiering ###

- **App Services:** Basic B1 tier (development/testing level)

- **Virtual Machine:** Standard_E4s_v3 (production-grade)

- **Storage:** Standard GRS (cost-effective for backups)

## Recommendations ##

1.  **Scale App Service Plans** to Standard tier for production
    workloads

2.  **Implement Azure Application Gateway** for web application firewall
    capabilities

3.  **Configure Azure Backup** policies for all critical resources

4.  **Establish resource tagging standards** for cost allocation
