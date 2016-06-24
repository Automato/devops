# Setup the provider as AWS
provider "aws" {
  region = "us-east-1" # This doesn't matter for global
  profile = "admin"
}
