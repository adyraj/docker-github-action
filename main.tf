terraform {
  backend "remote" {
    organization = "adyraj"

    workspaces {
      name = "gh-actions-demo"
    }
  }
}


provider "aws" {
  region = "ap-south-1"
}

module "lambda_function_container_image" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "mylambdatest"
  description   = "My awesome lambda function"

  create_package = false

  image_uri    = "442803386520.dkr.ecr.ap-south-1.amazonaws.com/docker_image_demo:latest"
  package_type = "Image"
}