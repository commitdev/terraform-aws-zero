variable "project" {
  description = "The name of the project, mostly for tagging"
}

variable "environment" {
  description = "The environment (stage/prod)"
}

variable "vpc_id" {
  description = "The id of the VPC to create the DB in"
}


variable "password_secret_suffix" {
  description = "Suffix to add to the secret that will be generated containing the database credentials"
}

variable "allowed_security_group_id" {
  description = "The security group to allow access"
}

variable "db_subnet_group" {
  description = "The subnet group to create dbs in. The default is to use the one created by the vpc module"
  default     = ""
}

variable "instance_class" {
  description = "The AWS instance class of the db"
}

variable "storage_gb" {
  description = "The amount of storage to allocate for the db, in GB"
}

variable "database_engine" {
  description = "Which database engine to use, currently supports `postgres` or `mysql`"
}

variable "database_engine_version" {
  description = "Which database version to use. See the aws cli describe-db-engine-versions command for a list of valid versions"
}

variable "parameter_group_family" {
  description = "Which parameter group family to use. See the aws cli describe-db-engine-versions command for a list of valid versions"
}

variable "parameter_group_engine_version" {
  description = "Which parameter group engine version to use. See the aws cli describe-db-engine-versions command for a list of valid versions"
}

variable "parameters" {
  description = "A list of DB parameters to set in a parameter group, passed directly to the underlying module"
  type        = list(map(string))
  default     = []
}

variable "replicate_from_db_id" {
  description = "Set this to the ID of a database to replicate from. If set, the database will be created as a read replica of the specified database"
  default     = null
}

variable "additional_identifier" {
  description = "An additional string to add to the rds identifier. The final string will look like: <project>-<additional_identifier><environment>"
  default     = ""
}

variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  default     = false
}
