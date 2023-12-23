variable "aws_region" {
  description = "AWS region where the RDS instance will be created."
}
variable "db_instance_identifier" {
  description = "Identifier for the RDS instance."
}

variable "allocated_storage" {
  description = "The amount of storage in gibibytes (GiB) to allocate to the DB instance."
}

variable "storage_type" {
  description = "The storage type to be associated with the DB instance."
}

variable "engine" {
  description = "The name of the database engine to be used for this DB instance."
}

variable "engine_version" {
  description = "The version number of the database engine to be used."
}

variable "instance_class" {
  description = "The instance type of the RDS instance."
}

variable "db_name" {
  description = "The name of the initial database that should be created when the DB instance is created."
}

variable "db_username" {
  description = "The name of the master user for the DB instance."
}

variable "db_password" {
  description = "The password for the master user."
}
variable "parameter_group_name" {
  description = "The name of the DB parameter group to associate with this DB instance."
}

variable "publicly_accessible" {
  description = "Determines if the DB instance can be publicly accessed."
}
