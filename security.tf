# ALB Security Group

resource "aws_security_group" "alb-sg" {
   name = "test-load-balancer-security-group"
   description = "ALB Security group access from Internet"
   vpc_id = aws_vpc.test-vpc.id

   ingress {
     protocol = "tcp"
     from_port = var.app_port
     to_port = var.app_port
     cidr_blocks = ["0.0.0.0/0"]
   }

   egress {
     protocol = "-1"
     from_port = 0
     to_port = 0
     cidr_blocks = ["0.0.0.0/0"]
   }
}

# TRAFFIC FROM ALB TO ECS

resource "aws_security_group" "fargate-sg" {
   name = "test-fargate-security-group"
   description = "Allow access only from ALB"
   vpc_id = aws_vpc.test-vpc.id

   ingress {
     protocol = "tcp"
     from_port = var.app_port
     to_port = var.app_port
     security_groups = [aws_security_group.alb-sg.id]
   }

   egress {
     protocol = "-1"
     from_port = 0
     to_port = 0
     cidr_blocks = ["0.0.0.0/0"]
   }
}

# TRAFFIC FroM ECS TO RDS

resource "aws_security_group" "aurora_sg" {
  name   = "aurora-sg"
  description = "Allow ECS Wordpress only to access RDS"
  vpc_id = aws_vpc.test-vpc.id

  ingress {
    protocol    = "tcp"
    from_port   = 3306
    to_port     = 3306
    security_groups = [aws_security_group.fargate-sg.id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

