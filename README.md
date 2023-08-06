# Example usage for terraform remote state

blog: 

## Quick Setup

```
# get project code
git clone https://github.com/fabianlee/example-terraform_remote_state.git
cd example-terraform_remote_state

# gcloud login for terraform
gcloud auth application-default login

# sets env var with new random GCP project id
source ./sourceMakeRandomProjectId.sh

# creates basic project, saves to local bootstrap.state
cd gcp-project-bootstrap
./init.sh
./apply.sh
cd ..

# gcloud login for terraform, set to explicit project id
gcloud auth application-default login --project $TF_VAR_project

# creates 'example-topic' using values from local bootstrap.state, saves to remote GCS
cd gcp-topic
./init.sh
./apply.sh
cd ..

# creates 'example-topic-2' using values from local bootstrap.state and remote 'example-topic' state
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
rm -f bootstrap.tfstate*
rm -f dynamic-backend.hcl
```

