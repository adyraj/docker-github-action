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

module "dockerlambda" {
  source       = "./terraform_modules"
  functionname = "mylambdatest"
  imageuri     = "442803386520.dkr.ecr.ap-south-1.amazonaws.com/docker_image_demo:latest"
}