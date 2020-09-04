output "elasticsearch_endpoint" {
  description = "The internal hostname used to connect to Elasticsearch"
  value       = module.elasticsearch.domain_endpoint
}

output "kibana_endpoint" {
  description = "The URL used to connect to kibana (not including the https scheme)"
  value       = module.elasticsearch.kibana_endpoint
}
