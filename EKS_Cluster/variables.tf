variable "aws_region" {
  type = string
  default = "us-east-1"
  description = "AWS region to deploy resources"
}

variable "environment_name" {
  type = string
  description = "Environment used in resource names and tags"
  default = "dev"
}

variable "business_division" {
  type = string
  description = "Business Division in large organization this infra belongs to"
  default = "retail"
}

#----------------------------------------------------
#  EKS Cluster Configuration
#----------------------------------------------------

variable "cluster_name" {
  description = "Name of EKS cluster, also used as prefix in names of related resources"
  type = string
  default = "eksdemo"
}
variable "cluster_version" {
  description = "kubernetes minor version to use for EKS cluster control plane"
  type = string
  default = null
}

variable "cluster_service_ipv4_cidr" {
  description = "cidr for service networking in kubernetes(leave null to use AWS default)"  
  type = string
  default = null
}

variable "cluster_endpoint_private_access" {
  description = "whether to enable private access EKS control plane endpoint"
  type = bool
  default = false
}

variable "cluster_endpoint_public_access" {
  description = "Whether to enable public access EKS controlplane endpoint"
  type = bool
  default = true
}

variable "cluster_endpoint_public_access_cidr" {
  description = "List of CIDRs allowed to access public EKS endpoint "
  type = list(string)
  default = ["0.0.0.0/0"]
}

variable "tags" {
  description = "tags to apply on eks and related resources"
  type = map(string)
  default = {
    Terraform = "true"
  }
}

#------------------------------------------
#   EKS Node Group Configuration
#------------------------------------------

variable "node_instance_type" {
  description = "List of EC2 instance type for the node group"
  type = list(string)
  default = ["t2.medium"]
}

variable "node_capacity_type" {
  description = "Instance Capacity Type ON_DEMAND OR SPOT"
  type = string
  default = "ON_DEMAND"
}

variable "node_disk_size" {
  description = "Disk size in GiB for worker node"
  type = number
  default = 20
}