
variable project {}
variable region { 
  type=string
  default="us-east1"
}
variable zone_suffix { default="b" }

# storage-component for cloud storage
variable project_services_list {
  type = list(string)
  default = [
   "compute.googleapis.com",
   "iamcredentials.googleapis.com",
   "storage-component.googleapis.com",
   "monitoring.googleapis.com",
   "logging.googleapis.com",
   "cloudresourcemanager.googleapis.com",
   "logging.googleapis.com",
   "stackdriver.googleapis.com"
  ]
}


