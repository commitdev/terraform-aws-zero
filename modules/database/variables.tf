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
