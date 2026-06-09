resource "aws_db_subnet_group" "url-shortener_db_subnet_group" {
  name = "main"
  subnet_ids = [
    aws_subnet.url-shortener_private1.id,
    aws_subnet.url-shortener_private2.id,
  ]

  tags = {
    Name = "My URL-shortener DB subnet group"
  }
}

resource "aws_db_instance" "url-shortener_db" {
  allocated_storage      = 20
  db_name                = "urlshortenerdb"
  engine                 = "postgres"
  engine_version         = "18.4"
  instance_class         = "db.t4g.micro"
  username               = "postgres"
  password               = var.db_password
  parameter_group_name   = "default.postgres18"
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.db-sg.id]
  db_subnet_group_name   = aws_db_subnet_group.url-shortener_db_subnet_group.name
  publicly_accessible    = false
}