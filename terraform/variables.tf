variable "AMI" {
}

variable "KeyName" {
}

variable "PrivateSubnets" {
  type = list(string)
}

variable "PublicSubnets" {
  type = list(string)
}

variable "DatabaseSubnets" {
  type = list(string)
}

variable "Environment" {
}

variable "SSLCertificate" {
}

variable "VPCId" {
}

variable "DBName" {
}

variable "DBUsername" {
}

variable "DBClass" {
}

variable "DBAllocatedStorage" {
}

variable "MultiAZ" {
}

variable "BackupRetentionPeriod" {
}

variable "S3Bucket" {
}

variable "InstanceType" {
}

variable "KMSKeyId" {
}

variable "Region" {
}

variable "Account" {
}

variable "DomainControllers" {
  type = list(string)
}

variable "AllowedIngress" {
  type        = list(string)
  description = "List of hosts allowed to communicate with the Netbox ELB"
}

