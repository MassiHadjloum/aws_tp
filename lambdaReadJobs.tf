

resource "aws_lambda_function" "readFromJobDB" {
  filename         = "${path.module}/lambda_code/readFromJobDB.js.zip"
  function_name    = "readFromJobDB"
  role             = "${aws_iam_role.infrastucture1_role.arn}"
  handler          = "readFromJobDB.handler"
  runtime          = "nodejs14.x"
  source_code_hash = "${filebase64sha256("${path.module}/lambda_code/readFromJobDB.js.zip")}"
  environment {
    variables = {
    }
  }
}