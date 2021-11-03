data "aws_ecr_image" "service_image" {
  repository_name = "docker_image_demo"
  image_tag       = "latest"
}

data "aws_ecr_repository" "service" {
  name = "docker_image_demo"
}

# resource "aws_iam_role_policy" "basic_execution_policy" {
#   name   = "AWS"
#   role   = aws_iam_role.create_doctor_role.id
#   policy = jsonencode({
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Effect": "Allow",
#             "Action": "logs:CreateLogGroup",
#             "Resource": "arn:aws:logs:ap-south-1:892418949750:*"
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "logs:CreateLogStream",
#                 "logs:PutLogEvents"
#             ],
#             "Resource": [
#                 "arn:aws:logs:ap-south-1:892418949750:log-group:/aws/lambda/create_doctor_dev:*"
#             ]
#         }
#       ]
#     }
#   )
# }

# resource "aws_iam_role" "create_doctor_role" {
#   name               = "createDoctorServiceRoleDev"
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


module "lambda_function_container_image" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = var.functionname
  description   = "My awesome lambda function"

  create_package = false

  image_uri    = var.imageuri
  package_type = "Image"
}

# resource "aws_lambda_function" "lambda_function_container_image" {
#   function_name = var.functionname
#   description   = "My awesome lambda function"
#   role          = aws_iam_role.create_doctor_role.arn

#   image_uri = var.imageuri
#   package_type = "Image"

#   environment {
#     variables = {
#       env = "dev"
#     }
#   }
# }