resource "aws_security_group" "sg_netbox_asg" {
  name   = "sg_netbox_asg"
  vpc_id = var.VPCId

  tags = {
    Name = "sg_netbox_asg"
  }
}

resource "aws_security_group_rule" "elb_to_asg_ingress" {
  security_group_id        = aws_security_group.sg_netbox_asg.id
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  type                     = "ingress"
  source_security_group_id = aws_security_group.sg_netbox_elb.id
  description              = "ELB to ASG"
}

resource "aws_security_group_rule" "asg_egress_https" {
  security_group_id = aws_security_group.sg_netbox_asg.id
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "HTTPS - Package Downloads/Updates"
}

resource "aws_security_group_rule" "asg_egress_http" {
  security_group_id = aws_security_group.sg_netbox_asg.id
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "HTTP - Package Downloads/Updates"
}

resource "aws_security_group_rule" "asg_egress_ldap" {
  security_group_id = aws_security_group.sg_netbox_asg.id
  from_port         = 389
  to_port           = 389
  protocol          = "tcp"
  type              = "egress"
  cidr_blocks       = var.DomainControllers
  description       = "LDAP to Domain Controllers"
}

resource "aws_security_group_rule" "asg_egress_ldaps" {
  security_group_id = aws_security_group.sg_netbox_asg.id
  from_port         = 636
  to_port           = 636
  protocol          = "tcp"
  type              = "egress"
  cidr_blocks       = var.DomainControllers
  description       = "LDAPS to Domain Controllers"
}

resource "aws_security_group_rule" "asg_egress_dns_tcp" {
  security_group_id = aws_security_group.sg_netbox_asg.id
  from_port         = 53
  to_port           = 53
  protocol          = "tcp"
  type              = "egress"
  cidr_blocks       = var.DomainControllers
  description       = "DNS/TCP to Domain Controllers"
}

resource "aws_security_group_rule" "asg_egress_dns_udp" {
  security_group_id = aws_security_group.sg_netbox_asg.id
  from_port         = 53
  to_port           = 53
  protocol          = "udp"
  type              = "egress"
  cidr_blocks       = var.DomainControllers
  description       = "DNS/UDP to Domain Controllers"
}

resource "aws_security_group_rule" "asg_to_rds_egress" {
  security_group_id        = aws_security_group.sg_netbox_asg.id
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  type                     = "egress"
  source_security_group_id = aws_security_group.sg_netbox_rds.id
  description              = "ASG to RDS"
}

resource "aws_security_group" "sg_netbox_elb" {
  name   = "sg_netbox_elb"
  vpc_id = var.VPCId

  tags = {
    Name = "sg_netbox_elb"
  }
}

resource "aws_security_group_rule" "elb_ingress_https" {
  security_group_id = aws_security_group.sg_netbox_elb.id
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  type              = "ingress"
  cidr_blocks       = var.AllowedIngress
  description       = "Allowed Networks"
}

resource "aws_security_group_rule" "elb_to_asg_egress" {
  security_group_id        = aws_security_group.sg_netbox_elb.id
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  type                     = "egress"
  source_security_group_id = aws_security_group.sg_netbox_asg.id
  description              = "ELB to ASG"
}

resource "aws_security_group" "sg_netbox_rds" {
  name   = "sg_netbox_rds"
  vpc_id = var.VPCId

  tags = {
    Name = "sg_netbox_rds"
  }
}

resource "aws_security_group_rule" "asg_to_rds_ingresss" {
  security_group_id        = aws_security_group.sg_netbox_rds.id
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  type                     = "ingress"
  source_security_group_id = aws_security_group.sg_netbox_asg.id
  description              = "ASG to RDS"
}