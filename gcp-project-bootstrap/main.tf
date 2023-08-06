
# import GCP Project
# terraform state rm -state=../terraform.tfstate google_project.project
# terraform import -var-file=../all.tfvars -state=../terraform.tfstate google_project.project <projectId>

# import GCS bucket
# terraform import -var-file=../all.tfvars -state=../terraform.tfstate google_storage_bucket.tfstate <projectId>/tfstate-<projectId>

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/billing_account
data "google_billing_account" "acct" {
  display_name = "My Billing Account"
  open         = true
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project
resource "google_project" "project" {
  name       = var.project
  project_id = var.project

  # if set to false, will delete 'default'
  # this leaves networking in current state
  auto_create_network = true

  billing_account = data.google_billing_account.acct.id
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_service
resource "google_project_service" "services" {
  depends_on = [ google_project.project ]
  for_each = toset(var.project_services_list)

  project = var.project
  service = each.value

  disable_dependent_services = true
}

resource "time_sleep" "wait_for_service_apis" {
  depends_on = [ google_project_service.services ]
  create_duration = "00s"
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket
resource "google_storage_bucket" "tfstate" {
  depends_on = [ time_sleep.wait_for_service_apis ]
  name          = "tfstate-${var.project}"
  project       = var.project
  location      = "US"
  storage_class = "STANDARD"
  uniform_bucket_level_access = true
  force_destroy = true
}

# writes bucket name to file, for use by other terraform scripts with dynamic backend
resource "local_file" "thefile" {
  filename = "../dynamic-backend.hcl"
  content = <<EOF
bucket = "${google_storage_bucket.tfstate.name}"
EOF
}

