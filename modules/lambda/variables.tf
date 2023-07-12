variable "aws_dynamodb_table" {
  type = string
  description = "Resources of dynamodb to lambda"
}
variable "lambda_name" {
  type=string
  description = "Name of lambda"
}
variable "iam_for_lambda" {
  type=string
  description = "Name iam for lambda"
}
variable "dynamodb_lambda_policy" {
  type=string
  description = "Name of dynamodb policy"
}
variable "policy_actions" {
  type=string
  description = "Resources of dynamodb to lambda "
}
variable "runtime_python" {
  type=string
  description = "Version of python"
}