terraform {
  required_version = ">= 1.1.0"

  cloud {
    organization = "commerceprowess"
    workspaces {
      name = "notejam-infrastructure"
    }
  }
}


provider "azurerm" {
  features {}
}

module "notejam-infra-production-regional_pair_a" {
  source                               = "./modules/azure-k8s-cluster"
  resource_group_name                  = var.production_resource_group_name
  resource_group_location              = var.production_resource_group_regional_pair_a_location
  resource_group_tags_environment      = var.production_resource_group_tags_environment
  aks_cluster_name                     = var.production_aks_cluster_regional_pair_a_name
  aks_cluster_dnsprefix                = var.production_aks_cluster_regional_pair_a_dnsprefix
  aks_cluster_nodepool_name            = var.production_aks_cluster_nodepool_regional_pair_a_name
  aks_cluster_nodepool_nodecount       = var.production_aks_cluster_nodepool_nodecount
  aks_cluster_nodepool_vmsize          = var.production_aks_cluster_nodepool_vmsize
  aks_cluster_nodepool_os_disk_size_gb = var.production_aks_cluster_nodepool_os_disk_size_gb
  aks_cluste_rbac_enabled              = var.production_aks_cluste_rbac_enabled
  ARM_CLIENT_ID                        = var.ARM_CLIENT_ID
  ARM_CLIENT_SECRET                    = var.ARM_CLIENT_SECRET
}

module "notejam-infra-production-regional_pair_b" {
  source                               = "./modules/azure-k8s-cluster"
  resource_group_name                  = var.production_resource_group_name
  resource_group_location              = var.production_resource_group_regional_pair_b_location
  resource_group_tags_environment      = var.production_resource_group_tags_environment
  aks_cluster_name                     = var.production_aks_cluster_regional_pair_b_name
  aks_cluster_dnsprefix                = var.production_aks_cluster_regional_pair_b_dnsprefix
  aks_cluster_nodepool_name            = var.production_aks_cluster_nodepool_regional_pair_b_name
  aks_cluster_nodepool_nodecount       = var.production_aks_cluster_nodepool_nodecount
  aks_cluster_nodepool_vmsize          = var.production_aks_cluster_nodepool_vmsize
  aks_cluster_nodepool_os_disk_size_gb = var.production_aks_cluster_nodepool_os_disk_size_gb
  aks_cluste_rbac_enabled              = var.production_aks_cluste_rbac_enabled
  ARM_CLIENT_ID                        = var.ARM_CLIENT_ID
  ARM_CLIENT_SECRET                    = var.ARM_CLIENT_SECRET

}

module "notejam-infra-non_production-regional_pair_a" {
  source                               = "./modules/azure-k8s-cluster"
  resource_group_name                  = var.nonproduction_resource_group_name
  resource_group_location              = var.nonproduction_resource_group_regional_pair_a_location
  resource_group_tags_environment      = var.nonproduction_resource_group_tags_environment
  aks_cluster_name                     = var.nonproduction_aks_cluster_regional_pair_a_name
  aks_cluster_dnsprefix                = var.nonproduction_aks_cluster_regional_pair_a_dnsprefix
  aks_cluster_nodepool_name            = var.nonproduction_aks_cluster_nodepool_regional_pair_a_name
  aks_cluster_nodepool_nodecount       = var.nonproduction_aks_cluster_nodepool_nodecount
  aks_cluster_nodepool_vmsize          = var.nonproduction_aks_cluster_nodepool_vmsize
  aks_cluster_nodepool_os_disk_size_gb = var.nonproduction_aks_cluster_nodepool_os_disk_size_gb
  aks_cluste_rbac_enabled              = var.nonproduction_aks_cluste_rbac_enabled
  ARM_CLIENT_ID                        = var.ARM_CLIENT_ID
  ARM_CLIENT_SECRET                    = var.ARM_CLIENT_SECRET
}


module "notejam-acr-georeplicated" {
  source                                                       = "./modules/azure-container-registry"
  container_registry_name                                      = var.container_registry_name
  resource_group_name                                          = var.resource_group_name
  container_registry_location                                  = var.container_registry_location
  container_registry_sku                                       = var.container_registry_sku
  container_registry_adminenabled                              = var.container_registry_adminenabled
  container_registry_georeplications_1_location                = var.nonproduction_resource_group_regional_pair_a_location
  container_registry_georeplications_1_zone_redundancy_enabled = var.container_registry_georeplications_1_zone_redundancy_enabled
  container_registry_georeplications_2_location                = var.nonproduction_resource_group_regional_pair_b_location
  container_registry_georeplications_2_zone_redundancy_enabled = var.container_registry_georeplications_2_zone_redundancy_enabled

}


