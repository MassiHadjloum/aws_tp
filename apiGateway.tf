resource "aws_apigatewayv2_api" "gateway" {
  name          = "infrastucture"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "inttegration_Content_DB" {
  api_id             = aws_apigatewayv2_api.gateway.id
  integration_type   = "AWS_PROXY"
  connection_type    = "INTERNET"
  integration_method = "POST"
  integration_uri    = aws_lambda_function.writeContentToDB.invoke_arn
}


resource "aws_apigatewayv2_integration" "inttegration_Job_DB" {
  api_id             = aws_apigatewayv2_api.gateway.id
  integration_type   = "AWS_PROXY"
  connection_type    = "INTERNET"
  integration_method = "POST"
  integration_uri    = aws_lambda_function.writeToJobDB.invoke_arn
}

resource "aws_apigatewayv2_integration" "inttegration_Buket" {
  api_id             = aws_apigatewayv2_api.gateway.id
  integration_type   = "AWS_PROXY"
  connection_type    = "INTERNET"
  integration_method = "POST"
  integration_uri    = aws_lambda_function.writeToS3.invoke_arn
}

// -------------------------------------

resource "aws_apigatewayv2_integration" "inttegration_Get_Jobs_DB" {
  api_id             = aws_apigatewayv2_api.gateway.id
  integration_type   = "AWS_PROXY"
  connection_type    = "INTERNET"
  integration_method = "POST"
  integration_uri    = aws_lambda_function.readFromJobDB.invoke_arn
}

resource "aws_apigatewayv2_route" "route_read_job" {
  api_id    = aws_apigatewayv2_api.gateway.id
  route_key = "GET /jobs"
  target    = "integrations/${aws_apigatewayv2_integration.inttegration_Get_Jobs_DB.id}"
}

resource "aws_lambda_permission" "allow_lambda_invocation_read_job_db" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.readFromJobDB.arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.gateway.execution_arn}/*/*"
  statement_id  = "AllowExecutionFromAPIGateway"
}

// --------------------------------------

resource "aws_apigatewayv2_route" "route_write_content" {
  api_id    = aws_apigatewayv2_api.gateway.id
  route_key = "POST /content"
  target    = "integrations/${aws_apigatewayv2_integration.inttegration_Content_DB.id}"
}



resource "aws_lambda_permission" "allow_lambda_invocation_job_db" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.writeToJobDB.arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.gateway.execution_arn}/*/*"
  statement_id  = "AllowExecutionFromAPIGateway"
}

resource "aws_lambda_permission" "allow_lambda_invocation_content_db" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.writeContentToDB.arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.gateway.execution_arn}/*/*"
  statement_id  = "AllowExecutionFromAPIGateway"
}

# resource "aws_lambda_permission" "allow_lambda_invocation_buket" {
#   action        = "lambda:InvokeFunction"
#   function_name = "${aws_lambda_function.write_in_buket.arn}"
#   principal     = "apigateway.amazonaws.com"
#   source_arn    = "${aws_apigatewayv2_api.gateway.execution_arn}/*/*"
#   statement_id  = "AllowExecutionFromAPIGateway"
# }

resource "aws_lambda_permission" "allow_lambda_invocation_s3" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.writeToS3.arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.gateway.execution_arn}/*/*"
  statement_id  = "AllowExecutionFromAPIGateway"
}

resource "aws_apigatewayv2_stage" "prod" {
  api_id      = aws_apigatewayv2_api.gateway.id
  name        = "prod"
  auto_deploy = true
}

output "api_endpoint" {
  value = aws_apigatewayv2_api.gateway.api_endpoint
}
output "stage_url" {
  value = aws_apigatewayv2_stage.prod.invoke_url
}
