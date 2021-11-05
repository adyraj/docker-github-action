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


#module "lambda_function_container_image" {
#  source = "terraform-aws-modules/lambda/aws"

#  function_name = var.functionname
$  description   = "My awesome lambda function"

#  create_package = false

#  image_uri    = var.imageuri
#  package_type = "Image"
#}

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

resource "aws_iam_role" "iam_for_lambda" {
  name = "lambda-ecr-test"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
              "Service": "lambda.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF


}

resource "aws_iam_policy" "policy_for_lambda" {
  name        = "lambda-ecr-test"
  description = "For testing lambda function using custom docker image"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream",
                "ec2:DescribeInstances",
                "ec2:StartInstances",
                "ec2:StopInstances",
                "logs:CreateLogGroup",
                "logs:PutLogEvents",
                "ec2:ModifyInstanceAttribute"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "terraform_policy" {
  role = "${aws_iam_role.iam_for_lambda.name}"
  policy_arn = aws_iam_policy.policy_for_lambda.arn
}

resource "aws_lambda_function" "lambda-ECR-Test" {
  function_name = "lambda_function_name"
  role          = aws_iam_role.iam_for_lambda.arn
  image_uri     = "694517080963.dkr.ecr.ap-south-1.amazonaws.com/lambda-python:latest"  # put your image uri
  package_type = "Image"

}

# resource "aws_iam_role_policy" "attach_policy_with_LambdaARN" {
#   name = "Lambda_ARN"
#   role = aws_iam_role.iam_for_lambda.id

#   policy = <<EOF
# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Effect": "Allow",
#             "Action": "lambda:GetFunctionConfiguration",
#             "Resource": "${aws_lambda_function.lambda-ECR-Test.arn}"
#         }
#     ]
# }
# EOF
# }

resource "aws_iam_policy" "managed_policy_for_lambda" {
  name        = "lambda-ecr-managed-policy"
  description = "For testing lambda function using custom docker image"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "lambda:GetFunctionConfiguration",
            "Resource": "${aws_lambda_function.lambda-ECR-Test.arn}"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "terraform_policy2" {
  role = "${aws_iam_role.iam_for_lambda.name}"
  policy_arn = aws_iam_policy.managed_policy_for_lambda.arn
}
