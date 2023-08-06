#terraform apply -var-file=../all.tfvars -auto-approve
terraform apply -auto-approve

gcloud pubsub topics list --format='value(name,labels)'
