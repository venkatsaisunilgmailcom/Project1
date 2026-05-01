resource "aws_vpc" "myapplication_vpc" {
  cidr_block = "192.168.0.0/22"
  tags = {
    Name = "My_app_VPC_Rollback"
  }
}

resource "aws_subnet" "Public_Subnet" {
  vpc_id = aws_vpc.myapplication_vpc.id
  availability_zone = "us-east-1a"
  cidr_block = "192.168.0.0/23"


  tags = {
    name = "Public_Subnet"
    region = "us-east-1b"
  }
  depends_on = [aws_vpc.myapplication_vpc]

}


resource "aws_subnet" "Private_subnet" {
  vpc_id = aws_vpc.myapplication_vpc.id
  cidr_block = "192.168.2.0/23"
  availability_zone = "us-east-1d"

  tags = {
    Name = "Private_Subnet"
    region = "us-east-1d"
  }

  depends_on = [aws_vpc.myapplication_vpc]
}


