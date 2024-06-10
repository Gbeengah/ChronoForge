# Reference your existing VPC
data "aws_vpc" "main" {
  id = "vpc-09f42619036040f14"
}

data "aws_subnet" "public" {
  id = "subnet-03f90651a2b4c7b9e"
}

data "aws_subnet" "private" {
  id = "subnet-049cb79614ee9f220"
}

data "aws_availability_zone" "public_az" {
  zone_id = "usw2-az2"
}

data "aws_availability_zone" "private_az" {
  zone_id = "usw2-az1"
}

# Reference your existing security groups (adjust as needed)
data "aws_security_group" "worker_nodes" {
  id = "sg-053242f172027365b"
}

# Create EKS cluster in a private subnet for improved security (recommended)
resource "aws_eks_cluster" "eks_cluster" {
  name     = "my-eks-cluster"
  role_arn = aws_iam_role.eks_service_role.arn

  vpc_config {
    security_group_ids = [data.aws_security_group.worker_nodes.id]
    # Assuming you want to use the public subnet for now (replace with private subnet IDs for production)
    subnet_ids = [data.aws_subnet.public.id, data.aws_subnet.private.id]
  }

  # ... other configuration options (e.g., node instance type, count, etc.)
}

# IAM role and policy for EKS service account (replace with your specific policy)
resource "aws_iam_role" "eks_service_role" {
  name = "eks-service-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "eks_service_role_policy" {
  name = "eks-service_role_policy" # Corrected typo in resource name
  role = aws_iam_role.eks_service_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeSubnets",
        "ec2:CreateNetworkInterface",
        "ec2:DeleteNetworkInterface",
        "iam:PassRole",
        "iam:ListInstanceProfiles",
        "sts:GetCallerIdentity"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

# Node group for the EKS cluster
resource "aws_eks_node_group" "eks_node_group" {
  cluster_name        = aws_eks_cluster.eks_cluster.name
  node_group_name     = "my-node-group"
  node_role_arn       = aws_iam_role.eks_node_role.arn
  subnet_ids          = [data.aws_subnet.public.id, data.aws_subnet.private.id]
  instance_types      = ["t3.medium"]  # Adjust instance type as needed
  ami_type            = "AL2_x86_64"   # Amazon Linux 2 AMI type
  capacity_type       = "ON_DEMAND"    # Use on-demand instances

  scaling_config {
    desired_size = 2  # Number of desired nodes
    min_size     = 1  # Minimum number of nodes
    max_size     = 3  # Maximum number of nodes
  }

  tags = {
    Environment = "Production"
  }
}
resource "aws_iam_role" "eks_node_role" {
  name               = "eks-node-role"
  assume_role_policy = jsonencode({
    "Version"   : "2012-10-17",
    "Statement" : [
      {
        "Effect"    : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Action"    : "sts:AssumeRole"
      }
    ]
  })
}
