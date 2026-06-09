resource "aws_security_group" "web-sg" {
  name        = "web-sg"
  description = "Allow web inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.url-shortener_vpc.id

  tags = {
    Name = "web-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_web_ipv4" {
  security_group_id = aws_security_group.web-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.web-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.web-sg.id
  cidr_ipv4         = var.admin_ip
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_security_group" "db-sg" {
  name        = "db-sg"
  description = "Allow database inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.url-shortener_vpc.id

  tags = {
    Name = "db-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_db_ipv4" {
  security_group_id            = aws_security_group.db-sg.id
  referenced_security_group_id = aws_security_group.web-sg.id
  from_port                    = 5432
  ip_protocol                  = "tcp"
  to_port                      = 5432
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_db_ipv4" {
  security_group_id = aws_security_group.db-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
