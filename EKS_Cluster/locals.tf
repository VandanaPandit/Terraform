locals {
  name = "${var.business_division}-${var.environment_name}"
  eks_cluster_name = "${local.name}-${var.cluster_name}"
}