resource "aws_s3_bucket" "apiBucket" {
  bucket = "architecture-service"
}

output "apiBucketId" {
  value = "${aws_s3_bucket.apiBucket.id}"
}
output "apiBucketArn" {
  value = "${aws_s3_bucket.apiBucket.arn}"
}