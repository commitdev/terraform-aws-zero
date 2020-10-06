variable "project" {
  description = "Name of the project"
}

variable "environment" {
  description = "The environment (development/staging/production)"
}

variable "include_global_service_events" {
  description = "Specifies whether the trail is publishing events from global services such as IAM to the log files"
}
