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

resource "aws_instance" "app_server" {
  ami           = "ami-01cb2ecea35798f3f"
  instance_type = "t2.micro"
  subnet_id     = "subnet-0f9cb66c7400d1b68"
  user_data = file("install-app.sh")
}