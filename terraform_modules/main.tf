data "aws_ecr_image" "service_image" {
  repository_name = "docker_image_demo"
  image_tag       = "latest"
}

data "aws_ecr_repository" "service" {
  name = "docker_image_demo"
}

resource "aws_iam_role_policy" "lambda_policy" {
  name   = "lambda_policy_${var.env}"
  role   = aws_iam_role.lambda_role.id
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
        "Sid": "Stmt1635938747595",
        "Action": "logs:*",
        "Effect": "Allow",
        "Resource": "*"
    }
  ]
}

  )
}
resource "aws_iam_role" "lambda_role" {
  name               = "lambda_role_${var.env}"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
        "Action": "sts:AssumeRole",
        "Principal": {
            "Service": "lambda.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
        }
      ]
    }
  )
}


# module "lambda_function_container_image" {
#   source = "terraform-aws-modules/lambda/aws"

#   function_name = var.functionname
#   description   = "My awesome lambda function"

#   create_package = false

#   image_uri    = var.imageuri
#   package_type = "Image"
# }

resource "aws_lambda_function" "lambda_function_container_image" {
  function_name = "${var.functionname}-${var.env}"
  description   = "My awesome lambda function"
  role          = aws_iam_role.lambda_role.arn

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  #source_code_hash = filebase64sha256("lambda_function_payload.zip")

  image_uri = var.imageuri
  package_type = "Image"

  environment {
    variables = {
      env = "${var.env}"
    }
  }
}