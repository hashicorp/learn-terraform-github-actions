variable "appId" {
  description = "Azure Kubernetes Service Cluster service principal"
}

variable "password" {
  description = "Azure Kubernetes Service Cluster password"
}

variable "resource_group_name" {
  default = "commerceprowess-rg"
}

variable "resource_group_location" {
  default = "westeurope"
}

variable "aks_cluster_name" {
  default = "commerceprowess"
}

variable "aks_cluster_dnsprefix" {
  default = "commerceprowess-k8s"
}

variable "aks_cluster_default_node_pool_name" {
  default = "default"
}

variable "aks_cluster_default_node_pool_nodecount" {
  default = 2
}

variable "aks_cluster_default_node_pool_vmsize" {
  default = "Standard_D2_v2"
}

variable "aks_cluster_default_node_pool_os_disk_size_gb" {
  default = 30
}


variable "aks_cluster_default_role_based_access_control_enabled" {
  default = true
}

variable "aks_cluster_default_tags_environment" {
  default = "production"
} 

