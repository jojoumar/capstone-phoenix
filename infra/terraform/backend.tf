terraform {
  backend "s3" {
    bucket         = "jojo-capstone-phoenix-tfstate"
    key            = "terraform/state.tfstate"
    region         = "eu-north-1"
    dynamodb_table = "phoenix-tf-locks"
    encrypt        = true
  }
}