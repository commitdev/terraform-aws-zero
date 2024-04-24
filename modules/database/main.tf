locals {
  subnet_group_name = (var.replicate_from_db_id == null) ? (
    var.db_subnet_group != "" ? var.db_subnet_group : "${var.project}-${var.environment}-vpc"
  ) : null
}

module "rds_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.9.0"

  name        = "${var.project}-${var.additional_identifier}${var.environment}-rds-sg"
  description = "Security group for RDS DB"
  vpc_id      = var.vpc_id

  number_of_computed_ingress_with_source_security_group_id = 1
  computed_ingress_with_source_security_group_id = [
    var.database_engine == "postgres" ? {
      from_port                = 5432
      to_port                  = 5432
      protocol                 = "tcp"
      description              = "PostgreSQL from EKS"
      source_security_group_id = var.allowed_security_group_id
      } : {
      from_port                = 3306
      to_port                  = 3306
      protocol                 = "tcp"
      description              = "MYSQL from EKS"
      source_security_group_id = var.allowed_security_group_id
    }
  ]

  egress_rules = ["all-all"]

  tags = {
    Env = var.environment
  }
}

data "aws_caller_identity" "current" {
}

# secret declared so secret version waits for rds-secret to be ready
# or else we often see a AWSDEFAULT VERSION secret not found error
data "aws_secretsmanager_secret" "rds_master_secret" {
  name = "${var.project}-${var.environment}-rds-${var.password_secret_suffix}"
}

# RDS does not support secret-manager, have to provide the actual string
data "aws_secretsmanager_secret_version" "rds_master_secret" {
  secret_id = data.aws_secretsmanager_secret.rds_master_secret.name
}

module "rds_postgres" {
  count   = var.database_engine == "postgres" ? 1 : 0
  source  = "terraform-aws-modules/rds/aws"
  version = "4.3.0"

  identifier = "${var.project}-${var.additional_identifier}${var.environment}"

  engine            = "postgres"
  engine_version    = var.database_engine_version
  instance_class    = var.instance_class
  allocated_storage = var.storage_gb
  storage_encrypted = true

  db_name                = (var.replicate_from_db_id == null) ? replace(var.project, "-", "") : null
  username               = "master_user"
  password               = (var.replicate_from_db_id == null) ? data.aws_secretsmanager_secret_version.rds_master_secret.secret_string : null
  create_random_password = false

  port = "5432"

  vpc_security_group_ids = [module.rds_security_group.security_group_id]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  # disable backups to create DB faster in non-production environments
  # note that read replicas can only replicate from databases with a backup period specified
  backup_retention_period = (var.environment == "prod" && var.replicate_from_db_id == null) ? 30 : 0

  # Subnet is created by the vpc module
  create_db_subnet_group = false
  db_subnet_group_name   = local.subnet_group_name

  # DB parameter and option group
  family               = var.parameter_group_family
  major_engine_version = var.parameter_group_engine_version

  parameters = var.parameters

  final_snapshot_identifier_prefix = "final-snapshot"
  skip_final_snapshot              = (var.replicate_from_db_id != null)
  deletion_protection              = true
  multi_az                         = var.multi_az

  # Enhanced monitoring
  performance_insights_enabled = (var.replicate_from_db_id == null)
  create_monitoring_role       = true
  monitoring_role_name         = "${var.project}-${var.additional_identifier}${var.environment}-rds-postgres-monitoring-role"
  monitoring_interval          = "30"

  # Read replica
  replicate_source_db = var.replicate_from_db_id

  tags = {
    Name = "${var.project}-${var.additional_identifier}${var.environment}-rds-postgres"
    Env  = var.environment
  }
  depends_on = [module.rds_security_group]
}

module "rds_mysql" {
  count   = var.database_engine == "mysql" ? 1 : 0
  source  = "terraform-aws-modules/rds/aws"
  version = "4.3.0"

  identifier = "${var.project}-${var.additional_identifier}${var.environment}"

  engine            = "mysql"
  engine_version    = var.database_engine_version
  instance_class    = var.instance_class
  allocated_storage = var.storage_gb
  storage_encrypted = true

  db_name                = (var.replicate_from_db_id == null) ? replace(var.project, "-", "") : null
  username               = "master_user"
  password               = (var.replicate_from_db_id == null) ? data.aws_secretsmanager_secret_version.rds_master_secret.secret_string : null
  create_random_password = false

  port = "3306"

  vpc_security_group_ids = [module.rds_security_group.security_group_id]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  # disable backups to create DB faster in non-production environments
  # note that read replicas can only replicate from databases with a backup period specified
  backup_retention_period = (var.environment == "prod" && var.replicate_from_db_id == null) ? 30 : 0

  # Subnet is created by the vpc module
  create_db_subnet_group = false
  db_subnet_group_name   = local.subnet_group_name

  # DB parameter and option group
  family               = var.parameter_group_family
  major_engine_version = var.parameter_group_engine_version

  parameters = var.parameters

  final_snapshot_identifier_prefix = "final-snapshot"
  skip_final_snapshot              = (var.replicate_from_db_id != null)
  deletion_protection              = true
  multi_az                         = var.multi_az

  # Enhanced monitoring
  # Seems like mysql doesnt have performance insight on this instance size
  # Amazon RDS for MySQL
  # 8.0.17 and higher 8.0 versions, version 5.7.22 and higher 5.7 versions,
  # and version 5.6.41 and higher 5.6 versions. Not supported for version 5.5.
  # Not supported on the following DB instance classes:
  # db.t2.micro, db.t2.small, db.t3.micro, db.t3.small,
  # all db.m6g instance classes, and all db.r6g instance classes.
  performance_insights_enabled = false
  create_monitoring_role       = true
  monitoring_role_name         = "${var.project}-${var.additional_identifier}${var.environment}-rds-mysql-monitoring-role"
  monitoring_interval          = "30"

  # Read replica
  replicate_source_db = var.replicate_from_db_id

  tags = {
    Name = "${var.project}-${var.additional_identifier}${var.environment}-rds-mysql"
    Env  = var.environment
  }
  depends_on = [module.rds_security_group]
}
