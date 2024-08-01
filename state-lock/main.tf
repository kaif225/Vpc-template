// here we will setup state locking using s3 and dynamodb table so that if multiple users a working on a same terraform code and one from them has run terraform plan then the outher user should not be able to do the same
// before running the below code we have have a s3 bucket and a dynamodb table configured  

terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "terraform/state.tfstate"
    region         = "us-west-2"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}

// the above part will save the lock whenever a user do terraform apply and after all the resources get created the lock will get remove

provider "aws" {
  region = "us-west-2"
}

resource "aws_lambda_function" "example" {
  filename         = "lambda.zip"
  function_name    = "example_lambda"
  role             = "arn:aws:iam::123456789012:role/lambda_role"
  handler          = "index.handler"
  source_code_hash = filebase64sha256("lambda.zip")
  runtime          = "nodejs14.x"
}

resource "aws_sqs_queue" "example" {
  name = "example-queue"
}

# Add other resources as needed
