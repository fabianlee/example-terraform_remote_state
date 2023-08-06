# https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference
  
terraform {

  required_version = ">= 1.2.0"

  required_providers {
    google = {
      source = "hashicorp/google"
      version = ">= 4.11.0"
    }
  }

  backend "gcs" {
    #'bucket' will come dynamically from local ../dynamic-backend.hcl
    prefix = "gcp-topic2"
  }
}

# bootstrap state for base set of values
data "terraform_remote_state" "bootstrapstate" {
  backend = "local"
  config = {
    path = "../bootstrap.tfstate"
  }
}

# remote state from first Topic
data "terraform_remote_state" "topic1" {
  backend = "gcs"
  config = {
    bucket = data.terraform_remote_state.bootstrapstate.outputs.bucketname
    prefix = "gcp-topic"
  }
}


provider "google" {
      # prereq: gcloud auth application-default login --project <projectId>

      project     = data.terraform_remote_state.bootstrapstate.outputs.projid
      region      = data.terraform_remote_state.bootstrapstate.outputs.region
}

provider "google-beta" {
      # prereq: gcloud auth application-default login --project <projectId>

      project     = data.terraform_remote_state.bootstrapstate.outputs.projid
      region      = data.terraform_remote_state.bootstrapstate.outputs.region
}



