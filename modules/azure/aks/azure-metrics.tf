/**
  There are a number of metrics that Azure provides through an API.
  We use a deployment inside kubernetes to gather it together with prometheus.
  This terraform file gives access to those metrics to a specific managed identity.
  */

resource "azurerm_user_assigned_identity" "azure_metrics" {
  resource_group_name = data.azurerm_resource_group.this.name
  location            = data.azurerm_resource_group.this.location
  name                = "uai-${var.environment}-${var.location_short}-${var.name}-azure-metrics"
}

resource "azurerm_role_assignment" "azure_metrics" {
  scope                = azurerm_user_assigned_identity.azure_metrics.id
  role_definition_name = "Managed Identity Operator"
  principal_id         = var.aks_managed_identity_group_id
}

resource "azurerm_role_assignment" "azure_metrics_aks_reader" {
  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourcegroups/${data.azurerm_resource_group.this.name}/providers/Microsoft.ContainerService/managedClusters/aks-${var.environment}-${var.location_short}-${var.name}${var.aks_name_suffix}"
  role_definition_name = "Monitoring Reader"
  principal_id         = azurerm_user_assigned_identity.azure_metrics.principal_id
}

resource "azurerm_role_assignment" "azure_metrics_lb_reader" {
  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/mc_${data.azurerm_resource_group.this.name}_aks-${var.environment}-${var.location_short}-${var.name}${var.aks_name_suffix}_${data.azurerm_resource_group.this.location}/providers/Microsoft.Network/loadBalancers/kubernetes"
  role_definition_name = "Monitoring Reader"
  principal_id         = azurerm_user_assigned_identity.azure_metrics.principal_id
}
