# Example usage for terraform remote state

blog: https://fabianlee.org/2023/08/06/terraform-remote_state-to-pass-values-to-other-configurations/

## Quick Setup

```
# get project code
git clone https://github.com/fabianlee/example-terraform_remote_state.git
cd example-terraform_remote_state

# gcloud login for terraform
gcloud auth application-default login

# sets env var 'TF_VAR_project' with new random GCP project id
source ./sourceMakeRandomProjectId.sh

# creates basic project, saves to local bootstrap.tfstate
cd gcp-project-bootstrap
./init.sh
# shows output: bucketname, mybilling, projid, projname, projnumber, region
./apply.sh
cd ..

# gcloud login for terraform, set to explicit project id
gcloud auth application-default login --project $TF_VAR_project

# creates 'example-topic', saves to remote GCS
cd gcp-topic
./init.sh
# shows output: topic1_labels, topic1_name
./apply.sh
cd ..

# creates 'example-topic-2' using values from local bootstrap.tfstate and remote 'example-topic' state
cd gcp-topic2
./init.sh
./apply.sh
cd ..
```

## Teardown

```
cd gcp-project-bootstrap
./destroy.sh
cd ..

# remove local state and variables
rm -f bootstrap.tfstate* dynamic-backend.hcl
rm -fr gcp-project-bootstrap/.terraform gcp-project-bootstrap/.terraform.lock.hcl
rm -fr gcp-topic/.terraform gcp-topic/.terraform.lock.hcl
rm -fr gcp-topic2/.terraform gcp-topic2/.terraform.lock.hcl
```

