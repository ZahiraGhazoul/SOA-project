# Configure le fournisseur Azure
provider "azurerm" {
  features {}

  subscription_id = "4ab6c057-6ae5-4858-ab93-1cd721074d1b"
  client_id       = "4ab6c057-6ae5-4858-ab93-1cd721074d1b"
  client_secret   = "0b73d502-5c35-4cd5-bf21-1180384a224b"
  tenant_id       = "c6cc3975-6c26-4f91-ab9f-435835912fe5"

  version = "~> 2.0"
}

# Définit les variables
variable "resource_group_name" {
  type    = string
  default = "my-resource-group"
}

variable "location" {
  type    = string
  default = "westeurope"
}

variable "virtual_network_name" {
  type    = string
  default = "my-virtual-network"
}

variable "subnet_name" {
  type    = string
  default = "my-subnet"
}

variable "vm_name" {
  type    = string
  default = "my-vm"
}

variable "vm_size" {
  type    = string
  default = "Standard_DS2_v2"
}

# Crée le groupe de ressources
resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}

# Crée le réseau virtuel
resource "azurerm_virtual_network" "example" {
  name                = var.virtual_network_name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

# Crée le sous-réseau
resource "azurerm_subnet" "example" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Crée la machine virtuelle
resource "azurerm_virtual_machine" "example" {
  name                  = var.vm_name
  location              = azurerm_resource_group.example.location
  resource_group_name   = azurerm_resource_group.example.name
  network_interface_ids = [azurerm_network_interface.example.id]
  vm_size               = var.vm_size

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = var.vm_name
    admin_username = "adminuser"
    admin_password = "password"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

# Crée l'interface réseau
resource "azurerm_network_interface" "example" {
  name                = "example-nic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "example-ipconfig"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

