resource "aws_alb" "test-alb" {
  name = "test-load-balancer"
  subnets = aws_subnet.public.*.id
  security_groups = [aws_security_group.alb-sg.id]
}

resource "aws_alb_target_group" "test-tg" {
   name = "test-target-group"
   port = 80
   protocol = "HTTP"
   vpc_id = aws_vpc.test-vpc.id
   target_type = "ip"

   health_check {
     healthy_threshold = "3"
     interval = "30"
     protocol = "HTTP"
     matcher = "200"
     timeout = "3"
     path = var.health_check_path
     unhealthy_threshold = "2"
   }
}

# Redirect all traffic from ALB to Target Group

resource "aws_alb_listener" "front_end" {
   load_balancer_arn = aws_alb.test-alb.id
   port = var.app_port
   protocol = "HTTP"

   default_action {
     target_group_arn = aws_alb_target_group.test-tg.id
     type = "forward"
   }
}
