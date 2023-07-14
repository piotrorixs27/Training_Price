variable "lambda_function" {
  type=string
  description = "Name of lambda function."
}
variable "lambda_return_price" {
  type=string
  description = "Name of lambda return price."
}
variable "passthrough_behavior" {
  type = string
  description="Integration passthrough behavior."
  validation{
    condition = var.passthrough_behavior=="WHEN_NO_MATCH" ||  var.passthrough_behavior=="WHEN_NO_TEMPLATES" ||  var.passthrough_behavior=="NEVER"
    error_message = "This is wrong mode.Integration passthrough behavior (WHEN_NO_MATCH, WHEN_NO_TEMPLATES, NEVER)."
    
}
}
variable "name_httpapi" {
  type = string
  description="Name of httpapi"
}
variable "protocol_type" {
  type = string
  validation {
    condition = var.protocol_type=="HTTP" || var.protocol_type=="WEBSOCKET"
    error_message = "This is wrong mode.API protocol. Valid values: HTTP, WEBSOCKET."
  }
}
variable "integration_type" {
  type = string
  validation {
    condition = var.integration_type=="AWS " || var.integration_type=="AWS_PROXY" || var.integration_type=="HTTP" || var.integration_type=="HTTP_PROXY" || var.integration_type=="MOCK"
    error_message = "This is wrong mode.Integration type of an integration. Valid values: AWS (supported only for WebSocket APIs), AWS_PROXY, HTTP (supported only for WebSocket APIs), HTTP_PROXY, MOCK (supported only for WebSocket APIs). For an HTTP API private integration, use HTTP_PROXY."
  }
}
variable "connection_type" {
  type = string
  validation {
    condition=var.connection_type=="INTERNET" || var.connection_type=="VPC_LINK "
    error_message = "This is wrong mode.Integration input's connectionType. Valid values are INTERNET (default for connections through the public routable internet), and VPC_LINK (for private connections between API Gateway and a network load balancer in a VPC)."
  }
}
variable "integration_method" {
  type = string
  description = "Integration's HTTP method. Must be specified if integration_type is not MOCK."
}
variable "payload_format_version" {
  type = string
  validation{
    condition = var.payload_format_version=="1.0" || var.payload_format_version=="2.0"
    error_message = "The format of the payload sent to an integration."
  }
}
variable "list_name_api" {
  type = string
  description = "Route key for the route. For HTTP APIs, the route key can be either $default, or a combination of an HTTP method and resource path, for example, GET /pets."
}
variable "auto_deploy" {
  description = "Whether updates to an API automatically trigger a new deployment."
  type = bool
  validation {
    condition=var.deletion_protection_enabled==false || var.deletion_protection_enabled==true
    error_message = "Enables deletion protection for table. Defaults to false."
  }

}
variable "name_stage" {
  type = string
  description = "Name of the stage. Must be between 1 and 128 characters in length."
}
