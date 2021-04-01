workers_group_name = "hydradx-cluster-1-8-16"
workers_asg_desired_capacity = 1
workers_kubernetes_instance_type = "c5.2xlarge"
workers_asg_max_size = 2

cluster_name = "hydradx-cluster"

public_cluster_namespace = "kube-system"
public_k8s_service_account_name      = "hydradx-cluster-autoscaler"
