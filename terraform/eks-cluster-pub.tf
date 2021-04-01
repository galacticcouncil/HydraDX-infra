provider "kubernetes" {
  host                   = data.aws_eks_cluster.public_cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.public_cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.public_cluster.token
  load_config_file       = false
  alias                  = "hydradx_eks"
}

module "eks_hydradx" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "14.0.0"
  write_kubeconfig  = false
  cluster_name    = var.cluster_name

  cluster_version = var.cluster_version
  subnets         = module.vpc.private_subnets

  providers = {
    kubernetes = kubernetes.hydradx_eks
  }
  tags = {
    Environment = var.environment
    Type = "workload"
    Terraform = "true"
  }

  vpc_id = module.vpc.vpc_id

  worker_groups_launch_template = [
    {
      name                          = var.workers_group_name
      asg_desired_capacity          = var.workers_asg_desired_capacity
      instance_type                 = var.workers_kubernetes_instance_type
      key_name                      = var.ssh_key_name
      asg_max_size                  = var.workers_asg_max_size
      asg_min_size                  = var.workers_asg_desired_capacity
    }
  ]
  workers_group_defaults = {
    root_volume_type = "gp2"
  }

  map_users = [
    //Users who will have access to the Kubernetes Hydra cluster.
  ]
}

data "aws_eks_cluster" "public_cluster" {
  name = module.eks_hydradx.cluster_id
}

data "aws_eks_cluster_auth" "public_cluster" {
  name = module.eks_hydradx.cluster_id
}

