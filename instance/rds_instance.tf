resource "random_password" "password" {
  length           = 30
  special          = false
  override_special = "_%@"
}

output "password" {
  value     = random_password.password.result
  sensitive = true
}


resource "aws_ssm_parameter" "wordpress" {
  name  = "/devops/us-east-2/passwords/wordpress"
  type  = "SecureString"
  value = random_password.password.result
}





resource "aws_db_instance" "default" {
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7.16"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "foo"
  password             = random_password.password.result
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.default.name
  vpc_security_group_ids = [
    aws_security_group.wordpress-db.id
  ]
}
