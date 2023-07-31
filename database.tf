resource "aws_dynamodb_table" "actionTable" {
  name         = "actionTable"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"
  stream_view_type  = "NEW_IMAGE"
  attribute {
    name = "id"
    type = "S"
  }
  attribute {
    name = "job_type"
    type = "S"
  }
  attribute {
    name = "content"
    type = "S"
  }
  attribute {
    name = "is_done"
    type = "S"
  }

  global_secondary_index {
    name            = "job_typeIndex"
    hash_key        = "job_type"
    projection_type = "ALL"
    read_capacity   = 5
    write_capacity  = 5
  }
  global_secondary_index {
    name            = "is_doneIndex"
    hash_key        = "is_done"
    projection_type = "ALL"
    read_capacity   = 5
    write_capacity  = 5
  }
  global_secondary_index {
    name            = "contentIndex"
    hash_key        = "content"
    projection_type = "ALL"
    read_capacity   = 5
    write_capacity  = 5
  }
  stream_enabled = true
}

resource "aws_dynamodb_table" "contentTable" {
  name         = "contentTable"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }
  attribute {
    name = "content"
    type = "S"
  }

  global_secondary_index {
    name            = "contentIndex"
    hash_key        = "content"
    projection_type = "ALL"
    read_capacity   = 5
    write_capacity  = 5
  }
}

