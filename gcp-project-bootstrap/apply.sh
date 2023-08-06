
# could explicitly specify project variable
#terraform apply -state=../bootstrap.tfstate -var="project=$TF_VAR_project"

# instead allowing specially prefixed env var 'TF_VAR_project' to populate 'project' variable
# https://developer.hashicorp.com/terraform/cli/config/environment-variables#tf_var_name
terraform apply -state=../bootstrap.tfstate -auto-approve
