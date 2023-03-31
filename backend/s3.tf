#create backend s3 bucket
resource "aws_s3_bucket" "sskeu1-backend" {
  bucket        = "sskeu1-backend2"
  force_destroy = true
  tags = {
    Name = "sskeu1-backend"
  }
}


# Creating the backend S3 Bucket acl
resource "aws_s3_bucket_acl" "sskeu1_backend-acl-s3" {
  bucket = aws_s3_bucket.sskeu1-backend.id
  acl    = "private"
}

################
# DYNAMODB TABLE
################

resource "aws_dynamodb_table" "tflock" {
  name     = "sskeu1_dynamo_table"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"

  }

  write_capacity = 1
  read_capacity  = 1


  tags = {

    Name        = "TF State Lock"
    Environment = "Terraform"

  }

}