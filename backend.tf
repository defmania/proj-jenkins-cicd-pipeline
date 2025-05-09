terraform {
  backend "s3" {
    bucket = "my-tf-state-bucket"
    key    = "my-project/app-deployment/terraform.tfstate"
    region = "us-east-1"

    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
