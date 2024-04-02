resource "aws_subnet" "subnet_a" {
  vpc_id            = "vpc-09f42619036040f14"  # Update with your VPC ID
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-west-2a"
}

resource "aws_subnet" "subnet_b" {
  vpc_id            = "vpc-09f42619036040f14"  # Update with your VPC ID
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-west-2b"
}

resource "aws_db_subnet_group" "my_subnet_group" {
  name       = "my-subnet-group"
  subnet_ids = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]
}

resource "aws_db_instance" "my_rds_instance" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "13.4"
  instance_class       = "db.t2.micro"
  username             = "admin"
  password             = "12345"  # Update with your password
  db_subnet_group_name = aws_db_subnet_group.my_subnet_group.name
  vpc_security_group_ids = ["sg-001ba4d0d7bb2e96c"]  # Update with your security group ID
  parameter_group_name  = "default.postgres13"
}