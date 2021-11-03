data "aws_ecr_image" "service_image" {
  repository_name = "docker_image_demo"
  image_tag       = "latest"
}

data "aws_ecr_repository" "service" {
  name = "docker_image_demo"
}


module "lambda_function_container_image" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = var.fun_name
  description   = "My awesome lambda function"

  create_package = false

  image_uri    = var.imageuri
  package_type = "Image"
}