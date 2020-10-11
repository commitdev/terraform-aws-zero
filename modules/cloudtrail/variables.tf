variable "project" {
  description = "Name of the project"
}

variable "trail_name" {
  description = "Name of the trail"
}

variable "include_global_service_events" {
  description = "Specifies whether the trail is publishing events from global services such as IAM to the log files"
}
