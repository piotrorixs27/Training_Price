data "archive_file" "zip" {
  type        = "zip"
  source_file = "${var.lambda_name}.py"
  output_path = "${var.lambda_name}.zip"
}
resource "aws_lambda_function" "lambda" {
  function_name    = var.lambda_name
  filename         = data.archive_file.zip.output_path
  source_code_hash = data.archive_file.zip.output_base64sha256
  role             = aws_iam_role.iam_for_lambda.arn
  runtime          = var.runtime_python
  handler          = "${var.lambda_name}.lambda_handler"
}

resource "aws_iam_role" "iam_for_lambda" {
  name = var.iam_for_lambda

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}
data "aws_iam_policy_document" "dynamodb-lambda-policy" {
  statement {
    actions   = [var.policy_actions]
    resources = [var.aws_dynamodb_table, var.aws_dynamodb_table]
  }
  statement {
    actions = ["logs:CreateLogGroup",
      "logs:CreateLogStream",
    "logs:PutLogEvents"]
    resources = ["*"]
  }
}
resource "aws_iam_policy" "dynamodb_policy" {
  name   = var.dynamodb_lambda_policy
  policy = data.aws_iam_policy_document.dynamodb-lambda-policy.json
}
resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.dynamodb_policy.arn
}