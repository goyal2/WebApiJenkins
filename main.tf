//Configuration the azure Provider
provider "azurerm" {

  features { 
  }
  client_id = var.client.id
  client_secret = var.client_secret
  teanent_id = var.tenant_id
  subscritption_id = var.subscription_id
}

//Create a resource group with a new name
resource "azurerm_resource_group" "rg" {
  name = var.resource_group_name
  location = var.location
}

resource "azurerm_app_service_plan" "plan" {
  name = var.app_service_plan_name
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
 
  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "app" {
  name = var.app_service_name
  location =  azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.plan.id

  site_config {
    dotnet_framework_version =  "v6.0"
  }
  app_settings = {
    WEBSITE_RUN_FRON_PACKAGE = "1"
  }
} 
