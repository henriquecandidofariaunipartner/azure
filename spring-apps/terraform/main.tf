provider "azurerm" {
  features {}
  subscription_id = ""
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

##################### Spring Apps for Azure

resource "azurerm_spring_cloud_service" "example" {
  name                = "example-springcloud"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
}

# resource "azurerm_spring_cloud_app" "planet-weather-provider" {
#   name                = "planet-weather-provider"
#   resource_group_name = azurerm_resource_group.example.name
#   service_name        = azurerm_spring_cloud_service.example.name

#   identity {
#     type = "SystemAssigned"
#   }
# }

# resource "azurerm_spring_cloud_build_deployment" "planet-weather-provider" {
#   name                = "planet-weather-provider"
#   spring_cloud_app_id = azurerm_spring_cloud_app.planet-weather-provider.id
#   build_result_id     = "bcdbbc2bf0104a16ab812a818857cbc2"
#   instance_count      = 1
#   quota {
#     cpu    = "1"
#     memory = "1Gi"
#   }
# }

# resource "azurerm_spring_cloud_app" "solar-system-weather" {
#   name                = "solar-system-weather"
#   resource_group_name = azurerm_resource_group.example.name
#   service_name        = azurerm_spring_cloud_service.example.name

#   identity {
#     type = "SystemAssigned"
#   }
# }

# resource "azurerm_spring_cloud_build_deployment" "solar-system-weather" {
#   name                = "solar-system-weather"
#   spring_cloud_app_id = azurerm_spring_cloud_app.solar-system-weather.id
#   build_result_id     = "bcdbbc2bf0104a16ab812a818857cbc2"
#   instance_count      = 1
#   quota {
#     cpu    = "1"
#     memory = "1Gi"
#   }
# }

##################### VM Linux for agent Azure DevOps

resource "azurerm_virtual_network" "example" {
  name                = "example-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "example" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "example" {
  name                = "acceptanceTestPublicIp1"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  allocation_method   = "Static"

  tags = {
    environment = "dev"
  }
}

resource "azurerm_public_ip" "acceptanceTestPublicIp2" {
  name                = "acceptanceTestPublicIp2"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  allocation_method   = "Static"

  tags = {
    environment = "dev"
  }
}

resource "azurerm_network_interface" "example" {
  name                = "example-nic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.example.id
  }
}

resource "azurerm_network_interface" "example-nic-02" {
  name                = "example-nic-02"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.acceptanceTestPublicIp2.id
  }
}

resource "azurerm_network_security_group" "example" { # --> Nao esta associado a interface de rede
  name                = "SSH"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  security_rule {
    name                       = "SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "22"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

    security_rule {
    name                       = "RDP"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "3389"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "dev"
  }
}

resource "azurerm_linux_virtual_machine" "example" {
  name                = "example-machine"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

resource "azurerm_windows_virtual_machine" "example" {
  name                = "machine"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = ""
  network_interface_ids = [
    azurerm_network_interface.example-nic-02.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}

output "public_ip_address-01" {
  value = "${azurerm_public_ip.example.*.ip_address}"
}

output "public_ip_address-02" {
  value = "${azurerm_public_ip.acceptanceTestPublicIp2.*.ip_address}"
}