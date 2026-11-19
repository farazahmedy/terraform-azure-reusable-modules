resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = "1.28"
  tags                = var.tags

  default_node_pool {
    name                = "systempool"
    node_count          = var.node_count
    vm_size             = var.vm_size
    vnet_subnet_id      = var.subnet_id
    enable_auto_scaling = true
    min_count           = 1
    max_count           = 5
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
  }
}
