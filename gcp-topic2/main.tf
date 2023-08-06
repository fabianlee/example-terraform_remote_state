
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_topic
resource "google_pubsub_topic" "example" {

  # same name, but suffixed with '-2'
  name = "${data.terraform_remote_state.topic1.outputs.topic1_name}-2"

  # same labels, but add 'another'
  labels = merge(data.terraform_remote_state.topic1.outputs.topic1_labels,{"another"="value"})

  message_retention_duration = "86600s"
}

# root level outputs can be pulled by other projects using terraform_remote_state
output "topic1_name" {
  value = data.terraform_remote_state.topic1.outputs.topic1_name
}
output "topic2_name" {
  value = resource.google_pubsub_topic.example.name
}
