# Example usage for terraform remote state

blog: 

## Quick Setup

```
# sets env var with random project id
source ./sourceMakeRandomProjectId.sh

# creates basic project, saves to local bootstrap.state
cd gcp-project-bootstrap
./init.sh
./apply.sh
cd ..

# creates 'example-topic' using values from local bootstrap.state, saves to remote GCS
cd gcp-topic
./init.sh
./apply.sh
cd ..

# creates 'example-topic-2' using values from local bootstrap.state and remote 'example-topic' GCS
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
rm bootstrap.tfstate*
rm dynamic-backend.hcl
```

