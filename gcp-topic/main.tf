
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_topic
resource "google_pubsub_topic" "example" {
  name = "example-topic"

  labels = {
    foo = "bar"
  }

  message_retention_duration = "86600s"
}


# root level outputs can be pulled by other projects using terraform_remote_state
output topic1_name { value = "example-topic" }
output topic1_labels {
  value = { foo = "bar" }
}
