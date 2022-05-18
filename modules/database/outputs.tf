output "database_endpoint" {
  description = "The internal hostname used to connect to the database"
  value       = (var.database_engine == "postgres") ? module.rds_postgres[0].db_instance_endpoint : module.rds_mysql[0].db_instance_endpoint
}
