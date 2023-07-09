resource "aws_apigatewayv2_api" "httpapi" {
  name          = var.name_httpapi
  protocol_type = var.protocol_type
}
resource "aws_apigatewayv2_integration" "httpapiintegration" {
  api_id                 = aws_apigatewayv2_api.httpapi.id
  integration_type       = var.integration_type
  connection_type        = var.connection_type
  integration_method     = var.integration_method
  integration_uri        = var.lambda_function
  passthrough_behavior   = var.WHEN_NO_MATCH
  payload_format_version = var.payload_format_version
}

resource "aws_apigatewayv2_route" "api_route_terraform" {
  api_id    = aws_apigatewayv2_api.httpapi.id
  route_key = "GET /${var.list_name_api}"
  target    = "integrations/${aws_apigatewayv2_integration.httpapiintegration.id}"
}
resource "aws_apigatewayv2_stage" "stage_terrraform" {
  api_id      = aws_apigatewayv2_api.httpapi.id
  auto_deploy = var.auto_deploy
  name        = var.name_stage
}
resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = "AllowMyDemoAPIInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function
  principal     = "apigateway.amazonaws.com"

  # The /* part allows invocation from any stage, method and resource path
  # within API Gateway.
  source_arn = "${aws_apigatewayv2_api.httpapi.execution_arn}/*"
}

resource "aws_apigatewayv2_integration" "httpapiintegration_return_price" {
  api_id                 = aws_apigatewayv2_api.httpapi.id
  integration_type       = var.integration_type
  connection_type        = var.connection_type
  integration_method     = var.integration_method
  integration_uri        = var.lambda_return_price
  passthrough_behavior   = var.passthrough_behavior
  payload_format_version = var.payload_format_version
}


resource "aws_apigatewayv2_route" "api_route_terraform_return_price_EUR" {
  api_id    = aws_apigatewayv2_api.httpapi.id
  for_each  = toset(["GET /EUR", "GET /CHF", "GET /ZL", "GET /USD", "GET /GBP"])
  route_key = each.key
  target    = "integrations/${aws_apigatewayv2_integration.httpapiintegration_return_price.id}"
}

resource "aws_lambda_permission" "lambda_permission_return_price" {
  statement_id  = "AllowMyDemoAPIInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_return_price
  principal     = "apigateway.amazonaws.com"

  # The /* part allows invocation from any stage, method and resource path
  # within API Gateway.
  source_arn = "${aws_apigatewayv2_api.httpapi.execution_arn}/*"
}

