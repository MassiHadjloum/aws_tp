
resource "aws_lambda_function" "writeContentToDB" {
  filename         = "${path.module}/lambda_code/writeContentToDB.js.zip"     
  function_name    = "writeContentToDB"                              
  role             = "${aws_iam_role.infrastucture1_role.arn}"
  handler          = "writeContentToDB.handler"                       
  runtime          = "nodejs14.x"
  source_code_hash = "${filebase64sha256("${path.module}/lambda_code/writeContentToDB.js.zip")}" 
  tracing_config {
    mode = "Active"
  }
  environment {
    variables = {
      BUCKET_NAME = aws_s3_bucket.apiBucket.id
    }
  }
}

resource "aws_kinesis_stream" "kinesis" {
  name        = "for-content-stream"
  shard_count = 1
}

resource "aws_lambda_event_source_mapping" "mapping_to_db_action" {
  event_source_arn  = aws_kinesis_stream.kinesis.arn// aws_dynamodb_table.actionTable.arn
  function_name     = aws_lambda_function.writeContentToDB.function_name
  starting_position = "LATEST" # Démarre le traitement depuis la dernière insertion

}
