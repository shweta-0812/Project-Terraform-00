locals {
  tags = {
    created-by = "eks-setup"
    env        = var.cluster_name
  }
}
