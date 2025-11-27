**Date:** Nov 25, 2025  
**From:** IT/Cloud Architecture  
**Subject:** **Azure Production Environment Architecture & Security
Overview: **rg-id001

**A.**

**1. Executive Summary**

This document provides a high-level overview of our primary production
application, **\"CARTN\"**, hosted in the Microsoft Azure cloud. The
environment is designed for security, high availability, and
scalability, supporting both internal and customer-facing services. All
resources are contained within a single, well-managed resource group
(rg-id001) in our cartn-production subscription.

The architecture follows industry best practices, including
a **hub-and-spoke network model, zero-trust security principles, and
comprehensive monitoring.** Key highlights include a robust security
posture with a firewall, encrypted data storage, and isolated
application tiers. The total environment is currently in a healthy state
with all critical monitoring and backup systems operational.

**2. Environment at a Glance**

| Category           | Detail                            | Summary                                                                             |
|--------------------|-----------------------------------|-------------------------------------------------------------------------------------|
| **Business Unit**  | DOS-CA (Department of State - CA) |                                                                                     |
| **Application**    | CARTN (Component: npc)            | A multi-tier application supporting web, API, and data services.                    |
| **Subscription**   | cartn-production                  | Dedicated production subscription.                                                  |
| **Resource Group** | rg-id001                          | Centralized management for all related resources.                                   |
| **Overall Status** | **Healthy & Secured**             | Environment is deployed, monitored, and compliant with baseline security standards. |

**3. High-Level Architecture & Data Flow**

![A diagram of a software application AI-generated content may be
incorrect.](media/image1.png){width="6.268055555555556in"
height="4.178472222222222in"}**Key Architectural Decisions:**

- **Network Isolation:** All resources reside within a single, segmented
  Virtual Network (vnet-id001-s001) with dedicated subnets for
  firewalls, services, and databases.

- **Security-First:** A central **Azure Firewall** controls all inbound,
  outbound, and East-West traffic. Public access is minimized.

- **Modern Application Hosting:** We leverage **Azure App Services** and
  a **Static Web App** for scalable and manageable web hosting, reducing
  operational overhead.

- **Secure Access:** Administrative access is provided securely
  via **Azure Bastion Host**, eliminating the need for open RDP/SSH
  ports.

![A screenshot of a computer AI-generated content may be
incorrect.](media/image2.png){width="7.048611111111111in"
height="4.763888888888889in"}

**4. Key Components & Business Purpose**

| Resource Name      | Type            | Business Purpose & Criticality                                                                                         |
|--------------------|-----------------|------------------------------------------------------------------------------------------------------------------------|
| vnet-id001-s001    | Virtual Network | **Core Networking:** The secure backbone connecting all application components. **(Critical)**                         |
| vmdbid002          | Virtual Machine | **Database Server:** Hosts the primary application database. **(Critical)**                                            |
| vnet-fw-id001-s004 | Firewall        | **Security Perimeter:** Central point for network security and traffic inspection. **(Critical)**                      |
| kv-id001-s160-001  | Key Vault       | **Secrets Management:** Securely stores passwords, certificates, and keys. **(Critical)**                              |
| stgid001s030       | Storage Account | **Data & Backup Storage:** Stores application data, logs, and diagnostics. **(High)**                                  |
| wa-\*-id001-s0\*0  | App Services    | **Web Application Hosting:** Runs the user interface and API components of the application. **(High)**                 |
| law-id001-s110     | Log Analytics   | **Centralized Monitoring:** Aggregates all logs and performance data for security and operational insights. **(High)** |

**5. Security & Compliance Posture**

We have implemented a strong security baseline, as confirmed by the
resource inventory.

<table>
<colgroup>
<col style="width: 17%" />
<col style="width: 19%" />
<col style="width: 63%" />
</colgroup>
<thead>
<tr class="header">
<th>Security Area</th>
<th>Status</th>
<th>Details</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>Network Security</strong></td>
<td><strong>Strong</strong></td>
<td>- Default "Deny All" posture with explicit allow rules.<br />
- Database subnet (snet-db-id001-s011) is highly restricted.<br />
- Azure Firewall deployed for centralized control.</td>
</tr>
<tr class="even">
<td><strong>Data Encryption</strong></td>
<td><strong>Enabled</strong></td>
<td>- All storage accounts and VM disks encrypted at rest using
Microsoft Managed Keys.<br />
- TLS 1.2 enforced for data in transit.</td>
</tr>
<tr class="odd">
<td><strong>Secrets Management</strong></td>
<td><strong>Best Practice</strong></td>
<td>- Key Vault with <strong>Purge Protection</strong> and <strong>Soft
Delete</strong> enabled.<br />
- Accessed via <strong>Private Endpoints</strong>, not public
internet.<br />
- Uses RBAC (Role-Based Access Control) for authorization.</td>
</tr>
<tr class="even">
<td><strong>Access Management</strong></td>
<td><strong>Managed</strong></td>
<td>- All App Services and VMs use <strong>System-Assigned Managed
Identities</strong> for secure, credential-free access to other Azure
services.</td>
</tr>
<tr class="odd">
<td><strong>Monitoring &amp; Alerting</strong></td>
<td><strong>Comprehensive</strong></td>
<td>- Full monitoring enabled (Application Insights, Log Analytics, VM
Diagnostics).<br />
- Alert rules configured for VM health (CPU, Memory, Disk,
Network).</td>
</tr>
</tbody>
</table>

**6. Recommendations & Strategic Roadmap**

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

**Azure Production Environment Architecture Overview**  
**Environment:** Production (cartn-production)  
**Resource Group:** rg-id001

**1. Summary**

This document provides a high-level overview of the CARTN application
architecture running in Microsoft Azure. The environment is designed for
security, reliability, and scalability, hosting business-critical
applications and data services for production use.

All infrastructure is centrally managed within the **rg-id001** resource
group, following modern cloud security practices including network
segmentation, private connectivity, and comprehensive monitoring.

**2. Environment Overview**

- **Subscription:** cartn-production

- **Resource Group:** rg-id001

- **Region:** Primary: East US 2

- **Business Unit:** DOS-CA

- **Application:** CARTN

- **Status:** **Production Ready**

**3. Core Architecture Components**

**3.1 Networking & Security Foundation**

| **Component**               | **Name**                               | **Purpose**                                   |
|-----------------------------|----------------------------------------|-----------------------------------------------|
| **Virtual Network**         | vnet-id001-s001                        | Core network infrastructure (10.0.0.0/19)     |
| **Firewall**                | vnet-fw-id001-s004                     | Central network security & traffic inspection |
| **Bastion Host**            | vnet-hst-bastion-id001-s002            | Secure remote access to virtual machines      |
| **DDoS Protection**         | vnet-ddosp-id001-s015                  | Protection against volumetric attacks         |
| **Network Security Groups** | vmdbid002-nsg, snet-sg-qpui-id001-s007 | Subnet and VM-level traffic control           |

**3.2 Compute Resources**

| **Resource**             | **Type**        | **Role**          | **Specifications**                 |
|--------------------------|-----------------|-------------------|------------------------------------|
| **vmdbid002**            | Virtual Machine | Database Server   | Standard_E4s_v3, 4 vCPUs, 32GB RAM |
| **wa-qpapi-id001-s060**  | App Service     | Application API   | Basic B1 Plan                      |
| **wa-api-id001-s070**    | App Service     | Main API Service  | Basic B1 Plan                      |
| **wa-ingsvc-id001-s080** | App Service     | Ingestion Service | Basic B1 Plan                      |
| **swa-qpui-id001-s050**  | Static Web App  | User Interface    | Standard Tier                      |

**3.3 Data & Storage Services**

| **Service**           | **Name**                 | **Purpose**                               |
|-----------------------|--------------------------|-------------------------------------------|
| **Storage Account**   | stgid001s030             | General storage, diagnostics, and backups |
| **Key Vault**         | kv-id001-s160-001        | Secrets, certificates, and key management |
| **Recovery Services** | vm-db-rec-vlt-id001-s095 | VM backup and disaster recovery           |

**3.4 Monitoring & Management**

| **Service**              | **Name**                   | **Function**                       |
|--------------------------|----------------------------|------------------------------------|
| **Log Analytics**        | law-id001-s110             | Centralized logging and monitoring |
| **Application Insights** | ai-id001-s130              | Application performance monitoring |
| **Action Groups**        | RecommendedAlertRules-AG-1 | Alert notifications and automation |

**4. Network Architecture**

**4.1 Subnet Structure**

The virtual network contains multiple isolated subnets for different
tiers:

- **AzureFirewallSubnet** (10.0.1.64/26) - Firewall services

- **AzureBastionSubnet** (10.0.1.0/26) - Secure access service

- **snet-db-id001-s011** (10.0.6.0/24) - Database tier

- **snet-qpui-id001-s007** (10.0.2.0/24) - User interface services

- **snet-api-id001-s009** (10.0.4.0/24) - API services

- **snet-stg-id001-s013** (10.0.8.0/24) - Storage connectivity

**4.2 Connectivity Flow**

![A diagram of a computer process AI-generated content may be
incorrect.](media/image3.png){width="2.9784722222222224in"
height="4.319444444444445in"}

**5. Security Posture**

**5.1 Key Security Features**

- **Network Security:** Default deny posture with explicit allow rules

- **Data Encryption:** All storage encrypted at rest; TLS 1.2 enforced

- **Access Control:** Managed Identities for service authentication

- **Secrets Management:** Key Vault with private endpoints and purge
  protection

- **Monitoring:** Comprehensive logging with Security Center integration

**5.2 Compliance & Protection**

- **Soft Delete & Purge Protection** enabled on Key Vault

- **Private Endpoints** for Storage and Key Vault services

- **Network Security Groups** restricting traffic between tiers

- **Azure Defender** integrations enabled

**6. High Availability & Disaster Recovery**

**6.1 Current Capabilities**

- **Geo-redundant Storage** (GRS) for storage accounts

- **Recovery Services Vault** configured for VM backup

- **Distributed Application Architecture** across multiple subnets

**6.2 Backup Strategy**

- **VM Backups:** Configured via Recovery Services Vault

- **Application Data:** Stored in geo-redundant storage

- **Operational Logs:** 90-day retention in Log Analytics

**7. Cost Management**

**7.1 Resource Tiering**

- **App Services:** Basic B1 tier (development/testing level)

- **Virtual Machine:** Standard_E4s_v3 (production-grade)

- **Storage:** Standard GRS (cost-effective for backups)

**8. Recommendations**

1.  **Scale App Service Plans** to Standard tier for production
    workloads

2.  **Implement Azure Application Gateway** for web application firewall
    capabilities

3.  **Configure Azure Backup** policies for all critical resources

4.  **Establish resource tagging standards** for cost allocation

**9. Conclusion**

The Azure environment for CARTN application represents a
well-architected, secure foundation for production workloads. The
architecture follows cloud best practices with proper network
segmentation, security controls, and monitoring in place.

The environment is currently optimized for development and testing with
room for scaling as user demand increases.

**Document Approval**

**Prepared By:** \_Mohd Shoaib Siddiqui  
**Date:** 25-11-2025

**Approved By:** \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_  
**Date:** \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_
