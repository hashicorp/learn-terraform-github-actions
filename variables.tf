variable "ARM_CLIENT_ID" {
  default = "xxxxxx"
}

variable "ARM_CLIENT_SECRET" {
  default = "xxxxxx"
}

variable "production_resource_group_name" {
  default = "notejam-prod-rg"
}

variable "production_resource_group_regional_pair_a_location" {
  default = "westeurope"
}

variable "production_resource_group_tags_environment" {
  default = "production"
}

variable "production_aks_cluster_regional_pair_a_name" {
  default = "k8s-prod-westeurope-cluster"
}

variable "production_aks_cluster_regional_pair_a_dnsprefix" {
  default = "k8s-prod-westeurope-cluster"
}

variable "production_aks_cluster_nodepool_regional_pair_a_name" {
  default = "k8s-prod-westeurope-nodepool"
}

variable "production_aks_cluster_nodepool_nodecount" {
  default = 2
}

variable "production_aks_cluster_nodepool_vmsize" {
  default = "Standard_D2_v2"
}

variable "production_aks_cluster_nodepool_os_disk_size_gb" {
  default = 30
}

variable "production_aks_cluster_rbac_enabled" {
  default = true
}

variable "production_resource_group_regional_pair_b_location" {
  default = "northeurope"
}

variable "production_aks_cluster_regional_pair_b_name" {
  default = "k8s-prod-northeurope-cluster"
}

variable "production_aks_cluster_regional_pair_b_dnsprefix" {
  default = "k8s-prod-northeurope-cluster"
}

variable "production_aks_cluster_nodepool_regional_pair_b_name" {
  default = "k8s-prod-northeurope-nodepool"
}

variable "nonproduction_resource_group_name" {
  default = "notejam-nonprod-rg"
}

variable "nonproduction_resource_group_regional_pair_a_location" {
  default = "westeurope"
}

variable "nonproduction_resource_group_tags_environment" {
  default = "nonproduction"
}

variable "nonproduction_aks_cluster_regional_pair_a_name" {
  default = "k8s-nonprod-westeurope-cluster"
}

variable "nonproduction_aks_cluster_regional_pair_a_dnsprefix" {
  default = "k8s-nonprod-westeurope-cluster"
}

variable "nonproduction_aks_cluster_nodepool_regional_pair_a_name" {
  default = "k8s-nonprod-westeurope-nodepool"
}

variable "nonproduction_aks_cluster_nodepool_nodecount" {
  default = 2
}

variable "nonproduction_aks_cluster_nodepool_vmsize" {
  default = "Standard_D2_v2"
}

variable "nonproduction_aks_cluster_nodepool_os_disk_size_gb" {
  default = 30
}

variable "nonproduction_aks_cluste_rbac_enabled" {
  default = true
}

variable "container_registry_name" {
  default = "notejam-prod-acr"
}

variable "resource_group_name" {
  default = "notejam-prod-rg"
}

variable "container_registry_location" {
  default = "westeurope"
}

variable "container_registry_sku" {
  default = "premium"
}

variable "container_registry_adminenabled" {
  default = false
}

variable "container_registry_georeplications_1_zone_redundancy_enabled" {
  default = true
}

variable "container_registry_georeplications_2_zone_redundancy_enabled" {
  default = true
}

variable "container_registry_georeplications_1_location" {
  default = "westeurope"
}

variable "container_registry_georeplications_2_location" {
  default = "northeurope"
}

