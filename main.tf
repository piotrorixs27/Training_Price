provider "aws" {
    region = "eu-west-1"
}
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.63.0"
    }
  }
  required_version = "1.3.6"
}

module "httpapi" {
  source                 = "./modules/httpapi"
  lambda_function        = module.lambda.my_lambda_function
  lambda_return_price    = module.lambda_return_price.my_lambda_function
  passthrough_behavior   = "WHEN_NO_MATCH"
  name_httpapi           = "My_Httpapi"
  protocol_type          = "HTTP"
  integration_type       = "AWS_PROXY"
  connection_type        = "INTERNET"
  integration_method     = "POST"
  WHEN_NO_MATCH          = "WHEN_NO_MATCH"
  payload_format_version = "2.0"
  list_name_api          = "list"
  auto_deploy            = true
  name_stage             = "$default"
}
module "lambda" {
  source                 = "./modules/lambda"
  aws_dynamodb_table     = module.dynamodb.dynamodb
  lambda_name          = "lambda_function_terraform"
  iam_for_lambda         = "iam_for_lambda"
  dynamodb_lambda_policy = "dynamodb_lambda_policy"
  policy_actions         = "dynamodb:scan"
}
module "lambda_return_price" {
  source                 = "./modules/lambda"
  aws_dynamodb_table     = module.dynamodb.dynamodb
  lambda_name            = "lambda_return_price"
  iam_for_lambda         = "iam_for_lambda_price_return"
  dynamodb_lambda_policy = "dynamodb_lambda_policy_price_return"
  policy_actions         = "dynamodb:GetItem"
}

module "dynamodb" {
  source                      = "./modules/dynamodb"
  dynamodb_table_name         = "Table_Price_Training_Terraform"
  billing_mode                = "PAY_PER_REQUEST"
  table_class                 = "STANDARD_INFREQUENT_ACCESS"
  deletion_protection_enabled = false
  hash_key                    = "currency"
  name_currency               = "currency"
  type_attribute_dynamodb     = "S"
}
