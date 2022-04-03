resource "aws_security_group" "wordpress-db" {
  name        = "wordpress-db"
  description = "Allow Mysql traffic to wordpress"
  vpc_id      = module.vpc.vpc
  ingress {
    description = "Allow mysql"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [
        "0.0.0.0/0",
        "127.0.0.1/32",
    ]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
