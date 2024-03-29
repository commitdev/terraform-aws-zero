module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.70.0"

  name = "${var.project}-${var.environment}-vpc"
  cidr = var.cidr

  azs              = ["${var.region}a", "${var.region}b"] # Most regions have 3+ azs
  private_subnets  = [cidrsubnet(var.cidr, 3, 1), cidrsubnet(var.cidr, 3, 2)]
  public_subnets   = [cidrsubnet(var.cidr, 8, 1), cidrsubnet(var.cidr, 8, 2)]
  database_subnets = [cidrsubnet(var.cidr, 8, 10), cidrsubnet(var.cidr, 8, 11)]

  # Allow kubernetes ALB ingress controller to auto-detect
  private_subnet_tags = {
    "kubernetes.io/cluster/${var.kubernetes_cluster_name}" = "owned"
    "kubernetes.io/role/internal-elb"                      = "1"
    "visibility"                                           = "private"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.kubernetes_cluster_name}" = "owned"
    "kubernetes.io/role/elb"                               = "1"
    "visibility"                                           = "public"
  }

  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = var.single_nat_gateway
  enable_s3_endpoint = true

  enable_vpn_gateway   = false
  enable_dns_hostnames = true

  create_database_subnet_group       = true
  create_database_subnet_route_table = true

  tags = {
    environment = var.environment
  }

  vpc_tags = {
    "kubernetes.io/cluster/${var.kubernetes_cluster_name}" = "shared"
  }
}

module "nat_instance" {
  # create nat instance instead of nat gateway
  count = var.enable_nat_gateway ? 0 : 1

  source  = "int128/nat-instance/aws"
  version = "2.0.0"

  name = "${var.project}-${var.environment}-nat"

  vpc_id                      = module.vpc.vpc_id
  public_subnet               = module.vpc.public_subnets[0]
  private_subnets_cidr_blocks = module.vpc.private_subnets_cidr_blocks
  private_route_table_ids     = module.vpc.private_route_table_ids

  use_spot_instance = false
  instance_types    = var.nat_instance_types
}

resource "aws_eip" "nat_instance" {
  count = var.enable_nat_gateway ? 0 : 1

  network_interface = module.nat_instance[0].eni_id
  tags = {
    "Name" = "${var.project}-${var.environment}-nat-instance"
  }
}
