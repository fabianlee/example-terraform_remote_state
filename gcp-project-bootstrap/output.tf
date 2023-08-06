# root level outputs can be pulled by other projects using terraform_remote_state

output "mybilling" {
  value = data.google_billing_account.acct.id
}
output "region" {
  value = var.region
}
output "projname" {
  value = google_project.project.name
}
output "projid" {
  value = google_project.project.project_id
}
output "projnumber" {
  value = google_project.project.number
}
output "bucketname" {
  value = google_storage_bucket.tfstate.name
}
