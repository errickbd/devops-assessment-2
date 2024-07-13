provider "aws" {
  region = "us-east-2"
  profile = "cpbravo-errick"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

resource "aws_instance" "targetNode"{
    ami = var.ec2-ami
    instance_type = var.ec2-type
    key_name = "errick-pem"
    tags = {
        Name = var.ec2-name
    }
    vpc_security_group_ids = [aws_security_group.node_sg1.id]
}

resource "aws_s3_bucket" "tf_s3_state" {
  bucket = "tf-s3-state-assessment2-errick"
  force_destroy = true
}
resource "aws_s3_bucket_versioning" "tf_s3_state_versioning" {
  bucket = aws_s3_bucket.tf_s3_state.bucket
  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_bucket_server_side_encryption_configuration" "tf_s3_state_encryption" {
  bucket = aws_s3_bucket.tf_s3_state.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
output "s3-arn" {
  value = aws_s3_bucket.tf_s3_state.arn
}
output "s3-bucket-name" {
  value = aws_s3_bucket.tf_s3_state.bucket
}
resource "aws_dynamodb_table" "tf_dynmodb_state_lock" {
  hash_key = "LockID"
  name     = "tf_dynmodb_state_lock-errick"
  attribute {
    name = "LockID"
    type = "S"
  }
  billing_mode = "PAY_PER_REQUEST"
}

resource "aws_security_group" "node_sg1" {
  name        = "cp-sg-assessment2-errick"
  description = "Security group for nodes"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9876
    to_port     = 9876
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
