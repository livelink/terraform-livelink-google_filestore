terraform {
  backend "s3" {}
}

provider "aws" {
  region  = "eu-west-2"
  profile = "default"
}

locals {
  google_project_data = data.terraform_remote_state.client_google_projects.outputs.projects[var.environment]
  project_id = local.google_project_data["project_id"]
  project_name = local.google_project_data["project_name"]
  project_credentials = base64decode(local.google_project_data["project_service_account_key"])
  resource_location = data.terraform_remote_state.client_metadata.outputs.location
}

provider google {
  project     = local.project_id
  region      = local.resource_location
  credentials = local.project_credentials
}

data terraform_remote_state client_metadata {
  backend = "s3"
  config = {
    bucket = "livelink-terraform"
    key = "client/${var.client_name}.tfstate"
    region = "eu-west-2"
  }
}

data terraform_remote_state client_google_projects {
  backend = "s3"
  config = {
    bucket = "livelink-terraform"
    key = "client-projects/${var.client_name}.tfstate"
    region = "eu-west-2"
  }
}
