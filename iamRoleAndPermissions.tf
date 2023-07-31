resource "aws_iam_role" "infrastucture1_role" {
  name = "infrastucture1_role"

  assume_role_policy = <<POLICY
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Principal": {
            "Service": "lambda.amazonaws.com"
          },
          "Effect": "Allow",
          "Sid": ""
        }
      ]
    }
    POLICY
}


resource "aws_iam_policy" "infrastructure_policy" {
  name        = "InfrastructurePolicy"
  description = "Permissions to write and read Infrastructure table"

   policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "WriteAccess",
      "Effect": "Allow",
      "Action": [
        "dynamodb:PutItem"
      ],
      "Resource": [
        "arn:aws:dynamodb:eu-west-3:318727587946:table/actionTable",
        "arn:aws:dynamodb:eu-west-3:318727587946:table/contentTable"
      ]
    },
    {
      "Sid": "ReadAccess",
      "Effect": "Allow",
      "Action": [
        "dynamodb:GetItem",
        "dynamodb:Scan"
      ],
      "Resource": [
        "arn:aws:dynamodb:eu-west-3:318727587946:table/actionTable",
        "arn:aws:dynamodb:eu-west-3:318727587946:table/contentTable"
      ]
    },
    {
      "Sid": "AllObjectActions",
      "Effect": "Allow",
      "Action": "s3:*Object",
      "Resource": ["${aws_s3_bucket.apiBucket.arn}/*"]
    },
    {
      "Sid": "KinesisAccess",
      "Effect": "Allow",
      "Action": [
        "kinesis:GetRecords",
        "kinesis:GetShardIterator",
        "kinesis:DescribeStream",
        "kinesis:ListShards",
        "kinesis:ListStreams"
      ],
      "Resource": "${aws_kinesis_stream.kinesis.arn}"
    }, {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "dynamodb:GetRecords",
        "dynamodb:GetShardIterator",
        "dynamodb:DescribeStream",
        "dynamodb:ListStreams"
      ],
      "Resource": "arn:aws:dynamodb:eu-west-3:318727587946:table/actionTable/stream/*"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "dynamodb_attachment" {
  role       = aws_iam_role.infrastucture1_role.name
  policy_arn = aws_iam_policy.infrastructure_policy.arn
}
