output "aws_ecr_image_info" {
  value = data.aws_ecr_image.service_image
}

output "aws_ecr_repository_info" {
  value = data.aws_ecr_repository.service
}
