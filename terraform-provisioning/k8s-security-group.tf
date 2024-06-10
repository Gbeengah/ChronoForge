# Define variables
variable "vpc_id" {
  description = "ID of the VPC"
  default     = "vpc-09f42619036040f14"  # Update with your VPC ID
}

variable "load_balancer_port" {
  description = "Port exposed by the load balancer"
  default     = 80  # Example port, adjust as needed
}

# Define security group for control plane
resource "aws_security_group" "control_plane" {
  name        = "k8s-control-plane-sg"
  description = "Security group for Kubernetes control plane"

  vpc_id = var.vpc_id

  # Inbound rule to allow HTTPS traffic
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rule to allow all traffic to the internet
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Define security group for worker nodes
resource "aws_security_group" "worker_nodes" {
  name        = "k8s-worker-nodes-sg"
  description = "Security group for Kubernetes worker nodes"

  vpc_id = var.vpc_id

  # Inbound rule to allow traffic on port 10250
  ingress {
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rule to allow all traffic to the internet
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Define security group for load balancer
resource "aws_security_group" "load_balancer" {
  name        = "k8s-load-balancer-sg"
  description = "Security group for Kubernetes load balancer"

  vpc_id = var.vpc_id

  # Inbound rule to allow traffic from the internet on the exposed port
  ingress {
    from_port   = var.load_balancer_port
    to_port     = var.load_balancer_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rule to allow all traffic to the internet
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
