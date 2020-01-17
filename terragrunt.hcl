terraform {
  source = "module"
}

remote_state {
  backend = "s3"
  config = {
    bucket = "${get_env("S3_BUCKET", "livelink-terraform")}"
    key = "infrastructure/filestore/${get_env("TF_VAR_environment", "test")}/${get_env("TF_VAR_client_name", "bob")}/${get_env("TF_VAR_instance", "default")}.tfstate"
    region = "${get_env("REGION", "eu-west-2")}"
    encrypt = true
    dynamodb_table = "infrastructure-filestore"
  }
}
