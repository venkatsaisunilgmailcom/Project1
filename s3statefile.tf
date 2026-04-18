terraform {
  backend "s3" {
    bucket         = "venkat-terraform-state-prod"
    key            = "three-tier/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}

resource "aws_route_table" "My-app-Terraform" {
  vpc_id = aws_vpc.myapplication_vpc.id
  depends_on = [ aws_vpc.myapplication_vpc ] 

  tags = {
    Name = "Public_Subnet_My_app_RTB"
  }
}

resource "aws_route_table_association" "Public_Subnet_Assoc" {
    route_table_id = aws_route_table.My-app-Terraform.id
    subnet_id = aws_subnet.Public_Subnet.id
}

resource "aws_route_table" "Private_Subnet_Assoc" {
vpc_id = aws_vpc.myapplication_vpc.id
tags = {
  Name = "Private_Subnet_My_app_RTB"
}
}

resource "aws_route_table_association" "name" {
  route_table_id = aws_route_table.Private_Subnet_Assoc.id
  subnet_id = aws_subnet.Private_subnet.id

}