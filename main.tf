provider "azurerm" {
  subscription_id = var.azure_subscription_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_group_name}"
  location = "${var.region}"
}

resource "azurerm_sql_database" "db" {
  name                             = "${var.db_name}"
  resource_group_name              = "${azurerm_resource_group.rg.name}"
  location                         = "${var.region}"
  edition                          = "${var.db_edition}"
  collation                        = "${var.collation}"
  server_name                      = "${azurerm_sql_server.server.name}"
  create_mode                      = "Default"
  requested_service_objective_name = "${var.service_objective_name}"
  tags                             = "${var.tags}"
}

resource "azurerm_sql_server" "server" {
  name                         = "${var.db_name}-sqlsvr"
  resource_group_name          = "${azurerm_resource_group.rg.name}"
  location                     = "${var.region}"
  version                      = "${var.server_version}"
  administrator_login          = "${var.sql_admin_username}"
  administrator_login_password = "${var.sql_password}"
  tags                         = "${var.tags}"
}

resource "azurerm_sql_firewall_rule" "fw" {
  name                = "${var.db_name}-fwrules"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  server_name         = "${azurerm_sql_server.server.name}"
  start_ip_address    = "${var.start_ip_address}"
  end_ip_address      = "${var.end_ip_address}"
}


resource "azurerm_sql_database" "db1" {
  name                             = "${var.db1_name}"
  resource_group_name              = "${azurerm_resource_group.rg.name}"
  location                         = "${var.region}"
  edition                          = "${var.db_edition}"
  collation                        = "${var.collation}"
  server_name                      = "${azurerm_sql_server.server1.name}"
  create_mode                      = "Default"
  requested_service_objective_name = "${var.service_objective_name}"
  tags                             = "${var.tags}"
}
resource "azurerm_sql_server" "server1" {
  name                         = "${var.db1_name}-sqlsvr1"
  resource_group_name          = "${azurerm_resource_group.rg.name}"
  location                     = "${var.region}"
  version                      = "${var.server_version}"
  administrator_login          = "${var.sql_admin_username}"
  administrator_login_password = "${var.sql_password}"
  tags                         = "${var.tags}"
}

resource "azurerm_sql_firewall_rule" "fw1" {
  name                = "${var.db_name}-fwrules1"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  server_name         = "${azurerm_sql_server.server1.name}"
  start_ip_address    = "${var.start_ip_address}"
  end_ip_address      = "${var.end_ip_address}"
}

