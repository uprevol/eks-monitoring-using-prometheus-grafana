data "aws_caller_identity" "current" {}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
}

data "aws_route53_zone" "public_zone" {
  name = "devops4solutions.com" # Replace with your domain name, including the trailing dot
}