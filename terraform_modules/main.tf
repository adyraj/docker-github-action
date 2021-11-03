data "aws_ecr_image" "service_image" {
  repository_name = "docker_image_demo"
  image_tag       = "latest"
}

data "aws_ecr_repository" "service" {
  name = "docker_image_demo"
}

resource "aws_iam_role_policy" "lambda_policy" {
  name   = "lambda_policy"
  role   = aws_iam_role.lambda_role.id
  policy = "${file("./iam/lambda_policy.json")}"
}
resource "aws_iam_role" "lambda_role" {
  name               = "lambda_role"
  assume_role_policy = "${file("/home/runner/work/docker-github-action/docker-github-action/terraform_modules/lambda_assume_role_policy.json")}"
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
  function_name = var.functionname
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
      env = "dev"
    }
  }
}