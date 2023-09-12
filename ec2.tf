# create ec2 instance

provider "aws" {
  region = "cn-northwest-1"
  profile = "codebuild-user"
}

# store the terraform state file in S3
terraform {
  backend "s3" {
    bucket = "terraform-state-bucket"
    key = "build/terraform.tfstate"
    region = "cn-northwest-1"
    profile = "codebuild-user"
  }
}

resource "aws_security_group" "ec2_security_group" {
  name        = "ec2 security group"
  description = "Allow access on port 80"
  vpc_id      = "vpc-0e214236b59ede490"

  ingress {
    description      = "http access"
    from_port        = 9999
    to_port          = 9999
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  
   ingress {
    description      = "http access"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "app_server" {
  ami           = "ami-01cb2ecea35798f3f"
  instance_type = "t2.micro"
  subnet_id     = "subnet-03a8a5b36aa48ac7a"
  vpc_security_group_ids  = [aws_security_group.ec2_security_group.id]
  key_name = "test"
  user_data = file("install-app.sh")
}