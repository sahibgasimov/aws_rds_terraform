resource "aws_db_subnet_group" "default" {
  name = "main"
  subnet_ids = [
    module.vpc.private_subnets[0],
    module.vpc.private_subnets[1],
    module.vpc.private_subnets[2],
  ]
}
