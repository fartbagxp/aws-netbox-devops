data "aws_ssm_parameter" "netbox_db_pass" {
  name = "/netbox/db_pass"
}

resource "aws_db_subnet_group" "netbox" {
  name       = "netbox"
  subnet_ids = var.DatabaseSubnets
}

resource "aws_db_instance" "netbox" {
  allocated_storage       = var.DBAllocatedStorage
  storage_type            = "gp2"
  engine                  = "postgres"
  engine_version          = "11.4"
  identifier_prefix       = "netbox-"
  instance_class          = var.DBClass
  name                    = var.DBName
  username                = var.DBUsername
  password                = data.aws_ssm_parameter.netbox_db_pass.value
  multi_az                = var.MultiAZ
  backup_retention_period = var.BackupRetentionPeriod
  skip_final_snapshot     = true
  apply_immediately       = true
  deletion_protection     = false
  storage_encrypted       = true
  # kms_key_id              = var.KMSKeyId
  vpc_security_group_ids = [aws_security_group.sg_netbox_rds.id]
  db_subnet_group_name   = aws_db_subnet_group.netbox.name
}
