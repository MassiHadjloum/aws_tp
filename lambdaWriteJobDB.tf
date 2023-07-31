

resource "aws_lambda_function" "writeToJobDB" {
  filename         = "${path.module}/lambda_code/writeToJobDB.js.zip"
  function_name    = "writeToJobDB"
  role             = "${aws_iam_role.infrastucture1_role.arn}"
  handler          = "writeToJobDB.handler"
  runtime          = "nodejs14.x"
  source_code_hash = "${filebase64sha256("${path.module}/lambda_code/writeToJobDB.js.zip")}"
  tracing_config {
    mode = "Active"
  }
  environment {
    variables = {
      //AWS_LAMBDA_LOGS = "/aws/lambda/${aws_lambda_function.writeToJobDB.function_name}"
    }
  }
}