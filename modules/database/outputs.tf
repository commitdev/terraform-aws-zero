output "database_endpoint" {
  description = "The internal hostname used to connect to the database"
  value       = (var.database_engine == "postgres") ? module.rds_postgres[0].db_instance_endpoint : module.rds_mysql[0].db_instance_endpoint
}

output "database_id" {
  description = "The instance id of the database"
  value       = (var.database_engine == "postgres") ? module.rds_postgres[0].db_instance_id : module.rds_mysql[0].db_instance_id
}

output "database_security_group_id" {
  description = "The id of the created security group"
  value       = module.rds_security_group.security_group_id
}
