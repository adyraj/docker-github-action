data "aws_ecr_image" "service_image" {
  repository_name = "docker_image_demo"
  image_tag       = "latest"
}

data "aws_ecr_repository" "service" {
  name = "docker_image_demo"
}

# resource "aws_iam_role_policy" "lambda_policy" {
#   name   = "lambda_policy"
#   role   = aws_iam_role.lambda_role.id
#   policy = jsonencode({
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#         "Sid": "Stmt1635938747595",
#         "Action": "logs:*",
#         "Effect": "Allow",
#         "Resource": "*"
#     }
#   ]
# }

#   )
# }
# resource "aws_iam_role" "lambda_role" {
#   name               = "lambda_role"
#   assume_role_policy = jsonencode({
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#         "Action": "sts:AssumeRole",
#         "Principal": {
#             "Service": "lambda.amazonaws.com"
#         },
#         "Effect": "Allow",
#         "Sid": ""
#         }
#       ]
#     }
#   )
# }


# module "lambda_function_container_image" {
#   source = "terraform-aws-modules/lambda/aws"

#   function_name = var.functionname
#   description   = "My awesome lambda function"

#   create_package = false

#   image_uri    = var.imageuri
#   package_type = "Image"
# }

resource "aws_lambda_function" "lambda_function_container_image" {
  function_name = var.functionname
  description   = "My awesome lambda function"
#   role          = aws_iam_role.lambda_role.arn

  image_uri = var.imageuri
  package_type = "Image"

  environment {
    variables = {
      env = "dev"
    }
  }
}