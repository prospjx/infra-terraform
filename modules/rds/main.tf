resource "aws_db_instance" "myrds" {
  engine              = "PostgreSQL"
  storage_type        = "gp2"
  instance_class      = "db.t4g.micro"
  allocated_storage   = 20
  identifier          = "mydb"
  username            = var.username
  password            = var.password
  publicly_accessible = true
  skip_final_snapshot = true

  tags = {
    Name = "MyTasks"
  }

}
