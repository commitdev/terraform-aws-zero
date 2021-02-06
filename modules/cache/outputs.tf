output "id" {
  value       = var.cache_store == "memcached" ? module.memcached[0].cluster_id : var.cache_store == "redis" ? module.redis[0].id : "none"
  description = "Cache store ID"
}

output "endpoint" {
  value       = var.cache_store == "memcached" ? module.memcached[0].cluster_address : var.cache_store == "redis" ? module.redis[0].endpoint : "none"
  description = "Cache store address"
}

output "port" {
  value       = var.cache_store == "memcached" ? "11211" : var.cache_store == "redis" ? module.redis[0].port : "0"
  description = "Cache store port"
}

output "hostname" {
  value       = var.cache_store == "memcached" ? module.memcached[0].hostname : var.cache_store == "redis" ? module.redis[0].host : "none"
  description = "Cache store hostname"
}
