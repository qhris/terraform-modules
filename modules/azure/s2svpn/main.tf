/**
  * # Hub
  *
  * This module is used to create a site 2 site vpn connection for the virtual network in the production subscription. .
  * 
  * ## Usage
  *
  * Use together with the `hub` module to create a site 2 site connection with virtual network gateway.
  */

terraform {
  required_version = "0.13.5"

  required_providers {
    azurerm = {
      version = "2.35.0"
      source  = "hashicorp/azurerm"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.0.0"
    }
  }
}

data "azurerm_resource_group" "this" {
  for_each = {
    for env_resource in local.env_resources :
    env_resource.name => env_resource
  }

  name = "rg-${each.value.name}"
}

resource "random_password" "this" {
  length  = 16
  special = true

}

resource "azurerm_public_ip" "this" {
  for_each = {
    for subnet in local.gateways :
    subnet.subnet_name => subnet
  }

  name                = "pip-${each.value.vnet_resource}-site2site"
  location            = data.azurerm_resource_group.this[each.value.vnet_resource].location
  resource_group_name = data.azurerm_resource_group.this[each.value.vnet_resource].name
  allocation_method   = "Dynamic"
}

resource "azurerm_subnet" "this" {
  for_each = {
    for subnet in local.gateways :
    subnet.subnet_name => subnet
  }
  
  name                 = each.value.subnet_name
  resource_group_name  = data.azurerm_resource_group.this[each.value.vnet_resource].name
  virtual_network_name = var.vnet_name
  address_prefixes     = [each.value.subnet_cidr]
}

resource "azurerm_virtual_network_gateway" "this" {
  for_each = {
    for subnet in local.gateways :
    subnet.subnet_name => subnet
  }

  name                = "gw-${each.value.vnet_resource}-site2site"
  location            = data.azurerm_resource_group.this[each.value.vnet_resource].location
  resource_group_name = data.azurerm_resource_group.this[each.value.vnet_resource].name
  

  type     = "Vpn"
  vpn_type = var.vpn_type

  active_active = false
  enable_bgp    = false
  sku           = "VpnGw1"
  
  ip_configuration {
    public_ip_address_id          = azurerm_public_ip.this[each.key].id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.this[each.key].id
  }
}

resource "azurerm_local_network_gateway" "this" {
  for_each = {
    for subnet in local.gateways :
    subnet.subnet_name => subnet
  }

  name                = "lgw-${each.value.vnet_resource}-site2site"
  resource_group_name = data.azurerm_resource_group.this[each.value.vnet_resource].name
  location            = data.azurerm_resource_group.this[each.value.vnet_resource].location
  gateway_address     = var.local_gateway_address
  address_space       = var.local_gateway_address_space
}


resource "azurerm_virtual_network_gateway_connection" "this" {
  for_each = {
    for subnet in local.gateways :
    subnet.subnet_name => subnet
  }

  name                = "gwc-${each.value.vnet_resource}"
  resource_group_name = data.azurerm_resource_group.this[each.value.vnet_resource].name
  location            = data.azurerm_resource_group.this[each.value.vnet_resource].location

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.this[each.key].id
  local_network_gateway_id   = azurerm_local_network_gateway.this[each.key].id

  shared_key = var.shared_secret != "" ? var.shared_secret : random_password.this.result # If shared_secret is empty string, then use random_password, else use variable
}