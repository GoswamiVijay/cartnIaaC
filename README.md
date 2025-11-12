# cartnIaaC - Azure ARM Templates Repository

This repository serves as a centralized source for Azure Resource Manager (ARM) templates, enabling Infrastructure as Code (IaaC) for Azure resource deployments.

## 📁 Repository Structure

```
cartnIaaC/
├── templates/
│   ├── storage/              # Storage account templates
│   │   └── storage-account.json
│   ├── networking/           # Virtual network templates
│   │   └── virtual-network.json
│   ├── compute/             # Virtual machine templates
│   │   └── virtual-machine.json
│   └── parameters/          # Parameter files for templates
│       ├── storage-account.parameters.json
│       ├── virtual-network.parameters.json
│       └── virtual-machine.parameters.json
├── deploy.sh                # Deployment script for Azure CLI
├── .gitignore              # Git ignore file
└── README.md               # This file
```

## 🚀 Getting Started

### Prerequisites

- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) installed
- An active Azure subscription
- Appropriate permissions to create resources in Azure

### Authentication

Before deploying templates, authenticate to Azure:

```bash
az login
```

Set your subscription (if you have multiple subscriptions):

```bash
az account set --subscription "<subscription-id>"
```

## 📝 Available Templates

### Storage Account Template

Located at: `templates/storage/storage-account.json`

Creates an Azure Storage Account with the following features:
- Configurable SKU (Standard_LRS, Standard_GRS, etc.)
- HTTPS-only traffic enforcement
- Minimum TLS version 1.2
- Configurable tags

**Parameters:**
- `storageAccountName`: Unique storage account name (3-24 characters)
- `location`: Azure region (defaults to resource group location)
- `storageAccountSku`: Storage SKU type
- `storageAccountKind`: Storage account kind (StorageV2 recommended)
- `tags`: Resource tags

### Virtual Network Template

Located at: `templates/networking/virtual-network.json`

Creates an Azure Virtual Network with a subnet:
- Configurable address space
- Default subnet configuration
- Configurable tags

**Parameters:**
- `vnetName`: Virtual network name
- `location`: Azure region (defaults to resource group location)
- `vnetAddressPrefix`: Virtual network address prefix (e.g., 10.0.0.0/16)
- `subnetName`: Subnet name
- `subnetAddressPrefix`: Subnet address prefix (e.g., 10.0.1.0/24)
- `tags`: Resource tags

### Virtual Machine Template

Located at: `templates/compute/virtual-machine.json`

Creates an Azure Virtual Machine with network interface:
- Support for both Linux and Windows operating systems
- Configurable VM size
- Premium managed disk for OS
- Dynamic private IP allocation

**Parameters:**
- `vmName`: Virtual machine name
- `location`: Azure region (defaults to resource group location)
- `vmSize`: VM size (e.g., Standard_B2s)
- `adminUsername`: Administrator username
- `adminPassword`: Administrator password (secure string)
- `osType`: Operating system type (Linux or Windows)
- `subnetId`: Resource ID of the subnet
- `tags`: Resource tags

## 🔧 Deployment Methods

### Method 1: Using the Deployment Script

The repository includes a convenient deployment script (`deploy.sh`) for easy deployments:

```bash
./deploy.sh \
  --template templates/storage/storage-account.json \
  --parameters templates/parameters/storage-account.parameters.json \
  --resource-group myResourceGroup \
  --name myDeployment
```

**Script Options:**
- `-t, --template`: Path to ARM template file (required)
- `-p, --parameters`: Path to parameters file (required)
- `-g, --resource-group`: Resource group name (required)
- `-n, --name`: Deployment name (optional, auto-generated if not provided)
- `-h, --help`: Show help message

### Method 2: Using Azure CLI Directly

#### Create a Resource Group (if needed)

```bash
az group create --name myResourceGroup --location eastus
```

#### Validate the Template

```bash
az deployment group validate \
  --resource-group myResourceGroup \
  --template-file templates/storage/storage-account.json \
  --parameters @templates/parameters/storage-account.parameters.json
```

#### Deploy the Template

```bash
az deployment group create \
  --resource-group myResourceGroup \
  --name myDeployment \
  --template-file templates/storage/storage-account.json \
  --parameters @templates/parameters/storage-account.parameters.json
```

### Method 3: Using Azure Portal

1. Navigate to the Azure Portal
2. Search for "Deploy a custom template"
3. Select "Build your own template in the editor"
4. Copy and paste the template JSON
5. Click "Save"
6. Fill in the required parameters
7. Click "Review + create" and then "Create"

## 📋 Parameter Files

Parameter files are stored in `templates/parameters/` directory. These files contain values for template parameters.

### Creating Custom Parameter Files

1. Copy an existing parameter file:
   ```bash
   cp templates/parameters/storage-account.parameters.json templates/parameters/storage-account.dev.parameters.json
   ```

2. Edit the file with your custom values

3. Deploy using your custom parameter file:
   ```bash
   ./deploy.sh \
     --template templates/storage/storage-account.json \
     --parameters templates/parameters/storage-account.dev.parameters.json \
     --resource-group myResourceGroup
   ```

**Note:** Files matching `*.local.parameters.json` are ignored by git to prevent committing sensitive data.

## 🔒 Security Best Practices

1. **Never commit sensitive data** (passwords, connection strings, keys) to the repository
2. Use **Azure Key Vault** for storing secrets and reference them in templates
3. Use **managed identities** where possible instead of service principals
4. Keep templates **minimal and focused** on single resource types
5. Always use **HTTPS** and enforce **minimum TLS versions**
6. Review and apply **Azure Security Center** recommendations

## 🤝 Contributing

When adding new templates to this repository:

1. Follow the existing directory structure
2. Create templates in the appropriate category folder
3. Include comprehensive parameter descriptions
4. Add example parameter files
5. Document the template in this README
6. Test templates before committing
7. Use meaningful commit messages

## 📚 Additional Resources

- [Azure Resource Manager Documentation](https://docs.microsoft.com/en-us/azure/azure-resource-manager/)
- [ARM Template Reference](https://docs.microsoft.com/en-us/azure/templates/)
- [ARM Template Best Practices](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/best-practices)
- [Azure CLI Documentation](https://docs.microsoft.com/en-us/cli/azure/)

## 📄 License

This repository is maintained for internal use. Please ensure compliance with your organization's policies when using these templates.

## 🐛 Issues and Feedback

For issues, questions, or feedback, please open an issue in this repository.
