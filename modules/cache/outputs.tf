output "id" {
  value       = var.cache_store == "memcached" ? module.memcached[0].cluster_id : module.redis[0].id
  description = "Cache store ID"
}

output "endpoint" {
  value       = var.cache_store == "memcached" ? module.memcached[0].cluster_address : module.redis[0].endpoint
  description = "Cache store address"
}

output "port" {
  value       = var.cache_store == "memcached" ? "11211" : module.redis[0].port
  description = "Cache store port"
}

output "hostname" {
  value       = var.cache_store == "memcached" ? module.memcached[0].hostname : module.redis[0].host
  description = "Cache store hostname"
}
