resource "aws_db_instance" "main_db" {
  identifier        = "main-db"
  allocated_storage = 10
  name              = "postgres"
  engine            = "postgres"
  engine_version    = "14.4"
  instance_class    = "db.t3.micro"
  username          = "postgres"
  password          = "postgres"
  # parameter_group_name = "default.postgres14.4"
  skip_final_snapshot = true
  vpc_security_group_ids = [
    aws_security_group.rds_security_group.id,
  ]
}

resource "aws_security_group" "rds_security_group" {
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    # Only allowing traffic in from the load balancer & service security groups
    security_groups = [
      aws_security_group.service_security_group.id,
    ]
  }

  egress {
    from_port   = 0             # Allowing any incoming port
    to_port     = 0             # Allowing any outgoing port
    protocol    = "-1"          # Allowing any outgoing protocol 
    cidr_blocks = ["0.0.0.0/0"] # Allowing traffic out to all IP addresses
  }
}
